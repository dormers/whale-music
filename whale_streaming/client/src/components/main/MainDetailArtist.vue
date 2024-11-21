<template>
    <div class="playlistDetail">
        <div class="playlistDetailContainer" v-if="track !== null">
            <img :src="artist.images[0].url" :alt="artist.name" width="230"
                        height="230" style="border-radius: 8px;">
            <div class="playlistDetailInfo">
                <p class="detailSort">아티스트</p>
                <p class="playlistName">{{ artist.name }}</p>
                <div class="trackDescription">
                    <p style="font-size: 13px;">장르: {{ artist.genres.join(', ') }}</p>
                </div>
            </div>
        </div>
    </div>
    <div class="artistContainer">
        <h3 class="artistFont">인기</h3>
        <div class="playlist-tracks" style="height: 25px; margin-top: 5px; pointer-events: none;">
            <div class="playlist-tracks-top" style="justify-content: center;">#</div>
            <div class="playlist-tracks-top" style="padding-left: 5px;">제목</div>
            <div class="playlist-tracks-top" style="padding-left: 5px;">앨범</div>
            <div class="playlist-tracks-top" style="justify-content: center;">시간</div>
        </div>
        <div v-if="track !== null" style="width: 100%; height: 50%; margin-top: 19px;">
            <div class="playlist-tracks" style="padding: 9px 0;" v-for="(item, i) in track.tracks" :key="i" @mouseover="isShow[i] = true" @mouseleave="isShow[i] = false">
                <div class="playlist-tracks-content" style="justify-content: center;" v-if="!isShow[i]">{{ i+1 }}</div>
                <div class="playlist-tracks-content" style="justify-content: center;" v-if="addIsShow(i)">
                    <svg
                        data-encore-id="icon"
                        role="img"
                        aria-hidden="true"
                        viewBox="0 0 24 24"
                        class="playlistTrackBtn"
                        style="height: 16px;"
                        @click="playPlayer(item.uri)"
                    >
                        <path d="m7.05 3.606 13.49 7.788a.7.7 0 0 1 0 1.212L7.05 20.394A.7.7 0 0 1 6 19.788V4.212a.7.7 0 0 1 1.05-.606z"
                        ></path>
                    </svg>
                </div>
                <div class="playlist-tracks-content" style="padding-left: 5px;">
                    <img :src="item.album.images[0].url" alt="item.name" height="40" style="border-radius: 2px; margin-right: 10px;">
                    <p style="cursor: pointer;" @click="redirectRouter('track',item.id)">{{ item.name }} - {{ item.artists[0].name }}</p>
                </div>
                <div class="playlist-tracks-content" style="padding-left: 5px; font-size: 13px; cursor: pointer;" @click="redirectRouter('album',item.album.id)">{{ item.album.name }}</div>
                <div class="playlist-tracks-content" style="justify-content: center; font-size: 12px;" v-if="!isShow[i]">{{ String(Math.floor(( item.duration_ms / (1000 * 60 )) )).padStart(2, "0") }}분 {{ String(Math.floor(( item.duration_ms % (1000 * 60 )) / 1000 )).padStart(2, "0") }}초</div>
                <div class="playlist-tracks-content" style="justify-content: center;" v-if="isShow[i]">
                    <svg
                        data-encore-id="icon"
                        role="img"
                        aria-hidden="true"
                        viewBox="0 0 24 24"
                        class="playlistTrackBtn likeBtn"
                        :style="{ fill: like[i] === true ? 'rgb(203, 130, 163)' : '#000000' }"
                        @click="changeTrackLikeInfo(item.artists[0].name, item.name, item.album.name, item.album.images[0].url, item.id, i)"
                    >
                        <!-- 조건부로 좋아요 여부에 따라 아이콘 변경 가능 -->
                        <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"
                        ></path>
                    </svg>
                </div>
            </div>
        </div>
    </div>
    <div class="artistContainer" style="margin-top: 60px;" v-if="album !== null">
        <h3 class="artistFont">앨범</h3>
        <!-- 왼쪽 버튼 -->
        <button class="artistDetailSlideButton left" id="artistDetailScrollLeftBtn"
                @click="scrollLeftArtistDetailContent()">
            <img src="../../../public/images/main/prev.png"
                    alt="Prev Button" width="30"
                    height="30" style="border-radius: 8px; opacity: 0.75;">
        </button>
        <!-- 앨범 목록 -->
        <div class="albums">
            <div class="albumsWrap">
                <div class="albumItem" v-for="(item, i) in album.items" :key="i">
                    <img :src="item.images[0].url" :alt="item.name"
                            width="150"
                            height="150" style="border-radius: 4px; cursor: pointer;" @click="redirectRouter('album',item.id)">
                    <p class="trackName" style="font-size: 14px; cursor: pointer;" @click="redirectRouter('album',item.id)">{{ item.name }}</p>
                    <p class="trackName" style="font-size: 13px;">{{ item.release_date }}</p>
                </div>
            </div>
        </div>
        <!-- 오른쪽 버튼 -->
        <button class="artistDetailSlideButton right" id="artistDetailScrollRightBtn"
                @click="scrollRightArtistDetailContent()">
            <img src="../../../public/images/main/next.png"
                    alt="Next Button" width="30"
                    height="30" style="border-radius: 8px; opacity: 0.75;">
        </button>
    </div>
    <div class="artistContainer" style="margin-top: 60px; padding-bottom: 50px;" v-if="playlist !== null">
        <h3 class="artistFont">관련된 플레이리스트</h3>
        <!-- 왼쪽 버튼 -->
        <button class="artistDetailSlideButton left" id="playListScrollLeftBtn"
                @click="scrollLeftPlayListContent()">
            <img src="../../../public/images/main/prev.png"
                    alt="Prev Button" width="30"
                    height="30" style="border-radius: 8px; opacity: 0.75;">
        </button>
        <div class="relatedPlaylists">
            <div class="playlistItem" v-for="(item, i) in playlist.playlists.items" :key="i">
                <img :src="item.images[0].url" :alt="item.name"
                        width="150" height="150" style="border-radius: 4px; cursor: pointer;" @click="redirectPlaylistRouter(item.id)">
                <p class="trackName" style="margin-left: 2px; font-size: 14px; cursor: pointer;" @click="redirectPlaylistRouter(item.id)">{{ item.name }}</p>
            </div>
        </div>
        <!-- 오른쪽 버튼 -->
        <button class="artistDetailSlideButton right" id="playListScrollRightBtn"
                @click="scrollRightPlayListContent()">
            <img src="../../../public/images/main/next.png"
                    alt="Next Button" width="30"
                    height="30" style="border-radius: 8px; opacity: 0.75;">
        </button>
    </div>
