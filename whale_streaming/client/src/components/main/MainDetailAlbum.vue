<template>
    <div class="playlistDetail">
        <div class="playlistDetailContainer" v-if="artist !== null">
            <img :src="album.images[0].url" :alt="album.name" width="230"
                        height="230" style="border-radius: 8px;">
            <div class="playlistDetailInfo">
                <p class="detailSort">{{ album.album_type }}</p>
                <p class="playlistName">{{ album.name }}</p>
                <div class="trackDescription">
                    <img :src="artist.images[0].url" :alt="album.name" width="24" height="24" style="border-radius: 50%; cursor: pointer;" @click="redirectRouter('artist',artist.id)">
                    <p class="trackFont" style="margin-left: 2px;" @click="redirectRouter('artist',artist.id)">{{ album.artists[0].name }}</p>
                    <p> • </p>
                    <p>{{ album.total_tracks }}곡</p>
                    <p> • </p>
                    <p>{{ String(Math.floor( totalTrack / (1000 * 60 ) )).padStart(2, "0") }}분 {{ String(Math.floor( ( totalTrack % (1000 * 60 )) / 1000 )).padStart(2, "0") }}초</p>
                    <p> • </p>
                    <p>{{ album.release_date }}</p>
                </div>
            </div>
        </div>
    </div>
    <div class="playlistFunction">
        <div class="playlistBtnCircle">
            <svg
                data-encore-id="icon"
                role="img"
                aria-hidden="true"
                viewBox="0 0 24 24"
                class="playlistBtn"
                @click="playPlayer(album.uri)"
            >
                <path d="m7.05 3.606 13.49 7.788a.7.7 0 0 1 0 1.212L7.05 20.394A.7.7 0 0 1 6 19.788V4.212a.7.7 0 0 1 1.05-.606z"
                ></path>
            </svg>
        </div>
    </div>
    <div class="playlist-tracks" style="height: 25px; margin-top: 5px; pointer-events: none;">
        <div class="playlist-tracks-top" style="justify-content: center;">#</div>
        <div class="playlist-tracks-top" style="padding-left: 5px;">제목</div>
        <div class="playlist-tracks-top" style="justify-content: center;">시간</div>
    </div>
    <div v-if="artist !== null" style="width: 100%; height: 50%; margin-top: 19px;">
        <div class="playlist-tracks" style="padding: 9px 0;" v-for="(item, i) in album.tracks.items" :key="i" @mouseover="isShow[i] = true" @mouseleave="isShow[i] = false">
            <div class="playlist-tracks-content" style="justify-content: center;" v-if="!isShow[i]">{{ i+1 }}</div>
            <div class="playlist-tracks-content" style="justify-content: center;" v-if="addIsShow(i)">
                <svg
                    data-encore-id="icon"
                    role="img"
                    aria-hidden="true"
                    viewBox="0 0 24 24"
                    class="playlistTrackBtn"
                    style="height: 16px;"
                    @click="playPlayer(item.uri,i)"
                >
                <path :d=" isPlayed[i] === false ? 'm7.05 3.606 13.49 7.788a.7.7 0 0 1 0 1.212L7.05 20.394A.7.7 0 0 1 6 19.788V4.212a.7.7 0 0 1 1.05-.606z' : 'M6 19h4V5H6zm8-14v14h4V5z'"
                    ></path>
                </svg>
            </div>
            <div class="playlist-tracks-content" style="display: block; padding-left: 5px;">
                <p style="font-weight: 400; cursor: pointer;"  @click="redirectRouter('track',item.id)">{{ item.name }}</p>
                <p style="cursor: pointer;" @click="redirectRouter('artist',item.artists[0].id)">{{ item.artists[0].name }}</p>
            </div>
            <div class="playlist-tracks-content" style="justify-content: center; font-size: 12px;" v-if="!isShow[i]">{{ String(Math.floor(( item.duration_ms / (1000 * 60 )) )).padStart(2, "0") }}분 {{ String(Math.floor(( item.duration_ms % (1000 * 60 )) / 1000 )).padStart(2, "0") }}초</div>
            <div class="playlist-tracks-content" style="justify-content: center;" v-if="isShow[i]">
                <svg
                    data-encore-id="icon"
                    role="img"
                    aria-hidden="true"
                    viewBox="0 0 24 24"
                    class="playlistTrackBtn likeBtn"
                    :style="{ fill: like[i] === true ? 'rgb(203, 130, 163)' : '#000000' }"
                    @click="changeTrackLikeInfo(item.artists[0].name, item.name, album.name, album.images[0].url, item.id, i)"
                >
                    <!-- 조건부로 좋아요 여부에 따라 아이콘 변경 가능 -->
                    <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"
                    ></path>
                </svg>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            artist: null,
            album: null,
            totalTrack: null,
            isShow: [],
            like: [],
            isPlayed: [],
            position: [],
        }
    },
    mounted() {
        this.getAlbumInfo();
        this.changeBackground();
    },
    methods: {
        async getAlbumInfo() {
            const result = await fetch(`/whale/streaming/getAlbumInfo?id=${this.$route.params.id}`);
            if (await result.ok) {
                const data = await result.json();
                this.album = await data;

                this.album.tracks.items.forEach((el, index) => {
                    this.totalTrack += el.duration_ms;
                    this.getTrackLikeInfo(el.id,index);
                });
                
                fetch(`/whale/streaming/getArtistInfo?id=${this.album.artists[0].id}`)
                    .then((response) => response.json())
                    .then((data) => {
                        this.artist = data;
                    })
            } else {
                console.error('Failed to fetch user top items:', result.statusText);
            }
        },
        async playPlayer(i,j) {
            if (this.isPlayed[j] === false) {
                fetch(`/whale/streaming/play?uri=${ i }&device_id=${ sessionStorage.device_id }&position=${ this.position[j] }`);
                this.isPlayed.forEach((el, index) => {
                    if (el === true) {this.isPlayed[index] = false;}
                });
            } else {
                fetch(`/whale/streaming/pause?device_id=${ sessionStorage.device_id }`)
                .then((response) => response.json())
                .then((data) => {
                    this.position[j] = data.progress_ms;
                });
            }
            this.isPlayed[j] = !this.isPlayed[j];
        },
        getRandomColor() {
            // 랜덤 RGB 색상 생성 함수
            const r = Math.floor(Math.random() * 256);
            const g = Math.floor(Math.random() * 256);
            const b = Math.floor(Math.random() * 256);
            console.log("Generated RGB values:", r, g, b);
            return `rgb(${r}, ${g}, ${b})`;
        },
        changeBackground() {
            if (localStorage.getItem('darkmodeOn') === "1") {document.querySelector('.mainContent').style.backgroundImage = `linear-gradient(${this.getRandomColor()} 0%, rgb(17, 18, 17) 100%)`;}
            else {document.querySelector('.mainContent').style.backgroundImage = `linear-gradient(${this.getRandomColor()} 0%, rgb(249, 250, 249) 100%)`;}
        },
        addIsShow(i) {
            this.isPlayed.push(false);
            this.isShow.push(false);
            this.position.push(0);
            return this.isShow[i];
        },
        redirectRouter(i,y) {
            this.$router.push(`/whale/streaming/detail/${i}/${y}`);
        },
        getTrackLikeInfo(i,j) {
            fetch(`http://localhost:9002/whale/streaming/userLikeBoolInfo?userId=${ sessionStorage.userId }&trackId=${ i }`)
                .then((response) => response.json())
                .then((data) => {
                    this.like[j] = data;
                })
        },
        changeTrackLikeInfo(a,b,c,d,e,x){
            if (this.like[x] === false) {
                const body = {
                    userId: sessionStorage.userId,
                    artistName: a,
                    trackName: b,
                    albumName: c,
                    trackCover: d,
                    trackSpotifyId: e
                };

                fetch(`http://localhost:9002/whale/streaming/insertTrackLikeNode`, {
                    headers: {
                        'Accept': 'application/json',
                        'Content-Type': 'application/json'
                    },
                    method: 'POST',
                    body: JSON.stringify(body)
                });
            }
            else {
                fetch(`http://localhost:9002/whale/streaming/deleteTrackLikeNode?userId=${ sessionStorage.userId }&trackId=${ e }`);
            }
            this.like[x] = !this.like[x];
        }
    },
};
</script>

