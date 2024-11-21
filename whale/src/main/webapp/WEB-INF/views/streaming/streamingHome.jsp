<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="com.tech.whale.main.models.MainAuthorizationCode" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="icon" href="${pageContext.request.contextPath}/static/images/main/whaleLogo.png">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/streaming/streamingStyles.css"/>
    <title>Whale Streaming</title>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/streaming/mainFunction.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/setting/darkMode.js"></script>
    <script>
        window.contextPath = "<c:out value='${pageContext.request.contextPath}'/>";
        const page = "${page}";
        console.log(page);
    </script>
</head>
<body class="streamingBody">
<div class="header">
    <div class="headerItems">
        <button class="homeBtn">
            <button class="homeBtn" onclick="goMain()">
                <img src="${pageContext.request.contextPath}/static/images/streaming/homeBtn.png"
                     alt="Music Whale Search Button" height="20px">
            </button>
        </button>
        <div class="headerSearch">
            <button class="searchBtn" onclick="goSearch()">
                <img src="${pageContext.request.contextPath}/static/images/streaming/searchBtn.png"
                     alt="Music Whale Search Button" height="14px">
            </button>
            <input class="headerInput" placeholder="어떤 콘텐츠를 감상하고 싶으세요?" onfocus="placeholder=''"
                   onblur="placeholder='어떤 콘텐츠를 감상하고 싶으세요?'">
        </div>
    </div>
