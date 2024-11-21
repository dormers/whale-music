// [ Resize ]
$(document).ready(() => {
    resize();
});
$(window).resize(() => {
    resize();
});

function resize() {
    const libraryElement = document.querySelector(".mainLibraryFrame");
    const detailElement = document.querySelector(".mainDetailFrame");
    const headerElement = document.querySelector(".header");
    const footerElement = document.querySelector(".footer");
    const mainElement = document.querySelector('.main');
    const mainContentElement = document.querySelector('.mainContentFrame');

    const windowWidth = window.innerWidth;
    const libraryWidth = libraryElement ? libraryElement.offsetWidth : 0;
    const detailWidth = detailElement ? detailElement.offsetWidth : 0;

    const windowHeight = window.innerHeight;
    const headerHeight = headerElement ? headerElement.offsetHeight : 0;
    const footerHeight = footerElement ? footerElement.offsetHeight : 0;

    if (mainElement) {
        mainElement.style.height = `${windowHeight - headerHeight - footerHeight}px`;
    }

    if (mainContentElement) {
        const availableWidth = windowWidth - libraryWidth - detailWidth;
        if (availableWidth > 200) {
            mainContentElement.style.width = `${availableWidth}px`;
        } else {
            mainContentElement.style.width = `200px`;
        }
    }
}


// [ 부모창으로부터 데이터 받는 함수 ]
window.addEventListener("message", receiveMessage, false);

async function receiveMessage(event) {
    if (event.data.type === 'albumDetail') {
        window.location.href = '/whale/streaming/albumDetail?albumId='+event.data.albumId;
    } else if (event.data.type === 'trackDetail') {
        window.location.href = '/whale/streaming/detail?trackId='+event.data.trackId;
    } else if (event.data.type === 'artistDetail') {
        window.location.href = '/whale/streaming/artistDetail?artistId='+event.data.artistId;
    } else {
    }
}

function playTrack(trackId) {
    return fetch('/whale/streaming/playTrack', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ trackId: trackId })
    })
        .then(response => {
            if (response.ok) {
                console.log("Track is now playing");
                return Promise.resolve();
            } else {
                console.error("Failed to play track");
                return Promise.reject(new Error("Failed to play track"));
            }
        })
        .catch(error => {
            console.error("Error playing track:", error);
            return Promise.reject(error);
        });
}

function pauseTrack(trackId) {
    return fetch('/whale/streaming/pauseTrack', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ trackId: trackId })
    })
        .then(response => {
            if (response.ok) {
                console.log("Track is now paused");
                return Promise.resolve();
            } else {
                console.error("Failed to pause track");
                return Promise.reject(new Error("Failed to pause track"));
            }
        })
        .catch(error => {
            console.error("Error pausing track:", error);
            return Promise.reject(error);
        });
}

function playAndNavigate(trackId) {
    // 트랙을 재생하고 성공 시 navigateToDetail 호출
    playTrack(trackId).then(() => {
        navigateToDetail(trackId);
    }).catch(error => console.error("Error during play and navigate:", error));
}


$(document).ready(function () {
    var isExpanded = false;

    $('#toggleButton').click(function () {
        isExpanded = !isExpanded;
        $('.mainLibraryFrame').toggleClass('expanded', isExpanded);

        const path = $('#toggleButton path');
        if (isExpanded) {
            path.attr('d', 'M3 22a1 1 0 0 1-1-1V3a1 1 0 0 1 2 0v18a1 1 0 0 1-1 1zM15.5 2.134A1 1 0 0 0 14 3v18a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V6.464a1 1 0 0 0-.5-.866l-6-3.464zM9 2a1 1 0 0 0-1 1v18a1 1 0 1 0 2 0V3a1 1 0 0 0-1-1z'); // 확장 시 새로운 d 값
        } else {
            path.attr('d', 'M14.5 2.134a1 1 0 0 1 1 0l6 3.464a1 1 0 0 1 .5.866V21a1 1 0 0 1-1 1h-6a1 1 0 0 1-1-1V3a1 1 0 0 1 .5-.866zM16 4.732V20h4V7.041l-4-2.309zM3 22a1 1 0 0 1-1-1V3a1 1 0 0 1 2 0v18a1 1 0 0 1-1 1zm6 0a1 1 0 0 1-1-1V3a1 1 0 0 1 2 0v18a1 1 0 0 1-1 1z'); // 축소 시 기본 d 값
        }
    });
});


