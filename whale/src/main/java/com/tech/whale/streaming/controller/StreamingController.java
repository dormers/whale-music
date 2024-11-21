package com.tech.whale.streaming.controller;

import javax.servlet.http.HttpSession;

import com.google.gson.JsonArray;
import com.google.gson.JsonPrimitive;
import com.tech.whale.streaming.models.TrackDto;
import com.tech.whale.streaming.service.StreamingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;  // ResponseEntity 추가 필요
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import se.michaelthelin.spotify.model_objects.specification.*;
import se.michaelthelin.spotify.requests.data.personalization.interfaces.IArtistTrackModelObject;

import java.util.*;
import java.util.concurrent.CompletableFuture;
import java.util.stream.Collectors;

import com.tech.whale.streaming.service.LyricsService;

@Controller
public class StreamingController {

	@Autowired
	private StreamingService streamingService;

	@Autowired
	private LyricsService lyricsService;

	// [ 프레임에 스트리밍의 페이지 선택 ]
	@RequestMapping("/streaming")
	public String streaming(@RequestParam Map<String, String> queryParam, HttpSession session, Model model) {
		String type = queryParam.get("type");
		
		// 노드 스트리밍 서버를 위한 리다이렉트
//		if ("albumDetail".equals(type)) {return "redirect:https://localhost:5500/whale/streaming\\?accessToken="+(String) session.getAttribute("accessToken")+"&userId="+(String) session.getAttribute("user_id")+"&type="+queryParam.get("type")+"&id="+queryParam.get("albumId");}
//		else if ("trackDetail".equals(type)) {return "redirect:https://localhost:5500/whale/streaming\\?accessToken="+(String) session.getAttribute("accessToken")+"&userId="+(String) session.getAttribute("user_id")+"&type="+queryParam.get("type")+"&id="+queryParam.get("trackId");}
//		else if ("artistDetail".equals(type)) {return "redirect:https://localhost:5500/whale/streaming\\?accessToken="+(String) session.getAttribute("accessToken")+"&userId="+(String) session.getAttribute("user_id")+"&type="+queryParam.get("type")+"&id="+queryParam.get("artistId");}
//		else {return "redirect:https://localhost:5500/whale/streaming\\?accessToken="+(String) session.getAttribute("accessToken")+"&userId="+(String) session.getAttribute("user_id");}

		// 스프링 스트리밍 서버를 위한 리다이렉트
		 if ("albumDetail".equals(type)) {return "redirect:streaming/albumDetail?albumId="+queryParam.get("albumId");}
		 else if ("trackDetail".equals(type)) {return "redirect:streaming/detail?trackId="+queryParam.get("trackId");}
		 else if ("artistDetail".equals(type)) {return "redirect:streaming/artistDetail?artistId="+queryParam.get("artistId");}
		 else {return "redirect:streaming/home";}
	}
	
	// [ 프레임에 스트리밍 메인 구간 이동 ]
	@RequestMapping("/streaming/home")
	public String streamingHome(@RequestParam Map<String, String> queryParam, HttpSession session, Model model) {
		// 스프링 스트리밍 서버를 위한 리다이렉트
		// CompletableFuture로 반환되는 비동기 결과를 가져오기 위해 join() 사용
		CompletableFuture<Paging<Track>> topTracksFuture = streamingService.getUsersTopTracksAsync(session);
		Paging<Track> trackPaging = topTracksFuture.join(); // 결과를 동기적으로 기다림

		if (trackPaging != null && trackPaging.getItems().length > 0) {
			model.addAttribute("trackPaging", trackPaging);
		} else {
			model.addAttribute("error", "Unable to retrieve top tracks");
		}

		// 세션에서 userId 가져오기
		String userId = (String) session.getAttribute("user_id");
		
		// 사용자 플레이리스트 가져오기
		List<PlaylistSimplified> userPlaylists = streamingService.getUserPlaylists(session);
		model.addAttribute("userPlaylists", userPlaylists);

		// 좋아요 표시한 트랙 목록 가져오기
		List<TrackDto> likedTracks = streamingService.getLikedTracks(userId);
		model.addAttribute("likedTracks", likedTracks);

		// 최근 재생한 항목 가져오기
		List<PlayHistory> recentlyPlayedTracks = streamingService.getRecentlyPlayedTracks(session);
		model.addAttribute("recentlyPlayedTracks", recentlyPlayedTracks);

		// 추천 플레이리스트 가져오기
		List<PlaylistSimplified> featuredPlaylists = streamingService.getFeaturedPlaylists(session);
		model.addAttribute("featuredPlaylists", featuredPlaylists);

		// 최근 재생한 항목 기반 추천 아티스트 가져오기
		List<Artist> recommendedArtists = streamingService.getRecommendedArtistsFromRecentTracks(session);
		model.addAttribute("recommendedArtists", recommendedArtists);

		// 홈 페이지로 설정
		model.addAttribute("page", "home");
		System.out.println("page :" + model.getAttribute("page"));
		return "streaming/streamingHome";
	}

