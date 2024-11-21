<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 새로 로드된 피드들을 보여주는 JSP 조각 -->
<c:forEach var="feed" items="${feedList}">
    <div class="post" data-post-id="${feed.feed_id}" data-user-id="${feed.user_id}">
        <div class="user-info">
            <a href="profileHome?u=${feed.user_id}">
                <img src="${feed.user_image_url}" alt="User Profile" class="profile-pic">
            </a>
            <span class="username">${feed.user_id}</span>
        </div>

        <button class="other-btn">
            <img src="static/images/btn/other_btn.png" alt="Other Button">
        </button>

        <!-- 이미지가 존재할 때만 출력 -->
        <c:if test="${not empty feed.feed_img_url}">
            <img src="${feed.feed_img_url}" alt="Post Image" class="post-image">
        </c:if>

        <!-- 음악 정보가 존재할 때만 출력 -->
        <c:if test="${not empty feed.track_id}">
            <div class="music-info">
                <img class="album-icon" src="${feed.track_cover}" alt="Album Icon" style="width: 50px; height: 50px;">
                <div class="music-details">
                    <span class="music-title">${feed.track_name}</span> - <span class="music-artist">${feed.track_artist}</span>
                </div>
                <label class="play-button" onclick="playMusic(this, '${feed.track_id}')" style="display: inline-block;">
                    <img src="static/images/btn/play_btn.png" alt="play" style="width: 40px; height: 40px;" />
                </label>
                <!-- Pause 버튼 -->
                <label class="pause-button" onclick="pauseMusic(this, '${feed.track_id}')" style="display: none;">
                    <img src="static/images/btn/pause_btn.png" alt="pause" style="width: 40px; height: 40px;" />
                </label>
            </div>
        </c:if>

        <div class="post-text">
            <p>${feed.feed_text}</p>
            <span class="post-time">${feed.feed_date}</span>
        </div>
        <div class="post-actions">
            <button type="button" class="like-btn" data-feed-id="${feed.feed_id}" data-now-id="${now_id}">
                <img class="likebtn" src="static/images/btn/like_btn.png" alt="like" />
                <span class="like-count">${feed.likeCount}</span>
            </button>
            <button type="button" class="comments" onclick="window.location.href='feedDetail?f=${feed.feed_id}'">
                <img class="commentbtn" src="static/images/btn/comment_btn.png" alt="comments" />
                <span class="comment-count">${feed.commentsCount}</span>
            </button>
        </div>
    </div>
</c:forEach>

