<template>
    <div class="recommendationsHeader"></div>
    <div class="recommendations" v-for="i in 2" :key="i">
        <div v-if="recommendations[0] !== null">
            <!-- 왼쪽 버튼 -->
            <button class="artistDetailSlideButton left" id="scrollLeftBtn" @click="scrollContent(`.x${i-1}`, 'left')">
                <img src="../../../public/images/main/prev.png"
                        alt="Left Button" width="30"
                        height="30" style="border-radius: 8px; opacity: 0.75;">
            </button>
            <div class="recommendationTitle"><p class="titleName">{{ title[i-1] }}</p></div>
            <div :class="`recommendationContents x${i-1}`">
                <div class="recommendationContent" v-for="(recommendation, j) in recommendations[i-1]" :key="j" @mouseover="isShow[i-1][j] = true" @mouseleave="isShow[i-1][j] = false">
                    <div class="recommendationLike" style="left: 15px;" v-if="addIsShow(i-1,j)" @click="changeTrackLikeInfo(recommendation.artists[0].name, recommendation.name, recommendation.album.name, recommendation.album.images[0].url, recommendation.id, i-1, j)">
                        <img src="../../../public/images/main/like.png" alt="Like Button" width="30" height="30" style="border-radius: 8px; opacity: 0.75;" v-show="like[i-1][j] === false">
                        <img src="../../../public/images/main/liked.png" alt="Like Button" width="30" height="30" style="border-radius: 8px; opacity: 0.75;" v-show="like[i-1][j] === true">
                    </div>
                    <div class="recommendationCover">
                        <img :src="recommendation.album.images[0].url" :alt="recommendation.name" width="120" height="120" style="border-radius: 8px; cursor: pointer;" @click="redirectRouter('track',recommendation.id)">
                    </div>
                    <div class="recommendationLike" style="right: 15px;" v-if="isShow[i-1][j]" @click="playPlayer(recommendation.uri)">
                        <img src="../../../public/images/main/play.png"
                                alt="Play Button" width="30"
                                height="30" style="border-radius: 8px; opacity: 0.75;">
                    </div>
                    <div class="recommendationInfo">
                        <p class="trackName textHover" style="cursor: pointer;" @click="redirectRouter('track',recommendation.id)">{{ recommendation.name }}</p>
                        <p class="artistName textHover" style="cursor: pointer;" @click="redirectRouter('artist',recommendation.artists[0].id)">{{ recommendation.artists[0].name }}</p>
                    </div>
                </div>
            </div>
            <!-- 오른쪽 버튼 -->
            <button class="artistDetailSlideButton right" id="scrollRightBtn" @click="scrollContent(`.x${i-1}`, 'right')">
                <img src="../../../public/images/main/next.png"
                        alt="Right Button" width="30"
                        height="30" style="border-radius: 8px; opacity: 0.75;">
            </button>
        </div>
    </div>
    <div class="recommendations" v-if="recommendations[0] !== null">
        <!-- 왼쪽 버튼 -->
        <button class="artistDetailSlideButton left" id="scrollLeftBtn" @click="scrollContent(`.x2`, 'left')">
            <img src="../../../public/images/main/prev.png"
                    alt="Left Button" width="30"
                    height="30" style="border-radius: 8px; opacity: 0.75;">
        </button>
        <div class="recommendationTitle"><p class="titleName">추천 플레이리스트</p></div>
        <div :class="`recommendationContents x2`">
            <div class="recommendationContent" v-for="(recommendation, j) in recommendations[2]" :key="j">
                <div class="recommendationCover">
                    <img :src="recommendation.images[0].url" :alt="recommendation.name" width="120" height="120" style="border-radius: 8px; cursor: pointer;" @click="redirectPlaylistRouter(recommendation.id)">
                </div>
                <div class="recommendationInfo">
                    <p class="trackName textHover" style="cursor: pointer;" @click="redirectPlaylistRouter(recommendation.id)">{{ recommendation.name }}</p>
                </div>
            </div>
        </div>
        <!-- 오른쪽 버튼 -->
        <button class="artistDetailSlideButton right" id="scrollRightBtn" @click="scrollContent(`.x2`, 'right')">
            <img src="../../../public/images/main/next.png"
                    alt="Right Button" width="30"
                    height="30" style="border-radius: 8px; opacity: 0.75;">
        </button>
    </div>
    <div class="recommendations" v-if="recommendations[0] !== null" style="padding-bottom: 25px;">
        <!-- 왼쪽 버튼 -->
        <button class="artistDetailSlideButton left" id="scrollLeftBtn" @click="scrollContent(`.x3`, 'left')">
            <img src="../../../public/images/main/prev.png"
                    alt="Left Button" width="30"
                    height="30" style="border-radius: 8px; opacity: 0.75;">
        </button>
        <div class="recommendationTitle"><p class="titleName">추천 아티스트</p></div>
        <div :class="`recommendationContents x3`">
            <div class="recommendationContent" v-for="(recommendation, j) in recommendations[3]" :key="j">
                <div class="recommendationCover">
                    <img :src="recommendation.images[0].url" :alt="recommendation.name" width="120" height="120" style="border-radius: 50%; cursor: pointer;" @click="redirectRouter('artist',recommendation.id)">
                </div>
                <div class="recommendationInfo" style="padding: 0;">
                    <p class="trackName textHover" style="text-align: center; cursor: pointer;" @click="redirectRouter('artist',recommendation.id)">{{ recommendation.name }}</p>
                </div>
            </div>
        </div>
        <!-- 오른쪽 버튼 -->
        <button class="artistDetailSlideButton right" id="scrollRightBtn" @click="scrollContent(`.x3`, 'right')">
            <img src="../../../public/images/main/next.png"
                    alt="Right Button" width="30"
                    height="30" style="border-radius: 8px; opacity: 0.75;">
        </button>
    </div>
