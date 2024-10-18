<template>
    <div class="search-container">
        <!-- 검색 결과 및 페이지네이션 영역 -->
        <div id="pagination"></div>
        <div id="search-results"></div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            currentPage: 1,
            itemsPerPage: 10,                                        // 한 페이지에 표시할 항목 수
        }
    },
    mounted() {
        if (this.$route.params.query) {
            this.currentPage = 1; // 새로운 검색 시 페이지를 1로 초기화
            this.searchTracks(this.$route.params.query, this.currentPage);
        }
    },
    methods: {
        searchTracks(query, page = 1) {
            const offset = (page - 1) * this.itemsPerPage;
        
            fetch(
                `https://api.spotify.com/v1/search?q=${encodeURIComponent(
                query
                )}&type=track&limit=${this.itemsPerPage}&offset=${offset}`,
                {
                headers: {
                    Authorization: `Bearer ${sessionStorage.accessToken}`,
                },
                }
            )
            .then((response) => response.json())
            .then((data) => {
                this.displaySearchResults(data.tracks.items);
                this.setupPagination(data.tracks.total, page, query);
            })
            .catch((error) => console.error("검색 에러:", error));
        },
        setupPagination(totalItems, currentPage, query) {
            const pagination = document.getElementById("pagination");
            pagination.innerHTML = "";
        
            const totalPages = Math.ceil(totalItems / this.itemsPerPage);
        
            // 이전 페이지 버튼
            if (currentPage > 1) {
                const prevButton = document.createElement("button");
                prevButton.innerText = "이전";
                prevButton.addEventListener("click", () => {this.searchTracks(query, currentPage - 1);});
                pagination.appendChild(prevButton);
            }
        
            // 페이지 번호 표시
            const pageIndicator = document.createElement("span");
            pageIndicator.innerText = `페이지 ${currentPage} / ${totalPages}`;
            pagination.appendChild(pageIndicator);
        
            // 다음 페이지 버튼
            if (currentPage < totalPages) {
                const nextButton = document.createElement("button");
                nextButton.innerText = "다음";
                nextButton.addEventListener("click", () => {this.searchTracks(query, currentPage + 1);});
                pagination.appendChild(nextButton);
            }
        },
        displaySearchResults(tracks) {
            const searchResults = document.getElementById("search-results");
            searchResults.innerHTML = "";
        
            tracks.forEach((track) => {
                const trackItem = document.createElement("div");
                trackItem.classList.add("track-item");
        
                const albumImage = document.createElement("img");
                albumImage.src = track.album.images[0] ? track.album.images[0].url : "";
        
                const trackDetails = document.createElement("div");
                trackDetails.classList.add("track-details");
        
                const trackName = document.createElement("div");
                trackName.innerText = track.name;
        
                const artistName = document.createElement("div");
                artistName.innerText = track.artists.map((artist) => artist.name).join(", ");    
                artistName.classList.add("artist-name");
        
                trackDetails.appendChild(trackName);
                trackDetails.appendChild(artistName);
        
                const playButton = document.createElement("button");
                playButton.addEventListener("click", () => {this.playTrack(sessionStorage.device_id, track.uri);});
        
                trackItem.appendChild(albumImage);
                trackItem.appendChild(trackDetails);
                trackItem.appendChild(playButton);
        
                searchResults.appendChild(trackItem);
            });
        },
        playTrack(deviceId, trackUri) {
            fetch(`https://api.spotify.com/v1/me/player/play?device_id=${deviceId}`, {
                method: "PUT",
                body: JSON.stringify({ uris: [trackUri] }),
                headers: {
                "Content-Type": "application/json",
                Authorization: `Bearer ${sessionStorage.accessToken}`,
                },
            })
            .then(() => {
            console.log("재생 시작:", trackUri);
            })
            .catch((error) => console.error("재생 에러:", error));
        },
    },
};
</script>

<style>
    .search-container {display: flex; flex-direction: column; align-items: center; width: 100%; height: 100%;}

    .track-item {
        display: flex;
        align-items: center;
        border-bottom: 1.5px solid #2e2e2e;
        padding: 5px 0;
    }

    .track-item img {
        width: 64px;
        height: 64px;
        margin-right: 15px;
    }

    .track-details {flex-grow: 1; text-align: left; color: #f2f2f2; font-size: 14px; font-weight: 400; letter-spacing: 0.4px; opacity: 0.8;}
    .artist-name {margin-top: 4px; font-size: 12px;}

    .track-item button {
        width: 20px;
        height: 20px;
        background-color: #e2e2e2;
        border: none;
        border-radius: 50%;
        cursor: pointer;
    }

    #search-results {
        width: 90%;
        height: 90%;
        margin-top: 10px;
        overflow: auto;
        -ms-overflow-style: none;
    }

    #pagination {
        display: flex;
        justify-content: center;
        width: 90%;
        margin-top: 20px;
        color: #f2f2f2;
        font-size: 14px;
        font-weight: 400;
        letter-spacing: 0.4px;
        opacity: 0.8;
    }

    #pagination span {
        margin: 0 10px 0 10px;
    }
</style>