<style scoped>
    .playlistDetail {display: flex; align-items: center; width: 95%; height: 35%; padding: 40px 0 20px 15px;}
    .playlistDetailContainer {display: flex; gap: 20px; color: white; align-items: end; width: 100%; padding-left: 20px; overflow-x: scroll; -ms-overflow-style: none;}
    #app.light .playlistDetailContainer {color: #111;}
    .playlistDetailInfo {width: 75%; height: 170px; overflow: auto; white-space: nowrap; text-overflow: ellipsis;}
    .detailSort {margin-top: 15px; margin-left: 2px; font-size: 12px; font-weight: 300; letter-spacing: 0.3px; opacity: 0.7;}
    .trackDescription{font-size: 12px; font-weight: 300; letter-spacing: .2px; opacity: .8; display: flex; align-items: center; margin-top: 15px; gap: 5px;}
    .trackFont {font-size: 14px; font-weight: bold; cursor: pointer;}
    .playlistName {font-size: 64px; font-weight: 400; letter-spacing: 0.4px; opacity: 0.8;}
    .playlistFunction {width: 100%; margin-bottom: 20px;}
    .playlistBtnCircle {display: flex; justify-content: center; align-items: center; width: 50px; height: 50px; margin-left: 30px; border-radius: 50%; background-color: rgb(30, 214, 96);}
    .playlistBtnCircle:hover {opacity: 0.8;}
    .playlistBtnCircle:active {opacity: 0.6;}
    .playlistBtn {height: 22px;}
    .playlist-tracks {position: relative; display: grid; grid-template-columns: 6% 83% 11%; width: 95%; margin-left: 20px;}
    .playlist-tracks:hover {border-radius: 5px; background-color: #5e5e5e;}
    #app.light .playlist-tracks:hover {background-color: #f0f0f0;}
    .playlist-tracks-top {display: flex; align-items: center; height: 25px; border-bottom: 0.5px solid rgb(197, 197, 197, 0.7); padding-top: 10px; padding-bottom: 6px; font-size: 13px; color: #ffffff; font-weight: 300; letter-spacing: 0.2px; opacity: 0.8;}
    #app.light .playlist-tracks-top {border-bottom: 0.5px solid #111; color: #111;}
    .playlist-tracks-content {display: flex; align-items: center; height: 32px; color: #ffffff; font-size: 14px; font-weight: 300; letter-spacing: 0.2px; opacity: 0.8;}
    #app.light .playlist-tracks-content {color: #000;}
    .playlistTrackBtn:hover {opacity: 0.8;}
    .playlistTrackBtn:active {opacity: 0.6;}
    .likeBtn {height: 16px; cursor: pointer;}
</style>