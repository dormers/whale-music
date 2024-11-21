package com.tech.whale.streaming.models;

import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper
public interface StreamingDao {
	public String selectTrackId(String trackSpotifyId);
	public Integer selectTrackLikeId(String userId, String trackSpotifyId);
	public TrackDto selectTrackDto(String trackSpotifyId);
	public void insertTrack(String track_spotify_id, String track_artist, String track_name, String track_album, String track_cover);
	public void insertTrackLike(String trackSpotifyId, String userId);
	public void insertTrackCnt(String trackSpotifyId, String userId);
	public void deleteTrackLike(Integer trackLikeId);
	public List<TrackDto> selectLikedTracks(String userId);
	public Integer getLikeCountInfo(String userId);
	public Integer getTrackLikeCountInfo(String userId, String trackSpotifyId);
}