// 스크롤 이동 함수
function updateScrollButtons() {
    const container = document.getElementById('recommendationContents');
    const scrollLeftBtn = document.getElementById('scrollLeftBtn');
    const scrollRightBtn = document.getElementById('scrollRightBtn');

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

function scrollLeftContent() {
    const container = document.getElementById('recommendationContents');
    container.scrollBy({ left: -210, behavior: 'smooth' });
    setTimeout(updateScrollButtons, 300); // 스크롤 후 버튼 업데이트
}

function scrollRightContent() {
    const container = document.getElementById('recommendationContents');
    container.scrollBy({ left: 210, behavior: 'smooth' });
    setTimeout(updateScrollButtons, 300); // 스크롤 후 버튼 업데이트
}

// 스크롤 및 초기 버튼 상태 설정
document.addEventListener("DOMContentLoaded", () => {
	// 홈화면 기능시 함수 실행
	if (window.location.pathname === '/whale/streaming/home') {
		updateScrollButtons(); // 초기 상태
	    const container = document.getElementById('recommendationContents');
	    container.addEventListener('scroll', updateScrollButtons);
	}
});

// 트랙 이미지 누르면 트랙 디테일 페이지로 리다이렉트
function navigateToDetail(trackId) {
    window.location.href = `/whale/streaming/detail?trackId=${trackId}`;
}

// 길이에 따른 폰트 크기 조절 함수
function adjustFontSizeByTextLength(elementId) {
    const element = document.getElementById(elementId);
    if (element) {
        const textLength = element.innerText.length;

        if (textLength > 16) {
            element.classList.add("small-font");
        } else if (textLength > 8) {
            element.classList.add("medium-font");
        } else {
            element.classList.add("large-font");
        }
    }
}

// 페이지 로드 시 폰트 크기 조절
document.addEventListener("DOMContentLoaded", function() {
    adjustFontSizeByTextLength("trackName");
    adjustFontSizeByTextLength("playlistName");
    adjustFontSizeByTextLength("artistName");
    adjustFontSizeByTextLength("likedTracksName");
});

document.addEventListener("DOMContentLoaded", function() {
    const descriptionElement = document.querySelector(".playlistDesc");
    if (descriptionElement) {
        // a 태그를 찾아 제거
        const parser = new DOMParser();
        const parsedContent = parser.parseFromString(descriptionElement.innerHTML, 'text/html');
        const links = parsedContent.querySelectorAll("a");

        // 각 a 태그를 순회하며 텍스트만 남기기
        links.forEach(link => {
            const textNode = document.createTextNode(link.textContent);
            link.replaceWith(textNode);
        });

        // 수정된 내용을 다시 playlistDesc에 반영
        descriptionElement.innerHTML = parsedContent.body.innerHTML;
    }
});


// 스트리밍 홈 화면으로 돌아가는 버튼
function goMain() {
    window.location.href = "/whale/streaming";
}

// 스트리밍 서치 기능
function goSearch() {
    window.location.href = "/whale/streaming/search";
    const query = document.querySelector('.headerInput').value;
    if (query) {
        window.location.href = `/whale/streaming/search?query=${encodeURIComponent(query)}`;
    } else {
        alert("검색어를 입력해주세요.");
        window.location.href = `/whale/streaming`;
    }
}

// 엔터 키 입력 시 검색 실행
document.addEventListener("DOMContentLoaded", () => {
    const headerInput = document.querySelector('.headerInput');

    headerInput.addEventListener("keypress", (event) => {
        if (event.key === "Enter") {
            goSearch();
        }
    });
});


// 검색 결과 스크롤 이동 함수
function updateSearchScrollButtons() {
    const container = document.querySelector('.searchResults');
    const searchScrollLeftBtn = document.getElementById('searchScrollLeftBtn');
    const searchScrollRightBtn = document.getElementById('searchScrollRightBtn');

    // 왼쪽 버튼 보이기/숨기기
    if (container.scrollLeft > 0) {
        searchScrollLeftBtn.classList.remove('hidden');
    } else {
        searchScrollLeftBtn.classList.add('hidden');
    }

    // 오른쪽 버튼 보이기/숨기기
    const maxScrollLeft = container.scrollWidth - container.clientWidth;
    if (container.scrollLeft < maxScrollLeft - 1) { // 약간의 여유를 두어 숨김 처리
        searchScrollRightBtn.classList.remove('hidden');
    } else {
        searchScrollRightBtn.classList.add('hidden');
    }
}

function scrollLeftSearchContent() {
    const container = document.querySelector('.searchResults');
    container.scrollBy({ left: -210, behavior: 'smooth' });
    setTimeout(updateSearchScrollButtons, 300); // 스크롤 후 버튼 업데이트
}

function scrollRightSearchContent() {
    const container = document.querySelector('.searchResults');
    container.scrollBy({ left: 210, behavior: 'smooth' });
    setTimeout(updateSearchScrollButtons, 300); // 스크롤 후 버튼 업데이트
}

// 스크롤 및 초기 버튼 상태 설정
document.addEventListener("DOMContentLoaded", () => {
	// 검색 기능시 함수 실행
	if (window.location.pathname === '/whale/streaming/search') {
		updateSearchScrollButtons(); // 초기 상태
	    const container = document.querySelector('.searchResults');
	    container.addEventListener('scroll', updateSearchScrollButtons);
	}
});

// 아티스트 디테일 스크롤 이동 함수
function updateArtistDetailScrollButtons() {
    const container = document.querySelector('.albumsWrap');
    const scrollLeftBtn = document.getElementById('artistDetailScrollLeftBtn');
    const scrollRightBtn = document.getElementById('artistDetailScrollRightBtn');

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

function scrollLeftArtistDetailContent() {
    const container = document.querySelector('.albumsWrap');
    container.scrollBy({ left: -210, behavior: 'smooth' });
    setTimeout(updateArtistDetailScrollButtons, 300); // 스크롤 후 버튼 업데이트
}

function scrollRightArtistDetailContent() {
    const container = document.querySelector('.albumsWrap');
    container.scrollBy({ left: 210, behavior: 'smooth' });
    setTimeout(updateArtistDetailScrollButtons, 300); // 스크롤 후 버튼 업데이트
}

// 아티스트 디테일 스크롤 초기화
document.addEventListener("DOMContentLoaded", () => {
	// 아티스트 디테일 기능시 함수 실행
	if (window.location.pathname === '/whale/streaming/artistDetail') {
		updateArtistDetailScrollButtons();
	    const container = document.querySelector('.albumsWrap');
	    container.addEventListener('scroll', updateArtistDetailScrollButtons);
	}
});

// 아티스트 디테일
function navigateToArtistDetail(artistId) {
    window.location.href = `/whale/streaming/artistDetail?artistId=${artistId}`;
}

// 플레이리스트 스크롤 이동 함수
function updatePlayListScrollButtons() {
    const container = document.querySelector('.relatedPlaylists');
    const scrollLeftBtn = document.getElementById('playListScrollLeftBtn');
    const scrollRightBtn = document.getElementById('playListScrollRightBtn');

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

function scrollLeftPlayListContent() {
    const container = document.querySelector('.relatedPlaylists');
    container.scrollBy({ left: -210, behavior: 'smooth' });
    setTimeout(updatePlayListScrollButtons, 300); // 스크롤 후 버튼 업데이트
}

function scrollRightPlayListContent() {
    const container = document.querySelector('.relatedPlaylists');
    container.scrollBy({ left: 210, behavior: 'smooth' });
    setTimeout(updatePlayListScrollButtons, 300); // 스크롤 후 버튼 업데이트
}

// 플레이리스트 스크롤 초기화
document.addEventListener("DOMContentLoaded", () => {
	// 아티스트 디테일 기능시 함수 실행
	if (window.location.pathname === '/whale/streaming/artistDetail') {
		updatePlayListScrollButtons();
	    const container = document.querySelector('.relatedPlaylists');
	    container.addEventListener('scroll', updatePlayListScrollButtons);
	}
});

// 재생/일시정지 상태를 토글하는 함수
function togglePlayPause(trackId, button) {
    const isPlaying = button.classList.contains("playing");

    if (isPlaying) {
        // 일시정지 호출
        pauseTrack(trackId)
            .then(() => {
                button.classList.remove("playing");
                button.querySelector(".icon").innerHTML = `
                        <path d="m7.05 3.606 13.49 7.788a.7.7 0 0 1 0 1.212L7.05 20.394A.7.7 0 0 1 6 19.788V4.212a.7.7 0 0 1 1.05-.606z"></path>`; // 재생 아이콘으로 변경
            })
            .catch(error => console.error("Error pausing track:", error));
    } else {
        // 재생 호출
        playTrack(trackId)
            .then(() => {
                button.classList.add("playing");
                button.querySelector(".icon").innerHTML = `
                        <path d="M6 19h4V5H6zm8-14v14h4V5z"></path>`; // 일시정지 아이콘으로 변경
            })
            .catch(error => console.error("Error playing track:", error));
    }
}

function playPlaylist(playlistId) {
    window.location.href = `/whale/streaming/playlistDetail?playlistId=${playlistId}`;
}

function navigateToAlbumDetail(albumId) {
    window.location.href = `/whale/streaming/albumDetail?albumId=${albumId}`;
}

function playAllPlaylist(playlistId) {
    return fetch('/whale/streaming/playAllPlaylist', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ playlistId: playlistId })
    })
        .then(response => {
            if (response.ok) {
                console.log("Playlist is now playing");
            } else {
                console.error("Failed to play playlist");
            }
        })
        .catch(error => {
            console.error("Error playing playlist:", error);
        });
}