</div>
<div class="main">
    <div class="mainLibraryFrame">
        <div class="mainLibrary">
            <svg id="toggleButton"
                 data-encore-id="icon"
                 role="img"
                 aria-hidden="true"
                 viewBox="0 0 24 24"
                 class="libraryBtn"
            >
                <path
                        d="M14.5 2.134a1 1 0 0 1 1 0l6 3.464a1 1 0 0 1 .5.866V21a1 1 0 0 1-1 1h-6a1 1 0 0 1-1-1V3a1 1 0 0 1 .5-.866zM16 4.732V20h4V7.041l-4-2.309zM3 22a1 1 0 0 1-1-1V3a1 1 0 0 1 2 0v18a1 1 0 0 1-1 1zm6 0a1 1 0 0 1-1-1V3a1 1 0 0 1 2 0v18a1 1 0 0 1-1 1z"
                ></path>
            </svg>
            <p class="mainLibraryName">내 라이브러리</p>
            <div class="userPlaylists">
                <div class="playlist-content" onclick="navigateToLikedTracks()">
                    <div class="playlistCover">
                        <img src="https://misc.scdn.co/liked-songs/liked-songs-64.png" alt="WHALE LIKE TRACK" width="45"
                             height="45"
                             style="border-radius: 2px; opacity: 0.8;">
                    </div>
                    <div class="libraryInfo">
                        <p class="libraryInfoFont">좋아요 표시한 곡</p>
                        <p class="libraryInfoFont" style="margin-top: 2px; font-size: 10px;">플레이리스트
                            • ${fn:length(likedTracks)}곡</p>
                    </div>
                </div>
                <c:forEach var="playlist" items="${userPlaylists}">
                    <div class="playlist-content">
                        <c:if test="${not empty playlist.images}">
                            <div class="playlistCover" onclick="playPlaylist('${playlist.id}')">
                                <img src="${playlist.images[0].url}" alt="${playlist.name}" width="45" height="45"
                                     style="border-radius: 2px; opacity: 0.8;">
                            </div>
                            <div class="libraryInfo">
                                <p class="libraryInfoFont">${playlist.name}</p>
                                <p class="libraryInfoFont" style="margin-top: 2px; font-size: 10px;">
                                    플레이리스트 • ${playlist.owner.displayName}</p>
                            </div>
                        </c:if>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    <div class="mainContentFrame">
        <div class="mainContent">
            <div class="mainContentMargin">
                <div class="recommendationsHeader"></div>
                <c:choose>
                    <c:when test="${page == 'home'}">
                        <div class="recommendations">
                            <div class="recommendationTitle"><p class="titleName">내가 즐겨 듣는 노래</p></div>
                            <div class="recommendationWrapper">
                                <button class="slideButton left" id="scrollLeftBtn" onclick="scrollLeftContent()">
                                    <img src="${pageContext.request.contextPath}/static/images/streaming/prev.png"
                                         alt="Like Button" width="30"
                                         height="30" style="border-radius: 8px; opacity: 0.75;">
                                </button>
                                <div class="recommendationContents" id="recommendationContents">
                                    <c:forEach var="track" items="${trackPaging.items}">
                                        <div class="recommendationContent" data-track-id="${track.id}">
                                            <div class="recommendationLike"
                                                 onclick="insertTrackLike('<c:out
                                                         value="${track.album.images[0].url}"/>', '<c:out
                                                         value="${fn:escapeXml(track.name)}"/>', '<c:out
                                                         value="${fn:escapeXml(track.artists[0].name)}"/>', '<c:out
                                                         value="${fn:escapeXml(track.album.name)}"/>', '${track.id}', false)">
                                                <img src="${pageContext.request.contextPath}/static/images/streaming/like.png"
                                                     alt="Like Button" width="30"
                                                     height="30" style="border-radius: 8px; opacity: 0.75;">
                                            </div>
                                            <div class="recommendationCover" onclick="navigateToDetail('${track.id}')">
                                                <img src="${track.album.images[0].url}" alt="${track.name}" width="120"
                                                     height="120" style="border-radius: 8px;">
                                            </div>
                                            <div class="recommendationPlay" onclick="playTrack('${track.id}')">
                                                <img src="${pageContext.request.contextPath}/static/images/streaming/play.png"
                                                     alt="Like Button" width="30"
                                                     height="30" style="border-radius: 8px; opacity: 0.75;">
                                            </div>
                                            <div class="recommendationInfo">
                                                <p class="trackName"
                                                   onclick="navigateToDetail('${track.id}')">${track.name}</p>
                                                <p class="artistName"
                                                   onclick="navigateToArtistDetail('${track.artists[0].id}')">${track.artists[0].name}</p>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <button class="slideButton right" id="scrollRightBtn" onclick="scrollRightContent()">
                                    <img src="${pageContext.request.contextPath}/static/images/streaming/next.png"
                                         alt="Like Button" width="30"
                                         height="30" style="border-radius: 8px; opacity: 0.75;">
                                </button>
                            </div>
                        </div>
                        <div class="recentlyPlayed">
                            <h3 class="recentlyPlayedTitle">최근 재생한 항목</h3>
                            <div class="recentlyPlayedWrap">
                                <button class="slideButton left" id="scrollRecentlyPlayedLeftBtn"
                                        onclick="scrollRecentlyPlayedLeftContent()">
                                    <img src="${pageContext.request.contextPath}/static/images/streaming/prev.png"
                                         alt="Like Button" width="30"
                                         height="30" style="border-radius: 8px; opacity: 0.75;">
                                </button>
                                <div class="recentlyPlayedTracks">
                                    <c:forEach var="playHistory" items="${recentlyPlayedTracks}">
                                        <div class="recentlyPlayedTrack" data-track-id="${playHistory.track.id}">
                                            <div class="recentlyPlayedTrackLike"
                                                 onclick="insertTrackLike('<c:out value="${playHistory.track.album.images[0].url}"/>',
                                                 						  '<c:out value="${fn:escapeXml(playHistory.track.name)}"/>',
                                                 						  '<c:out value="${fn:escapeXml(playHistory.track.artists[0].name)}"/>',
                                                 						  '<c:out value="${fn:escapeXml(playHistory.track.album.name)}"/>',
                                                 						  '${playHistory.track.id}',
                                                 						  false)">
                                                <img src="${pageContext.request.contextPath}/static/images/streaming/like.png"
                                                     alt="Like Button" width="30"
                                                     height="30" style="border-radius: 8px; opacity: 0.75;">
                                            </div>
                                            <div class="trackCover"
                                                 onclick="navigateToDetail('${playHistory.track.id}')">
                                                <img src="${playHistory.track.album.images[0].url}"
                                                     alt="${playHistory.track.name}" width="120" height="120"
                                                     style="border-radius: 8px;">
                                            </div>
                                            <div class="recentlyPlayedTrackPlay"
                                                 onclick="playTrack('${playHistory.track.id}')">
                                                <img src="${pageContext.request.contextPath}/static/images/streaming/play.png"
                                                     alt="Like Button" width="30"
                                                     height="30" style="border-radius: 8px; opacity: 0.75;">
                                            </div>
                                            <div class="trackInfo">
                                                <p class="trackName"
                                                   onclick="navigateToDetail('${playHistory.track.id}')">${playHistory.track.name}</p>
                                                <p class="artistName"
                                                   onclick="navigateToArtistDetail('${playHistory.track.artists[0].id}')">${playHistory.track.artists[0].name}</p>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <button class="slideButton right" id="scrollRecentlyPlayedRightBtn"
                                        onclick="scrollRecentlyPlayedRightContent()">
                                    <img src="${pageContext.request.contextPath}/static/images/streaming/next.png"
                                         alt="Like Button" width="30"
                                         height="30" style="border-radius: 8px; opacity: 0.75;">
                                </button>
                            </div>
                        </div>
                        <div class="featuredPlaylists">
                            <h3 class="featuredPlaylistsTitle">추천 플레이리스트</h3>
                            <div class="featuredPlaylistsWrap">
                                <button class="slideButton left" id="scrollFeaturedLeftBtn"
                                        onclick="scrollFeaturedLeftContent()">
                                    <img src="${pageContext.request.contextPath}/static/images/streaming/prev.png"
                                         alt="Previous Button" width="30" height="30"
                                         style="border-radius: 8px; opacity: 0.75;">
                                </button>
                                <div class="featuredPlaylistsContent">
                                    <c:forEach var="playlist" items="${featuredPlaylists}">
                                        <div class="featuredPlaylist" data-playlist-id="${playlist.id}">
                                            <div class="featuredPlaylistCover"
                                                 onclick="playPlaylist('${playlist.id}')">
                                                <img src="${playlist.images[0].url}" alt="${playlist.name}" width="120"
                                                     height="120" style="border-radius: 8px;">
                                            </div>
                                            <div class="featuredPlaylistInfo">
                                                <p class="playlistName"
                                                   onclick="playPlaylist('${playlist.id}')">${playlist.name}</p>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <button class="slideButton right" id="scrollFeaturedRightBtn"
                                        onclick="scrollFeaturedRightContent()">
                                    <img src="${pageContext.request.contextPath}/static/images/streaming/next.png"
                                         alt="Next Button" width="30" height="30"
                                         style="border-radius: 8px; opacity: 0.75;">
                                </button>
                            </div>
                        </div>
                        <div class="recommendedArtists">
                            <h3 class="recommendedArtistsTitle">추천 아티스트</h3>
                            <div class="recommendedArtistsWrap">
                                <button class="slideButton left" id="scrollRecommendedArtistsLeftBtn"
                                        onclick="scrollRecommendedArtistsLeftContent()">
                                    <img src="${pageContext.request.contextPath}/static/images/streaming/prev.png"
                                         alt="Previous Button" width="30" height="30"
                                         style="border-radius: 8px; opacity: 0.75;">
                                </button>
                                <div class="recommendedArtistsContainer">
                                    <c:forEach var="artist" items="${recommendedArtists}">
                                        <div class="artistItem" onclick="navigateToArtistDetail('${artist.id}')">
                                            <div class="artistItemCover">
                                                <c:if test="${not empty artist.images}">
                                                    <img src="${artist.images[0].url}" alt="${artist.name}" width="120"
                                                         height="120" style="border-radius: 50%;">
                                                </c:if>
                                            </div>
                                            <p class="artistItemName">${artist.name}</p>
                                        </div>
                                    </c:forEach>
                                </div>
                                <button class="slideButton right" id="scrollRecommendedArtistsRightBtn"
                                        onclick="scrollRecommendedArtistsRightContent()">
                                    <img src="${pageContext.request.contextPath}/static/images/streaming/next.png"
                                         alt="Next Button" width="30" height="30"
                                         style="border-radius: 8px; opacity: 0.75;">
                                </button>
                            </div>
                        </div>
                    </c:when>
                    <c:when test="${page == 'detail'}">
                        <div class="trackDetail">
                            <div class="trackDetailContainer">
                                <c:if test="${not empty trackDetail.album.images}">
                                    <img src="${trackDetail.album.images[0].url}" alt="${trackDetail.name}" width="230"
                                         height="230" style="border-radius: 8px;"
                                         onclick="copyTrackId('<c:out
                                             value="${trackDetail.album.images[0].url}"/>', '<c:out
                                             value="${fn:escapeXml(trackDetail.name)}"/>', '<c:out
                                             value="${fn:escapeXml(trackDetail.artists[0].name)}"/>', '<c:out
                                             value="${fn:escapeXml(trackDetail.album.name)}"/>', '${trackDetail.id}')">
                                </c:if>
                                <div class="trackDetailInfo">
                                    <p class="detailSort">곡</p>
                                    <p id="trackName" class="trackName" style="cursor: default;">${trackDetail.name}</p>
                                    <div class="trackDescription">
                                        <c:if test="${not empty artistDetail.images}">
                                            <img src="${artistDetail.images[0].url}" alt="${artistDetail.name}"
                                                 width="24" height="24" style="border-radius: 50%;">
                                        </c:if>
                                        <p class="artistName" style="margin-left: 2px;"
                                           onclick="navigateToArtistDetail('${trackDetail.artists[0].id}')">${trackDetail.artists[0].name}</p>
                                        <p> • </p>
                                        <p class="albumName"
                                           onclick="navigateToAlbumDetail('${trackDetail.album.id}')">${trackDetail.album.name}</p>
                                        <p> • </p>
                                        <p>${albumDetail.releaseDate}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="trackDetailButtons">
                            <button class="playAllButton" onclick="playTrack('${trackDetail.id}')">
                                <svg style="width: 20px;" data-v-057e38be="" data-encore-id="icon" role="img"
                                     aria-hidden="true" viewBox="0 0 24 24" class="playlistBtn">
                                    <path data-v-057e38be=""
                                          d="m7.05 3.606 13.49 7.788a.7.7 0 0 1 0 1.212L7.05 20.394A.7.7 0 0 1 6 19.788V4.212a.7.7 0 0 1 1.05-.606z"></path>
                                </svg>
                            </button>
                            <div class="trackDetailLike" data-track-id="${trackDetail.id}"
                                 onclick="insertTrackLike('<c:out
                                         value="${trackDetail.album.images[0].url}"/>', '<c:out
                                         value="${fn:escapeXml(trackDetail.name)}"/>', '<c:out
                                         value="${fn:escapeXml(trackDetail.artists[0].name)}"/>', '<c:out
                                         value="${fn:escapeXml(trackDetail.album.name)}"/>', '${trackDetail.id}', false)">
                                <svg class="icon" style="width: 20px; filter: invert(1);" viewBox="0 0 24 24">
                                    <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"></path>
                                </svg>
                            </div>
                        </div>
                        <div class="lyrics">
                            <h3>가사</h3>
                            <pre style="padding-top: 10px">${lyrics}</pre>
                        </div>
                    </c:when>
                    <c:when test="${page == 'search'}">
                        <div class="searchFirstContainer">
                            <div style="padding-left: 10px;">
                                <!-- 연관 아티스트가 있을 때만 표시 -->
                                <c:if test="${not empty searchedArtist}">
                                    <h3 class="resultContainerTitle">연관 아티스트</h3>
                                    <div class="relatedArtists">
                                        <div class="artistResult" onclick="navigateToArtistDetail('${searchedArtist.id}');">
                                            <div class="artistResultCover">
                                                <img src="${searchedArtist.images[0].url}" alt="${searchedArtist.name}" width="100"
                                                     height="100" style="border-radius: 50%;">
                                            </div>
                                            <p class="searchArtistName">${searchedArtist.name}</p>
                                            <p class="artistName">아티스트</p>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                            <div class="resultContainer">
                                <h3 class="resultContainerTitle">곡</h3>
                                <div class="searchResults">
                                    <c:forEach var="track" items="${searchResults}">
                                        <div class="searchResult">
                                            <div class="searchCover" onclick="playAndNavigate('${track.id}');">
                                                <img src="${track.album.images[0].url}" alt="${track.name}" width="45"
                                                     height="45" style="border-radius: 2px;">
                                            </div>
                                            <div class="searchInfo">
                                                <p class="trackName"
                                                    style="font-size: 1rem">${track.name}</p>
                                                <p class="artistName"
                                                   onclick="navigateToArtistDetail('${track.artists[0].id}')">${track.artists[0].name}</p>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                        <div class="searchAlbumsContainer">
                            <h3 class="searchAlbumsContainerTitle">앨범</h3>
                            <button class="searchAlbumsSlideButton left" id="searchAlbumsScrollLeftBtn"
                                    onclick="scrollLeftSearchAlbumsContent()">
                                <img src="${pageContext.request.contextPath}/static/images/streaming/prev.png"
                                     alt="Like Button" width="30"
                                     height="30" style="border-radius: 8px; opacity: 0.75;">
                            </button>
                            <div class="searchAlbums">
                                <div class="searchAlbumsWrap">
                                    <c:forEach var="album" items="${albums}">
                                        <div class="searchAlbumsItem"
                                             onclick="navigateToAlbumDetail('${album.id}')"
                                             style="cursor: pointer;">
                                            <c:if test="${not empty album.images}">
                                                <img src="${album.images[0].url}" alt="${album.name}"
                                                     width="150"
                                                     height="150" style="border-radius: 4px;">
                                            </c:if>
                                            <p class="trackName"
                                               style="margin-left: 2px; font-size: 14px;">${album.name}</p>
                                            <p class="trackName"
                                               style="margin-left: 2px; font-size: 13px;">${album.releaseDate}</p>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                            <button class="searchAlbumsSlideButton right" id="searchAlbumsScrollRightBtn"
                                    onclick="scrollRightSearchAlbumsContent()">
                                <img src="${pageContext.request.contextPath}/static/images/streaming/next.png"
                                     alt="Like Button" width="30"
                                     height="30" style="border-radius: 8px; opacity: 0.75;">
                            </button>
                        </div>
                        <div class="searchPlayListContainer">
                            <h3 class="searchPlayListContainerTitle">관련된 플레이리스트</h3>
                            <button class="searchPlayListSlideButton left" id="searchPlayListScrollLeftBtn"
                                    onclick="scrollLeftSearchPlayListContent()">
                                <img src="${pageContext.request.contextPath}/static/images/streaming/prev.png"
                                     alt="Like Button" width="30"
                                     height="30" style="border-radius: 8px; opacity: 0.75;">
                            </button>
                            <div class="searchRelatedPlaylists">
                                <c:forEach var="playlist" items="${relatedPlaylists}">
                                    <div class="searchPlaylistItem" style="cursor: pointer;">
                                        <c:if test="${not empty playlist.images}">
                                            <img src="${playlist.images[0].url}" alt="${playlist.name}"
                                                 width="150" height="150" style="border-radius: 4px;"
                                                 onclick="playPlaylist('${playlist.id}')">
                                        </c:if>
                                        <p class="trackName"
                                           onclick="playPlaylist('${playlist.id}')"
                                           style="margin-left: 2px; font-size: 14px;">${playlist.name}</p>
                                    </div>
                                </c:forEach>
                            </div>
                            <button class="searchPlayListSlideButton right" id="searchPlayListScrollRightBtn"
                                    onclick="scrollRightSearchPlayListContent()">
                                <img src="${pageContext.request.contextPath}/static/images/streaming/next.png"
                                     alt="Like Button" width="30"
                                     height="30" style="border-radius: 8px; opacity: 0.75;">
                            </button>
                        </div>
                    </c:when>
                    <c:when test="${page == 'artistDetail'}">
                        <div class="artistDetail">
                            <div class="artistDetailContainer">
                                <div class="artistDetailInfo">
                                    <div class="artistDetailWrap">
                                        <div class="artistDetailImage">
                                            <c:if test="${not empty artistDetail.images}">
                                                <img src="${artistDetail.images[0].url}" alt="${artistDetail.name}"
                                                     width="230"
                                                     height="230" style="border-radius: 8px;">
                                            </c:if>
                                        </div>
                                        <div class="artistDetailGenre">
                                            <p class="detailSort">아티스트</p>
                                            <p id="artistName" class="trackName"
                                               style="cursor: default;">${artistDetail.name}</p>
                                                <%--<p>팔로워 수: ${artistDetail.followers.total}</p>--%>
                                            <p class="artistDesc">장르:
                                                <c:forEach var="genre" items="${artistDetail.genres}"
                                                           varStatus="status">
                                                    ${genre}<c:if test="${!status.last}">, </c:if>
                                                </c:forEach>
                                            </p>
                                                <%--<p>인기도: ${artistDetail.popularity}</p>--%>
                                        </div>
                                    </div>
                                    <div class="topTracks">
                                        <h3 style="margin: 0 0 15px 10px;">인기</h3>
                                        <div class="topTracks-tracks"
                                             style="height: 25px; margin-top: 5px; pointer-events: none;">
                                            <div class="topTracks-tracks-top" style="justify-content: center;">#</div>
                                            <div class="topTracks-tracks-top" style="padding-left: 5px;">제목</div>
                                            <div class="topTracks-tracks-top" style="padding-left: 5px;">앨범</div>
                                            <div class="topTracks-tracks-top" style="justify-content: center;">시간</div>
                                        </div>
                                        <c:forEach var="track" items="${topTracks}" varStatus="status">
                                            <div class="topTrackItem">
                                                <span class="rank">${status.index + 1}</span>
                                                <button class="playPauseButton"
                                                        onclick="togglePlayPause('${track.id}', this)">
                                                    <svg class="icon" style="width: 20px; filter: invert(1);"
                                                         viewBox="0 0 24 24">
                                                        <path d="m7.05 3.606 13.49 7.788a.7.7 0 0 1 0 1.212L7.05 20.394A.7.7 0 0 1 6 19.788V4.212a.7.7 0 0 1 1.05-.606z"></path>
                                                    </svg>
                                                </button>
                                                <div class="topTrackInfo" onclick="playAndNavigate('${track.id}');">
                                                    <c:if test="${not empty track.album.images}">
                                                        <img src="${track.album.images[0].url}" alt="${track.name}"
                                                             width="50" height="50"
                                                             style="border-radius: 4px; padding-left: 5px; cursor: pointer;"
                                                             onclick="playAndNavigate('${track.id}')">
                                                    </c:if>
                                                    <p class="topTrackName" style="cursor: pointer;">${track.name}</p>
                                                </div>
                                                <p class="albumName"
                                                   onclick="navigateToAlbumDetail('${track.album.id}')"
                                                   style="padding-left: 5px; cursor: pointer;">${track.album.name}</p>
                                                <!-- 트랙의 길이 표시 (분/초 변환) -->
                                                <c:set var="minutes" value="${track.durationMs / 60000}"/>
                                                <c:set var="seconds" value="${(track.durationMs % 60000) / 1000}"/>
                                                <!-- 소수점 제거 후 출력 -->
                                                <p class="trackTime" style="justify-content: center;">${minutes.intValue()}분 ${seconds.intValue()}초</p>
		                                        <div class="trackLike"
		                                             onclick="insertTrackLike('<c:out
		                                                     value="${track.album.images[0].url}"/>', '<c:out
		                                                     value="${fn:escapeXml(track.name)}"/>', '<c:out
		                                                     value="${fn:escapeXml(artistDetail.name)}"/>', '<c:out
		                                                     value="${fn:escapeXml(track.album.name)}"/>', '${track.id}', false);
		                                                     toggleIcon(this)">
		                                            <c:choose>
		                                                <c:when test="${trackLike[status.index]}">
		                                                    <svg class="icon likeIcon" style="width: 20px; fill: rgb(203, 130, 163); cursor: pointer;" viewBox="0 0 24 24">
		                                                        <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"></path>
		                                                    </svg>
		                                                </c:when>
		                                                <c:otherwise>
		                                                    <svg class="icon likeIcon" style="width: 20px; fill: #000000; cursor: pointer;" viewBox="0 0 24 24">
		                                                        <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"></path>
		                                                    </svg>
		                                                </c:otherwise>
		                                            </c:choose>
		                                        </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <div class="albumsContainer">
                                        <h3 class="albumsContainerTitle">앨범</h3>
                                        <button class="artistDetailSlideButton left" id="artistDetailScrollLeftBtn"
                                                onclick="scrollLeftArtistDetailContent()">
                                            <img src="${pageContext.request.contextPath}/static/images/streaming/prev.png"
                                                 alt="Like Button" width="30"
                                                 height="30" style="border-radius: 8px; opacity: 0.75;">
                                        </button>
                                        <div class="albums">
                                            <div class="albumsWrap">
                                                <c:forEach var="album" items="${albums}">
                                                    <div class="albumItem"
                                                         onclick="navigateToAlbumDetail('${album.id}')"
                                                         style="cursor: pointer;">
                                                        <c:if test="${not empty album.images}">
                                                            <img src="${album.images[0].url}" alt="${album.name}"
                                                                 width="150"
                                                                 height="150" style="border-radius: 4px;">
                                                        </c:if>
                                                        <p class="trackName"
                                                           style="margin-left: 2px; font-size: 14px;">${album.name}</p>
                                                        <p class="trackName"
                                                           style="margin-left: 2px; font-size: 13px;">${album.releaseDate}</p>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                        <button class="artistDetailSlideButton right" id="artistDetailScrollRightBtn"
                                                onclick="scrollRightArtistDetailContent()">
                                            <img src="${pageContext.request.contextPath}/static/images/streaming/next.png"
                                                 alt="Like Button" width="30"
                                                 height="30" style="border-radius: 8px; opacity: 0.75;">
                                        </button>
                                    </div>
                                        <%--                                    <div class="relatedArtists">--%>
                                        <%--                                        <h3>연관된 아티스트</h3>--%>
                                        <%--                                        <c:forEach var="relatedArtist" items="${relatedArtists}">--%>
                                        <%--                                            <p>${relatedArtist.name}</p>--%>
                                        <%--                                        </c:forEach>--%>
                                        <%--                                    </div>--%>
                                    <div class="playListContainer">
                                        <h3 class="playListContainerTitle">관련된 플레이리스트</h3>
                                        <button class="playListSlideButton left" id="playListScrollLeftBtn"
                                                onclick="scrollLeftPlayListContent()">
                                            <img src="${pageContext.request.contextPath}/static/images/streaming/prev.png"
                                                 alt="Like Button" width="30"
                                                 height="30" style="border-radius: 8px; opacity: 0.75;">
                                        </button>
                                        <div class="relatedPlaylists">
                                            <c:forEach var="playlist" items="${relatedPlaylists}">
                                                <div class="playlistItem" style="cursor: pointer;">
                                                    <c:if test="${not empty playlist.images}">
                                                        <img src="${playlist.images[0].url}" alt="${playlist.name}"
                                                             width="150" height="150" style="border-radius: 4px;"
                                                             onclick="playPlaylist('${playlist.id}')">
                                                    </c:if>
                                                    <p class="trackName"
                                                       onclick="playPlaylist('${playlist.id}')"
                                                       style="margin-left: 2px; font-size: 14px;">${playlist.name}</p>
                                                </div>
                                            </c:forEach>
                                        </div>
                                        <button class="playListSlideButton right" id="playListScrollRightBtn"
                                                onclick="scrollRightPlayListContent()">
                                            <img src="${pageContext.request.contextPath}/static/images/streaming/next.png"
                                                 alt="Like Button" width="30"
                                                 height="30" style="border-radius: 8px; opacity: 0.75;">
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:when test="${page == 'playlistDetail'}">
                        <div class="playlistDetail">
                            <div class="playListInfo">
                                <c:if test="${not empty playlistDetail.images}">
                                    <img src="${playlistDetail.images[0].url}" alt="${playlistDetail.name}" width="170"
                                         height="170" style="border-radius: 8px;">
                                </c:if>
                                <div>
                                    <p class="detailSort">플레이리스트</p>
                                    <h1 id="playlistName">${playlistDetail.name}</h1>
                                    <p class="playlistDesc">설명: ${playlistDetail.description}</p>
                                    <p class="playlistOpt">WHALE • ${playlistDetail.tracks.total}곡</p>
                                </div>
                            </div>
                            <!-- 전체 재생 버튼 추가 -->
                            <div class="playlistFunction">
	                            <button class="playAllButton" onclick="playAllPlaylist('${playlistDetail.id}')">
	                                <svg style="width: 20px;" data-v-057e38be="" data-encore-id="icon" role="img"
	                                     aria-hidden="true" viewBox="0 0 24 24" class="playlistBtn">
	                                    <path data-v-057e38be=""
	                                          d="m7.05 3.606 13.49 7.788a.7.7 0 0 1 0 1.212L7.05 20.394A.7.7 0 0 1 6 19.788V4.212a.7.7 0 0 1 1.05-.606z"></path>
	                                </svg>
	                            </button>
	                            <c:if test="${isSpotified == true}">
		                            <div class="playlistAddContainer">
		                            	<c:choose>
		                            		<c:when test="${isAdded == false}">
	                                            <svg
									                data-encore-id="icon"
									                role="img"
									                aria-hidden="true"
									                viewBox="0 0 24 24"
									                class="playlistAddBtn"
									                onclick="followPlaylist(0,`${playlistDetail.id}`)"
									            >
									                <path d="M11.999 3a9 9 0 1 0 0 18 9 9 0 0 0 0-18zm-11 9c0-6.075 4.925-11 11-11s11 4.925 11 11-4.925 11-11 11-11-4.925-11-11z"
									                ></path>
									                <path d="M17.999 12a1 1 0 0 1-1 1h-4v4a1 1 0 1 1-2 0v-4h-4a1 1 0 1 1 0-2h4V7a1 1 0 1 1 2 0v4h4a1 1 0 0 1 1 1z"
									                ></path>
									            </svg>
	                                        </c:when>
	                                        <c:otherwise>
	                                            <img src="${pageContext.request.contextPath}/static/images/streaming/player/cross.png" alt="cross" width="30" height="30" class="crossBtn" style="cursor: pointer;"
	                                            	 onclick="followPlaylist(1,`${playlistDetail.id}`)">
	                                        </c:otherwise>
	                                    </c:choose>
							        </div>
						        </c:if>
                            </div>
                            <div class="playlist-tracks" style="height: 25px; margin-top: 5px; pointer-events: none;">
                                <div class="playlist-tracks-top" style="justify-content: center;">#</div>
                                <div class="playlist-tracks-top" style="padding-left: 10px;">제목</div>
                                <div class="playlist-tracks-top" style="padding-left: 5px;">앨범</div>
                                <div class="playlist-tracks-top" style="justify-content: center;">시간</div>
                            </div>
                            <div class="playlistTracks">
                                <c:forEach var="trackItem" items="${playlistDetail.tracks.items}" varStatus="status">
                                    <div class="trackItem"
                                         style="${status.last ? 'padding-bottom: 20px;' : ''}">
                                        <span class="rank">${status.index + 1}</span>
                                        <button class="playPauseButton"
                                                onclick="togglePlayPause('${trackItem.track.id}', this)">
                                            <svg class="icon" style="width: 20px;"
                                                 viewBox="0 0 24 24">
                                                <path d="m7.05 3.606 13.49 7.788a.7.7 0 0 1 0 1.212L7.05 20.394A.7.7 0 0 1 6 19.788V4.212a.7.7 0 0 1 1.05-.606z"></path>
                                            </svg>
                                        </button>
                                        <div class="trackImageAndTitle"
                                             onclick="playAndNavigate('${trackItem.track.id}');">
                                            <c:if test="${not empty trackItem.track.album.images}">
                                                <img src="${trackItem.track.album.images[0].url}"
                                                     alt="${trackItem.track.name}" width="50" height="50"
                                                     style="border-radius: 4px; padding-left: 5px; cursor: pointer;">
                                            </c:if>
                                            <p class="trackHover">${trackItem.track.name} - ${trackItem.track.artists[0].name}</p>
                                        </div>
                                        <p class="albumName"
                                           onclick="navigateToAlbumDetail('${trackItem.track.album.id}')"
                                           style="padding-left: 5px; cursor: pointer;">${trackItem.track.album.name}</p>
                                        <!-- 트랙 재생 시간 표시 -->
                                        <c:set var="minutes" value="${trackItem.track.durationMs / 60000}"/>
                                        <c:set var="seconds" value="${(trackItem.track.durationMs % 60000) / 1000}"/>
                                        <!-- 소수점 제거 후 출력 -->
                                        <p class="trackTime" style="justify-content: center;">${minutes.intValue()}분 ${seconds.intValue()}초</p>
                                        <div class="trackLike"
                                             onclick="insertTrackLike('<c:out
                                                     value="${trackItem.track.album.images[0].url}"/>', '<c:out
                                                     value="${fn:escapeXml(trackItem.track.name)}"/>', '<c:out
                                                     value="${fn:escapeXml(trackItem.track.artists[0].name)}"/>', '<c:out
                                                     value="${fn:escapeXml(trackItem.track.album.name)}"/>', '${trackItem.track.id}', false);
                                                     toggleIcon(this)">
                                            <c:choose>
                                                <c:when test="${trackLike[status.index]}">
                                                    <svg class="icon likeIcon" style="width: 20px; fill: rgb(203, 130, 163); cursor: pointer;" viewBox="0 0 24 24">
                                                        <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"></path>
                                                    </svg>
                                                </c:when>
                                                <c:otherwise>
                                                    <svg class="icon likeIcon" style="width: 20px; fill: #000000; cursor: pointer;" viewBox="0 0 24 24">
                                                        <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"></path>
                                                    </svg>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:when>
                    <c:when test="${page == 'albumDetail'}">
                        <div class="albumDetail">
                            <!-- 앨범 이미지와 제목, 발매일 -->
                            <div class="albumInfo">
                                <c:if test="${not empty albumDetail.images}">
                                    <img src="${albumDetail.images[0].url}" alt="${albumDetail.name}" width="230"
                                         height="230"
                                         style="border-radius: 8px;">
                                </c:if>
                                <div class="trackDetailInfo" style="cursor: default;">
                                    <p class="detailSort">${albumDetail.albumType}</p>
                                    <p id="trackName" class="trackName" style="cursor: default;">${albumDetail.name}</p>
                                    <div class="trackDescription">
                                        <c:if test="${not empty artistDetail.images}">
                                            <img src="${artistDetail.images[0].url}" alt="${artistDetail.name}"
                                                 width="24" height="24" style="border-radius: 50%;">
                                        </c:if>
                                        <p class="artistName" style="margin-left: 2px;"
                                           onclick="navigateToArtistDetail('${albumDetail.artists[0].id}')">${albumDetail.artists[0].name}</p>
                                        <p> • </p>
                                        <!-- 앨범 전체 시간 구하기 -->
                                        <c:set var="albumTotal" value="0"/>
                                        <c:forEach var="trackItem" items="${tracks}" varStatus="status">
                                            <c:set var="albumTotal" value="${albumTotal+trackItem.durationMs}"/>
                                        </c:forEach>
                                        <p>${fn:length(tracks)}곡</p>
                                        <p> • </p>
                                        <!-- 소수점 제거 후 출력 -->
                                        <p>${(albumTotal / 60000).intValue()}분 ${((albumTotal % 60000) / 1000).intValue()}초</p>
                                        <p> • </p>
                                        <p>${albumDetail.releaseDate}</p>
                                    </div>
                                </div>
                            </div>
                            <div class="playlistFunction">
	                            <!-- 전체 재생 버튼 추가 -->
	                            <button class="playAllButton" onclick="playAllAlbum('<c:out value="${albumDetail.id}"/>')">
	                                <svg style="width: 20px;" data-v-057e38be="" data-encore-id="icon" role="img"
	                                     aria-hidden="true" viewBox="0 0 24 24" class="playlistBtn">
	                                    <path data-v-057e38be=""
	                                          d="m7.05 3.606 13.49 7.788a.7.7 0 0 1 0 1.212L7.05 20.394A.7.7 0 0 1 6 19.788V4.212a.7.7 0 0 1 1.05-.606z"></path>
	                                </svg>
	                            </button>
                            </div>
                            <div class="playlist-tracks"
                                 style="height: 25px; grid-template-columns: 6% 83% 11%; margin-top: 5px; pointer-events: none;">
                                <div class="playlist-tracks-top" style="justify-content: center;">#</div>
                                <div class="playlist-tracks-top" style="padding-left: 5px;">제목</div>
                                <div class="playlist-tracks-top" style="justify-content: center;">시간</div>
                            </div>
                            <div class="albumTracks">
                                <c:forEach var="trackItem" items="${tracks}" varStatus="status">
                                    <div class="trackItem" onclick="playAndNavigate('${trackItem.id}');"
                                         style="${status.last ? 'padding-bottom: 20px;' : ''}">
                                        <span class="rank">${status.index + 1}</span>
                                        <button class="playPauseButton"
                                                onclick="togglePlayPause('${trackItem.id}', this)">
                                            <svg class="icon" style="width: 20px; filter: invert(1);"
                                                 viewBox="0 0 24 24">
                                                <path d="m7.05 3.606 13.49 7.788a.7.7 0 0 1 0 1.212L7.05 20.394A.7.7 0 0 1 6 19.788V4.212a.7.7 0 0 1 1.05-.606z"></path>
                                            </svg>
                                        </button>
                                        <div style="display: block; cursor: pointer;">
                                            <p class="albumTracksName"
                                               onclick="navigateToDetail('${trackItem.id}')"
                                               style="font-weight: 400;">${trackItem.name}</p>
                                            <p class="albumTracksArtist"
                                               onclick="navigateToArtistDetail('${albumDetail.artists[0].id}')">${trackItem.artists[0].name}</p>
                                        </div>
                                        <!-- 트랙 재생 시간 표시 -->
                                        <c:set var="minutes" value="${trackItem.durationMs / 60000}"/>
                                        <c:set var="seconds" value="${(trackItem.durationMs % 60000) / 1000}"/>
                                        <!-- 소수점 제거 후 출력 -->
                                        <p class="trackTime" style="justify-content: center;">${minutes.intValue()}분 ${seconds.intValue()}초</p>
                                        <div class="trackLike"
                                             onclick="insertTrackLike('<c:out
                                                     value="${albumDetail.images[0].url}"/>', '<c:out
                                                     value="${fn:escapeXml(trackItem.name)}"/>', '<c:out
                                                     value="${fn:escapeXml(trackItem.artists[0].name)}"/>', '<c:out
                                                     value="${fn:escapeXml(albumDetail.name)}"/>', '${trackItem.id}', false);
                                                     toggleIcon(this)">
                                            <c:choose>
                                                <c:when test="${trackLike[status.index]}">
                                                    <svg class="icon likeIcon" style="width: 20px; fill: rgb(203, 130, 163); cursor: pointer;" viewBox="0 0 24 24">
                                                        <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"></path>
                                                    </svg>
                                                </c:when>
                                                <c:otherwise>
                                                    <svg class="icon likeIcon" style="width: 20px; fill: #000000; cursor: pointer;" viewBox="0 0 24 24">
                                                        <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"></path>
                                                    </svg>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:when>
                    <c:when test="${page == 'likedTracks'}">
                        <div class="playlistDetail">
                        	<div class="playListInfo">
                                <img src="https://misc.scdn.co/liked-songs/liked-songs-300.png" width="170"
                                     height="170" style="border-radius: 8px;">
                                <div>
                                    <p class="detailSort" style="padding-bottom: 5px;">플레이리스트</p>
                                    <h1 id="playlistName">좋아요 표시한 곡</h1>
                                    <p class="playlistOpt" style="margin-left: 5px;">WHALE • ${fn:length(likedTracks)}곡</p>
                                </div>
                            </div>
                            <div class="playlistFunction">
						        <button class="playAllButton"
						        		onclick="playAllLikeTrack('<c:out value="${uris}"/>')">
	                                <svg style="width: 20px;" data-v-057e38be="" data-encore-id="icon" role="img"
	                                     aria-hidden="true" viewBox="0 0 24 24" class="playlistBtn">
	                                    <path data-v-057e38be=""
	                                          d="m7.05 3.606 13.49 7.788a.7.7 0 0 1 0 1.212L7.05 20.394A.7.7 0 0 1 6 19.788V4.212a.7.7 0 0 1 1.05-.606z"></path>
	                                </svg>
	                            </button>
						    </div>
                            <div class="playlist-tracks" style="height: 25px; margin-top: 30px; pointer-events: none;">
                                <div class="playlist-tracks-top" style="justify-content: center;">#</div>
                                <div class="playlist-tracks-top" style="padding-left: 5px;">제목</div>
                                <div class="playlist-tracks-top" style="padding-left: 5px;">앨범</div>
                                <div class="playlist-tracks-top" style="justify-content: center;">추가한 날짜</div>
                            </div>
                            <div class="playlistTracks">
                                <c:forEach var="track" items="${likedTracks}" varStatus="status">
                                    <div class="trackItem" style="${status.last ? 'padding-bottom: 20px;' : ''}">
                                        <span class="rank">${status.index + 1}</span>
                                        <button class="playPauseButton"
                                                onclick="togglePlayPause('${track.track_id}', this)">
                                            <svg class="icon" style="width: 20px; filter: invert(1);"
                                                 viewBox="0 0 24 24">
                                                <path d="m7.05 3.606 13.49 7.788a.7.7 0 0 1 0 1.212L7.05 20.394A.7.7 0 0 1 6 19.788V4.212a.7.7 0 0 1 1.05-.606z"></path>
                                            </svg>
                                        </button>
                                        <div class="trackImageAndTitle">
                                            <c:if test="${not empty track.track_cover}">
                                                <img src="${track.track_cover}" alt="${track.track_name}" width="50"
                                                     height="50"
                                                     style="border-radius: 4px; padding-left: 5px;">
                                            </c:if>
                                            <div>
                                                <p class="trackInfoTitle" style="font-weight: 400; cursor: pointer;" onclick="playAndNavigate('${track.track_id}');">${track.track_name}</p>
                                                <p class="trackInfoArtist" style="cursor: pointer;" onclick="navigateToArtistDetail('${artistIds[track.track_id]}')">${track.track_artist}</p>
                                            </div>
                                        </div>
                                        <p class="albumName"
                                           style="padding-left: 5px; cursor: pointer;"
                                           onclick="navigateToAlbumDetail('${albumIds[track.track_id]}')">${track.track_album}</p>
                                        <!-- 트랙의 길이 표시 (분/초 변환) -->