	// getDeviceId POST 요청 처리 메서드
	@PostMapping("/streaming/getDeviceId")
	public ResponseEntity<String> getDeviceId(HttpSession session) {
		// 임시로 예시 ID 반환 또는 원하는 처리를 여기에 작성
		return ResponseEntity.ok("Device ID가 성공적으로 생성되었습니다.");
	}

	// 음악 재생 메서드
	@PostMapping("/streaming/playTrack")
	public ResponseEntity<String> playTrack(HttpSession session, @RequestBody Map<String, String> body) {
		String trackId = body.get("trackId");

		// 트랙 재생 메서드 호출
		boolean isPlayed = streamingService.playTrack(session, trackId);
		if (isPlayed) {
			return ResponseEntity.ok("Track is playing");
		} else {
			return ResponseEntity.status(500).body("Failed to play track");
		}
	}

	// pauseTrack POST 요청 처리 메서드 추가
	@PostMapping("/streaming/pauseTrack")
	public ResponseEntity<Map<String, Boolean>> pauseTrack(HttpSession session) {
		boolean isPaused = streamingService.pauseTrack(session);
		Map<String, Boolean> response = new HashMap<>();
		response.put("success", isPaused);
		return isPaused ? ResponseEntity.ok(response) : ResponseEntity.status(500).body(response);
	}


	// 음악 상세 페이지로 이동
	@RequestMapping("/streaming/detail")
	public String musicDetail(@RequestParam("trackId") String trackId, HttpSession session, Model model) {
		// 트랙 상세 정보 가져오기
		Track trackDetail = streamingService.getTrackDetail(session, trackId);

		if (trackDetail != null) {
			model.addAttribute("trackDetail", trackDetail);

			// 앨범 ID 가져오기
			String[] result = streamingService.getAlbumIdByTrackId(session, trackId);
			model.addAttribute("albumId", result[0]);

			// Album 정보 추가
			Album albumDetail = streamingService.getAlbumDetail(session, trackDetail.getAlbum().getId());
			model.addAttribute("albumDetail", albumDetail);

			// 첫 번째 아티스트의 정보 추가
			String artistId = trackDetail.getArtists()[0].getId();
			Artist artistDetail = streamingService.getArtistDetail(session, artistId);
			model.addAttribute("artistDetail", artistDetail);

			// 가사 추가
			String artistName = trackDetail.getArtists()[0].getName();
			String songTitle = trackDetail.getName();
			String lyrics = lyricsService.getLyrics(artistName, songTitle);  // 가사 조회

			// 가사에서 \r 제거
			if (lyrics != null) {
				lyrics = lyrics.replace("\\r", "");
			}
			model.addAttribute("lyrics", lyrics);
		} else {
			model.addAttribute("error", "Unable to retrieve track details");
		}

		// 세션에서 userId 가져오기
		String userId = (String) session.getAttribute("user_id");

		// 사용자 플레이리스트 가져오기
		List<PlaylistSimplified> userPlaylists = streamingService.getUserPlaylists(session);
		model.addAttribute("userPlaylists", userPlaylists);

		// 좋아요 표시한 트랙 목록 가져오기
		List<TrackDto> likedTracks = streamingService.getLikedTracks(userId);
		model.addAttribute("likedTracks", likedTracks);

		// 디테일 페이지로 설정
		model.addAttribute("page", "detail");
		System.out.println("page :" + model.getAttribute("page"));
		return "streaming/streamingHome";
	}

