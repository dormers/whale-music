<template>
    <div class="recommendationsHeader"></div>
    <div class="searchFirstContainer" v-if="search !== null && search.artists.items.length !== 0">
        <div style="padding-left: 10px;">
            <h3 class="resultContainerTitle">연관 아티스트</h3>
            <div class="relatedArtists" @click="redirectRouter('artist',search.artists.items[0].id)">
                <div class="artistResult">
                    <div class="artistResultCover">
                        <img :src="search.artists.items[0].images[0].url" :alt="search.artists.items[0].name" width="100" height="100" style="border-radius: 50%; cursor: pointer;">
                    </div>
                    <p class="searchArtistName">{{ search.artists.items[0].name }}</p>
                    <p class="artistName">아티스트</p>
                </div>
            </div>
        </div>
        <div class="resultContainer">
            <h3 class="resultContainerTitle">곡</h3>
            <div class="searchResults">
                <div class="searchResult" v-for="(item, i) in search.tracks.items" :key="i">
                    <div class="searchCover">
                        <img :src="item.album.images[0].url" :alt="item.name" width="45" height="45" style="border-radius: 2px;" @click="redirectRouter('album',item.album.id)">
                    </div>
                    <div class="searchInfo">
                        <p class="trackName textHover" style="font-size: 1rem" @click="redirectRouter('track',item.id)">{{ item.name }}</p>
                        <p class="artistName textHover" @click="redirectRouter('artist',item.artists[0].id)">{{ item.artists[0].name }}</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="recommendations" v-if="search !== null && search.albums.items.length !== 0">
        <!-- 왼쪽 버튼 -->
        <button class="artistDetailSlideButton left" id="scrollLeftBtn" @click="scrollContent(`.x0`, 'left')">
            <img src="../../../public/images/main/prev.png"
                    alt="Left Button" width="30"
                    height="30" style="border-radius: 8px; opacity: 0.75;">
        </button>
        <div class="recommendationTitle"><p class="titleName">앨범</p></div>
        <div :class="`recommendationContents x0`">
            <div class="recommendationContent" v-for="(recommendation, j) in search.albums.items" :key="j">
                <div class="recommendationCover">
                    <img :src="recommendation.images[0].url" :alt="recommendation.name" width="120" height="120" style="border-radius: 8px; cursor: pointer;" @click="redirectRouter('album',recommendation.id)">
                </div>
                <div class="recommendationInfo">
                    <p class="trackName" style="cursor: pointer;" @click="redirectRouter('album',recommendation.id)">{{ recommendation.name }}</p>
                    <p class="trackName" style="cursor: pointer; font-size: 11px;" @click="redirectRouter('album',recommendation.id)">{{ recommendation.release_date }}</p>
                </div>
            </div>
        </div>
        <!-- 오른쪽 버튼 -->
        <button class="artistDetailSlideButton right" id="scrollRightBtn" @click="scrollContent(`.x0`, 'right')">
            <img src="../../../public/images/main/next.png"
                    alt="Right Button" width="30"
                    height="30" style="border-radius: 8px; opacity: 0.75;">
        </button>
    </div>
    <div class="recommendations" v-if="search !== null && search.playlists.items.length !== 0">
        <!-- 왼쪽 버튼 -->
        <button class="artistDetailSlideButton left" id="scrollLeftBtn" @click="scrollContent(`.x1`, 'left')">
            <img src="../../../public/images/main/prev.png"
                    alt="Left Button" width="30"
                    height="30" style="border-radius: 8px; opacity: 0.75;">
        </button>
        <div class="recommendationTitle"><p class="titleName">관련된 플레이리스트</p></div>
        <div :class="`recommendationContents x1`">
            <div class="recommendationContent" v-for="(recommendation, j) in search.playlists.items" :key="j">
                <div class="recommendationCover">
                    <img :src="recommendation.images[0].url" :alt="recommendation.name" width="120" height="120" style="border-radius: 8px; cursor: pointer;" @click="redirectPlaylistRouter(recommendation.id)">
                </div>
                <div class="recommendationInfo">
                    <p class="trackName" style="cursor: pointer;" @click="redirectPlaylistRouter(recommendation.id)">{{ recommendation.name }}</p>
                </div>
            </div>
        </div>
        <!-- 오른쪽 버튼 -->
        <button class="artistDetailSlideButton right" id="scrollRightBtn" @click="scrollContent(`.x1`, 'right')">
            <img src="../../../public/images/main/next.png"
                    alt="Right Button" width="30"
                    height="30" style="border-radius: 8px; opacity: 0.75;">
        </button>
    </div>
    <div class="searchFirstContainer" v-if="search !== null">
        <pre style="padding: 20px 0 0 20px; color: white; font-size: 16px; opacity: 0.6;" v-if="search.artists.items.length === 0">검색 결과를 찾을 수 없습니다.</pre>
    </div>
