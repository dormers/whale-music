const MainFooterComponent = {
	template: `
		<div class="footer flexCenter">
	        <div class="player">
	        	<div class="playerComponent" id="playerLeft">
	        		<div class="flexCenter" v-show="!isStarted"><img :src="trackInfo[0]" alt="" height="48px" style="border-radius: 5px; opacity: 0.9;"></div>
	        		<div class="playerRightStyle" v-show="!isStarted"><p class="playerTrackName">{{ trackInfo[1] }}</p><p class="playerArtistName">{{ trackInfo[2] }}</p></div>
	        		<div class="playerRightStyle" v-show="!isStarted" @click="insertTrack()"><img class="playerLikeImg" src="static/images/streaming/player/like.png" alt="Music Whale Like Button" width="23px" height="23px" :style="{backgroundColor: trackInfo[3] ? '#efefef' : '#FCFCFC'}"></div>
	        	</div>
	            <div class="playerComponent flexCenter">
	            	<button class="playerBtn flexCenter"><img src="static/images/streaming/player/shuffle.png" alt="Music Whale Shuffle Button" height="32px"></button>
	                <button class="playerBtn flexCenter" @click="prevPlay()"><img src="static/images/streaming/player/prev.png" alt="Music Whale Previous Button" height="42px"></button>
	                <button class="playerBtn flexCenter"v-if="isStarted" @click="playStart()"><img src="static/images/streaming/player/play.png" alt="Music Whale Play Button" height="42px"></button>
	                <button class="playerBtn flexCenter" v-show="!isStarted" @click="togglePlay()"><img :src="playBtnSrc[playBtnSrcIndex]" alt="Music Whale Play Button" height="42px"></button>
	                <button class="playerBtn flexCenter" @click="nextPlay()"><img src="static/images/streaming/player/next.png" alt="Music Whale Next Button" height="42px"></button>
	                <button class="playerBtn flexCenter"><img src="static/images/streaming/player/repeat.png" alt="Music Whale Repeat Button" height="32px"></button>
	            </div>
	            <div class="playerComponent" id="playerRight">
	            	<div class="playerRightMargin"><img class="playerFullScreenImg" src="static/images/streaming/player/fullScreenBtn.png" alt="Music Whale Full Screen Button" width="24px" height="24px" @click="fetchIframe('leftIframe','Full')"></div>
	            	<div class="playerRightMargin"><img class="playerPlayListImg" src="static/images/streaming/player/playlist.png" alt="Music Whale Playlist Button" width="34px" height="34px"></div>
	            </div>
	        </div>
	    </div>
	    <div class="footerMargin"></div>
	`,
	props: {
		fetchIframe: {type: Function, default() {return 'Default function'}},
		fetchWebApi: {type: Function, default() {return 'Default function'}},
	},
	data() {
		return {
			player: null,
			playbackState: null,
			trackInfo: [],
			isStarted: true,
			playBtnSrc: ['static/images/streaming/player/play.png','static/images/streaming/player/pause.png'],
			playBtnSrcIndex: 1,
		};
	},
	mounted() {
		this.playerOn();
	},
	methods: {
		playerOn() {
			window.onSpotifyWebPlaybackSDKReady = () => {
				this.player = new Spotify.Player({
			        name: 'Whale Player',
			        getOAuthToken: cb => { cb(sessionStorage.accessToken); },
			        volume: 0.5
			    });
			    
			    // [ Connection ]
			    this.player.connect().then(success => {
			        if (success) {
			            console.log('The Web Playback SDK successfully connected to Spotify!');
			        }
			    });
			    
			    // [ Ready ]
			    this.player.addListener('ready', ({ device_id }) => {
					sessionStorage.device_id = device_id;
					
					// [ The Spring Web App ]
					(async () => {await this.fetchData(`http://localhost:9002/whale/main/device_id`);})();
					
					// [ The Node js Web App ]
					this.fetchIframe('leftIframe',sessionStorage.device_id);
					
			        console.log('Ready with Device ID', device_id);
			    });
			    
			    // [ Not Ready ]
			    this.player.addListener('not_ready', ({ device_id }) => {
			        console.log('Device ID has gone offline', device_id);
			    });
			
			    this.player.addListener('initialization_error', ({ message }) => {
			        console.error(message);
			    });
			
			    this.player.addListener('authentication_error', ({ message }) => {
			        console.error(message);
			    });
			
			    this.player.addListener('account_error', ({ message }) => {
			        console.error(message);
			    });
			    
			    // [ Player State Changed ]
			    this.player.addListener('player_state_changed', ({
			        track_window: { current_track }
			    }) => {
			        this.trackInfo[0] = current_track.album.images[0].url;
			        this.trackInfo[1] = current_track.name;
			        this.trackInfo[2] = current_track.artists[0].name;
			        this.trackInfo[3] = false;
			    });
			}
		},
		
		async playStart() {try {this.isStarted = false; await this.fetchWebApi(`v1/me/player/play?device_id=${sessionStorage.device_id}`,'PUT');} catch(error) {}},
		async insertTrack() {
			this.trackInfo[3] = true;
            try {
                const body = {
                    trackArtist: this.playbackState.items[0].track.artists[0].name,
                    trackName: this.playbackState.items[0].track.name,
                    trackAlbum: this.playbackState.items[0].track.album.name,
                    trackCover: this.playbackState.items[0].track.album.images[0].url,
                    trackSpotifyId: this.playbackState.items[0].track.id,
                };
                const response = await fetch('streaming/insertTrack', {
                    headers: {
                        'Accept': 'application/json',
                        'Content-Type': 'application/json'
                    },
                    method: 'POST',
                    body: JSON.stringify(body)
                });
                
                if (response.ok) {
					console.log("Success inserting Data to the Spring Wep App");
		        } else {
		            console.error('Failed to insert the track info: ', response.statusText);
		        }
            } catch (error) {
                console.error('Error while fetching the track info:', error);
            }
        },
        async fetchData(address) {
			const body = {
				device_id: sessionStorage.device_id,
			};
	        const response = await fetch(`${ address }`, {
		        headers: {
		            'Accept': 'application/json',
		            'Content-Type': 'application/json'
		        },
		        method: 'POST',
		        body: JSON.stringify(body)
	    	});
	        
	        if (response.ok) {
	            console.log("Success fetching Data to the Spring Wep App");
	        } else {
	            console.error('Failed to fetch the device_id: ', response.statusText);
	        }
		},
		
		togglePlay() {if (this.playBtnSrcIndex === 1) {this.playBtnSrcIndex = 0;} else {this.playBtnSrcIndex = 1;} this.player.togglePlay();},
		nextPlay() {if (this.playBtnSrcIndex === 0) {this.playBtnSrcIndex = 1;} this.player.nextTrack();},
		prevPlay() {if (this.playBtnSrcIndex === 0) {this.playBtnSrcIndex = 1;} this.player.previousTrack();},
	},
};

export default MainFooterComponent;