package com.tech.whale.streaming.models;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class TrackDto {
	private String track_id;
	private String track_artist;
	private String track_name;
	private String track_album;
	private String track_cover;
	
	private Date track_like_date;
	private boolean liked;  // 좋아요 상태 필드 추가
	private int durationMs;
}
