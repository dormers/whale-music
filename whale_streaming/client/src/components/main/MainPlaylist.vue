<template>
    <div class="playlistDetail">
        <div class="playlistDetailContainer" v-if="playlist !== null">
            <img :src="playlist.images[0].url" :alt="playlist.name" width="170"
                        height="170" style="border-radius: 8px;">
            <div class="playlistDetailInfo">
                <p class="detailSort">플레이리스트</p>
                <p class="playlistName">{{ playlist.name }}</p>
                <p class="playlistDesc">{{ deleteTag(playlist.description) }}</p>
                <p class="playlistOpt">WHALE • {{ playlist.tracks.total }}곡</p>
            </div>
        </div>
        <div class="playlistDetailContainer" v-if="isLiked === true">
            <img src="https://misc.scdn.co/liked-songs/liked-songs-300.png" :alt="좋아요" width="170"
                        height="170" style="border-radius: 8px;">
            <div class="playlistDetailInfo">
                <p class="detailSort" style="padding-top: 20px;">플레이리스트</p>
                <p class="playlistName">좋아요 표시한 곡</p>
                <p class="playlistOpt" style="margin-top: 0; margin-left: 5px;" v-if="userLike !== null"> {{ userName }} • {{ userLike.length }}곡</p>
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
                @click="playPlayer( isLiked === false ? playlist.uri : userLikeTracks )"
            >
                <path d="m7.05 3.606 13.49 7.788a.7.7 0 0 1 0 1.212L7.05 20.394A.7.7 0 0 1 6 19.788V4.212a.7.7 0 0 1 1.05-.606z"
                ></path>
            </svg>
        </div>
        <div class="playlistAddContainer" v-if="isLiked === false && playlist !== null && playlist.owner.display_name === 'Spotify'">
            <svg
                data-encore-id="icon"
                role="img"
                aria-hidden="true"
                viewBox="0 0 24 24"
                class="playlistAddBtn"
                v-if="isAdded === false"
                @click="followPlaylist(playlist.id)"
            >
                <path d="M11.999 3a9 9 0 1 0 0 18 9 9 0 0 0 0-18zm-11 9c0-6.075 4.925-11 11-11s11 4.925 11 11-4.925 11-11 11-11-4.925-11-11z"
                ></path>
                <path d="M17.999 12a1 1 0 0 1-1 1h-4v4a1 1 0 1 1-2 0v-4h-4a1 1 0 1 1 0-2h4V7a1 1 0 1 1 2 0v4h4a1 1 0 0 1 1 1z"
                ></path>
            </svg>
            <img src="../../../public/images/main/cross.png" alt="cross" width="30" height="30" class="crossBtn" style="cursor: pointer;" v-if="isAdded === true" @click="followPlaylist(playlist.id)">
        </div>
    </div>
    <div class="playlist-tracks" style="height: 25px; margin-top: 5px; pointer-events: none;">
        <div class="playlist-tracks-top" style="justify-content: center;">#</div>
        <div class="playlist-tracks-top" style="padding-left: 5px;">제목</div>
        <div class="playlist-tracks-top" style="padding-left: 5px;">앨범</div>
        <div class="playlist-tracks-top" style="justify-content: center;" v-if="isLiked === false">시간</div>
        <div class="playlist-tracks-top" style="justify-content: center;" v-if="isLiked === true">추가한 날짜</div>
    </div>
    <div v-if="playlist !== null" style="width: 100%; height: 50%; margin-top: 19px;">
        <div class="playlist-tracks" style="padding: 9px 0;" v-for="(item, i) in playlist.tracks.items" :key="i" @mouseover="isShow[i] = true" @mouseleave="isShow[i] = false">
            <div class="playlist-tracks-content" style="justify-content: center;" v-if="!isShow[i]">{{ i+1 }}</div>
            <div class="playlist-tracks-content" style="justify-content: center;" v-if="addIsShow(i)">
                <svg
                    data-encore-id="icon"
                    role="img"
                    aria-hidden="true"
                    viewBox="0 0 24 24"
                    class="playlistTrackBtn"
                    style="height: 16px;"
                    @click="playPlayer(item.track.uri,i)"
                >
                    <path :d=" isPlayed[i] === false ? 'm7.05 3.606 13.49 7.788a.7.7 0 0 1 0 1.212L7.05 20.394A.7.7 0 0 1 6 19.788V4.212a.7.7 0 0 1 1.05-.606z' : 'M6 19h4V5H6zm8-14v14h4V5z'"
                    ></path>
                </svg>
            </div>
            <div class="playlist-tracks-content" style="padding-left: 5px;">
                <img :src="item.track.album.images[0].url" :alt="item.track.name" height="40" style="border-radius: 2px; margin-right: 10px;">
                <span style="cursor: pointer;" @click="redirectRouter('track',item.track.id)">{{ item.track.name }}</span>&nbsp;/&nbsp;<span style="cursor: pointer;" @click="redirectRouter('artist',item.track.artists[0].id)">{{ item.track.artists[0].name }}</span>
            </div>
            <div class="playlist-tracks-content" style="padding-left: 5px; font-size: 13px; cursor: pointer;" @click="redirectRouter('album',item.track.album.id)">{{ item.track.album.name }}</div>
            <div class="playlist-tracks-content" style="justify-content: center; font-size: 12px;" v-if="!isShow[i]">{{ String(Math.floor(( item.track.duration_ms / (1000 * 60 )) )).padStart(2, "0") }}분 {{ String(Math.floor(( item.track.duration_ms % (1000 * 60 )) / 1000 )).padStart(2, "0") }}초</div>
            <div class="playlist-tracks-content" style="justify-content: center;" v-if="isShow[i]">
                <svg
                    data-encore-id="icon"
                    role="img"
                    aria-hidden="true"
                    viewBox="0 0 24 24"
                    class="playlistTrackBtn likeBtn"
                    :style="{ fill: like[i] === true ? 'rgb(203, 130, 163)' : '#000000' }"
                    @click="changeTrackLikeInfo(item.track.artists[0].name, item.track.name, item.track.album.name, item.track.album.images[0].url, item.track.id, i)"
                >
                    <!-- 조건부로 좋아요 여부에 따라 아이콘 변경 가능 -->
                    <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"
                    ></path>
                </svg>
            </div>
        </div>
    </div>
    <div v-if="isLiked !== null" style="width: 100%; height: 50%; margin-top: 19px;">
        <div class="playlist-tracks" style="padding: 9px 0;" v-for="(item, i) in userLike" :key="i" @mouseover="isShow[i] = true" @mouseleave="isShow[i] = false">
            <div class="playlist-tracks-content" style="justify-content: center;" v-if="!isShow[i]">{{ i+1 }}</div>
            <div class="playlist-tracks-content" style="justify-content: center;" v-if="addIsShow(i)">
                <svg
                    data-encore-id="icon"
                    role="img"
                    aria-hidden="true"
                    viewBox="0 0 24 24"
                    class="playlistTrackBtn"
                    style="height: 16px;"
                    @click="playPlayer(`spotify:track:${item.track_id}`,i)"
                >
                    <path :d=" isPlayed[i] === false ? 'm7.05 3.606 13.49 7.788a.7.7 0 0 1 0 1.212L7.05 20.394A.7.7 0 0 1 6 19.788V4.212a.7.7 0 0 1 1.05-.606z' : 'M6 19h4V5H6zm8-14v14h4V5z'"
                    ></path>
                </svg>
            </div>
            <div class="playlist-tracks-content" style="padding-left: 5px;">
                <img :src="item.track_cover" :alt="item.track_name" height="40" style="border-radius: 2px; margin-right: 10px;">
                <span style="cursor: pointer;" @click="redirectRouter('track',item.track_id)">{{ item.track_name }}</span>&nbsp;/&nbsp;<span style="cursor: pointer;" @click="redirectRouter('artist',temp[i].artists[0].id)">{{ item.track_artist }}</span>
            </div>
            <div class="playlist-tracks-content" style="padding-left: 5px; font-size: 13px; cursor: pointer;" @click="redirectRouter('album',temp[0].album.id)">{{ item.track_album }}</div>
            <div class="playlist-tracks-content" style="justify-content: center; font-size: 12px;" v-if="!isShow[i]">{{ new Date(item.track_like_date).getFullYear() }}.{{ String(new Date(item.track_like_date).getDay()).padStart(2, "0") }}.{{ String(new Date(item.track_like_date).getDate()).padStart(2, "0") }}</div>
            <div class="playlist-tracks-content" style="justify-content: center;" v-if="isShow[i]">
                <svg
                    data-encore-id="icon"
                    role="img"
                    aria-hidden="true"
                    viewBox="0 0 24 24"
                    class="playlistTrackBtn likeBtn"
                    :style="{ fill: like[i] === true ? 'rgb(203, 130, 163)' : '#000000' }"
                    @click="changeTrackLikeInfo(item.track_artist, item.track_name, item.track_album, item.track_cover, item.track_id, i)"
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
    props: {
        libraries: Object,
    },
    data() {
        return {
            playlist: null,
            isShow: [],
            isLiked: false,
            userName: sessionStorage.userId,
            userLike: null,
            userLikeTracks: null,
            temp: [],
            like: [],
            isPlayed: [],
            position: [],
            isAdded: false,
        }
    },
    mounted() {
        this.getUserPlaylists();
        this.changeBackground();
    },
    methods: {
        async getUserPlaylists() {
            if(this.$route.params.id === '0') {
                this.isLiked = true;
                fetch(`http://localhost:9002/whale/streaming/userLikeInfo?userId=${ sessionStorage.userId }`)
                    .then((response) => response.json())
                    .then((data) => {
                        this.userLike = data;
                        this.userLikeTracks = this.userLike.map((el) => {return `spotify:track:${el.track_id}`});

                        this.userLike.forEach((el, index) => {
                            this.getTrackInfo(el.track_id,index);
                            this.getTrackLikeInfo(el.track_id,index);
                        });
                    })
            } else {
                this.isLiked = false;
                const result = await fetch(`/whale/streaming/getPlaylist?id=${this.$route.params.id}`);
                if (await result.ok) {
                    const data = await result.json();
                    if (data && data.tracks.items.length > 0) {
                        this.playlist = data;

                        this.playlist.tracks.items.forEach((el, index) => {
                            this.getTrackLikeInfo(el.track.id,index);
                        });
                        this.libraries.forEach((el) => {
                            if (el.id === this.playlist.id) {this.isAdded = true;}
                        });
                    } else {
                        console.error('No items found');
                    }
                } else {
                    console.error('Failed to fetch user top items:', result.statusText);
                }
            }
        },
        async playPlayer(i,j) {
            if (typeof i === 'object') {
                const body = {
                    uri: i,
                    device_id: sessionStorage.device_id,
                };
                fetch(`/whale/streaming/plays`, {
                    headers: {
                        'Accept': 'application/json',
                        'Content-Type': 'application/json'
                    },
                    method: 'POST',
                    body: JSON.stringify(body)
                });
            } else if (i.substring(8,16) === 'playlist') {
                fetch(`/whale/streaming/play?uri=${ i }&device_id=${ sessionStorage.device_id }`);
            } else {
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
            }
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
        deleteTag(i) {
            // a 태그를 찾아 제거
            const parser = new DOMParser();
            const parsedContent = parser.parseFromString(i, 'text/html');
            const links = parsedContent.querySelectorAll("a");

            // 각 a 태그를 순회하며 텍스트만 남기기
            links.forEach(link => {
                const textNode = document.createTextNode(link.textContent);
                link.replaceWith(textNode);
            });

            // 수정된 내용을 다시 playlistDesc에 반영
            return parsedContent.body.innerHTML;
        },
        redirectRouter(i,y) {
            this.$router.push(`/whale/streaming/detail/${i}/${y}`);
        },
        getTrackInfo(i,j) {
            fetch(`/whale/streaming/getTrackInfo?id=${i}`)
                .then((response) => response.json())
                .then((data) => {
                    this.temp[j] = data;
                })
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
        },
        followPlaylist(i) {
            if (this.isAdded === false) {
                fetch(`/whale/streaming/followPlaylist?id=${ i }`);
            } else {
                fetch(`/whale/streaming/unfollowPlaylist?id=${ i }`);
            }
            this.isAdded = !this.isAdded;
            setTimeout(() => {this.$emit('updateLibrary');},500);
        }
    },
};
</script>

