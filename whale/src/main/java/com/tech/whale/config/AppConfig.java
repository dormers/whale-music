package com.tech.whale.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import se.michaelthelin.spotify.SpotifyApi;
import se.michaelthelin.spotify.SpotifyHttpManager;

@Configuration
public class AppConfig {
	// [ Spotify API 빈 생성 ]
	@Bean
	public SpotifyApi spotifyApi() {
		return new SpotifyApi.Builder().setClientId("f2cc9888d2084241bab84a860b658d81")
									   .setClientSecret("8c910bf3638e4de5932b72f60fcea918")
									   .setRedirectUri(SpotifyHttpManager.makeUri("http://localhost:9002/whale/callback"))
									   .build();
	}
}
