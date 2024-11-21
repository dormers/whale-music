<template>
    <div class="mainLibraryFrame" :class="{ expanded: isExpanded }">
        <div class="mainLibrary">
            <svg
                data-encore-id="icon"
                role="img"
                aria-hidden="true"
                viewBox="0 0 24 24"
                class="libraryBtn"
                @click="expandLibrary()"
                v-if="!isExpanded"
            >
                <path
                    d="M14.5 2.134a1 1 0 0 1 1 0l6 3.464a1 1 0 0 1 .5.866V21a1 1 0 0 1-1 1h-6a1 1 0 0 1-1-1V3a1 1 0 0 1 .5-.866zM16 4.732V20h4V7.041l-4-2.309zM3 22a1 1 0 0 1-1-1V3a1 1 0 0 1 2 0v18a1 1 0 0 1-1 1zm6 0a1 1 0 0 1-1-1V3a1 1 0 0 1 2 0v18a1 1 0 0 1-1 1z"
                ></path>
            </svg>
            <svg
                data-encore-id="icon"
                role="img"
                aria-hidden="true"
                viewBox="0 0 24 24"
                class="libraryBtn"
                @click="expandLibrary()"
                v-if="isExpanded"
            >
                <path
                    d="M3 22a1 1 0 0 1-1-1V3a1 1 0 0 1 2 0v18a1 1 0 0 1-1 1zM15.5 2.134A1 1 0 0 0 14 3v18a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V6.464a1 1 0 0 0-.5-.866l-6-3.464zM9 2a1 1 0 0 0-1 1v18a1 1 0 1 0 2 0V3a1 1 0 0 0-1-1z"
                ></path>
            </svg>
            <p class="mainLibraryName" v-if="isExpanded">내 라이브러리</p>
            <div class="playlist-container">
                <div class="playlist-content" @click="redirectPlaylist(0)">
                    <div class="playlistCover">
                        <img src="https://misc.scdn.co/liked-songs/liked-songs-64.png" alt="WHALE LIKE TRACK" width="45" height="45"
                        style="border-radius: 2px; opacity: 0.8;">
                    </div>
                    <div class="libraryInfo" v-if="isExpanded">
                        <p class="libraryInfoFont">좋아요 표시한 곡</p>
                        <p class="libraryInfoFont" style="margin-top: 2px; font-size: 10px;">플레이리스트•{{ likeCnt.CNT }}곡</p>
                    </div>
                </div>
                <div class="playlist-content" v-for="(library, i) in libraries" :key="i" @click="redirectPlaylist(library.id)">
                    <div class="playlistCover">
                        <img :src="library.images[0].url" :alt="library.name" width="45" height="45" style="border-radius: 2px; opacity: 0.8;">
                    </div>
                    <div class="libraryInfo" v-if="isExpanded">
                        <p class="libraryInfoFont">{{ library.name }}</p>
                        <p class="libraryInfoFont" style="margin-top: 2px; font-size: 10px;">플레이리스트•{{ library.owner.display_name }}</p>
                    </div>
                </div>
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
            isExpanded: false,
            isShow: [],
            likeCnt: null,
        };
    },
    mounted() {
        this.getUserLikeCnt();
    },
    methods: {
        expandLibrary() {
            this.isExpanded = !this.isExpanded;
        },
        getUserLikeCnt() {
            fetch(`http://localhost:9002/whale/streaming/likeCnt?userId=${ sessionStorage.userId }`)
                .then((response) => response.json())
                .then((data) => {
                    this.likeCnt = data;
                })
        },
        redirectPlaylist(i) {
            this.$router.push(`/whale/streaming/playlist/${ i }`);
        },
    },
};
</script>

<style scoped>
    .mainLibraryFrame {display: flex; justify-content: center; align-items: center; width: 100px; min-width: 100px; height: 100%; background-color: #1f1f1f; transition: width 0.5s ease;}
    #app.light .mainLibraryFrame {background-color: #f0f0f0;}
    .mainLibraryFrame.expanded {width: 300px; max-width: 300px;}
    .mainLibrary {position: relative; display: flex; justify-content: center; width: 72%; height: 96%; background-color: #2e2e2e; border-radius: 12px; transition: width 0.5s ease;}
    #app.light .mainLibrary {background-color: #fff;}
    .mainLibraryFrame.expanded .mainLibrary {width: 88%;}
    .libraryBtn {position: absolute; top: 20px; left: 25px; height: 22px; fill: #9f9f9f;}
    .libraryBtn:hover {opacity: 0.8; cursor: grab;}
    .libraryBtn:active {opacity: 0.6; cursor: grab;}
    .mainLibraryName {position: absolute; top: 25px; left: 60px; color: white; font-size: 13px; font-weight: 400; letter-spacing: 0.4px; opacity: 0.8; overflow: hidden; white-space: nowrap; text-overflow: clip;}
    #app.light .mainLibraryName {color: #111;}
    .playlist-container {display: flex; flex-direction: column; justify-content: flex-start; padding-top: 64px; overflow: auto; -ms-overflow-style: none;}
    .playlist-content {position: relative; display: flex; justify-content: center; align-items: center; width: 60px; height: 60px; margin-bottom: 5px; border-radius: 8px;}
    .playlist-content:hover {background-color: rgba(60,60,60,0.8);}
    #app.light .playlist-content:hover {background-color: #f0f0f0;}
    .mainLibraryFrame.expanded .playlist-content {width: 200px;}
    .playlistCover {width: 45px; height: 45px;}
    .playlistCover:hover {cursor: grab;}
    .mainLibraryFrame.expanded .playlistCover {position: absolute; top: 7.5px; left: 10px;}
    .libraryInfo {width: 100px; height: 50px; margin-left: 38px; padding: 19px 0 0 5px; overflow: auto; white-space: nowrap; text-overflow: clip;}
    .libraryInfoFont {color: white; font-size: 12px; font-weight: 400; letter-spacing: 0.4px; opacity: 0.8; user-select: none;}
    #app.light .libraryInfoFont {color: #111;}
</style>