<style scoped>
    .playlistDetail {display: flex; align-items: center; width: 100%; height: 35%;}
    .playlistDetailContainer {display: flex; gap: 20px; color: white; align-items: end; width: 100%; padding-left: 20px; overflow-x: scroll; -ms-overflow-style: none;}
    #app.light .playlistDetailContainer {color: #111;}
    .playlistDetailInfo {width: 75%; height: 170px; overflow: auto; white-space: nowrap; text-overflow: ellipsis;}
    .detailSort {margin-top: 20px; margin-left: 2px; font-size: 12px; font-weight: 200; letter-spacing: 0.3px; opacity: 0.7;}
    .playlistName {font-size: 64px; font-weight: 400; letter-spacing: 0.4px; opacity: 0.8;}
    .playlistDesc {font-size: 12px; font-weight: 300; letter-spacing: 0.2px; opacity: 0.8;}
    .playlistOpt {margin-top: 5px; font-size: 14px; font-weight: 400; letter-spacing: 0.2px; opacity: 0.8;}
    .playlistFunction {display: flex; width: 100%;}
    .playlistBtnCircle {display: flex; justify-content: center; align-items: center; width: 50px; height: 50px; margin-left: 30px; border-radius: 50%; background-color: rgb(30, 214, 96);}
    .playlistBtnCircle:hover {opacity: 0.8;}
    .playlistBtnCircle:active {opacity: 0.6;}
    .playlistBtn {height: 22px;}
    .playlistAddContainer {display: flex; justify-content: center; align-items: center; width: 50px; height: 50px; margin-left: 15px; background: transparent;}
    .playlistAddBtn {height: 40px; fill: rgb(178, 179, 178); cursor: pointer; transition: all 0.1s ease;}
    .playlistAddBtn:hover {height: 41px; fill: #ffffff; opacity: 0.8;}
    .playlistAddBtn:active {height: 41px; fill: #ffffff; opacity: 0.6;}
    .playlist-tracks {position: relative; display: grid; grid-template-columns: 7% 48% 35% 10%; width: 100%;}
    .playlist-tracks:hover {border-radius: 5px; background-color: #5e5e5e;}
    #app.light .playlist-tracks:hover {background-color: #f0f0f0;}
    .playlist-tracks-top {display: flex; align-items: center; height: 25px; border-bottom: 0.5px solid #c6c6c6; padding-top: 10px; padding-bottom: 6px; font-size: 13px; color: #ffffff; font-weight: 300; letter-spacing: 0.2px; opacity: 0.8;}
    #app.light .playlist-tracks-top {border-bottom: 0.5px solid #111; color: #111;}
    .playlist-tracks-content {display: flex; align-items: center; height: 32px; color: #ffffff; font-size: 14px; font-weight: 300; letter-spacing: 0.2px; opacity: 0.8;}
    #app.light .playlist-tracks-content {color: #000;}
    .playlistTrackBtn:hover {opacity: 0.8;}
    .playlistTrackBtn:active {opacity: 0.6;}
    .likeBtn {height: 16px; cursor: pointer;}
    .crossBtn {opacity: 0.8;}
    .crossBtn:hover {opacity: 0.6;}
    .crossBtn:active {opacity: 0.4;}
</style>