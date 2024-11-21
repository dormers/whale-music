package com.tech.whale.streaming.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.JsonArray;
import com.tech.whale.streaming.models.TrackDto;
import com.tech.whale.streaming.service.StreamingService;

@RestController
public class StreamingRestController {
	private StreamingService streamingService;
	
	public StreamingRestController(StreamingService streamingService) {
		this.streamingService = streamingService;
	}
	
	@PostMapping(value = "/streaming/currentTrackInfo", produces = MediaType.APPLICATION_JSON_VALUE)
    public HashMap<String, Object> currentTrackInfo(@RequestBody HashMap<String, Object> map, HttpSession session) {
		HashMap<String, Object> response = new HashMap<>();
		
    	String artistName = map.get("artistName").toString();
    	String trackName = map.get("trackName").toString();
    	String albumName = map.get("albumName").toString();
    	String albumCover = map.get("trackCover").toString();
    	String trackSpotifyId = map.get("trackSpotifyId").toString();
    	
    	// 트랙 아이디 반환 및 세션 저장
    	String trackId = streamingService.selectTrackIdService(trackSpotifyId, artistName, trackName, albumName, albumCover);
    	
    	session.setAttribute("trackId", trackId);
    	
    	// 좋아요 테이블 확인 및 반환
    	if (streamingService.selectTrackLikeService(session, trackSpotifyId)) {response.put("result", "yes"); return response;}
    	else {response.put("result", "no"); return response;}
    }
	
	@PostMapping(value = "/streaming/insertTrackLike", produces = MediaType.APPLICATION_JSON_VALUE)
    public void insertTrackLike(@RequestBody HashMap<String, Object> map, HttpSession session) {
    	String artistName = map.get("artistName").toString();
    	String trackName = map.get("trackName").toString();
    	String albumName = map.get("albumName").toString();
    	String albumCover = map.get("trackCover").toString();
    	String trackSpotifyId = map.get("trackSpotifyId").toString();
    	
    	// 트랙 아이디 반환 및 트랙 좋아요 테이블 삽입
    	streamingService.insertTrackLikeService(session, trackSpotifyId, artistName, trackName, albumName, albumCover);
    }
	
	@PostMapping(value = "/streaming/insertTrackCnt", produces = MediaType.APPLICATION_JSON_VALUE)
    public void insertTrackCnt(@RequestBody HashMap<String, Object> map, HttpSession session) {
    	String artistName = map.get("artistName").toString();
    	String trackName = map.get("trackName").toString();
    	String albumName = map.get("albumName").toString();
    	String albumCover = map.get("trackCover").toString();
    	String trackSpotifyId = map.get("trackSpotifyId").toString();
    	
    	// 트랙 아이디 반환 및 트랙 좋아요 테이블 삽입
    	streamingService.updateTrackCntService(session, trackSpotifyId, artistName, trackName, albumName, albumCover);
    }
	
	@PostMapping(value = "/streaming/deleteTrackLike", produces = MediaType.APPLICATION_JSON_VALUE)
    public void deleteTrackLike(@RequestBody HashMap<String, Object> map, HttpSession session) {
    	String trackSpotifyId = map.get("trackSpotifyId").toString();
    	// 트랙 좋아요 테이블 삭제
    	streamingService.deleteTrackLikeService(session, trackSpotifyId);
    }
    
	// 트랙 좋아요 숫자 반환
    @GetMapping(value = "/streaming/likeCnt", produces = MediaType.APPLICATION_JSON_VALUE)
    public HashMap<String, Object> LikeCnt(@RequestParam("userId") String userId) {
    	HashMap<String, Object> response = new HashMap<>();
    	response.put("CNT", streamingService.getLikeCountInfoService(userId));
    	return response;
    }
    
    // 트랙 좋아요 테이블 반환
    @GetMapping(value = "/streaming/userLikeInfo", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<TrackDto> userLikeInfo(@RequestParam("userId") String userId) {
    	List<TrackDto> result = streamingService.getLikedTracks(userId);
    	return result;
    }
    
    // 트랙 좋아요 확인
    @GetMapping(value = "/streaming/userLikeBoolInfo", produces = MediaType.APPLICATION_JSON_VALUE)
    public Boolean userLikeBoolInfo(@RequestParam("userId") String userId, @RequestParam("trackId") String trackId) {
    	return streamingService.getTrackLikeBoolService(userId, trackId);
    }
    
    // 노드용
    @PostMapping(value = "/streaming/insertTrackLikeNode", produces = MediaType.APPLICATION_JSON_VALUE)
    public void insertTrackLikeNode(@RequestBody HashMap<String, Object> map, HttpSession session) {
    	String userId = map.get("userId").toString();
    	String artistName = map.get("artistName").toString();
    	String trackName = map.get("trackName").toString();
    	String albumName = map.get("albumName").toString();
    	String albumCover = map.get("trackCover").toString();
    	String trackSpotifyId = map.get("trackSpotifyId").toString();
    	
    	// 트랙 아이디 반환 및 트랙 좋아요 테이블 삽입
    	streamingService.insertTrackLikeNodeService(userId, trackSpotifyId, artistName, trackName, albumName, albumCover);
    }
    
    @GetMapping(value = "/streaming/deleteTrackLikeNode", produces = MediaType.APPLICATION_JSON_VALUE)
    public void deleteTrackLikeNode(@RequestParam("userId") String userId, @RequestParam("trackId") String trackId) {
    	// 트랙 좋아요 테이블 삭제
    	streamingService.deleteTrackLikeNodeService(userId, trackId);
    }
    
    // 플레이리스트 추가 및 삭제
    @GetMapping(value = "/streaming/followPlaylist", produces = MediaType.APPLICATION_JSON_VALUE)
    public void followPlaylist(@RequestParam("id") String playlistId) {
    	streamingService.followPlaylistService(playlistId);
    }
    
    // 플레이리스트 추가 및 삭제
    @GetMapping(value = "/streaming/unfollowPlaylist", produces = MediaType.APPLICATION_JSON_VALUE)
    public void unfollowPlaylist(@RequestParam("id") String playlistId) {
    	streamingService.unfollowPlaylistService(playlistId);
    }
    
    // 좋아요 전체 트랙 재생
    @PostMapping(value = "/streaming/playAllLikeTrack", produces = MediaType.APPLICATION_JSON_VALUE)
    public void playAllLikeTrack(@RequestBody HashMap<String, Object> map, HttpSession session) {
    	streamingService.playAllLikeTrackService(session, map.get("uris").toString());
    }
    
    // 트랙 아이디 인서트
    @PostMapping(value = "/streaming/insertTrackInfo", produces = MediaType.APPLICATION_JSON_VALUE)
    public void insertTrackInfo(@RequestBody HashMap<String, Object> map, HttpSession session) {
    	String artistName = map.get("artistName").toString();
    	String trackName = map.get("trackName").toString();
    	String albumName = map.get("albumName").toString();
    	String albumCover = map.get("trackCover").toString();
    	String trackSpotifyId = map.get("trackSpotifyId").toString();
    	
    	streamingService.selectTrackIdService(trackSpotifyId, artistName, trackName, albumName, albumCover);
    }
}
