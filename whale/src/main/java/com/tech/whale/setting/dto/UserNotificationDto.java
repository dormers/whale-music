package com.tech.whale.setting.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class UserNotificationDto {

	private int all_notification_off;
	private int like_notification_onoff;
	private int comment_notification_onoff;
	private int message_notification_onoff;
}