// 메인 스트리밍 화면 좋아요 버튼
let trackInfo = [];

function initializePlayer(player) {
    player.addListener('player_state_changed', (state) => {
        // 트랙 정보가 있을 때만 trackInfo 배열 초기화
        if (state && state.track_window && state.track_window.current_track) {
            trackInfo = [
                state.track_window.current_track.album.images[0].url, // 트랙 커버 이미지
                state.track_window.current_track.name,                // 트랙 이름
                state.track_window.current_track.artists[0].name,     // 아티스트 이름
                state.track_window.current_track.album.name,          // 앨범 이름
                state.track_window.current_track.id,                  // 트랙 ID
                false                                                 // 좋아요 상태 기본값
            ];

            // 비동기로 앨범 ID와 아티스트 ID를 추가로 가져옴
            (async () => {
                try {
                    const result = await fetchWebApi(`v1/tracks/${trackInfo[4]}`, 'GET');
                    trackInfo[6] = result.album.id;    // 앨범 ID
                    trackInfo[7] = result.artists[0].id;  // 아티스트 ID
                } catch (error) {
                    console.error('Error fetching track details:', error);
                }
            })();

            // 좋아요 상태를 서버에서 가져와 trackInfo[5]에 설정
            fetch(`/whale/streaming/currentTrackInfo`, {
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                },
                method: 'POST',
                body: JSON.stringify({
                    artistName: trackInfo[2],
                    trackName: trackInfo[1],
                    albumName: trackInfo[3],
                    trackCover: trackInfo[0],
                    trackSpotifyId: trackInfo[4]
                })
            })
                .then(response => response.json())
                .then(data => {
                    trackInfo[5] = data.result === 'yes';  // 좋아요 상태를 업데이트
                })
                .catch(error => console.error('Error fetching like status:', error));
        } else {
            console.error("Player state or track information is missing.");
        }
    });
}

