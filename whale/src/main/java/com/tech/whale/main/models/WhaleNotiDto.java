package com.tech.whale.main.models;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class WhaleNotiDto {
	private int whale_noti_id;
	private int whale_noti_check;
	private Date whale_noti_date;
	private int whale_noti_type;
	private String whale_noti_text;
}