</template>

<script>
export default {
    data() {
        return {
            search: null,
        }
    },
    mounted() {
        this.getSearch();
    },
    methods: {
        async getSearch() {
            const result = await fetch(`/whale/streaming/getArtistPlaylist?q=${this.$route.params.query}`);
            if (await result.ok) {
                const data = await result.json();
                this.search = await data;
                this.$nextTick(() => {
                    this.checkScroll('.x0');
                    this.checkScroll('.x1');
                });
            } else {
                console.error('Failed to fetch user search items:', result.statusText);
            }
        },
        async playPlayer(i) {
            await fetch(`/whale/streaming/play?uri=${ i }&device_id=${ sessionStorage.device_id }`);
        },
        updateScrollButtons(containerSelector) {
            const container = document.querySelector(containerSelector);
            if (!container) return;

            const scrollLeftBtn = container.parentNode.querySelector('.artistDetailSlideButton.left');
            const scrollRightBtn = container.parentNode.querySelector('.artistDetailSlideButton.right');

            if (container.scrollLeft > 0) {
                scrollLeftBtn.classList.remove('hidden');
            } else {
                scrollLeftBtn.classList.add('hidden');
            }

            const maxScrollLeft = container.scrollWidth - container.clientWidth;
            if (container.scrollLeft < maxScrollLeft) {
                scrollRightBtn.classList.remove('hidden');
            } else {
                scrollRightBtn.classList.add('hidden');
            }
        },
        scrollContent(containerSelector, direction) {
            const container = document.querySelector(containerSelector);
            if (!container) return;
            
            const scrollAmount = direction === 'left' ? -210 : 210;
            container.scrollBy({ left: scrollAmount, behavior: 'smooth' });

            setTimeout(() => {
                this.updateScrollButtons(containerSelector);
            }, 300);
        },
        checkScroll(containerSelector) {
            const container = document.querySelector(containerSelector);
            if (container) {
                this.updateScrollButtons(containerSelector);
                container.addEventListener('scroll', () => this.updateScrollButtons(containerSelector));
            }
        },
        redirectRouter(i,y) {
            this.$router.push(`/whale/streaming/detail/${i}/${y}`);
        },
        redirectPlaylistRouter(i) {
            this.$router.push(`/whale/streaming/playlist/${i}`);
        },
    },
};
</script>