// 좋아요 상태 변경 함수
let likeActionPending = false; // 중복 요청 방지를 위한 상태 잠금 변수

async function insertTrackLike(coverUrl, trackName, artistName, albumName, trackId, isLiked) {
    if (likeActionPending) return;
    likeActionPending = true;

    trackInfo = [coverUrl, trackName, artistName, albumName, trackId, isLiked];

    try {
        const body = {
            artistName: trackInfo[2],
            trackName: trackInfo[1],
            albumName: trackInfo[3],
            trackCover: trackInfo[0],
            trackSpotifyId: trackInfo[4]
        };

        const response = await fetch(`/whale/streaming/toggleTrackLike`, {
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            method: 'POST',
            body: JSON.stringify(body)
        });
    } catch (error) {
        console.error('Error while updating the Track Like Data:', error);
    } finally {
        likeActionPending = false;
    }
}

// player 초기화 함수
function setupPlayer() {
    window.onSpotifyWebPlaybackSDKReady = () => {
        const player = new Spotify.Player({
            name: 'Whale Player',
            getOAuthToken: cb => { cb(sessionStorage.accessToken); },
            volume: 0.5
        });

        // Player 연결
        player.connect().then(success => {
            if (success) {
                console.log('The Web Playback SDK successfully connected to Spotify!');
            }
        });

        // Player 이벤트 리스너 추가
        initializePlayer(player);
    };
}

