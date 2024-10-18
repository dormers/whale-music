package com.tech.whale.streaming.models;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface StreamingTrackDao {
	public void insertTrack(String trackArtist, String trackName, String trackAlbum, String trackCover, String trackSpotifyId);
}