	// 아티스트 디테일 페이지 메서드
	@RequestMapping("/streaming/artistDetail")
	public String artistDetail(@RequestParam("artistId") String artistId, HttpSession session, Model model) {
		// 아티스트 상세 정보 가져오기
		Artist artistDetail = streamingService.getArtistDetail(session, artistId);

		if (artistDetail != null) {
			model.addAttribute("artistDetail", artistDetail);

			// 아티스트의 상위 곡
			Track[] topTracks = streamingService.getArtistTopTracks(session, artistId);
			model.addAttribute("topTracks", topTracks);
			
			// 곡 좋아요 확인
			List<Boolean> trackLike = new ArrayList<Boolean>(topTracks.length);
			int x = 0;
			
			for (Track element : topTracks) {
				trackLike.add(x++, streamingService.getTrackLikeBoolService((String) session.getAttribute("user_id"), element.getId()));
			}
			model.addAttribute("trackLike", trackLike);

			// 아티스트의 앨범 목록
			Paging<AlbumSimplified> albums = streamingService.getArtistAlbums(session, artistId);
			model.addAttribute("albums", albums.getItems());

			// 연관된 아티스트 가져오기
			// Artist[] relatedArtists = streamingService.getRelatedArtists(session, artistId);  // 메서드가 구현되어 있어야 함
			// model.addAttribute("relatedArtists", relatedArtists);

			// 관련 플레이리스트 가져오기
			List<PlaylistSimplified> relatedPlaylists = streamingService.getRelatedPlaylists(artistDetail.getName(), session);
			model.addAttribute("relatedPlaylists", relatedPlaylists);
		} else {
			model.addAttribute("error", "Unable to retrieve artist details");
		}

		// 세션에서 userId 가져오기
		String userId = (String) session.getAttribute("user_id");

		// 사용자 플레이리스트 가져오기
		List<PlaylistSimplified> userPlaylists = streamingService.getUserPlaylists(session);
		model.addAttribute("userPlaylists", userPlaylists);

		// 좋아요 표시한 트랙 목록 가져오기
		List<TrackDto> likedTracks = streamingService.getLikedTracks(userId);
		model.addAttribute("likedTracks", likedTracks);

		// 디테일 페이지로 설정
		model.addAttribute("page", "artistDetail");
		System.out.println("page :" + model.getAttribute("page"));
		return "streaming/streamingHome";
	}

	// 검색 결과를 받아오는 메서드 추가
	@RequestMapping("/streaming/search")
	public String searchTracks(@RequestParam("query") String query, HttpSession session, Model model) {

		// 세션에서 userId 가져오기
		String userId = (String) session.getAttribute("user_id");

		// 정확히 일치하는 아티스트 찾기
		Artist searchedArtist = streamingService.getFirstArtistByQuery(session, query);
		model.addAttribute("searchedArtist", searchedArtist); // 검색된 아티스트를 모델에 추가

		// Spotify API로 트랙 검색 요청
		Paging<Track> searchResults = streamingService.searchTracks(session, query);
		if (searchResults != null && searchResults.getItems().length > 0) {
			model.addAttribute("searchResults", searchResults.getItems());
		} else {
			model.addAttribute("error", "No search results found.");
		}

		// **앨범 검색 추가**
		Paging<AlbumSimplified> albumResults = streamingService.searchAlbums(session, query);
		if (albumResults != null && albumResults.getItems().length > 0) {
			model.addAttribute("albums", albumResults.getItems());
		}

		// **관련된 플레이리스트 검색 추가**
		List<PlaylistSimplified> relatedPlaylists = streamingService.searchPlaylists(session, query);
		if (relatedPlaylists != null && !relatedPlaylists.isEmpty()) {
			model.addAttribute("relatedPlaylists", relatedPlaylists);
		}

		// 사용자 플레이리스트 가져오기
		List<PlaylistSimplified> userPlaylists = streamingService.getUserPlaylists(session);
		model.addAttribute("userPlaylists", userPlaylists);

		// 좋아요 표시한 트랙 목록 가져오기
		List<TrackDto> likedTracks = streamingService.getLikedTracks(userId);
		model.addAttribute("likedTracks", likedTracks);

		// 검색 결과 페이지로 이동
		model.addAttribute("page", "search");
		System.out.println("page :" + model.getAttribute("page"));
		return "streaming/streamingHome";
	}