</template>

<script>
export default {
    data() {
        return {
            track: null,
            artist: null,
            album: null,
            playlist: null,
            isShow: [],
            like: [],
            isPlayed: [],
            position: [],
        }
    },
    mounted() {
        this.getArtistInfo();
        this.changeBackground();
    },
    methods: {
        async getArtistInfo() {
            const result = await fetch(`/whale/streaming/getArtistInfo?id=${this.$route.params.id}`);
            if (await result.ok) {
                const data = await result.json();
                this.artist = await data;
                
                fetch(`/whale/streaming/getArtistTopTrack?id=${this.$route.params.id}`)
                    .then((response) => response.json())
                    .then((data) => {
                        this.track = data;
                        this.track.tracks.forEach((el, index) => {
                            this.getTrackLikeInfo(el.id,index);
                        });
                    })
                fetch(`/whale/streaming/getArtistAlbum?id=${this.$route.params.id}`)
                    .then((response) => response.json())
                    .then((data) => {
                        this.album = data;
                        this.$nextTick(() => {
                            this.checkArtistDetailScroll();
                        });
                    })
                fetch(`/whale/streaming/getArtistPlaylist?q=${ this.artist.name }&t=playlist`)
                    .then((response) => response.json())
                    .then((data) => {
                        this.playlist = data;
                        this.$nextTick(() => {
                            this.checkArtistDetailPlaylistScroll();
                        });
                    })

            } else {
                console.error('Failed to fetch user top items:', result.statusText);
            }
        },
        async playPlayer(i) {
            await fetch(`/whale/streaming/play?uri=${ i }&device_id=${ sessionStorage.device_id }`);
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
        updateArtistDetailScrollButtons() {
            const container = document.querySelector('.albumsWrap');
            const scrollLeftBtn = document.getElementById('artistDetailScrollLeftBtn');
            const scrollRightBtn = document.getElementById('artistDetailScrollRightBtn');

            if (container) {
                // 왼쪽 버튼 보이기/숨기기
                if (container.scrollLeft > 0) {
                    scrollLeftBtn.classList.remove('hidden');
                } else {
                    scrollLeftBtn.classList.add('hidden');
                }

                // 오른쪽 버튼 보이기/숨기기
                const maxScrollLeft = container.scrollWidth - container.clientWidth;
                if (container.scrollLeft < maxScrollLeft) {
                    scrollRightBtn.classList.remove('hidden');
                } else {
                    scrollRightBtn.classList.add('hidden');
                }
            }
        },
        scrollLeftArtistDetailContent() {
            const container = document.querySelector('.albumsWrap');
            container.scrollBy({ left: -210, behavior: 'smooth' });
            setTimeout(this.updateArtistDetailScrollButtons, 300); // 스크롤 후 버튼 업데이트
        },
        scrollRightArtistDetailContent() {
            const container = document.querySelector('.albumsWrap');
            container.scrollBy({ left: 210, behavior: 'smooth' });
            setTimeout(this.updateArtistDetailScrollButtons, 300); // 스크롤 후 버튼 업데이트
        },
        checkArtistDetailScroll() {
            this.updateArtistDetailScrollButtons();
            const container = document.querySelector('.albumsWrap');
            if (container) {
                container.addEventListener('scroll', this.updateArtistDetailScrollButtons); // 스크롤 이벤트 감지
            }
        },
        updatePlayListScrollButtons() {
            const container = document.querySelector('.relatedPlaylists');
            const scrollLeftBtn = document.getElementById('playListScrollLeftBtn');
            const scrollRightBtn = document.getElementById('playListScrollRightBtn');

            if (container) {
                // 왼쪽 버튼 보이기/숨기기
                if (container.scrollLeft > 0) {
                    scrollLeftBtn.classList.remove('hidden');
                } else {
                    scrollLeftBtn.classList.add('hidden');
                }

                // 오른쪽 버튼 보이기/숨기기
                const maxScrollLeft = container.scrollWidth - container.clientWidth;
                if (container.scrollLeft < maxScrollLeft) {
                    scrollRightBtn.classList.remove('hidden');
                } else {
                    scrollRightBtn.classList.add('hidden');
                }
            }
        },
        scrollLeftPlayListContent() {
            const container = document.querySelector('.relatedPlaylists');
            container.scrollBy({ left: -210, behavior: 'smooth' });
            setTimeout(this.updatePlayListScrollButtons, 300); // 스크롤 후 버튼 업데이트
        },
        scrollRightPlayListContent() {
            const container = document.querySelector('.relatedPlaylists');
            container.scrollBy({ left: 210, behavior: 'smooth' });
            setTimeout(this.updatePlayListScrollButtons, 300); // 스크롤 후 버튼 업데이트
        },
        checkArtistDetailPlaylistScroll() {
            this.updatePlayListScrollButtons();
            const container = document.querySelector('.relatedPlaylists');
            if (container) {
                container.addEventListener('scroll', this.updatePlayListScrollButtons); // 스크롤 이벤트 감지
            }
        },
        redirectRouter(i,y) {
            this.$router.push(`/whale/streaming/detail/${i}/${y}`);
        },
        redirectPlaylistRouter(i) {
            this.$router.push(`/whale/streaming/playlist/${i}`);
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
    .playlistDetail {display: flex; align-items: center; width: 95%; height: 35%; padding: 40px 0 20px 20px;}
    .playlistDetailContainer {display: flex; gap: 20px; color: white; align-items: end; width: 100%; padding-left: 20px; overflow-x: scroll; -ms-overflow-style: none;}
    #app.light .playlistDetailContainer {color: #111;}
    .playlistDetailInfo {width: 75%; height: 170px; overflow: auto; white-space: nowrap; text-overflow: ellipsis;}
    .detailSort {margin-top: 15px; margin-left: 2px; font-size: 12px; font-weight: 300; letter-spacing: 0.3px; opacity: 0.7;}
    .trackDescription{font-size: 12px; font-weight: 300; letter-spacing: .2px; opacity: .8; display: flex; align-items: center; margin-top: 15px; gap: 5px;}
    .playlistName {font-size: 64px; font-weight: 400; letter-spacing: 0.4px; opacity: 0.8;}
    .playlist-tracks {position: relative; display: grid; grid-template-columns: 7% 48% 35% 10%; width: 100%;}
    .playlist-tracks:hover {border-radius: 5px; background-color: #5e5e5e;}
    #app.light .playlist-tracks:hover {background-color: #f0f0f0;}
    .playlist-tracks-top {display: flex; align-items: center; height: 25px; border-bottom: 0.5px solid rgb(197, 197, 197, 0.7); padding-top: 10px; padding-bottom: 6px; font-size: 13px; color: #ffffff; font-weight: 300; letter-spacing: 0.2px; opacity: 0.8;}
    #app.light .playlist-tracks-top {border-bottom: 0.5px solid #111; color: #111;}
    .playlist-tracks-content {display: flex; align-items: center; height: 32px; color: #ffffff; font-size: 14px; font-weight: 300; letter-spacing: 0.2px; opacity: 0.8;}
    #app.light .playlist-tracks-content {color: #000;}
    .playlistTrackBtn:hover {opacity: 0.8;}
    .playlistTrackBtn:active {opacity: 0.6;}
    .likeBtn {height: 16px; cursor: pointer;}
    .artistContainer {position: relative; margin: 40px 0 10px 20px; width: 95%;}
    .artistFont {color: white; margin: 0 0 15px 10px;}
    #app.light .artistFont {color: #111;}
    .albumsWrap{display: flex; gap: 20px; overflow-x: scroll; white-space: nowrap; padding-bottom: 10px; margin-left: 5px;}
    .albumItem{width: fit-content;}
    .artistDetailSlideButton {cursor: pointer; position: absolute; z-index: 1; transition: opacity 0.3s ease; border: 0; background-color: transparent; transform: translateY(-50%);}
    .artistDetailSlideButton.left {left: 0; top: 50%;}
    .artistDetailSlideButton.right {right: 0; top: 50%;}
    .artistDetailSlideButton.hidden {opacity: 0; pointer-events: none; /* 클릭 불가 */}
    .albumItem p {width: 150px; /* 이미지 너비와 동일하게 설정 */ white-space: nowrap; /* 한 줄로 표시 */ overflow: hidden; /* 넘치는 텍스트 숨김 */ text-overflow: ellipsis; /* 말줄임표 표시 */ margin: 5px 0; /* 간격 조정 */}
    .trackName {margin-top: 5px; margin-left: 2px; color: white; font-size: 12px; font-weight: 400; letter-spacing: 0.4px; opacity: 0.8;}
    #app.light .trackName {color: #111;}
    .relatedPlaylists{display: flex; gap: 20px; overflow-x: scroll; white-space: nowrap; padding-bottom: 10px; margin-left: 5px;}
    .playlistItem{width: fit-content;}
    .playlistItem p {width: 150px; /* 이미지 너비와 동일하게 설정 */ white-space: nowrap; /* 한 줄로 표시 */ overflow: hidden; /* 넘치는 텍스트 숨김 */ text-overflow: ellipsis; /* 말줄임표 표시 */ margin: 5px 0; /* 간격 조정 */}
</style>