<%--                                        <c:set var="minutes" value="${track.durationMs / 60000}"/>--%>
<%--                                        <c:set var="seconds" value="${(track.durationMs % 60000) / 1000}"/>--%>
                                        <!-- 소수점 제거 후 출력 -->
<%--                                        <p class="trackDuration" style="justify-content: center;">${minutes.intValue()}분 ${seconds.intValue()}초</p>--%>
                                        <p class="trackDuration">
                                            <fmt:formatDate value="${track.track_like_date}" pattern="yyyy-MM-dd" />
                                        </p>
                                        <!-- 좋아요 제거 버튼 -->
                                        <button class="toggleLikeButton"
                                                onclick="toggleTrackLike('${track.track_artist}', '${track.track_name}', '${track.track_album}', '${track.track_cover}', '${track.track_id}', this)"
                                                style="cursor: pointer;">
                                            <svg class="icon" style="width: 20px; fill: rgb(203, 130, 163); display: none;"
                                                 viewBox="0 0 24 24">
                                                <path d="${track.liked ? 'M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z' : 'M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z'}"></path>
                                            </svg>
                                        </button>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:when>
                </c:choose>
            </div>
        </div>
    </div>
    <div class="mainDetailFrame"></div>
    <MainDetail/>
</div>
<div class="footer"></div>
</body>
<script>
    document.addEventListener("DOMContentLoaded", () => {
        // 리사이즈
        $(document).ready(() => {
            resize();
        });
        $(window).resize(() => {
            resize();
        });

        function resize() {
            var windowHeight = $(window).height();
            var headerHeight = $(".header").height();
            $('.main').css({'height': (windowHeight - headerHeight - 1) + 'px'});
        };
    });
</script>
</html>