	// 플레이리스트 디테일 메서드
	@RequestMapping("/streaming/playlistDetail")
	public String playlistDetail(@RequestParam("playlistId") String playlistId, HttpSession session, Model model) {
		Playlist playlistDetail = streamingService.getPlaylistDetail(session, playlistId);
		
		List<Boolean> trackLike = new ArrayList<Boolean>(playlistDetail.getTracks().getItems().length);
		int x = 0;
		
		for (PlaylistTrack element : playlistDetail.getTracks().getItems()) {
			trackLike.add(x++, streamingService.getTrackLikeBoolService((String) session.getAttribute("user_id"), element.getTrack().getId()));
		}

		if (playlistDetail != null) {
			model.addAttribute("playlistDetail", playlistDetail);
			model.addAttribute("tracks", Arrays.asList(playlistDetail.getTracks().getItems()));
			model.addAttribute("trackLike", trackLike);
		} else {
			model.addAttribute("error", "Unable to retrieve playlist details");
		}

		// 세션에서 userId 가져오기
		String userId = (String) session.getAttribute("user_id");

		// 사용자 플레이리스트 가져오기
		List<PlaylistSimplified> userPlaylists = streamingService.getUserPlaylists(session);
		model.addAttribute("userPlaylists", userPlaylists);
		
		// 플레이리스트 현재 사용자에 추가 여부 확인 및 자신이 만든 플레이리스트 여부 확인
		boolean isAdded = false;
		boolean isSpotified = false;
		for (PlaylistSimplified element : userPlaylists) {
			if (element.getId().equals(playlistId)) {
				isAdded = true;
				break;
			}
		}
		if (playlistDetail.getOwner().getDisplayName().equals("Spotify")) {
			isSpotified = true;
		}
		model.addAttribute("isAdded", isAdded);
		model.addAttribute("isSpotified", isSpotified);

		// 좋아요 표시한 트랙 목록 가져오기
		List<TrackDto> likedTracks = streamingService.getLikedTracks(userId);
		model.addAttribute("likedTracks", likedTracks);

		model.addAttribute("page", "playlistDetail");
		System.out.println("page :" + model.getAttribute("page"));
		return "streaming/streamingHome";
	}

	// 앨범 디테일 메서드
	@RequestMapping("/streaming/albumDetail")
	public String albumDetail(@RequestParam("albumId") String albumId, HttpSession session, Model model) {
		System.out.println("앨범 ID: " + albumId);

		Album albumDetail = streamingService.getAlbumDetail(session, albumId);
		List<Track> albumTracks = streamingService.getAlbumTracks(session, albumId);
		
		List<Boolean> trackLike = new ArrayList<Boolean>(albumTracks.size());
		int x = 0;
		
		for (Track element : albumTracks) {
			trackLike.add(x++, streamingService.getTrackLikeBoolService((String) session.getAttribute("user_id"), element.getId()));
		}

		if (albumDetail != null && albumTracks != null) {
			model.addAttribute("albumDetail", albumDetail);
			model.addAttribute("tracks", albumTracks);
			model.addAttribute("trackLike", trackLike);
		} else {
			model.addAttribute("error", "앨범 정보를 불러오지 못했습니다.");
		}
		
		// 첫 번째 아티스트의 정보 추가
		Artist artistDetail = streamingService.getArtistDetail(session, albumDetail.getArtists()[0].getId());
		model.addAttribute("artistDetail", artistDetail);

		// 세션에서 userId 가져오기
		String userId = (String) session.getAttribute("user_id");

		// 사용자 플레이리스트 가져오기
		List<PlaylistSimplified> userPlaylists = streamingService.getUserPlaylists(session);
		model.addAttribute("userPlaylists", userPlaylists);

		// 좋아요 표시한 트랙 목록 가져오기
		List<TrackDto> likedTracks = streamingService.getLikedTracks(userId);
		model.addAttribute("likedTracks", likedTracks);

		model.addAttribute("page", "albumDetail");
		System.out.println("page :" + model.getAttribute("page"));
		return "streaming/streamingHome";
	}

	// 전체 플레이리스트 재생 메서드
	@PostMapping("/streaming/playAllPlaylist")
	public ResponseEntity<String> playAllPlaylist(HttpSession session, @RequestBody Map<String, String> body) {
		String playlistId = body.get("playlistId");

		// 전체 재생 메서드 호출
		boolean isPlayed = streamingService.playAllPlaylist(session, playlistId);
		if (isPlayed) {
			return ResponseEntity.ok("Playlist is playing");
		} else {
			return ResponseEntity.status(500).body("Failed to play playlist");
		}
	}

