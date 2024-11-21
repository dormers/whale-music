<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;600&display=swap">
    <title>Feed Detail</title>
    <style>
        /* 기존 feedHome 페이지와 동일한 스타일 사용 */
        body {font-family: 'Noto Sans', Arial, sans-serif; margin: 0; padding: 0; background-color: #f0f0f0;}
        body, .music-info, .username, .post-text {font-family: 'Noto Sans KR', Arial, sans-serif !important;}
        ::-webkit-scrollbar {display: none;}
        .feed-container[data-darkmode="1"]{background-color: #434343;}
        .feed-container[data-darkmode="1"] .post {position: relative; background-color: #2e2e2e; width: 90%; max-width: 600px; margin: 40px auto; border-radius: 10px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); padding: 15px;}
        .feed-container[data-darkmode="1"] .user-info {display: flex; align-items: center;}
        .feed-container[data-darkmode="1"] .profile-pic {width: 40px; height: 40px; border-radius: 50%; margin: 5px 10px 0 4px;}
        .feed-container[data-darkmode="1"] .username {font-weight: bold; font-size: 1.2em; color: #e2e2e2;}
        .feed-container[data-darkmode="1"] .post-image {width: 100%; height: auto; margin: 15px 0 0 0; border-radius: 10px;}
        .feed-container[data-darkmode="1"] .post-actions {display: flex; justify-content: space-around; align-items: center; /* 아이템들을 수직 가운데 정렬 */ margin-top: 22px; font-size: 1em;}
        .feed-container[data-darkmode="1"] .post-actions .like-btn,
        .feed-container[data-darkmode="1"] .post-actions .comments {display: flex; /* 수평 배치 */ align-items: center; /* 수직 가운데 정렬 */ background: none; border: none; cursor: pointer;}
        .feed-container[data-darkmode="1"] .post-actions .likebtn,
        .feed-container[data-darkmode="1"] .post-actions .commentbtn {width: 30px; /* 아이콘 크기 조정 */ height: 30px; margin-right: 5px; /* 아이콘과 텍스트 사이 간격 */}
        .feed-container[data-darkmode="1"] .like-count,
        .feed-container[data-darkmode="1"] .comment-count {font-size: 14px; /* 글자 크기 통일 */ color: #e2e2e2; /* 필요 시 색상 지정 */}
        .feed-container[data-darkmode="1"] .post-text {margin: 15px 0 15px 10px; display: flex; align-items: center;}
        .feed-container[data-darkmode="1"] .post-content {flex: 1;}
        .feed-container[data-darkmode="1"] .post-text p {margin: 0; color: #e2e2e2;}
        .feed-container[data-darkmode="1"] .post-time {float: right; font-size: 0.8em; color: gray;}
        .feed-container[data-darkmode="1"] .other-btn {position: absolute; top: 25px; right: 15px; background: none; border: none; cursor: pointer;}
        .feed-container[data-darkmode="1"] .other-btn img {width: 30px; height: 30px;}
        .feed-container[data-darkmode="1"] .modal {display: none; /* 기본적으로 숨김 상태 */ position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.6); justify-content: center; align-items: center;}
        /* 모달 내용 */
        .feed-container[data-darkmode="1"] .modal-content {background-color: #414141; border-radius: 12px; width: 80%; max-width: 300px; text-align: center; overflow: hidden; color: #e2e2e2;}
        /* 모달 항목 스타일 */
        .feed-container[data-darkmode="1"] .modal-item {padding: 20px; border-bottom: 1px solid #626262; font-size: 16px; cursor: pointer;}
        .feed-container[data-darkmode="1"] .modal-item.red {color: red;}
        .feed-container[data-darkmode="1"] .modal-item.gray {color: gray;}
        .feed-container[data-darkmode="1"] .modal-item:last-child {border-bottom: none;}
        .feed-container[data-darkmode="1"] .modal-item:hover {background-color: #f9f9f9;}
        /* 댓글 스타일 */
        .feed-container[data-darkmode="1"] .comment {position: relative; padding: 20px 0; margin: 20px; border-top: 1px solid #828282;}
        .feed-container[data-darkmode="1"] .comment-form {display: flex; justify-content: center; align-items: center; width: 60%; height: 35px; border: 1.6px solid #828282; border-radius: 10px; margin: 25px auto;}
        .feed-container[data-darkmode="1"] .comment-input {width: 80%; height: 56%; background: transparent; border: none; outline: none; font-size: 13px; color: rgb(164, 164, 164); text-align: center; cursor: grab;}
        .feed-container[data-darkmode="1"] .comment-btn {background: transparent; border: 1px solid #828282; border-radius: 4px; font-size: 12px; color: rgb(164, 164, 164); text-align: center; cursor: grab; padding: 5px 10px;}
        .feed-container[data-darkmode="1"] .comment-header {display: flex; align-items: center; margin-bottom: 5px;}
        .feed-container[data-darkmode="1"] .comment .profile-pic {width: 30px; height: 30px; border-radius: 50%;}
        .feed-container[data-darkmode="1"] .comment-meta {display: flex; flex-direction: column; margin-left: 4px;}
        .feed-container[data-darkmode="1"] .comment-meta .username {font-size: 0.9em; font-weight: bold;}
        .feed-container[data-darkmode="1"] .comment-meta .comment-date {font-size: 0.8em; color: gray;}
        .feed-container[data-darkmode="1"] .comment-other-btn {background: none; border: none; cursor: pointer; margin-left: auto;}
        .feed-container[data-darkmode="1"] .comment-other-btn img {width: 20px; height: 20px;}
        .feed-container[data-darkmode="1"] .comment-text {margin: 6px 0; padding-left: 40px; font-size: 14px; color: #e2e2e2;}
        .feed-container[data-darkmode="1"] .comment-actions {display: flex; align-items: center; padding-left: 40px;}
        /* 답글 스타일 */
        .feed-container[data-darkmode="1"] .replies {margin-left: 40px; margin-top: 5px;}
        .feed-container[data-darkmode="1"] .reply {position: relative; padding: 10px 0;}
        .feed-container[data-darkmode="1"] .reply .comment-header {display: flex; align-items: center;}
        .feed-container[data-darkmode="1"] .reply .profile-pic {width: 25px; height: 25px; border-radius: 50%;}
        .feed-container[data-darkmode="1"] .reply .comment-meta {display: flex; flex-direction: column; margin-left: 4px;}
        .feed-container[data-darkmode="1"] .reply .username {font-size: 0.85em; font-weight: bold;}
        .feed-container[data-darkmode="1"] .reply .comment-date {font-size: 0.75em; color: gray;}
        .feed-container[data-darkmode="1"] .reply .comment-other-btn {background: none; border: none; cursor: pointer; margin-left: auto;}
        .feed-container[data-darkmode="1"] .reply .comment-other-btn img {width: 18px; height: 18px;}
        .feed-container[data-darkmode="1"] .reply .comment-text {margin: 6px 0; padding-left: 35px;}
        .feed-container[data-darkmode="1"] .reply .comment-actions {display: flex; align-items: center; padding-left: 35px;}
        .feed-container[data-darkmode="1"] .comment-like-btn {display: flex; align-items: center; background: none; border: none; cursor: pointer; color: #e2e2e2;}
        .feed-container[data-darkmode="1"] .comment-like-btn .likebtn {width: 20px; height: 20px; margin-right: 5px;}
        .feed-container[data-darkmode="1"] .reply-btn {display: flex; align-items: center; background: none; border: none; cursor: pointer; color: #e2e2e2;}
        .feed-container[data-darkmode="1"] .reply-btn .commentbtn {width: 20px; height: 20px; margin-right: 5px;}
        .feed-container[data-darkmode="1"] .music-info {display: flex; align-items: center; justify-content: space-between; /* 양 끝에 요소 배치 */ padding: 10px; background-color: #434343; border-radius: 5px; margin-top: 15px;}
        .feed-container[data-darkmode="1"] .music-info > div {flex-grow: 1; /* 제목과 아티스트 영역이 남은 공간 차지 */ color: #e2e2e2;}
        .feed-container[data-darkmode="1"] .music-info label {margin-left: 10px; /* 버튼 간 간격 조정 */}
        .feed-container[data-darkmode="1"] .music-info .music-title {margin-left: 10px; font-weight: bold; font-size: 1em; color: #e2e2e2;}
        .feed-container[data-darkmode="1"] .music-info .artist-name {font-weight: normal; font-size: 0.9em; color: #e7e7e7; /* 회색 */}
    /*    --------------------------------------------------------------------------------------------------------------------*/
        .feed-container[data-darkmode="0"] .post {position: relative; background-color: white; width: 90%; max-width: 600px; margin: 40px auto; border-radius: 10px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); padding: 15px;}
        .feed-container[data-darkmode="0"] .user-info {display: flex; align-items: center;}
        .feed-container[data-darkmode="0"] .profile-pic {width: 40px; height: 40px; border-radius: 50%; margin: 5px 10px 0 4px;}
        .feed-container[data-darkmode="0"] .username {font-weight: bold; font-size: 1.2em;}
        .feed-container[data-darkmode="0"] .post-image {width: 100%; height: auto; margin: 15px 0 0 0; border-radius: 10px;}
        .feed-container[data-darkmode="0"] .post-actions {display: flex; justify-content: space-around; align-items: center; /* 아이템들을 수직 가운데 정렬 */ margin-top: 22px; font-size: 1em;}
        .feed-container[data-darkmode="0"] .post-actions .like-btn,
        .feed-container[data-darkmode="0"] .post-actions .comments {display: flex; /* 수평 배치 */ align-items: center; /* 수직 가운데 정렬 */ background: none; border: none; cursor: pointer;}
        .feed-container[data-darkmode="0"] .post-actions .likebtn,
        .feed-container[data-darkmode="0"] .post-actions .commentbtn {width: 30px; /* 아이콘 크기 조정 */ height: 30px; margin-right: 5px; /* 아이콘과 텍스트 사이 간격 */}
        .feed-container[data-darkmode="0"] .like-count,
        .feed-container[data-darkmode="0"] .comment-count {font-size: 1em; /* 글자 크기 통일 */ color: #333; /* 필요 시 색상 지정 */}
        .feed-container[data-darkmode="0"] .post-text {margin: 15px 0 15px 10px; display: flex; align-items: center;}
        .feed-container[data-darkmode="0"] .post-content {flex: 1;}
        .feed-container[data-darkmode="0"] .post-text p {margin: 0;}
        .feed-container[data-darkmode="0"] .post-time {float: right; font-size: 0.8em; color: gray;}
        .feed-container[data-darkmode="0"] .other-btn {position: absolute; top: 25px; right: 15px; background: none; border: none; cursor: pointer;}
        .feed-container[data-darkmode="0"] .other-btn img {width: 30px; height: 30px;}
        .feed-container[data-darkmode="0"] .modal {display: none; /* 기본적으로 숨김 상태 */ position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.6); justify-content: center; align-items: center;}
        /* 모달 내용 */
        .feed-container[data-darkmode="0"] .modal-content {background-color: white; border-radius: 12px; width: 80%; max-width: 300px; text-align: center; overflow: hidden;}
        /* 모달 항목 스타일 */
        .feed-container[data-darkmode="0"] .modal-item {padding: 20px; border-bottom: 1px solid #eee; font-size: 16px; cursor: pointer;}
        .feed-container[data-darkmode="0"] .modal-item.red {color: red;}
        .feed-container[data-darkmode="0"] .modal-item.gray {color: gray;}
        .feed-container[data-darkmode="0"] .modal-item:last-child {border-bottom: none;}
        .feed-container[data-darkmode="0"] .modal-item:hover {background-color: #f9f9f9;}
        /* 댓글 스타일 */
        .feed-container[data-darkmode="0"] .comment {position: relative; padding: 20px 0; margin: 20px; border-top: 1px solid #e2e2e2;}
        .feed-container[data-darkmode="0"] .comment-form {display: flex; justify-content: center; align-items: center; width: 60%; height: 35px; border: 1.6px solid #d2d2d2; border-radius: 10px; margin: 25px auto;}
        .feed-container[data-darkmode="0"] .comment-input {width: 80%; height: 56%; background: transparent; border: none; outline: none; font-size: 13px; color: rgb(164, 164, 164); text-align: center; cursor: grab;}
        .feed-container[data-darkmode="0"] .comment-btn {background: transparent; border: 1px solid #d2d2d2; border-radius: 4px; font-size: 12px; color: rgb(164, 164, 164); text-align: center; cursor: grab; padding: 5px 10px;}
        .feed-container[data-darkmode="0"] .comment-header {display: flex; align-items: center; margin-bottom: 5px;}
        .feed-container[data-darkmode="0"] .comment .profile-pic {width: 30px; height: 30px; border-radius: 50%;}
        .feed-container[data-darkmode="0"] .comment-meta {display: flex; flex-direction: column; margin-left: 4px;}
        .feed-container[data-darkmode="0"] .comment-meta .username {font-size: 0.9em; font-weight: bold;}
        .feed-container[data-darkmode="0"] .comment-meta .comment-date {font-size: 0.8em; color: gray;}
        .feed-container[data-darkmode="0"] .comment-other-btn {background: none; border: none; cursor: pointer; margin-left: auto;}
        .feed-container[data-darkmode="0"] .comment-other-btn img {width: 20px; height: 20px;}
        .feed-container[data-darkmode="0"] .comment-text {margin: 6px 0; padding-left: 40px; font-size: 14px;}
        .feed-container[data-darkmode="0"] .comment-actions {display: flex; align-items: center; padding-left: 40px;}
        /* 답글 스타일 */
        .feed-container[data-darkmode="0"] .replies {margin-left: 40px; margin-top: 5px;}
        .feed-container[data-darkmode="0"] .reply {position: relative; padding: 10px 0;}
        .feed-container[data-darkmode="0"] .reply .comment-header {display: flex; align-items: center;}
        .feed-container[data-darkmode="0"] .reply .profile-pic {width: 25px; height: 25px; border-radius: 50%;}
        .feed-container[data-darkmode="0"] .reply .comment-meta {display: flex; flex-direction: column; margin-left: 4px;}
        .feed-container[data-darkmode="0"] .reply .username {font-size: 0.85em; font-weight: bold;}
        .feed-container[data-darkmode="0"] .reply .comment-date {font-size: 0.75em; color: gray;}
        .feed-container[data-darkmode="0"] .reply .comment-other-btn {background: none; border: none; cursor: pointer; margin-left: auto;}
        .feed-container[data-darkmode="0"] .reply .comment-other-btn img {width: 18px; height: 18px;}
        .feed-container[data-darkmode="0"] .reply .comment-text {margin: 6px 0; padding-left: 35px;}
        .feed-container[data-darkmode="0"] .reply .comment-actions {display: flex; align-items: center; padding-left: 35px;}
        .feed-container[data-darkmode="0"] .comment-like-btn {display: flex; align-items: center; background: none; border: none; cursor: pointer;}
        .feed-container[data-darkmode="0"] .comment-like-btn .likebtn {width: 20px; height: 20px; margin-right: 5px;}
        .feed-container[data-darkmode="0"] .reply-btn {display: flex; align-items: center; background: none; border: none; cursor: pointer;}
        .feed-container[data-darkmode="0"] .reply-btn .commentbtn {width: 20px; height: 20px; margin-right: 5px;}
        .feed-container[data-darkmode="0"] .music-info {display: flex; align-items: center; justify-content: space-between; /* 양 끝에 요소 배치 */ padding: 10px; background-color: #f9f9f9; border-radius: 5px; margin-top: 15px;}
        .feed-container[data-darkmode="0"] .music-info > div {flex-grow: 1; /* 제목과 아티스트 영역이 남은 공간 차지 */}
        .feed-container[data-darkmode="0"] .music-info label {margin-left: 10px; /* 버튼 간 간격 조정 */}
        .feed-container[data-darkmode="0"] .music-info .music-title {margin-left: 10px; font-weight: bold; font-size: 1em; color: #333; /* 기본 검정색 */}
        .feed-container[data-darkmode="0"] .music-info .artist-name {font-weight: normal; font-size: 0.9em; color: #777; /* 회색 */}

    </style>
    <style id="darkmode-scrollbar-styles"></style>
    <script src="static/js/setting/darkMode.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const feedElement = document.querySelector('.feed-container');
            const toggleSlide = document.getElementById('toggle-slide');

            // localStorage에서 다크 모드 상태 확인 및 초기화
            let darkmodeOn = localStorage.getItem('darkmodeOn') || "0";
            console.log("Initial darkmodeOn from localStorage:", darkmodeOn);

            feedElement.setAttribute("data-darkmode", darkmodeOn);
            console.log("Initial data-darkmode attribute set to:", darkmodeOn);

            toggleSlide.checked = darkmodeOn === "1";
            console.log("Initial toggleSlide checked status:", toggleSlide.checked);

            // 토글 변경 시 localStorage 업데이트
            toggleSlide.addEventListener('change', function () {
                darkmodeOn = this.checked ? "1" : "0";
                console.log("Toggle changed, new darkmodeOn:", darkmodeOn);

                // localStorage 업데이트
                localStorage.setItem('darkmodeOn', darkmodeOn);
                console.log("Updated localStorage darkmodeOn to:", darkmodeOn);

                // data-darkmode 속성 업데이트
                feedElement.setAttribute("data-darkmode", darkmodeOn);
                console.log("Updated data-darkmode attribute to:", darkmodeOn);
            });

            // 다른 iframe 또는 탭에서 localStorage가 업데이트될 때 적용
            window.addEventListener('storage', function (event) {
                if (event.key === 'darkmodeOn') {
                    darkmodeOn = event.newValue || "0";
                    console.log("storage event detected, new darkmodeOn from localStorage:", darkmodeOn);

                    // data-darkmode 속성 업데이트
                    feedElement.setAttribute("data-darkmode", darkmodeOn);
                    console.log("Updated data-darkmode attribute due to storage event to:", darkmodeOn);

                    // 토글 버튼 상태 업데이트
                    toggleSlide.checked = darkmodeOn === "1";
                    console.log("Updated toggleSlide checked status due to storage event:", toggleSlide.checked);
                }
            });
        });
    </script>
</head>
<body>
<div class="feed-container" data-darkmode="${darkMode.scndAttrName}">
    <div class="post" data-post-id="${feedDetail.feed_id}" data-user-id="${feedDetail.user_id}"
         data-open-id="${feedDetail.feed_open}">
        <div class="user-info">
            <a href="profileHome?u=${feedDetail.user_id}">
                <img src="${feedDetail.user_image_url}" alt="User Profile" class="profile-pic">
            </a>
            <span class="username">${feedDetail.user_id}</span>
        </div>

        <button class="other-btn">
            <img src="static/images/btn/other_btn.png" alt="Other Button">
        </button>

        <!-- 이미지가 존재할 때만 출력 -->
        <c:if test="${not empty feedDetail.feed_img_url}">
            <img src="${feedDetail.feed_img_url}" alt="Post Image" class="post-image">
        </c:if>
        
        <c:if test="${not empty feedDetail.track_id}">
            <div id="music-info" class="music-info">
                <img id="album-icon" src="${feedDetail.track_cover}" alt="Album Icon"
                     style="width: 50px; height: 50px;">
                <div>
                    <span class="music-title" id="music-title">${feedDetail.track_name}</span> -
                    <span class="artist-name" id="artist-name">${feedDetail.track_artist}</span>
                </div>
                <label class="play-button" onclick="playMusic(this, '${feedDetail.track_id}')"
                       style="display: inline-block;">
                    <img src="static/images/btn/play_btn.png" alt="play" style="width: 40px; height: 40px;"/>
                </label>
                <!-- Pause 버튼 -->
                <label class="pause-button" onclick="pauseMusic(this, '${feedDetail.track_id}')" style="display: none;">
                    <img src="static/images/btn/pause_btn.png" alt="pause" style="width: 40px; height: 40px;"/>
                </label>
            </div>
        </c:if>
        <div class="post-text">
            <div class="post-content">
                <p>${feedDetail.feed_text}</p>
                <span class="post-time">${feedDetail.feed_date}</span>
            </div>
        </div>
        <div class="post-actions">
            <button type="button" class="like-btn" data-feed-id="${feedDetail.feed_id}" data-now-id="${now_id}">
                <img class="likebtn" src="static/images/btn/like_btn.png" alt="like"/>
                <span class="like-count">${feedDetail.likeCount}</span>
            </button>
            <div class="comments">
                <img class="commentbtn" src="static/images/btn/comment_btn.png" alt="comments" style="width: 28px; height: 28px;"/>
                <span class="comment-count" style="margin-top: -3px; font-size: 13px;">${feedDetail.commentsCount}</span>
            </div>
        </div>
        <div class="comments-section">
	        <c:forEach var="comment" items="${feedDetail.feedComments}">
	            <div class="comment" data-feed-id="${comment.feed_id}" data-comment-id="${comment.feed_comments_id}"
	                 data-user-id="${comment.user_id}">
	                <!-- 댓글 헤더 -->
	                <div class="comment-header">
	                    <!-- 프로필 사진 -->
	                    <a href="profileHome?u=${comment.user_id}">
	                        <img src="${comment.user_image_url}" alt="User Profile" class="profile-pic">
	                    </a>
	                    <!-- 아이디와 날짜 -->
	                    <div class="comment-meta">
	                        <span class="username">${comment.user_id}</span>
	                        <span class="comment-date">${comment.feed_comments_date}</span>
	                    </div>
	                    <!-- other_btn -->
	                    <button class="comment-other-btn">
	                        <img src="static/images/btn/other_btn.png" alt="Other Button">
	                    </button>
	                </div>
	                <!-- 댓글 내용 -->
	                <p class="comment-text">${comment.feed_comments_text}</p>
	                <!-- 좋아요 및 답글 아이콘 -->
	                <div class="comment-actions">
	                    <button type="button" class="comment-like-btn" data-comment-id="${comment.feed_comments_id}"
	                            data-now-id="${now_id}">
	                        <img class="likebtn" src="static/images/btn/like_btn.png" alt="like"/>
	                        <span class="comment-like-count">${comment.likeCount}</span>
	                    </button>
	                    <button type="button" class="reply-btn" onclick="toggleReplyForm(${comment.feed_comments_id})">
	                        <img class="commentbtn" src="static/images/btn/comment_btn.png" alt="답글"/>
	                        <span class="comment-reply-count">${comment.replyCount}</span>
	                    </button>
	                </div>
	                <!-- 답글 표시 -->
	                <c:if test="${not empty comment.replies}">
	                    <div class="replies">
	                        <c:forEach var="reply" items="${comment.replies}">
	                            <div class="reply" data-feed-id="${reply.feed_id}"
	                                 data-comment-id="${reply.feed_comments_id}" data-user-id="${reply.user_id}">
	                                <!-- 답글 헤더 -->
	                                <div class="comment-header">
	                                    <!-- 프로필 사진 -->
	                                    <a href="profileHome?u=${reply.user_id}">
	                                        <img src="${reply.user_image_url}" alt="User Profile" class="profile-pic">
	                                    </a>
	                                    <!-- 아이디와 날짜 -->
	                                    <div class="comment-meta">
	                                        <span class="username">${reply.user_id}</span>
	                                        <span class="comment-date">${reply.feed_comments_date}</span>
	                                    </div>
	                                    <!-- other_btn -->
	                                    <button class="comment-other-btn">
	                                        <img src="static/images/btn/other_btn.png" alt="Other Button">
	                                    </button>
	                                </div>
	                                <!-- 답글 내용 -->
	                                <p class="comment-text">${reply.feed_comments_text}</p>
	                                <!-- 좋아요 아이콘 -->
	                                <div class="comment-actions">
	                                    <button type="button" class="comment-like-btn"
	                                            data-comment-id="${reply.feed_comments_id}" data-now-id="${now_id}">
	                                        <img class="likebtn" src="static/images/btn/like_btn.png" alt="like"/>
	                                        <span class="comment-like-count">${reply.likeCount}</span>
	                                    </button>
	                                </div>
	                            </div>
	                        </c:forEach>
	                    </div>
	                </c:if>
	                <!-- 답글 입력 폼 -->
	                <div class="reply-form" id="reply-form-${comment.feed_comments_id}" style="display: none;"
	                     onsubmit="validateReplyForm(event)">
	                    <form action="feedDetail/reply" method="post" class="comment-form" style="margin: 10px auto;">
	                        <input type="hidden" name="feedId" value="${feedDetail.feed_id}">
	                        <input type="hidden" name="parentCommentId" value="${comment.feed_comments_id}">
	                        <input type="hidden" name="userId" value="${now_id}">
	                        <input type="text" name="replyText" class="comment-input" placeholder="답글을 입력하세요"/>
	                        <button type="submit" class="comment-btn">답글</button>
	                    </form>
	                </div>
	            </div>
	        </c:forEach>
	        <!-- 댓글 입력 폼 -->
	        <div>
	            <form action="feedDetail/comments" method="post" onsubmit="validateCommentForm(event)" class="comment-form">
	                <input type="hidden" name="feedId" value="${feedDetail.feed_id}">
	                <input type="hidden" name="userId" value="${now_id}">
	                <input type="text" name="comments" class="comment-input" placeholder="댓글을 입력하세요"/>
	                <button type="submit" class="comment-btn">입력</button>
	            </form>
	        </div>
	    </div>
    </div>

    <div id="otherModal" class="modal">
        <div class="modal-content">
            <div id="deleteItem" class="modal-item red" style="display: none;">삭제</div>
            <div id="publicPost" class="modal-item">피드 공유</div>
            <div id="hidePostItem" class="modal-item" style="display: none;">게시글 비공개</div>
            <div id="openPostItem" class="modal-item" style="display: none;">게시글 공개</div>
            <div id="reportItem" class="modal-item red" style="display: none;">신고</div>
            <div class="modal-item gray" onclick="closeOtherModal()">취소</div>
        </div>
    </div>
</div>

<script type="text/javascript">
    function validateCommentForm(event) {
        var comments = document.getElementsByName("comments")[0].value.trim();
        if (comments === "") {
            alert("댓글 내용을 작성해 주세요.");
            event.preventDefault();  // 폼 제출을 중단
            return false;
        }
        return true;
    }

    function validateReplyForm(event) {
        var replyText = event.target.querySelector("[name='replyText']").value.trim();
        if (replyText === "") {
            alert("답글 내용을 작성해 주세요.");
            event.preventDefault();  // 폼 제출을 중단
            return false;
        }
        return true;
    }
</script>

<script>
    let selectedItemId = null;
    let selectedItemFeedId = null;
    let selectedOpenId = null;
    let selectedItemType = null; // 'post', 'comment', 'reply'
    let isOwner = false;

    function openOtherModal(itemId, openId, itemFeedId, itemOwnerId, currentUserId, itemType) {
        selectedItemId = itemId;
        selectedItemFeedId = itemFeedId;
        selectedOpenId = openId;
        selectedItemType = itemType;
        isOwner = (itemOwnerId === currentUserId);

        // 모든 모달 아이템을 초기화
        document.getElementById("deleteItem").style.display = "none";
        document.getElementById("hidePostItem").style.display = "none";
        document.getElementById("openPostItem").style.display = "none";
        document.getElementById("reportItem").style.display = "none";
        document.getElementById("publicPost").style.display = "none";

        if (itemType === 'post') {
        	document.getElementById("publicPost").style.display = "block";
            if (isOwner) {
                document.getElementById("deleteItem").style.display = "block";
                if (selectedOpenId == 1) {
                    document.getElementById("openPostItem").style.display = "block";
                } else {
                    document.getElementById("hidePostItem").style.display = "block";
                }
            } else {
                document.getElementById("reportItem").style.display = "block";
            }
        } else if (itemType === 'comment' || itemType === 'reply') {
            if (isOwner) {
                document.getElementById("deleteItem").style.display = "block";
            } else {
                document.getElementById("reportItem").style.display = "block";
            }
        }

        document.getElementById("otherModal").style.display = "flex";
    }

    function closeOtherModal() {
        document.getElementById("otherModal").style.display = "none";
        selectedItemId = null;
        selectedItemType = null;
    }

    document.getElementById("deleteItem").addEventListener("click", function () {
        if (confirm("정말로 삭제하시겠습니까?")) {
            if (selectedItemType === 'post') {
                window.location.href = `feedDel?f=\${selectedItemId}`;
            } else if (selectedItemType === 'comment' || selectedItemType === 'reply') {
                window.location.href = `feedDetail/deleteComment?feedCommentsId=\${selectedItemId}&feedId=\${selectedItemFeedId}`;
            }
        }
        closeOtherModal();
    });

    document.getElementById("publicPost").addEventListener("click", function () {
        window.location.href = `linkMessage?f=\${selectedItemId}`;
        closeOtherModal();
    });

    document.getElementById("hidePostItem").addEventListener("click", function () {
        alert("게시글을 숨깁니다.");
        window.location.href = `feedHide?f=\${selectedItemId}`;
        closeOtherModal();
    });

    document.getElementById("openPostItem").addEventListener("click", function () {
        alert("게시글을 공개합니다.");
        window.location.href = `feedOpen?f=\${selectedItemId}`;
        closeOtherModal();
    });

    document.getElementById("reportItem").addEventListener("click", function () {
        if (selectedItemType === 'post') {
            window.location.href = `report?f=\${selectedItemId}`;
        } else if (selectedItemType === 'comment' || selectedItemType === 'reply') {
            window.location.href = `report?fc=\${selectedItemId}`;
        }
        closeOtherModal();
    });

    window.addEventListener('click', function (event) {
        const modal = document.getElementById("otherModal");
        if (event.target === modal) {
            closeOtherModal();
        }
    });

    // 게시글의 other-btn 클릭 시 모달 열기
    document.querySelectorAll('.other-btn').forEach(button => {
        button.addEventListener('click', function (event) {
            event.stopPropagation();
            const postElement = this.closest('.post');
            const itemId = postElement.getAttribute('data-post-id');
            const itemFeedId = postElement.getAttribute('data-feed-id');
            const openId = postElement.getAttribute('data-open-id');
            const itemOwnerId = postElement.getAttribute('data-user-id');
            const currentUserId = '${now_id}';

            openOtherModal(itemId, openId, itemFeedId, itemOwnerId, currentUserId, 'post');
        });
    });

    // 댓글 및 답글의 other-btn 클릭 시 모달 열기
    document.querySelectorAll('.comment-other-btn, .reply-other-btn').forEach(button => {
        button.addEventListener('click', function (event) {
            event.stopPropagation();
            const itemElement = this.closest('.comment, .reply');
            const itemId = itemElement.getAttribute('data-comment-id');
            const openId = 0;
            const itemFeedId = itemElement.getAttribute('data-feed-id');
            const itemOwnerId = itemElement.getAttribute('data-user-id');
            const currentUserId = '${now_id}';
            const itemType = itemElement.classList.contains('reply') ? 'reply' : 'comment';

            openOtherModal(itemId, openId, itemFeedId, itemOwnerId, currentUserId, itemType);
        });
    });
</script>

<script>
    // 좋아요 처리 로직
    document.querySelector('.like-btn').addEventListener('click', function () {
        const feedId = this.getAttribute('data-feed-id');
        const nowId = this.getAttribute('data-now-id');

        fetch('/whale/feedLike', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: new URLSearchParams({
                'feedId': feedId,
                'now_id': nowId
            })
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    this.querySelector('.like-count').textContent = data.newLikeCount;
                } else {
                    alert("좋아요 처리에 실패했습니다.");
                }
            })
            .catch(error => console.error('Error:', error));
    });

    document.querySelectorAll('.comment-like-btn').forEach(button => {
        button.addEventListener('click', function () {
            const commentId = this.getAttribute('data-comment-id');
            const nowId = this.getAttribute('data-now-id');

            fetch('/whale/commentLike', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: new URLSearchParams({
                    'commentId': commentId,
                    'now_id': nowId
                })
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        this.querySelector('.comment-like-count').textContent = data.newLikeCount;
                    } else {
                        alert("좋아요 처리에 실패했습니다.");
                    }
                })
                .catch(error => console.error('Error:', error));
        });
    });

    function toggleReplyForm(commentId) {
        const replyForm = document.getElementById(`reply-form-\${commentId}`);
        if (replyForm.style.display === 'none' || replyForm.style.display === '') {
            replyForm.style.display = 'block';
        } else {
            replyForm.style.display = 'none';
        }
    }


    function playMusic(element, spotifyId) {
        fetch(`/whale/feedPlayMusic?id=\${spotifyId}`)
            .then(response => {
                if (response.ok) {
                    // Play 버튼 숨기고 Pause 버튼 보이기
                    element.style.display = 'none';
                    const pauseBtn = element.parentElement.querySelector('label[onclick^="pauseMusic"]');
                    if (pauseBtn) {
                        pauseBtn.style.display = 'inline-block';
                    }
                } else {
                    alert('음악 재생에 실패했습니다.');
                }
            })
            .catch(error => {
                console.error('에러 발생:', error);
                alert('음악 재생 중 오류가 발생했습니다.');
            });
    }

    function pauseMusic(element, spotifyId) {
        fetch('/whale/feedPauseMusic?id=${spotifyId}')
            .then(response => {
                if (response.ok) {
                    // Pause 버튼 숨기고 Play 버튼 보이기
                    element.style.display = 'none';
                    const playBtn = element.parentElement.querySelector('label[onclick^="playMusic"]');
                    if (playBtn) {
                        playBtn.style.display = 'inline-block';
                    }
                } else {
                    alert('음악 일시정지에 실패했습니다.');
                }
            })
            .catch(error => {
                console.error('에러 발생:', error);
                alert('음악 일시정지 중 오류가 발생했습니다.');
            });
    }

    document.addEventListener("DOMContentLoaded", function () {
        const settingElement = document.querySelector('.setting-body');
        const feedElement = document.querySelector('.feed-container');
        const toggleSlide = document.getElementById('toggle-slide');
        let darkmodeOn = localStorage.getItem('darkmodeOn') || "0";

        const updateScrollbarStyle = () => {
            const styleSheet = document.getElementById("darkmode-scrollbar-styles");
            if (darkmodeOn === "1") {
                styleSheet.innerHTML = `
                html::-webkit-scrollbar {display: block; width: 8px;}
                html::-webkit-scrollbar-track {background: #2e2e2e;}
                html::-webkit-scrollbar-thumb {background-color: #555; border-radius: 4px;}
                html {width: 100%; height: 190px; overflow-y: auto; scroll-behavior: smooth; display: flex; flex-direction: column;}
                html body{background-color: #434343;}
            `;
            } else {
                styleSheet.innerHTML = `
                html::-webkit-scrollbar {display: block; width: 8px;}
                html::-webkit-scrollbar-track {background: #fff;}
                html::-webkit-scrollbar-thumb {background-color: #ccc; border-radius: 4px;}
                html {width: 100%; height: 190px; overflow-y: auto; scroll-behavior: smooth; display: flex; flex-direction: column;}
            `;
            }
        };

        if (settingElement) {
            settingElement.setAttribute("data-darkmode", darkmodeOn);
            const isDarkMode = darkmodeOn === "1";
            toggleSlide.checked = isDarkMode;
            settingElement.classList.toggle("dark", isDarkMode);
            settingElement.classList.toggle("light", !isDarkMode);

            toggleSlide.addEventListener('change', function () {
                darkmodeOn = this.checked ? "1" : "0";
                localStorage.setItem('darkmodeOn', darkmodeOn);
                settingElement.setAttribute("data-darkmode", darkmodeOn);
                settingElement.classList.toggle("dark", darkmodeOn === "1");
                settingElement.classList.toggle("light", darkmodeOn !== "1");
                window.parent.postMessage({darkmodeOn: darkmodeOn}, "*");

                const xhr = new XMLHttpRequest();
                xhr.open('POST', '/whale/updateDarkmode', true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xhr.send('darkmode_setting_onoff=' + darkmodeOn);
            });
        }

        if (feedElement) {
            feedElement.setAttribute("data-darkmode", darkmodeOn);
            const isDarkMode = darkmodeOn === "1";
            feedElement.classList.toggle("dark", isDarkMode);
            feedElement.classList.toggle("light", !isDarkMode);

            window.addEventListener('message', function (event) {
                if (event.data && event.data.darkmodeOn !== undefined) {
                    darkmodeOn = event.data.darkmodeOn;
                    feedElement.setAttribute("data-darkmode", darkmodeOn);
                    const isDarkMode = darkmodeOn === "1";
                    feedElement.classList.toggle("dark", isDarkMode);
                    feedElement.classList.toggle("light", !isDarkMode);

                    updateScrollbarStyle(); // 스크롤바 스타일 업데이트
                }
            });
        }

        window.addEventListener('storage', function (event) {
            if (event.key === 'darkmodeOn') {
                darkmodeOn = event.newValue || "0";
                if (settingElement) {
                    settingElement.setAttribute("data-darkmode", darkmodeOn);
                    const isDark = darkmodeOn === "1";
                    settingElement.classList.toggle("dark", isDark);
                    settingElement.classList.toggle("light", !isDark);
                    toggleSlide.checked = isDark;
                }
                if (feedElement) {
                    feedElement.setAttribute("data-darkmode", darkmodeOn);
                    const isDark = darkmodeOn === "1";
                    feedElement.classList.toggle("dark", isDark);
                    feedElement.classList.toggle("light", !isDark);
                }
                updateScrollbarStyle(); // 스크롤바 스타일 업데이트
            }
        });

        // 초기 페이지 로드 시 스크롤바 스타일 적용
        updateScrollbarStyle();
    });
</script>

</body>
</html>