<style scoped>
    .recommendationsHeader {width: 100%; height: 30px;}
    .recommendations {position: relative; width: 100%; height: 240px; margin-top: 20px;}
    .recommendationTitle {display: flex; flex-direction: column-reverse; width: 100%; height: 45px; padding-left: 10px; color: #F2F2F2; font-size: 17px; font-weight: 400; letter-spacing: 0.2px; opacity: 0.8;}
    #app.light .recommendationTitle {color: #111;}
    .recommendationContents {display: flex; width: 100%; height: 195px; overflow: auto; -ms-overflow-style: none;}
    .recommendationContent {position: relative; flex: 0 0 auto; width: 150px; height: 100%; border-radius: 15px; opacity: 0.9;}
    .recommendationContent:hover {background-color: rgba(60,60,60,0.8);}
    #app.light .recommendationContent:hover {background-color: #f0f0f0;}
    .recommendationLike{position: absolute; width: 30px; height: 30px; top: 100px; background: transparent;}
    .recommendationLike:hover{opacity: 0.7;}
    .recommendationLike:active{opacity: 0.6;}
    .recommendationCover {display: flex; justify-content: center; align-items: center; width: 100%; height: 155px;}
    .recommendationInfo {width: 100%; height: 40px; padding: 0 12px; color: #FFFFFF;}
    #app.light .recommendationInfo {color: #111;}
    .trackName {font-size: 12px; font-weight: 400; letter-spacing: 0.4px; opacity: 0.8;}
    .artistName {font-size: 11px; font-weight: 200; letter-spacing: 0.4px; opacity: 0.8; color: white;}
    #app.light .artistName {color: #111;}
    .artistDetailSlideButton {cursor: pointer; position: absolute; z-index: 1; transition: opacity 0.3s ease; border: 0; background-color: transparent; transform: translateY(-50%);}
    .artistDetailSlideButton.left {left: 0; top: 50%;}
    .artistDetailSlideButton.right {right: 0; top: 50%;}
    .artistDetailSlideButton.hidden {opacity: 0; pointer-events: none; /* 클릭 불가 */}
    .searchFirstContainer {display: flex;}
    .searchFirstContainer > :first-child {flex: 0 0 40%;}
    .searchFirstContainer > :last-child {flex: 0 0 60%;}
    .resultContainer{position: relative;}
    .resultContainerTitle {display: flex; flex-direction: column-reverse; width: 100%; height: 45px; padding: 0 0 8px 15px; color: #F2F2F2; font-size: 17px; font-weight: 400; letter-spacing: 0.2px; opacity: 0.8; box-sizing: border-box;}
    #app.light .resultContainerTitle {color: #000;}
    .relatedArtists {height: 190px; border-radius: 15px; opacity: 0.9; cursor: pointer; transition: transform 0.3s ease;}
    .relatedArtists:hover {background-color: rgba(60,60,60,0.8);}
    #app.light .relatedArtists:hover {background-color: #f0f0f0;}
    .artistResultCover{height: 120px; display: flex; align-items: center;}
    .artistResult{margin-left: 15px;}
    .searchArtistName{color: white; font-size: 2rem; font-weight: bold;}
    #app.light .searchArtistName {color: #111;}
    .searchArtistName:hover {opacity: 0.6; cursor: grab;}
    /* searchResults에만 스크롤바 표시 */
    .searchResults::-webkit-scrollbar {display: block; /* 수직 스크롤바 표시 */ width: 8px; /* 스크롤바 너비 설정 */}
    /* 스크롤바의 트랙(기본 배경) 스타일 */
    .searchResults::-webkit-scrollbar-track {background: #2e2e2e; /* 트랙 배경색 설정 */}
    /* 스크롤바 핸들(스크롤 이동할 때 잡는 부분) 스타일 */
    #app.light .searchResults::-webkit-scrollbar-track {background: #f0f0f0;}
    .searchResults::-webkit-scrollbar-thumb {background-color: #555; /* 핸들 색상 설정 */ border-radius: 4px; /* 핸들 모서리 둥글게 설정 */}
    .searchResults {width: 100%; height: 190px; overflow-y: auto; /* 스크롤바 활성화 */ scroll-behavior: smooth; display: flex; flex-direction: column;}
    .searchResult {display: flex; border-radius: 4px; opacity: 0.9; cursor: pointer; transition: transform 0.3s ease; padding: 8px 10px;}
    .searchResult:hover {background-color: rgba(60,60,60,0.8);}
    #app.light .searchResult:hover {background-color: #f0f0f0;}
    .searchInfo{width: 100%; height: 40px; padding-left: 20px; color: #FFFFFF; display: flex; flex-direction: column; justify-content: center;}
    #app.light .searchInfo {color: #000;}
    .searchInfo .trackName,
    .searchInfo .artistName{white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 340px;}
    .searchCover {display: flex; justify-content: center; align-items: center;}
    .searchCover:hover {opacity: 0.6; cursor: grab;}
    .searchCover:active {opacity: 0.4; cursor: grab;}
    .textHover:hover {text-decoration: underline;}
    .textHover:active {text-decoration: underline;}
</style>