</template>

<script>
export default {
    data() {
        return {
            recommendations: [],
            isShow: [[],[]],
            like: [[],[]],
            title: ['내가 즐겨 듣는 노래','최근 재생한 항목'],
        }
    },
    mounted() {
        this.getUserTopItems();
    },
    methods: {
        async getUserTopItems() {
            const result = await fetch('/whale/streaming/getContents');
            if (await result.ok) {
                const data = await result.json();

                if (data[0].items && data[0].items.length > 0) {
                    this.recommendations[0] = data[0].items;
                    this.recommendations[1] = data[1];
                    this.recommendations[2] = data[2].playlists.items;
                    this.recommendations[3] = data[3].artists;
                    this.recommendations[0].forEach((el, index) => {
                        this.getTrackLikeInfo(el.id, 0, index);
                    });
                    this.recommendations[1].forEach((el, index) => {
                        this.getTrackLikeInfo(el.id, 1, index);
                    });
                    this.$nextTick(() => {
                        this.checkScroll('.x0');
                        this.checkScroll('.x1');
                        this.checkScroll('.x2');
                        this.checkScroll('.x3');
                    });
                } else {
                    console.error('No items found');
                }
            } else {
                console.error('Failed to fetch user top items:', result.statusText);
            }
        },
        addIsShow(i,j) {
            this.isShow[i].push(false);
            return this.isShow[i][j];
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
        getTrackLikeInfo(i,j,k) {
            fetch(`http://localhost:9002/whale/streaming/userLikeBoolInfo?userId=${ sessionStorage.userId }&trackId=${ i }`)
                .then((response) => response.json())
                .then((data) => {
                    this.like[j][k] = data;
                })
        },
        changeTrackLikeInfo(a,b,c,d,e,x,y){
            if (this.like[x][y] === false) {
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
            this.like[x][y] = !this.like[x][y];
        },
    },
};
</script>

<style scoped>
    .recommendationsHeader {width: 100%; height: 30px;}
    .recommendations {position: relative; width: 100%; height: 240px; margin-bottom: 25px;}
    .recommendationTitle {display: flex; flex-direction: column-reverse; width: 100%; height: 45px; padding-left: 10px; color: #F2F2F2; font-size: 17px; font-weight: 400; letter-spacing: 0.2px; opacity: 0.8;}
    #app.light .recommendationTitle {color: #111;}
    .recommendationContents {display: flex; width: 100%; height: 195px; overflow: auto; -ms-overflow-style: none;}
    .recommendationContent {position: relative; flex: 0 0 auto; width: 150px; height: 100%; border-radius: 15px; opacity: 0.9;}
    .recommendationContent:hover {background-color: rgba(60,60,60,0.8);}
    #app.light .recommendationContent:hover {background-color: #f0f0f0;}
    .recommendationLike{position: absolute; width: 30px; height: 30px; top: 105px; background: transparent;}
    .recommendationLike:hover{opacity: 0.7;}
    .recommendationLike:active{opacity: 0.6;}
    .recommendationCover {display: flex; justify-content: center; align-items: center; width: 100%; height: 155px;}
    .recommendationInfo {width: 100%; height: 40px; padding: 0 12px; color: #FFFFFF;}
    #app.light .recommendationInfo {color: #111;}
    .trackName {font-size: 12px; font-weight: 400; letter-spacing: 0.4px; opacity: 0.8;}
    .artistName {font-size: 11px; font-weight: 200; letter-spacing: 0.4px; opacity: 0.8;}
    .artistDetailSlideButton {cursor: pointer; position: absolute; z-index: 1; transition: opacity 0.3s ease; border: 0; background-color: transparent; transform: translateY(-50%);}
    .artistDetailSlideButton.left {left: 0; top: 50%;}
    .artistDetailSlideButton.right {right: 0; top: 50%;}
    .artistDetailSlideButton.hidden {opacity: 0; pointer-events: none; /* 클릭 불가 */}
    .textHover:hover {text-decoration: underline;}
    .textHover:active {text-decoration: underline;}
</style>