	// 앨범 전체 재생 메서드
	@PostMapping("/streaming/playAllAlbum")
	@ResponseBody
	public boolean playAllAlbum(@RequestParam String albumId, HttpSession session) {
		return streamingService.playAllAlbum(session, albumId);
	}


	// 스트리밍 메인 좋아요 버튼
	@PostMapping(value = "/streaming/toggleTrackLike", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public HashMap<String, Object> toggleTrackLike(@RequestBody HashMap<String, Object> map, HttpSession session) {
		HashMap<String, Object> response = new HashMap<>();
		String trackSpotifyId = map.get("trackSpotifyId").toString();

		boolean isLiked = streamingService.selectTrackLikeService(session, trackSpotifyId);

		if (isLiked) {
			streamingService.deleteTrackLikeService(session, trackSpotifyId);
			response.put("result", "deleted");
		} else {
			streamingService.insertTrackLikeService(session, trackSpotifyId,
					map.get("artistName").toString(),
					map.get("trackName").toString(),
					map.get("albumName").toString(),
					map.get("trackCover").toString());
			response.put("result", "inserted");
		}
		return response;
	}

	// 좋아요 표시한 곡 페이지 메서드
	@RequestMapping("/streaming/likedTracks")
	public String likedTracks(HttpSession session, Model model) {
		String userId = (String) session.getAttribute("user_id"); // userId를 session에서 가져옴

		if (userId == null) {
			model.addAttribute("error", "User not logged in");
			return "errorPage";
		}

		// 좋아요 표시한 트랙 목록 가져오기
		List<TrackDto> likedTracks = streamingService.getLikedTracks(userId);
		
		// 각 TrackSimplified 정보를 가져와 URI 배열 생성
        String uris = "";

		if (likedTracks != null && !likedTracks.isEmpty()) {
			// *****************************************************************************************
			// 각 트랙의 좋아요 여부를 확인하여 TrackDto의 필드에 추가
			for (TrackDto track : likedTracks) {
				boolean isLiked = streamingService.selectTrackLikeService(session, track.getTrack_id());
				track.setLiked(isLiked); // TrackDto에 isLiked 필드를 설정
				
				uris += "spotify:track:"+track.getTrack_id()+",";
			}
			// *****************************************************************************************

			// 각 트랙의 앨범 ID를 가져오기 위해 Spotify API 호출
			Map<String, String> albumIds = new HashMap<>();
			Map<String, String> artistIds = new HashMap<>();

			// for (TrackDto trackDto : likedTracks) {
			//	  String[] result = streamingService.getAlbumIdByTrackId(session, trackDto.getTrack_id());
			//	  albumIds.put(trackDto.getTrack_id(), result[0]);
			//	  artistIds.put(trackDto.getTrack_id(), result[1]);
			// }

			model.addAttribute("likedTracks", likedTracks);  // Model에 좋아요 트랙 추가
			model.addAttribute("albumIds", albumIds);        // 각 트랙의 앨범 ID 추가
			model.addAttribute("artistIds", artistIds);      // 각 트랙의 아티스트 ID 추가
			model.addAttribute("uris", uris);      // 각 트랙의 아티스트 ID 추가
		} else {
			model.addAttribute("error", "No liked tracks found.");
			System.out.println("likedTracks가 비어 있습니다.");
		}

		// 사용자 플레이리스트 가져오기
		List<PlaylistSimplified> userPlaylists = streamingService.getUserPlaylists(session);
		model.addAttribute("userPlaylists", userPlaylists);

		// 좋아요 표시한 곡 페이지로 이동
		model.addAttribute("page", "likedTracks");
		System.out.println("page :" + model.getAttribute("page"));
		return "streaming/streamingHome";
	}

	// 좋아요 상태 확인 메서드
	@PostMapping(value = "/streaming/checkTrackLike", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Map<String, Object>> checkTrackLike(@RequestBody Map<String, Object> map, HttpSession session) {
		String trackSpotifyId = map.get("trackSpotifyId").toString();
		Map<String, Object> response = new HashMap<>();

		boolean isLiked = streamingService.selectTrackLikeService(session, trackSpotifyId); // 좋아요 상태 확인

		if (isLiked) {
			response.put("result", "liked");
		} else {
			response.put("result", "not_liked");
		}

		return ResponseEntity.ok(response);
	}


}
