package com.tech.whale.streaming;

import java.util.HashMap;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.tech.whale.streaming.models.StreamingTrackDao;

@RestController
public class StreamingController {
	private StreamingTrackDao streamingTrackDao;
	
	public StreamingController(StreamingTrackDao streamingTrackDao) {
		this.streamingTrackDao = streamingTrackDao;
	}
	
	@PostMapping(value = "/streaming/insertTrack", produces = MediaType.APPLICATION_JSON_VALUE)
	public void insertTrack(@RequestBody HashMap<String, Object> map) {
		streamingTrackDao.insertTrack((String)map.get("trackArtist"),(String)map.get("trackName"),(String)map.get("trackAlbum"),
									  (String)map.get("trackCover"),(String)map.get("trackSpotifyId"));
	}
}