async function fetchWebApi(url, method) {
    const response = await fetch(`https://api.spotify.com/${url}`, {
        method: method,
        headers: {
            'Authorization': `Bearer ${sessionStorage.accessToken}`
        }
    });
    return response.json();
}

// 초기화 코드 실행
setupPlayer();
// --- 메인 스트리밍 화면 좋아요 버튼 끝

// 좋아요 표시한 곡
function navigateToLikedTracks() {
    window.location.href = "/whale/streaming/likedTracks";
}

// 좋아요 표시한 곡 페이지에서 좋아요 제거
async function toggleTrackLike(artistName, trackName, albumName, trackCover, trackId, button) {
	const body = {
        artistName: artistName,
        trackName: trackName,
        albumName: albumName,
        trackCover: trackCover,
        trackSpotifyId: trackId
    };
	
    try {
        const response = await fetch('/whale/streaming/toggleTrackLike', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(body)
        });
        
        const data = await response.json();
        if (data.result === 'deleted') {button.querySelector("path").setAttribute("fill", "#000000");}
        else {button.querySelector("path").setAttribute("fill", "rgb(203, 130, 163)");}
    } catch (error) {
        console.error("Error toggling like status:", error);
    }
}

// 좋아요 상태 확인 및 초기 이미지 설정 함수
async function checkTrackLikeStatus(trackId) {
    try {
        // 서버에 좋아요 상태 요청
        const response = await fetch(`/whale/streaming/checkTrackLike`, {
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            method: 'POST',
            body: JSON.stringify({ trackSpotifyId: trackId })
        });

        if (response.ok) {
            const data = await response.json();
            const isLiked = data.result === 'liked'; // 서버에서 'liked' 반환 시 true로 설정
            updateLikeButton(trackId, isLiked); // 좋아요 상태에 따라 버튼 업데이트
        } else {
            console.error('Failed to fetch like status:', response.statusText);
        }
    } catch (error) {
        console.error('Error fetching like status:', error);
    }
}

// 페이지 로드 시 모든 트랙의 좋아요 상태 확인
document.addEventListener("DOMContentLoaded", function() {
    const trackElements = document.querySelectorAll("[data-track-id]"); // data-track-id 속성을 가진 모든 요소 선택

    trackElements.forEach(trackElement => {
        const trackId = trackElement.getAttribute("data-track-id"); // 트랙 ID 가져오기
        checkTrackLikeStatus(trackId, trackElement); // 트랙 ID와 요소를 전달하여 좋아요 상태 확인
    });
});

// 좋아요 상태 확인 함수
async function checkTrackLikeStatus(trackId, trackElement) {
    try {
        const response = await fetch("/whale/streaming/checkTrackLike", {
            method: "POST",
            headers: {
                "Accept": "application/json",
                "Content-Type": "application/json"
            },
            body: JSON.stringify({ trackSpotifyId: trackId })
        });

        const data = await response.json();
        // `recommendationLike`와 `recentlyPlayedTrackLike`에서 좋아요 아이콘을 찾아 변경
        let imgElement = trackElement.querySelector(".recommendationLike img")
            || trackElement.querySelector(".recentlyPlayedTrackLike img");

        if (data.result === "liked") {
            imgElement.src = `${window.contextPath}/static/images/streaming/liked.png`;
        } else {
            imgElement.src = `${window.contextPath}/static/images/streaming/like.png`;
        }
    } catch (error) {
    }
}

