package com.tech.whale.streaming.service;

import com.neovisionaries.i18n.CountryCode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import se.michaelthelin.spotify.SpotifyApi;
import se.michaelthelin.spotify.exceptions.SpotifyWebApiException;
import se.michaelthelin.spotify.model_objects.special.FeaturedPlaylists;
import se.michaelthelin.spotify.model_objects.specification.*;
import se.michaelthelin.spotify.requests.data.personalization.simplified.GetUsersTopTracksRequest;
import org.apache.hc.core5.http.ParseException;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.concurrent.CompletableFuture;

import com.google.gson.JsonArray;
import com.google.gson.JsonPrimitive;
import com.tech.whale.streaming.models.StreamingDao;
import com.tech.whale.streaming.models.TrackDto;
import se.michaelthelin.spotify.requests.data.player.StartResumeUsersPlaybackRequest;
import se.michaelthelin.spotify.requests.data.search.simplified.SearchArtistsRequest;
import se.michaelthelin.spotify.requests.data.search.simplified.SearchTracksRequest;
import se.michaelthelin.spotify.requests.data.artists.GetArtistsTopTracksRequest;
import se.michaelthelin.spotify.requests.data.artists.GetArtistsAlbumsRequest;
import se.michaelthelin.spotify.requests.data.search.simplified.SearchPlaylistsRequest;
import se.michaelthelin.spotify.model_objects.specification.PlayHistory;
import se.michaelthelin.spotify.model_objects.specification.Paging;
import se.michaelthelin.spotify.requests.data.player.GetCurrentUsersRecentlyPlayedTracksRequest;

import se.michaelthelin.spotify.model_objects.specification.PagingCursorbased;

import java.util.HashSet;
import java.util.Set;


import java.util.List;
import java.util.Arrays;
import java.util.Collections;
import java.util.stream.Collectors;
import java.util.LinkedHashSet;


@Service
public class StreamingService {

    @Autowired
    private SpotifyApi spotifyApi;
    
    @Autowired
    private StreamingDao streamingDao;

    // Spotify API 초기화 메서드
    private void initializeSpotifyApi(HttpSession session) {
        String accessToken = (String) session.getAttribute("accessToken");
        String refreshToken = (String) session.getAttribute("refreshToken");

        if (accessToken == null || refreshToken == null) {
            System.out.println("accessToken 또는 refreshToken이 세션에 없습니다.");
            return;
        }

        this.spotifyApi = new SpotifyApi.Builder()
                .setAccessToken(accessToken)
                .setRefreshToken(refreshToken)
                .build();
    }

