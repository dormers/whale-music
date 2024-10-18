<template>
    <div class="recommendationsHeader"></div>
    <div class="recommendations">
        <div class="recommendationTitle"><p class="titleName">내가 즐겨 듣는 노래</p></div>
        <div class="recommendationContents">
            <div class="recommendationContent" v-for="(recommendation, i) in recommendations" :key="i" @mouseover="isShow[i] = true" @mouseleave="isShow[i] = false">
                <div class="recommendationLike" v-if="addIsShow(i)" @click="insertTrack(i)">
                    <img src="../../../public/images/main/like.png" alt="Like Button" width="30" height="30" style="border-radius: 8px; opacity: 0.75;">
                </div>
                <div class="recommendationCover">
                    <img :src="recommendation.album.images[0].url" :alt="recommendation.name" width="120" height="120" style="border-radius: 8px;">
                </div>
                <div class="recommendationInfo">
                    <p class="trackName">{{ recommendation.name }}</p>
                    <p class="artistName">{{ recommendation.artists[0].name }}</p>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            recommendations: null,
            isShow: [],
        }
    },
    mounted() {this.getUserTopItems();},
    methods: {
        async getUserTopItems() {
            const result = await fetch('/whale/streaming/getContents');
            if (await result.ok) {
                const data = await result.json();
                if (data.items && data.items.length > 0) {
                    this.recommendations = data.items;
                } else {
                    console.error('No items found');
                }
            } else {
                console.error('Failed to fetch user top items:', result.statusText);
            }
        },
        async insertTrack(i) {
            try {
                const body = {
                    trackArtist: this.recommendations[i].artists[0].name,
                    trackName: this.recommendations[i].name,
                    trackAlbum: this.recommendations[i].album.name,
                    trackCover: this.recommendations[i].album.images[0].url,
                    trackSpotifyId: this.recommendations[i].id,
                };
                const response = await fetch('http://localhost:9002/whale/streaming/insertTrack', {
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
                    console.error('Failed to fetch the track info: ', response.statusText);
                }
            } catch (error) {
                console.error('Error while fetching the track info:', error);
            }
        },
        addIsShow(i) {
            this.isShow.push(false);
            return this.isShow[i];
        },
    },
};
</script>

<style scoped>
    .recommendationsHeader {width: 100%; height: 30px;}
    .recommendations {width: 100%; height: 240px;}
    .recommendationTitle {display: flex; flex-direction: column-reverse; width: 100%; height: 45px; padding-left: 10px; color: #F2F2F2; font-size: 17px; font-weight: 400; letter-spacing: 0.2px; opacity: 0.8;}
    .recommendationContents {display: flex; width: 100%; height: 195px; overflow: auto; -ms-overflow-style: none;}
    .recommendationContent {position: relative; width: 150px; height: 100%; border-radius: 15px; opacity: 0.9;}
    .recommendationContent:hover {background-color: rgba(60,60,60,0.8);}
    .recommendationLike{position: absolute; width: 30px; height: 30px; top: 100px; left: 19px; background: transparent;}
    .recommendationLike:hover{opacity: 0.7;}
    .recommendationLike:active{opacity: 0.6;}
    .recommendationCover {display: flex; justify-content: center; align-items: center; width: 100%; height: 155px;}
    .recommendationInfo {width: 100%; height: 40px; padding: 0 12px; color: #FFFFFF;}
    .trackName {font-size: 12px; font-weight: 400; letter-spacing: 0.4px; opacity: 0.8;}
    .artistName {font-size: 11px; font-weight: 200; letter-spacing: 0.4px; opacity: 0.8;}
</style>