let currentPage = 1;
const itemsPerPage = 8; // 한 페이지에 표시할 항목 수

function searchTracks(query, page = 1) {
    const offset = (page - 1) * itemsPerPage;

    fetch(
        `https://api.spotify.com/v1/search?q=${encodeURIComponent(
        query
        )}&type=track&limit=${itemsPerPage}&offset=${offset}`,
        {
        headers: {
            Authorization: `Bearer ${sessionStorage.accessToken}`,
        },
        }
    )
    .then((response) => response.json())
    .then((data) => {
    	displaySearchResults(data.tracks.items);
        setupPagination(data.tracks.total, page, query);
    })
    .catch((error) => console.error("검색 에러:", error));
}
function setupPagination(totalItems, currentPage, query) {
    const pagination = document.getElementById("pagination");
    pagination.innerHTML = "";

    const totalPages = Math.ceil(totalItems / itemsPerPage);

    // 이전 페이지 버튼
    if (currentPage > 1) {
        const prevButton = document.createElement("button");
        prevButton.innerText = "이전";
        prevButton.classList.add("pageBtn");
        prevButton.addEventListener("click", () => {searchTracks(query, currentPage - 1);});
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
        nextButton.classList.add("pageBtn");
        nextButton.addEventListener("click", () => {searchTracks(query, currentPage + 1);});
        pagination.appendChild(nextButton);
    }
}
function displaySearchResults(tracks) {
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

        const checkbox = document.createElement("input");
        checkbox.classList.add("search-checkbox");
        checkbox.type = 'radio';
        checkbox.name = 'track';
        checkbox.value = JSON.stringify(track);

        trackItem.appendChild(albumImage);
        trackItem.appendChild(trackDetails);
        trackItem.appendChild(checkbox);

        searchResults.appendChild(trackItem);
    });
}

// 이벤트 리스너 등록
document.getElementById("search-button").addEventListener("click", () => {
	const query = document.getElementById("search-input").value;
	if (query) {
		searchTracks(query);
	}
});
// 검색 버튼 이벤트 리스너 수정
document.getElementById("search-button").addEventListener("click", () => {
	const query = document.getElementById("search-input").value;
	if (query) {
		currentPage = 1; // 새로운 검색 시 페이지를 1로 초기화
		searchTracks(query, currentPage);
	}
});