    // Access Token 갱신 메서드
    public void refreshAccessToken(HttpSession session) {
        try {
            var authorizationCodeCredentials = spotifyApi.authorizationCodeRefresh().build().execute();
            String newAccessToken = authorizationCodeCredentials.getAccessToken();

            // 세션에 새로운 accessToken 저장
            session.setAttribute("accessToken", newAccessToken);
            spotifyApi.setAccessToken(newAccessToken);

            System.out.println("새로운 accessToken: " + newAccessToken);
        } catch (IOException | SpotifyWebApiException | ParseException e) {
            System.out.println("Access Token 갱신 실패: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // Access Token 유효성 검사 메서드
    private boolean isTokenValid(HttpSession session) {
        initializeSpotifyApi(session);

        try {
            spotifyApi.getCurrentUsersProfile().build().execute();
            return true;
        } catch (SpotifyWebApiException | IOException | ParseException e) {
            System.out.println("유효하지 않은 Access Token입니다. 갱신을 시도합니다.");
            refreshAccessToken(session);
            return false;
        }
    }

    // Top 트랙 가져오기 비동기 메서드
    public CompletableFuture<Paging<Track>> getUsersTopTracksAsync(HttpSession session) {
        initializeSpotifyApi(session);

        GetUsersTopTracksRequest request = spotifyApi.getUsersTopTracks()
                .limit(10)
                .time_range("medium_term")
                .build();

        return request.executeAsync().exceptionally(e -> {
            System.out.println("예상치 못한 오류 발생: " + e.getMessage());
            return null;
        });
    }

    // 음악 재생 메서드
    public boolean playTrack(HttpSession session, String trackId) {
        initializeSpotifyApi(session);

        try {
            JsonArray uris = new JsonArray();
            uris.add(new JsonPrimitive("spotify:track:" + trackId));

            var playRequest = spotifyApi.startResumeUsersPlayback()
                    .uris(uris);

            // 재생 위치가 저장되어 있다면 해당 위치에서 재생 시작
            if (currentPositionMs != null) {
                playRequest = playRequest.position_ms(currentPositionMs);
            }

            playRequest.build().execute();

            // 재생이 시작되면 위치 초기화
            currentPositionMs = null;
            return true;
        } catch (IOException | SpotifyWebApiException | ParseException e) {
            System.out.println("Failed to play track: " + e.getMessage());
            return false;
        }
    }

    // 현재 재생 위치를 저장할 변수
    private Integer currentPositionMs = null;

    // 음악 일시정지 메서드 추가
    public boolean pauseTrack(HttpSession session) {
        initializeSpotifyApi(session);

        try {
            // 현재 재생 상태를 가져와 재생 위치 저장
            var playbackState = spotifyApi.getInformationAboutUsersCurrentPlayback().build().execute();
            if (playbackState != null && playbackState.getProgress_ms() != null) {
                currentPositionMs = playbackState.getProgress_ms();
            }

            spotifyApi.pauseUsersPlayback().build().execute();
            return true;
        } catch (IOException | SpotifyWebApiException | ParseException e) {
            System.out.println("Failed to pause track: " + e.getMessage());
            return false;
        }
    }

    // 트랙 세부정보 가져오는 메서드
    public Track getTrackDetail(HttpSession session, String trackId) {
        initializeSpotifyApi(session);

        try {
            // Spotify API에서 트랙 상세 정보 가져오기
            return spotifyApi.getTrack(trackId).build().execute();
        } catch (IOException | SpotifyWebApiException | ParseException e) {
            System.out.println("Failed to fetch track details: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    // 앨범 세부정보 가져오는 메서드
    public Album getAlbumDetail(HttpSession session, String albumId) {
        initializeSpotifyApi(session);

        try {
            // Album 정보 가져오기
            return spotifyApi.getAlbum(albumId).build().execute();
        } catch (IOException | SpotifyWebApiException | ParseException e) {
            System.out.println("Failed to fetch album details: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    // 아티스트 세부정보 가져오는 메서드
    public Artist getArtistDetail(HttpSession session, String artistId) {
        initializeSpotifyApi(session);

        try {
            // 아티스트 정보 가져오기
            return spotifyApi.getArtist(artistId).build().execute();
        } catch (IOException | SpotifyWebApiException | ParseException e) {
            System.out.println("Failed to fetch artist details: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    // 아티스트의 상위 곡 가져오기
    public Track[] getArtistTopTracks(HttpSession session, String artistId) {
        initializeSpotifyApi(session);
        try {
            GetArtistsTopTracksRequest request = spotifyApi.getArtistsTopTracks(artistId, CountryCode.KR).build();
            return request.execute();
        } catch (IOException | SpotifyWebApiException | ParseException e) {
            System.out.println("Failed to fetch artist's top tracks: " + e.getMessage());
            return null;
        }
    }

    // 아티스트의 앨범 목록 가져오기
    public Paging<AlbumSimplified> getArtistAlbums(HttpSession session, String artistId) {
        initializeSpotifyApi(session);
        try {
            GetArtistsAlbumsRequest request = spotifyApi.getArtistsAlbums(artistId).limit(10).build();
            return request.execute();
        } catch (IOException | SpotifyWebApiException | ParseException e) {
            System.out.println("Failed to fetch artist's albums: " + e.getMessage());
            return null;
        }
    }

    // 연관된 아티스트 가져오기
//    public Artist[] getRelatedArtists(HttpSession session, String artistId) {
//        initializeSpotifyApi(session);
//        try {
//            return spotifyApi.getArtistsRelatedArtists(artistId).build().execute();
//        } catch (IOException | SpotifyWebApiException | ParseException e) {
//            System.out.println("Failed to fetch related artists: " + e.getMessage());
//            return null;
//        }
//    }

    // 아티스트 관련 플레이리스트 가져오는 메서드
    public List<PlaylistSimplified> getRelatedPlaylists(String artistName, HttpSession session) {
        initializeSpotifyApi(session); // session 파라미터 전달

        try {
            SearchPlaylistsRequest searchRequest = spotifyApi.searchPlaylists(artistName)
                    .limit(10) // 필요한 플레이리스트 수 설정
                    .build();

            Paging<PlaylistSimplified> playlistPaging = searchRequest.execute();
            return Arrays.asList(playlistPaging.getItems()); // 플레이리스트 목록 반환

        } catch (IOException | SpotifyWebApiException | ParseException e) {
            System.out.println("Failed to fetch related playlists: " + e.getMessage());
            return Collections.emptyList();
        }
    }

    // Spotify에서 트랙 검색
    public Paging<Track> searchTracks(HttpSession session, String query) {
        initializeSpotifyApi(session);

        try {
            // 검색 요청 생성
            SearchTracksRequest searchTracksRequest = spotifyApi.searchTracks(query)
                    .limit(50)  // 최대 50개까지 가져올 수 있음
                    .build();

            Paging<Track> searchResults = searchTracksRequest.execute();

            // 응답 로그 출력
            System.out.println("Tracks Search Results for query '" + query + "': " + Arrays.toString(searchResults.getItems()));

            // 결과 반환
            return searchTracksRequest.execute();
        } catch (IOException | SpotifyWebApiException | ParseException e) {
            System.out.println("Failed to search tracks: " + e.getMessage());
            return null;
        }
    }

    // 특정 아티스트 이름으로 검색하여 첫 번째 결과만 반환하는 메서드
    public Artist getFirstArtistByQuery(HttpSession session, String query) {
        initializeSpotifyApi(session);

        try {
            SearchArtistsRequest searchRequest = spotifyApi.searchArtists(query).limit(1).build(); // 첫 번째 결과만 가져옴
            Paging<Artist> searchResults = searchRequest.execute();

            if (searchResults != null && searchResults.getItems().length > 0) {
                return searchResults.getItems()[0]; // 첫 번째 아티스트 반환
            }
        } catch (IOException | SpotifyWebApiException | ParseException e) {
            System.out.println("Failed to fetch artist by query: " + e.getMessage());
        }
        return null; // 검색 결과가 없을 경우 null 반환
    }

    // 특정 플레이리스트 ID로 플레이리스트 가져오기
    public Playlist getPlaylistDetail(HttpSession session, String playlistId) {
        initializeSpotifyApi(session);

        try {
            return spotifyApi.getPlaylist(playlistId).build().execute();
        } catch (IOException | SpotifyWebApiException | ParseException e) {
            System.out.println("Failed to fetch playlist details: " + e.getMessage());
            return null;
        }
    }

    public List<Track> getAlbumTracks(HttpSession session, String albumId) {
        initializeSpotifyApi(session);

        try {
            // TrackSimplified 타입의 앨범 트랙 목록을 가져옴
            Paging<TrackSimplified> trackSimplifiedPaging = spotifyApi.getAlbumsTracks(albumId).build().execute();
            TrackSimplified[] trackSimplifieds = trackSimplifiedPaging.getItems();

            List<Track> fullTrackDetails = new ArrayList<>();

            // TrackSimplified 객체의 ID로 Track 객체를 각각 가져와 리스트에 추가
            for (TrackSimplified trackSimplified : trackSimplifieds) {
                Track trackDetail = spotifyApi.getTrack(trackSimplified.getId()).build().execute();
                fullTrackDetails.add(trackDetail);
            }

            return fullTrackDetails; // Track 객체 리스트 반환
        } catch (IOException | SpotifyWebApiException | ParseException e) {
            System.out.println("앨범 트랙 가져오기 실패: " + e.getMessage());
            return Collections.emptyList();
        }
    }

    public List<PlaylistSimplified> getUserPlaylists(HttpSession session) {
        initializeSpotifyApi(session);

        try {
            // 최대 10개의 플레이리스트 가져오기
            Paging<PlaylistSimplified> playlistsPaging = spotifyApi.getListOfCurrentUsersPlaylists()
                    .limit(10)
                    .build()
                    .execute();
            return Arrays.asList(playlistsPaging.getItems());
        } catch (IOException | SpotifyWebApiException | ParseException e) {
            System.out.println("사용자 플레이리스트 가져오기 실패: " + e.getMessage());
            return Collections.emptyList();
        }
    }

    // 전체 플레이리스트 재생 메서드
    public boolean playAllPlaylist(HttpSession session, String playlistId) {
        initializeSpotifyApi(session);

        try {
            // 플레이리스트의 모든 트랙 가져오기
            Playlist playlistDetail = spotifyApi.getPlaylist(playlistId).build().execute();
            List<PlaylistTrack> playlistTracks = Arrays.asList(playlistDetail.getTracks().getItems());

            // 각 PlaylistTrack의 실제 TrackSimplified 정보를 가져와 URI 배열 생성
            JsonArray uris = new JsonArray();
            for (PlaylistTrack playlistTrack : playlistTracks) {
                if (playlistTrack.getTrack() instanceof Track) {
                    Track track = (Track) playlistTrack.getTrack();
                    uris.add(new JsonPrimitive("spotify:track:" + track.getId()));
                }
            }

            // 전체 재생 요청
            var playRequest = spotifyApi.startResumeUsersPlayback()
                    .uris(uris) // 전체 트랙 URI 리스트 전달
                    .build();
            playRequest.execute();

            return true;
        } catch (IOException | SpotifyWebApiException | ParseException e) {
            System.out.println("Failed to play playlist: " + e.getMessage());
            return false;
        }
    }


    //-----------------------------------------------------------------------------------------------------
    
    // 데이터 베이스에 해당 트랙의 정보 입력 유무 확인 및 프라이머리 키 및 DTO 리턴
    public String selectTrackIdService(String trackSpotifyId, String track_artist, String track_name, String track_album, String track_cover) {
    	String trackId = streamingDao.selectTrackId(trackSpotifyId);
    	
    	if(trackId != null) {return trackId;}
    	else {
    		streamingDao.insertTrack(trackSpotifyId, track_artist, track_name, track_album, track_cover);
    		trackId = streamingDao.selectTrackId(trackSpotifyId);
    		return trackId;
    	}
    }
    
    public TrackDto selectTrackDtoService(String trackSpotifyId) {
    	TrackDto trackDto = streamingDao.selectTrackDto(trackSpotifyId);
    	return trackDto;
    }
  
    // 데이터 베이스에 트랙 좋아요 정보 입력 유무 확인
    public boolean selectTrackLikeService(HttpSession session, String trackSpotifyId) {
    	String trackId = streamingDao.selectTrackId(trackSpotifyId);
    	
    	if(trackId != null) {
    		Integer trackLikeId = streamingDao.selectTrackLikeId((String) session.getAttribute("user_id"), trackId);
    		
    		if(trackLikeId != null) {return true;}
        	else {return false;}
    	} else {
    		return false;
    	}
    }
    
    // 트랙 좋아요 인서트
    public void insertTrackLikeService(HttpSession session, String trackSpotifyId, String track_artist, String track_name, String track_album, String track_cover) {
    	String trackId = selectTrackIdService(trackSpotifyId, track_artist, track_name, track_album, track_cover);
    	streamingDao.insertTrackLike(trackId, (String) session.getAttribute("user_id"));
    }
    
    // 트랙 좋아요 삭제
    public void deleteTrackLikeService(HttpSession session, String trackSpotifyId) {
    	String trackId = streamingDao.selectTrackId(trackSpotifyId);
    	Integer trackLikeId = streamingDao.selectTrackLikeId((String) session.getAttribute("user_id"), trackId);
    	streamingDao.deleteTrackLike(trackLikeId);
    }
    
    // 트랙 재생횟수 인서트
    public void updateTrackCntService(HttpSession session, String trackSpotifyId, String track_artist, String track_name, String track_album, String track_cover) {
    	String trackId = selectTrackIdService(trackSpotifyId, track_artist, track_name, track_album, track_cover);
    	streamingDao.insertTrackCnt(trackId, (String) session.getAttribute("user_id"));
    }
    
    // 좋아요 표시한 곡의 숫자
    public Integer getLikeCountInfoService(String userId) {
        return streamingDao.getLikeCountInfo(userId);
    }
    
    // 해당 유저의 트랙 좋아요 확인
    public Boolean getTrackLikeBoolService(String userId, String trackId) {
    	Integer result = streamingDao.getTrackLikeCountInfo(userId, trackId);
    	if (result > 0) {return true;}
    	else {return false;}
    }
    
    // 트랙 좋아요 인서트 노드용
    public void insertTrackLikeNodeService(String userId, String trackSpotifyId, String track_artist, String track_name, String track_album, String track_cover) {
    	String trackId = selectTrackIdService(trackSpotifyId, track_artist, track_name, track_album, track_cover);
    	streamingDao.insertTrackLike(trackId, userId);
    }
    
    // 트랙 좋아요 삭제 노드용
    public void deleteTrackLikeNodeService(String userId, String trackSpotifyId) {
    	String trackId = streamingDao.selectTrackId(trackSpotifyId);
    	Integer trackLikeId = streamingDao.selectTrackLikeId(userId, trackId);
    	streamingDao.deleteTrackLike(trackLikeId);
    }
    
    // 플레이리스트 추가 및 삭제
    public void followPlaylistService(String playlistId) {
    	try {
    		spotifyApi.followPlaylist(playlistId, true).build().execute();
		} catch (Exception e) {
		}
    }
    
    public void unfollowPlaylistService(String playlistId) {
    	try {
    		spotifyApi.unfollowPlaylist(playlistId).build().execute();
		} catch (Exception e) {
		}
    }
    
    // 좋아요 전체 재생
    public void playAllLikeTrackService(HttpSession session, String uris) {
        initializeSpotifyApi(session);
        String[] urisArray = uris.split(",");

        try {
            // 각 TrackSimplified 정보를 가져와 URI 배열 생성
            JsonArray result = new JsonArray();
            for (String track : urisArray) {
            	result.add(new JsonPrimitive(track));
            }

            // 전체 재생 요청
            var playRequest = spotifyApi.startResumeUsersPlayback()
                    .uris(result) // 전체 트랙 URI 리스트 전달
                    .build();
            playRequest.execute();
        } catch (IOException | SpotifyWebApiException | ParseException e) {
            System.out.println("Failed to play album: " + e.getMessage());
        }
    }

    //----------------------------------------------------------------------------------------------------------

    // 좋아요 표시한 곡
    public List<TrackDto> getLikedTracks(String userId) {
        return streamingDao.selectLikedTracks(userId);
    }

    // 최근 재생한 항목
    public List<PlayHistory> getRecentlyPlayedTracks(HttpSession session) {
        try {
            SpotifyApi spotifyApi = new SpotifyApi.Builder()
                    .setAccessToken((String) session.getAttribute("accessToken"))
                    .build();

            GetCurrentUsersRecentlyPlayedTracksRequest recentlyPlayedRequest = spotifyApi.getCurrentUsersRecentlyPlayedTracks()
                    .limit(50) // 충분한 양의 데이터를 가져와서 필터링
                    .build();

            PagingCursorbased<PlayHistory> recentlyPlayedPaging = recentlyPlayedRequest.execute();

            // 중복을 제거하기 위해 LinkedHashSet을 사용하여 순서를 유지하면서 중복 제거
            Set<String> trackIds = new LinkedHashSet<>();
            List<PlayHistory> uniqueRecentlyPlayed = Arrays.stream(recentlyPlayedPaging.getItems())
                    .filter(playHistory -> trackIds.add(playHistory.getTrack().getId())) // track ID 기준 중복 제거
                    .limit(10) // 상위 10개 항목만 가져옴
                    .collect(Collectors.toList());

            return uniqueRecentlyPlayed;
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }

    // 전체 앨범 재생 메서드
    public boolean playAllAlbum(HttpSession session, String albumId) {
        initializeSpotifyApi(session);

        try {
            // 앨범의 모든 트랙 가져오기
            Paging<TrackSimplified> albumTracksPaging = spotifyApi.getAlbumsTracks(albumId).build().execute();
            TrackSimplified[] albumTracks = albumTracksPaging.getItems();

            // 각 TrackSimplified 정보를 가져와 URI 배열 생성
            JsonArray uris = new JsonArray();
            for (TrackSimplified track : albumTracks) {
                uris.add(new JsonPrimitive("spotify:track:" + track.getId()));
            }

            // 전체 재생 요청
            var playRequest = spotifyApi.startResumeUsersPlayback()
                    .uris(uris) // 전체 트랙 URI 리스트 전달
                    .build();
            playRequest.execute();

            return true;
        } catch (IOException | SpotifyWebApiException | ParseException e) {
            System.out.println("Failed to play album: " + e.getMessage());
            return false;
        }
    }

    // 추천 플레이리스트 가져오기
    public List<PlaylistSimplified> getFeaturedPlaylists(HttpSession session) {
        initializeSpotifyApi(session);

        try {
            var featuredPlaylistsRequest = spotifyApi.getListOfFeaturedPlaylists()
                    .limit(10) // 필요한 플레이리스트 수를 설정
                    .build();

            // FeaturedPlaylists에서 Paging<PlaylistSimplified>를 가져옴
            FeaturedPlaylists featuredPlaylists = featuredPlaylistsRequest.execute();
            Paging<PlaylistSimplified> playlistsPaging = featuredPlaylists.getPlaylists();

            return Arrays.asList(playlistsPaging.getItems());
        } catch (IOException | SpotifyWebApiException | ParseException e) {
            System.out.println("Failed to fetch featured playlists: " + e.getMessage());
            return Collections.emptyList();
        }
    }

    // 추천 아티스트 가져오기
    public List<Artist> getRecommendedArtistsFromRecentTracks(HttpSession session) {
        initializeSpotifyApi(session);
        Set<String> artistIds = new HashSet<>();

        try {
            // 최근 재생한 항목을 가져와서 아티스트 ID를 추출
            PagingCursorbased<PlayHistory> recentlyPlayedTracks = spotifyApi.getCurrentUsersRecentlyPlayedTracks()
                    .limit(10)
                    .build()
                    .execute();

            for (PlayHistory playHistory : recentlyPlayedTracks.getItems()) {
                artistIds.add(playHistory.getTrack().getArtists()[0].getId());
            }

            // 중복 아티스트를 제거하고 최대 5개의 아티스트만 선택
            List<String> selectedArtistIds = artistIds.stream().limit(5).collect(Collectors.toList());
            List<Artist> recommendedArtists = new ArrayList<>();

            // 선택된 아티스트마다 추천 아티스트를 가져옴
            for (String artistId : selectedArtistIds) {
                Artist[] relatedArtists = spotifyApi.getArtistsRelatedArtists(artistId).build().execute();
                recommendedArtists.addAll(Arrays.asList(relatedArtists));
            }

            // 추천 아티스트 최대 10명으로 제한
            return recommendedArtists.stream().limit(10).collect(Collectors.toList());

        } catch (IOException | SpotifyWebApiException | ParseException e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }

    // Spotify API를 통해 트랙 정보 가져오기
    public String[] getAlbumIdByTrackId(HttpSession session, String trackId) {
        try {
            // Spotify API를 통해 트랙 정보 가져오기
            Track track = getTrackDetail(session, trackId);
            if (track != null && track.getAlbum() != null) {
                return new String[] {track.getAlbum().getId(), track.getArtists()[0].getId()};
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 검색에서 가장 연관된 아티스트 가져오는 메서드
    public Artist getRelatedArtists(HttpSession session, String query) {
        initializeSpotifyApi(session);

        try {
            // 검색어로 아티스트 검색
            SearchArtistsRequest searchRequest = spotifyApi.searchArtists(query).limit(1).build();
            Paging<Artist> searchResults = searchRequest.execute();

            if (searchResults != null && searchResults.getItems().length > 0) {
                // 첫 번째 아티스트의 ID로 연관 아티스트 검색
                String artistId = searchResults.getItems()[0].getId();
                Artist[] relatedArtists = spotifyApi.getArtistsRelatedArtists(artistId).build().execute();

                // 연관 아티스트가 있으면 첫 번째 아티스트만 반환
                return (relatedArtists.length > 0) ? relatedArtists[0] : null;
            }
        } catch (IOException | SpotifyWebApiException | ParseException e) {
            System.out.println("Failed to fetch related artist: " + e.getMessage());
            e.printStackTrace();
        }
        return null; // 오류 발생 시 null 반환
    }

    // 검색 결과에서 정확한 아티스트 반환
    public Artist searchArtistByName(HttpSession session, String query) {
        initializeSpotifyApi(session);

        try {
            SearchArtistsRequest searchRequest = spotifyApi.searchArtists(query).limit(50).build();
            Paging<Artist> artistSearchResults = searchRequest.execute();

            // 응답 로그 출력
            System.out.println("Artist Search Results for query '" + query + "': " + Arrays.toString(artistSearchResults.getItems()));

            // 정확히 이름이 일치하는 아티스트가 있는지 확인
            for (Artist artist : artistSearchResults.getItems()) {
                if (artist.getName().equalsIgnoreCase(query)) {
                    return artist;
                }
            }
        } catch (IOException | SpotifyWebApiException | ParseException e) {
            System.out.println("Failed to search artist by name: " + e.getMessage());
        }
        return null; // 일치하는 아티스트가 없으면 null 반환
    }

    // 앨범 검색 메서드
    public Paging<AlbumSimplified> searchAlbums(HttpSession session, String query) {
        try {
            return spotifyApi.searchAlbums(query)
                    .limit(10) // 검색 결과를 10개로 제한 (필요시 변경 가능)
                    .build()
                    .execute();
        } catch (IOException | SpotifyWebApiException | ParseException e) {
            e.printStackTrace();
            return null;
        }
    }

    // 플레이리스트 검색 메서드
    public List<PlaylistSimplified> searchPlaylists(HttpSession session, String query) {
        try {
            Paging<PlaylistSimplified> playlistResults = spotifyApi.searchPlaylists(query)
                    .limit(10) // 검색 결과를 10개로 제한 (필요시 변경 가능)
                    .build()
                    .execute();

            return Arrays.asList(playlistResults.getItems());
        } catch (IOException | SpotifyWebApiException | ParseException e) {
            e.printStackTrace();
            return null;
        }
    }

    public int getTrackDuration(HttpSession session, String trackId) {
        initializeSpotifyApi(session);

        try {
            // Spotify API를 통해 트랙 상세 정보 가져오기
            Track track = spotifyApi.getTrack(trackId).build().execute();
            if (track != null) {
                return track.getDurationMs();
            } else {
                System.out.println("트랙 정보를 가져오지 못했습니다: " + trackId);
                return -1;
            }
        } catch (IOException | SpotifyWebApiException | ParseException e) {
            System.out.println("트랙 재생 시간 가져오기 실패: " + e.getMessage());
            e.printStackTrace();
            return -1;
        }
    }
}
