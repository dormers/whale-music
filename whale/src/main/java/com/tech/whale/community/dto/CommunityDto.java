package com.tech.whale.community.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class CommunityDto {
	private int community_id;
	private String community_name;
	private String community_follow;
	private String community_name_en;
}