// 최근 재생한 항목 스크롤 이동 함수
function updateRecentlyPlayedScrollButtons() {
    const container = document.querySelector('.recentlyPlayedTracks');
    const scrollLeftBtn = document.getElementById('scrollRecentlyPlayedLeftBtn');
    const scrollRightBtn = document.getElementById('scrollRecentlyPlayedRightBtn');

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

function scrollRecentlyPlayedLeftContent() {
    const container = document.querySelector('.recentlyPlayedTracks');
    container.scrollBy({ left: -210, behavior: 'smooth' });
    setTimeout(updateRecentlyPlayedScrollButtons, 300); // 스크롤 후 버튼 업데이트
}

function scrollRecentlyPlayedRightContent() {
    const container = document.querySelector('.recentlyPlayedTracks');
    container.scrollBy({ left: 210, behavior: 'smooth' });
    setTimeout(updateRecentlyPlayedScrollButtons, 300); // 스크롤 후 버튼 업데이트
}

// 스크롤 및 초기 버튼 상태 설정
document.addEventListener("DOMContentLoaded", () => {
    // 홈화면에서 최근 재생한 항목 스크롤 버튼 업데이트
    if (window.location.pathname === '/whale/streaming/home') {
        updateRecentlyPlayedScrollButtons(); // 초기 상태
        const container = document.querySelector('.recentlyPlayedTracks');
        container.addEventListener('scroll', updateRecentlyPlayedScrollButtons);
    }
});

// 스트리밍 메인 좋아요 버튼 클릭 시 이미지 변경 함수
document.addEventListener("DOMContentLoaded", function() {
    // recommendationLike 및 recentlyPlayedTrackLike 클래스의 모든 이미지 요소 선택
    const likeButtons = document.querySelectorAll(".recommendationLike img, .recentlyPlayedTrackLike img");

    likeButtons.forEach(button => {
        button.addEventListener("click", function() {
            // 현재 이미지 경로 가져오기
            const currentSrc = button.src;

            // 이미지 경로 비교 후 변경
            if (currentSrc.includes("like.png")) {
                button.src = `${window.contextPath}/static/images/streaming/liked.png`;
            } else {
                button.src = `${window.contextPath}/static/images/streaming/like.png`;
            }
        });
    });
});

// 페이지 로드 시 trackDetailLike의 좋아요 상태 확인
document.addEventListener("DOMContentLoaded", function() {
    const trackDetailElement = document.querySelector(".trackDetailLike");

    if (trackDetailElement) {
        const trackId = trackDetailElement.getAttribute("data-track-id"); // trackDetailLike의 트랙 ID 가져오기
        checkTrackDetailLikeStatus(trackId, trackDetailElement); // 트랙 ID와 요소를 전달하여 좋아요 상태 확인
    }
});

// 좋아요 상태 확인 함수
async function checkTrackDetailLikeStatus(trackId, trackElement) {
    try {
        const response = await fetch("/whale/streaming/checkTrackLike", {
            method: "POST",
            headers: {
                "Accept": "application/json",
                "Content-Type": "application/json"
            },
            body: JSON.stringify({ trackSpotifyId: trackId })
        });

        const data = await response.json();
        const iconElement = trackElement.querySelector(".icon"); // icon 요소 선택

        if (data.result === "liked") {
            iconElement.style.filter = "invert(0)";
        } else {
            iconElement.style.filter = "invert(1)";
        }
    } catch (error) {
        console.error("Error checking track like status:", error);
    }
}

// 트랙 디테일 좋아요 버튼 클릭 시 이미지 변경 함수
document.addEventListener("DOMContentLoaded", function() {
    // trackDetailLike 클래스의 모든 .icon 요소 선택
    const likeButtons = document.querySelectorAll(".trackDetailLike .icon");

    likeButtons.forEach(button => {
        button.addEventListener("click", function() {
            if (button.style.filter === "invert(1)") {
                button.style.filter = "invert(0)";
            } else {
                button.style.filter = "invert(1)";
            }
        });
    });
});

// 앨범 전체 재생을 요청하는 함수
function playAllAlbum(albumId) {
    fetch('/whale/streaming/playAllAlbum', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: new URLSearchParams({ albumId: albumId })
    })
        .then(response => response.json())
        .then(data => {
            if (data) {
                console.log("앨범 전체 재생 시작");
            } else {
                console.error("앨범 재생 실패");
            }
        })
        .catch(error => console.error("앨범 재생 요청 중 오류 발생:", error));
}

// 추천 플레이리스트 스크롤 이동 함수
function updateFeaturedLeftContentScrollButtons() {
    const container = document.querySelector('.featuredPlaylistsContent');
    const scrollLeftBtn = document.getElementById('scrollFeaturedLeftBtn');
    const scrollRightBtn = document.getElementById('scrollFeaturedRightBtn');

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

function scrollFeaturedLeftContent() {
    const container = document.querySelector('.featuredPlaylistsContent');
    container.scrollBy({ left: -210, behavior: 'smooth' });
    setTimeout(updateFeaturedLeftContentScrollButtons, 300); // 스크롤 후 버튼 업데이트
}

function scrollFeaturedRightContent() {
    const container = document.querySelector('.featuredPlaylistsContent');
    container.scrollBy({ left: 210, behavior: 'smooth' });
    setTimeout(updateFeaturedLeftContentScrollButtons, 300); // 스크롤 후 버튼 업데이트
}

// 스크롤 및 초기 버튼 상태 설정
document.addEventListener("DOMContentLoaded", () => {
    // 홈화면에서 최근 재생한 항목 스크롤 버튼 업데이트
    if (window.location.pathname === '/whale/streaming/home') {
        updateFeaturedLeftContentScrollButtons(); // 초기 상태
        const container = document.querySelector('.featuredPlaylistsContent');
        container.addEventListener('scroll', updateFeaturedLeftContentScrollButtons);
    }
});

// 추천 아티스트 스크롤 이동 함수
function updateRecommendedArtistsLeftContentScrollButtons() {
    const container = document.querySelector('.recommendedArtistsContainer');
    const scrollLeftBtn = document.getElementById('scrollRecommendedArtistsLeftBtn');
    const scrollRightBtn = document.getElementById('scrollRecommendedArtistsRightBtn');

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

function scrollRecommendedArtistsLeftContent() {
    const container = document.querySelector('.recommendedArtistsContainer');
    container.scrollBy({ left: -210, behavior: 'smooth' });
    setTimeout(updateRecommendedArtistsLeftContentScrollButtons, 300); // 스크롤 후 버튼 업데이트
}

function scrollRecommendedArtistsRightContent() {
    const container = document.querySelector('.recommendedArtistsContainer');
    container.scrollBy({ left: 210, behavior: 'smooth' });
    setTimeout(updateRecommendedArtistsLeftContentScrollButtons, 300); // 스크롤 후 버튼 업데이트
}

// 스크롤 및 초기 버튼 상태 설정
document.addEventListener("DOMContentLoaded", () => {
    // 홈화면에서 최근 재생한 항목 스크롤 버튼 업데이트
    if (window.location.pathname === '/whale/streaming/home') {
        updateRecommendedArtistsLeftContentScrollButtons(); // 초기 상태
        const container = document.querySelector('.recommendedArtistsContainer');
        container.addEventListener('scroll', updateRecommendedArtistsLeftContentScrollButtons);
    }
});

// 검색창 앨범 스크롤 이동 함수
function updateSearchAlbumsLeftContentScrollButtons() {
    const container = document.querySelector('.searchAlbumsWrap');
    const scrollLeftBtn = document.getElementById('searchAlbumsScrollLeftBtn');
    const scrollRightBtn = document.getElementById('searchAlbumsScrollRightBtn');
    
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
}

// 왼쪽으로 스크롤하는 함수
function scrollLeftSearchAlbumsContent() {
    const container = document.querySelector('.searchAlbumsWrap');
    container.scrollBy({ left: -210, behavior: 'smooth' });
    setTimeout(updateSearchAlbumsLeftContentScrollButtons, 300); // 스크롤 후 버튼 업데이트
}

// 오른쪽으로 스크롤하는 함수
function scrollRightSearchAlbumsContent() {
    const container = document.querySelector('.searchAlbumsWrap');
    container.scrollBy({ left: 210, behavior: 'smooth' });
    setTimeout(updateSearchAlbumsLeftContentScrollButtons, 300); // 스크롤 후 버튼 업데이트
}

// 스크롤 및 초기 버튼 상태 설정
document.addEventListener("DOMContentLoaded", () => {
    updateSearchAlbumsLeftContentScrollButtons(); // 초기 상태 설정
    const container = document.querySelector('.searchAlbumsWrap');
    if (container) {
		container.addEventListener('scroll', updateSearchAlbumsLeftContentScrollButtons); // 스크롤 이벤트 감지
	}
});

// 검색창 플레이리스트 스크롤 이동 함수
function updateSearchPlayListContentScrollButtons() {
    const container = document.querySelector('.searchRelatedPlaylists');
    const scrollLeftBtn = document.getElementById('searchPlayListScrollLeftBtn');
    const scrollRightBtn = document.getElementById('searchPlayListScrollRightBtn');
    
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
}

// 왼쪽으로 스크롤하는 함수
function scrollLeftSearchPlayListContent() {
    const container = document.querySelector('.searchRelatedPlaylists');
    container.scrollBy({ left: -210, behavior: 'smooth' });
    setTimeout(updateSearchPlayListContentScrollButtons, 300); // 스크롤 후 버튼 업데이트
}

// 오른쪽으로 스크롤하는 함수
function scrollRightSearchPlayListContent() {
    const container = document.querySelector('.searchRelatedPlaylists');
    container.scrollBy({ left: 210, behavior: 'smooth' });
    setTimeout(updateSearchPlayListContentScrollButtons, 300); // 스크롤 후 버튼 업데이트
}

// 스크롤 및 초기 버튼 상태 설정
document.addEventListener("DOMContentLoaded", () => {
    updateSearchPlayListContentScrollButtons(); // 초기 상태 설정
    const container = document.querySelector('.searchRelatedPlaylists');
    if (container) {
		container.addEventListener('scroll', updateSearchPlayListContentScrollButtons);
	}
});

function toggleIcon(element) {
    const svg = element.querySelector("svg");
    const path = svg.querySelector("path");

	if (path.getAttribute("fill") === 'rgb(203, 130, 163)') {
        path.setAttribute("fill", "#000000");
    } else {
        path.setAttribute("fill", "rgb(203, 130, 163)");
    }
}

// 플레이리스트 추가 및 삭제 함수
function followPlaylist(i,j) {
    if (i === 0) {
        fetch(`/whale/streaming/followPlaylist?id=${ j }`);
    } else {
        fetch(`/whale/streaming/unfollowPlaylist?id=${ j }`);
    }
    setTimeout(() => {location.href = '/whale/streaming/playlistDetail?playlistId='+j;},500);
}

// 좋아요 전체 트랙 재생 함수
function playAllLikeTrack(i) {
	fetch(`/whale/streaming/playAllLikeTrack`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ uris: i })
    });
}

// 트랙 아이디 복사 함수
function copyTrackId(a,b,c,d,e) {
    // 해당 트랙 Whale DB에 저장
    const body = {
        artistName: c,
        trackName: b,
        albumName: d,
        trackCover: a,
        trackSpotifyId: e
    };

    fetch(`/whale/streaming/insertTrackInfo`, {
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        },
        method: 'POST',
        body: JSON.stringify(body)
    });
    // 클립 보드 카피 기능
    var t = document.createElement("textarea");
    document.body.appendChild(t);
    t.value = `%music%${e}`;
    t.select();
    document.execCommand('copy');
    document.body.removeChild(t);
    alert('해당 트랙 아이디를 복사했습니다.');
}
