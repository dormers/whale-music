<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${postDetail.post_title} - ${communityName}</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;600&display=swap">
<script src="static/js/setting/darkMode.js"></script>
<style>
	::-webkit-scrollbar {display: none;}
    body {font-family: 'Noto Sans KR', Arial, sans-serif; margin: 0; padding: 0;}
    .container[data-darkmode="0"] {width: 100%; max-width: 900px; margin: 0 auto; background-color: whitesmoke; padding: 40px 20px; box-sizing: border-box;}
    .container[data-darkmode="0"] .containerX {width: 90%; margin: auto; background: white;}
    .container[data-darkmode="0"] .community-name {background: linear-gradient(to right, #e0e0e0, #ffffff); padding: 20px 30px; font-size: 1.5em; font-weight: bold; color: #343a40; margin-bottom: 30px;}
    .container[data-darkmode="0"] .community-name a:visited {color: black; text-decoration: none;}
    .container[data-darkmode="0"] .post-header {border-bottom: 1px solid #e9ecef; padding-bottom: 30px; margin-bottom: 30px;}
    .container[data-darkmode="0"] .post-title {font-size: 2em; font-weight: bold; margin: 0 0 10px 20px;}
    .container[data-darkmode="0"] .post-meta {display: flex; align-items: center; color: #868e96; font-size: 0.9em; margin-right: 20px;}
    .container[data-darkmode="0"] .post-meta .profile-pic {width: 40px; height: 40px; border-radius: 50%; margin: 4px 10px 0 10px;}
    .container[data-darkmode="0"] .post-meta .username {margin-right: 10px; font-weight: bold; color: #495057;}
    .container[data-darkmode="0"] .post-meta .post-date {margin-right: 10px;}
    .container[data-darkmode="0"] .other-btn {background: none; border: none; cursor: pointer; padding: 0; margin-left: auto;}
    .container[data-darkmode="0"] .other-btn img {width: 24px; height: 24px;}
    .container[data-darkmode="0"] .post-content {font-size: 14px; letter-spacing: 1px; line-height: 30px; color: #212529; padding: 0 20px; margin-bottom: 30px;}
    .container[data-darkmode="0"] .post-content img {max-width: 100%; height: auto;}
    .container[data-darkmode="0"] .music-info {background-color: #f1f3f5; padding: 15px; border-radius: 5px; display: flex; align-items: center; width: 80%; margin: 0 auto 30px;}
    .container[data-darkmode="0"] .music-info img {width: 60px; height: 60px; border-radius: 5px; margin-right: 15px;}
    .container[data-darkmode="0"] .music-details {flex-grow: 1;}
    .container[data-darkmode="0"] .music-title {font-size: 15px; letter-spacing: 0.7px; font-weight: bold; margin-bottom: 2px;}
    .container[data-darkmode="0"] .artist-name {font-size: 14px; letter-spacing: 0.7px; color: #495057;}
    .container[data-darkmode="0"] .play-button, .pause-button {cursor: pointer; margin-left: 15px;}
    .container[data-darkmode="0"] .play-button img, .pause-button img {width: 40px; height: 40px;}
    .container[data-darkmode="0"] .post-actions {display: flex; justify-content: space-around; align-items: center; margin: 40px 0; color: black;}
    .container[data-darkmode="0"] .like-btn, .comment-btn {display: flex; align-items: center; background: none; border: none; cursor: pointer; margin-right: 20px; color: #495057; font-size: 1em;}
    .container[data-darkmode="0"] .like-btn img, .comment-btn img {width: 24px; height: 24px; margin-right: 5px;}
    .container[data-darkmode="0"] .like-count, .container[data-darkmode="0"] .comment-count {font-size: 1em; color: black;}
    .container[data-darkmode="0"] .comments-section {border-top: 1px solid #e9ecef; padding: 5px 30px;}
    .container[data-darkmode="0"] .comment-form {display: flex; justify-content: center; align-items: center; width: 70%; height: 35px; border: 1.6px solid #d2d2d2; border-radius: 10px; margin: 35px auto;}
    .container[data-darkmode="0"] .comment-input {width: 80%; height: 56%; background: transparent; border: none; outline: none; font-size: 13px; color: rgb(164, 164, 164); text-align: center; cursor: grab;}
    .container[data-darkmode="0"] .comment-btn-input {background: transparent; border: 1px solid #d2d2d2; border-radius: 4px; font-size: 12px; color: rgb(164, 164, 164); text-align: center; cursor: grab; padding: 5px 10px;}
    .container[data-darkmode="0"] .comment-item {margin: 25px 0; padding: 25px 0; border-bottom: 1px solid #e2e2e2;}
    .container[data-darkmode="0"] .comment-header {display: flex; align-items: center; margin-bottom: 5px; padding: 0 5px;}
    .container[data-darkmode="0"] .comment-header .profile-pic {width: 40px; height: 40px; border-radius: 50%; margin-right: 10px; margin-top: 5px;}
    .container[data-darkmode="0"] .comment-header .username {font-weight: bold; color: #495057; margin-right: 10px;}
    .container[data-darkmode="0"] .comment-header .comment-date {color: #868e96; font-size: 0.9em;}
    .container[data-darkmode="0"] .comment-header .comment-other-btn {background: none; border: none; cursor: pointer; padding: 0; margin-left: auto;}
    .container[data-darkmode="0"] .comment-other-btn img {width: 20px; height: 20px;}
    .container[data-darkmode="0"] .comment-text {font-size: 1em; line-height: 1.6; color: #212529; margin-bottom: 10px; padding: 0 7px;}
    .container[data-darkmode="0"] .comment-actions {display: flex; align-items: center; padding-left: 5px;}
    .container[data-darkmode="0"] .comment-actions button {background: none; border: none; cursor: pointer; margin-right: 15px; color: #495057; font-size: 0.9em; padding: 0;}
    .container[data-darkmode="0"] .comment-actions img {width: 20px; height: 20px; margin-right: 5px;}
    .container[data-darkmode="0"] .reply-form {margin-top: 10px;}
    .container[data-darkmode="0"] .reply-item {margin-left: 50px; margin-top: 25px;}
    #otherModal[data-darkmode="0"] {display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.6); justify-content: center; align-items: center;}
    #otherModal[data-darkmode="0"] .modal-content {background-color: white; border-radius: 12px; width: 80%; max-width: 300px; text-align: center; overflow: hidden; position: relative;}
    #otherModal[data-darkmode="0"] .modal-item {padding: 20px; border-bottom: 1px solid #eee; font-size: 16px; cursor: pointer;}
    #otherModal[data-darkmode="0"] .modal-item.red {color: red;}
    #otherModal[data-darkmode="0"] .modal-item.gray {color: gray;}
    #otherModal[data-darkmode="0"] .modal-item:last-child {border-bottom: none;}
    #otherModal[data-darkmode="0"] .modal-item:hover {background-color: #f9f9f9;}
    #otherModal[data-darkmode="0"] .close-modal {position: absolute; top: 15px; right: 20px; font-size: 30px; font-weight: bold; color: #aaaaaa; cursor: pointer;}
    #otherModal[data-darkmode="0"] .close-modal:hover {color: #000000;}
    #otherModal[data-darkmode="0"] .no-link-style {color: inherit; text-decoration: none;}
    /* -------------------------------------------------------------------------------------------------------------------- */
    .container[data-darkmode="1"] {width: 100%; max-width: 900px; margin: 0 auto; background-color: #1f1f1f; padding: 40px 20px; box-sizing: border-box;}
    .container[data-darkmode="1"] .containerX {width: 90%; margin: auto; background: #2e2e2e;}
    .container[data-darkmode="1"] .community-name {background: linear-gradient(to right, #335580, black); padding: 20px 30px; font-size: 1.5em; font-weight: bold; color: whitesmoke !important; margin-bottom: 30px; text-decoration: none;}
    .container[data-darkmode="1"] .community-name a:visited {color: whitesmoke; text-decoration: none;}
    .container[data-darkmode="1"] .post-header {border-bottom: 1px solid #e9ecef; padding-bottom: 30px; margin-bottom: 30px;}
    .container[data-darkmode="1"] .post-title {font-size: 2em; font-weight: bold; margin: 0 0 10px 20px; color: whitesmoke}
    .container[data-darkmode="1"] .post-meta {display: flex; align-items: center; color: #868e96; font-size: 0.9em; margin-right: 20px;}
    .container[data-darkmode="1"] .post-meta .profile-pic {width: 40px; height: 40px; border-radius: 50%; margin: 4px 10px 0 10px;}
    .container[data-darkmode="1"] .post-meta .username {margin-right: 10px; font-weight: bold; color: whitesmoke;}
    .container[data-darkmode="1"] .post-meta .post-date {margin-right: 10px; color: whitesmoke;}
    .container[data-darkmode="1"] .other-btn {background: none; border: none; cursor: pointer; padding: 0; margin-left: auto;}
    .container[data-darkmode="1"] .other-btn img {width: 24px; height: 24px;}
    .container[data-darkmode="1"] .post-content {font-size: 14px; letter-spacing: 1px; line-height: 30px; color: whitesmoke; padding: 0 20px; margin-bottom: 30px;}
    .container[data-darkmode="1"] .post-content img {max-width: 100%; height: auto;}
    .container[data-darkmode="1"] .music-info {background-color: #929292; padding: 15px; border-radius: 5px; display: flex; align-items: center; width: 80%; margin: 0 auto 30px;}
    .container[data-darkmode="1"] .music-info img {width: 60px; height: 60px; border-radius: 5px; margin-right: 15px;}
    .container[data-darkmode="1"] .music-details {flex-grow: 1;}
    .container[data-darkmode="1"] .music-title {font-size: 15px; letter-spacing: 0.7px; font-weight: bold; margin-bottom: 2px;}
    .container[data-darkmode="1"] .artist-name {font-size: 14px; letter-spacing: 0.7px; color: #495057;}
    .container[data-darkmode="1"] .play-button, .pause-button {cursor: pointer; margin-left: 15px;}
    .container[data-darkmode="1"] .play-button img, .pause-button img {width: 40px; height: 40px;}
    .container[data-darkmode="1"] .post-actions {display: flex; justify-content: space-around; align-items: center; margin: 40px 0; color: whitesmoke;}
    .container[data-darkmode="1"] .like-btn, .comment-btn {display: flex; align-items: center; background: none; border: none; cursor: pointer; margin-right: 20px; color: whitesmoke; font-size: 1em;}
    .container[data-darkmode="1"] .like-btn img, .comment-btn img {width: 24px; height: 24px; margin-right: 5px; filter: invert(1);}
    .container[data-darkmode="1"] .like-count, .container[data-darkmode="1"] .comment-count {font-size: 1em; color: whitesmoke;}
    .container[data-darkmode="1"] .comments-section {border-top: 1px solid #e9ecef; padding: 5px 30px;}
    .container[data-darkmode="1"] .comment-form {display: flex; justify-content: center; align-items: center; width: 70%; height: 35px; border: 1.6px solid #d2d2d2; border-radius: 10px; margin: 35px auto;}
    .container[data-darkmode="1"] .comment-input {width: 80%; height: 56%; background: transparent; border: none; outline: none; font-size: 13px; color: rgb(164, 164, 164); text-align: center; cursor: grab;}
    .container[data-darkmode="1"] .comment-btn-input {background: transparent; border: 1px solid #d2d2d2; border-radius: 4px; font-size: 12px; color: rgb(164, 164, 164); text-align: center; cursor: grab; padding: 5px 10px;}
    .container[data-darkmode="1"] .comment-item {margin: 25px 0; padding: 25px 0; border-bottom: 1px solid #e2e2e2;}
    .container[data-darkmode="1"] .comment-header {display: flex; align-items: center; margin-bottom: 5px; padding: 0 5px;}
    .container[data-darkmode="1"] .comment-header .profile-pic {width: 40px; height: 40px; border-radius: 50%; margin-right: 10px; margin-top: 5px;}
    .container[data-darkmode="1"] .comment-header .username {font-weight: bold; color: whitesmoke; margin-right: 10px;}
    .container[data-darkmode="1"] .comment-header .comment-date {color: whitesmoke; font-size: 0.9em;}
    .container[data-darkmode="1"] .comment-header .comment-other-btn {background: none; border: none; cursor: pointer; padding: 0; margin-left: auto;}
    .container[data-darkmode="1"] .comment-other-btn img {width: 20px; height: 20px;}
    .container[data-darkmode="1"] .comment-text {font-size: 1em; line-height: 1.6; color: whitesmoke; margin-bottom: 10px; padding: 0 7px;}
    .container[data-darkmode="1"] .comment-actions {display: flex; align-items: center; padding-left: 5px;}
    .container[data-darkmode="1"] .comment-actions button {background: none; border: none; cursor: pointer; margin-right: 15px; color: whitesmoke; font-size: 0.9em; padding: 0;}
    .container[data-darkmode="1"] .comment-actions img {width: 20px; height: 20px; margin-right: 5px; filter: invert(1);}
    .container[data-darkmode="1"] .reply-form {margin-top: 10px;}
    .container[data-darkmode="1"] .reply-item {margin-left: 50px; margin-top: 25px;}
    #otherModal[data-darkmode="1"] {display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.6); justify-content: center; align-items: center;}
    #otherModal[data-darkmode="1"] .modal-content {background-color: #2e2e2e; border-radius: 12px; width: 80%; max-width: 300px; text-align: center; overflow: hidden; position: relative;}
    #otherModal[data-darkmode="1"] .modal-item {padding: 20px; border-bottom: 1px solid #747474; font-size: 16px; cursor: pointer; color: whitesmoke;}
    #otherModal[data-darkmode="1"] .modal-item.red {color: #FF6C6C;}
    #otherModal[data-darkmode="1"] .modal-item.gray {color: whitesmoke;}
    #otherModal[data-darkmode="1"] .modal-item:last-child {border-bottom: none;}
    #otherModal[data-darkmode="1"] .modal-item:hover {background-color: #1f1f1f;}
    #otherModal[data-darkmode="1"] .close-modal {position: absolute; top: 15px; right: 20px; font-size: 30px; font-weight: bold; color: #aaaaaa; cursor: pointer;}
    #otherModal[data-darkmode="1"] .close-modal:hover {color: #000000;}
    #otherModal[data-darkmode="1"] .no-link-style {color: inherit; text-decoration: none;}
</style>
<style id="darkmode-scrollbar-styles"></style>
</head>
<body>

    <div class="container" data-darkmode="${darkMode.scndAttrName}">
    	<div class="containerX">
	        <!-- 페이지 상단 커뮤니티 이름 -->
	        <div class="community-name"><a href="communityPost?c=${communityId}" class="no-link-style">${communityName}</a></div>
	
	        <!-- 게시글 헤더 -->
	        <div class="post-header">
	            <h1 class="post-title">${postDetail.post_title}</h1>
	            <div class="post-meta">
	                <a href="profileHome?u=${postDetail.user_id}">
	                    <img src="${postDetail.user_image_url}" alt="User Profile" class="profile-pic">
	                </a>
	                <span class="username">${postDetail.user_id}</span>
	                <span class="post-date">${postDetail.post_date}</span>
	                <!-- 기타 버튼 -->
	                <button class="other-btn">
	                    <img src="static/images/btn/other_btn.png" alt="Other Button">
	                </button>
	            </div>
	        </div>
	
	        <!-- 게시글 내용 -->
	        <div class="post-content">
	            ${postDetail.post_text}
	        </div>
	
	        <!-- 음악 정보 표시 -->
	        <c:if test="${not empty postDetail.track_id}">
	            <div class="music-info">
	                <img src="${postDetail.track_cover}" alt="Album Cover">
	                <div class="music-details">
	                    <div class="music-title">${postDetail.track_name}</div>
	                    <div class="artist-name">${postDetail.track_artist}</div>
	                </div>
	                <label class="play-button" onclick="playMusic(this, '${postDetail.track_id}')">
	                    <img src="static/images/btn/play_btn.png" alt="Play">
	                </label>
	                <label class="pause-button" onclick="pauseMusic(this, '${postDetail.track_id}')" style="display: none;">
	                    <img src="static/images/btn/pause_btn.png" alt="Pause">
	                </label>
	            </div>
	        </c:if>
	
	        <!-- 좋아요 및 댓글 수 -->
	        <div class="post-actions">
	            <button type="button" class="like-btn" data-post-id="${postDetail.post_id}" data-now-id="${now_id}">
	                <img src="static/images/btn/like_btn.png" alt="Like">
	                <span class="like-count">${postDetail.likeCount}</span>
	            </button>
	            <div class="comment-btn">
	                <img src="static/images/btn/comment_btn.png" alt="Comments">
	                <span class="comment-count">${postDetail.commentsCount}</span>
	            </div>
	        </div>
	
	        <!-- 댓글 섹션 -->
	        <div class="comments-section">
	            <!-- 댓글 목록 -->
	            <c:forEach var="comment" items="${postDetail.comments}">
	                <div class="comment-item" data-comment-id="${comment.post_comments_id}" data-user-id="${comment.user_id}">
	                    <div class="comment-header">
	                        <a href="profileHome?u=${comment.user_id}">
	                            <img src="${comment.user_image_url}" alt="User Profile" class="profile-pic">
	                        </a>
	                        <span class="username">${comment.user_id}</span>
	                        <span class="comment-date">${comment.post_comments_date}</span>
	                        <!-- 댓글의 기타 버튼 -->
	                        <button class="comment-other-btn">
	                            <img src="static/images/btn/other_btn.png" alt="Other Button">
	                        </button>
	                    </div>
	                    <div class="comment-text">${comment.post_comments_text}</div>
	                    <div class="comment-actions">
	                        <button type="button" class="comment-like-btn" data-comment-id="${comment.post_comments_id}" data-now-id="${now_id}">
	                            <img src="static/images/btn/like_btn.png" alt="Like">
	                            <span class="comment-like-count">${comment.likeCount}</span>
	                        </button>
	                        <button type="button" class="reply-btn" onclick="toggleReplyForm(${comment.post_comments_id})">
	                            <img class="commentbtn" src="static/images/btn/comment_btn.png" alt="답글"/>
	                        	<span class="comment-reply-count">${comment.replyCount}</span>
	                        </button>
	                    </div>
	                    
	                    <!-- 답글 목록 -->
	                    <c:if test="${not empty comment.replies}">
	                        <c:forEach var="reply" items="${comment.replies}">
	                            <div class="reply-item" data-comment-id="${reply.post_comments_id}" data-user-id="${reply.user_id}">
	                                <div class="comment-header">
	                                    <a href="profileHome?u=${reply.user_id}">
	                                        <img src="${reply.user_image_url}" alt="User Profile" class="profile-pic">
	                                    </a>
	                                    <span class="username">${reply.user_id}</span>
	                                    <span class="comment-date">${reply.post_comments_date}</span>
	                                    <!-- 답글의 기타 버튼 -->
	                                    <button class="comment-other-btn">
	                                        <img src="static/images/btn/other_btn.png" alt="Other Button">
	                                    </button>
	                                </div>
	                                <div class="comment-text">${reply.post_comments_text}</div>
	                                <div class="comment-actions">
	                                    <button type="button" class="comment-like-btn" data-comment-id="${reply.post_comments_id}" data-now-id="${now_id}">
	                                        <img src="static/images/btn/like_btn.png" alt="Like">
	                                        <span class="comment-like-count">${reply.likeCount}</span>
	                                    </button>
	                                </div>
	                            </div>
	                        </c:forEach>
	                    </c:if>
	                    <!-- 답글 입력 폼 -->
	                    <div class="reply-form" id="reply-form-${comment.post_comments_id}" style="display: none;">
	                        <form action="communityDetail/comments" method="post" onsubmit="validateReplyForm(event)" class="comment-form">
	                            <input type="hidden" name="postId" value="${postDetail.post_id}">
	                            <input type="hidden" name="userId" value="${now_id}">
	                            <input type="hidden" name="parentCommentId" value="${comment.post_comments_id}">
	                            <input type="hidden" name="c" value="${communityId}">
	                            <input type="text" name="comments" class="comment-input" placeholder="답글을 입력하세요">
	                            <button type="submit" class="comment-btn-input">답글 달기</button>
	                        </form>
	                    </div>
	                </div>
	            </c:forEach>
	            <!-- 댓글 입력 폼 -->
	            <div>
	                <form action="communityDetail/comments" method="post" onsubmit="validateCommentForm(event)" class="comment-form">
	                    <input type="hidden" name="postId" value="${postDetail.post_id}">
	                    <input type="hidden" name="userId" value="${now_id}">
	                    <input type="hidden" name="c" value="${communityId}">
	                    <input type="text" name="comments" class="comment-input" placeholder="댓글을 입력하세요">
	                    <button type="submit" class="comment-btn-input">댓글 달기</button>
	                </form>
	            </div>
	        </div>
        </div>
    </div>

    <!-- 모달 창 -->
    <div id="otherModal" class="modal">
        <div class="modal-content">
            <div id="publicItem" class="modal-item white">게시글 공유</div>
            <div id="deleteItem" class="modal-item red" style="display: none;">삭제</div>
            <div id="updateItem" class="modal-item white" style="display:none;">수정</div>
            <div id="reportItem" class="modal-item red" style="display: none;">신고</div>
            <div class="modal-item gray" onclick="closeOtherModal()">취소</div>
        </div>
    </div>

    <!-- 스크립트 -->
    <script>
        // 댓글 입력 검증
        function validateCommentForm(event) {
            var comments = event.target.querySelector("[name='comments']").value.trim();
            console.log('Complete: '+comments);
            if (comments === "") {
                alert("댓글 내용을 작성해 주세요.");
                event.preventDefault();
                return false;
            }
            return true;
        }

        // 답글 입력 검증
        function validateReplyForm(event) {
            var replyText = event.target.querySelector("[name='comments']").value.trim();
            if (replyText === "") {
                alert("답글 내용을 작성해 주세요.");
                event.preventDefault();
                return false;
            }
            return true;
        }

        // 답글 폼 토글
        function toggleReplyForm(commentId) {
            const replyForm = document.getElementById(`reply-form-\${commentId}`);
            if (replyForm.style.display === 'none' || replyForm.style.display === '') {
                replyForm.style.display = 'block';
            } else {
                replyForm.style.display = 'none';
            }
        }

        // 좋아요 처리
        document.querySelector('.like-btn').addEventListener('click', function() {
            const postId = this.getAttribute('data-post-id');
            const nowId = this.getAttribute('data-now-id');

            fetch('communityDetail/like', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: new URLSearchParams({
                    'postId': postId,
                    'userId': nowId
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

        // 댓글 좋아요 처리
        document.querySelectorAll('.comment-like-btn').forEach(button => {
            button.addEventListener('click', function() {
                const commentId = this.getAttribute('data-comment-id');
                const nowId = this.getAttribute('data-now-id');

                fetch('communityDetail/commentLike', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: new URLSearchParams({
                        'commentId': commentId,
                        'userId': nowId
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

        // 음악 재생 및 일시정지
        function playMusic(element, trackId) {
            fetch(`/whale/feedPlayMusic?id=\${trackId}`)
                .then(response => {
                    if (response.ok) {
                        element.style.display = 'none';
                        const pauseBtn = element.parentElement.querySelector('.pause-button');
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

        function pauseMusic(element, trackId) {
            fetch(`/whale/feedPauseMusic?id=\${trackId}`)
                .then(response => {
                    if (response.ok) {
                        element.style.display = 'none';
                        const playBtn = element.parentElement.querySelector('.play-button');
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

        // 모달 처리
        let selectedItemId = null;
        let selectedItemType = null; // 'post', 'comment', 'reply'
        let isOwner = false;

        function openOtherModal(itemId, itemOwnerId, currentUserId, itemType) {
            selectedItemId = itemId;
            selectedItemType = itemType;
            isOwner = (itemOwnerId === currentUserId);

            // 모달 아이템 초기화
            document.getElementById("deleteItem").style.display = "none";
            document.getElementById("updateItem").style.display = "none";
            document.getElementById("reportItem").style.display = "none";

            if (isOwner) {
                document.getElementById("deleteItem").style.display = "block";
                if(selectedItemType === 'post') {
	                document.getElementById("updateItem").style.display = "block";                	
                }
            } else {
                document.getElementById("reportItem").style.display = "block";
            }

            document.getElementById("otherModal").style.display = "flex";
        }

        function closeOtherModal() {
            document.getElementById("otherModal").style.display = "none";
            selectedItemId = null;
            selectedItemType = null;
        }

        document.getElementById("publicItem").addEventListener("click", function() {
        	const communityId = '${communityId}';
        	window.location.href = `linkMessage?c=\${communityId}&p=\${selectedItemId}`;
        })
        
        document.getElementById("deleteItem").addEventListener("click", function() {
            const communityId = '${communityId}';
            if (confirm("정말로 삭제하시겠습니까?")) {
                if (selectedItemType === 'post') {
                    window.location.href = `communityDetailDel?c=\${communityId}&p=\${selectedItemId}`;
                } else if (selectedItemType === 'comment' || selectedItemType === 'reply') {
                    window.location.href = `communityDetail/deleteComment?postCommentsId=\${selectedItemId}&postId=${postDetail.post_id}&communityId=\${communityId}`;
                }
            }
            closeOtherModal();
        });

        document.getElementById("updateItem").addEventListener("click", function() {
        	const communityId = '${communityId}';
        	window.location.href = `communityUpdate?c=\${communityId}&p=\${selectedItemId}`;
        })
        
        document.getElementById("reportItem").addEventListener("click", function() {
            if (selectedItemType === 'post') {
                window.location.href = `report?p=\${selectedItemId}`;
            } else if (selectedItemType === 'comment' || selectedItemType === 'reply') {
                window.location.href = `report?pc=\${selectedItemId}`;
            }
            closeOtherModal();
        });

        window.addEventListener('click', function(event) {
            const modal = document.getElementById("otherModal");
            if (event.target === modal) {
                closeOtherModal();
            }
        });

        // 게시글의 other-btn 클릭 시 모달 열기
        document.querySelector('.other-btn').addEventListener('click', function(event) {
            event.stopPropagation();
            const itemId = '${postDetail.post_id}';
            const itemOwnerId = '${postDetail.user_id}';
            const currentUserId = '${now_id}';

            openOtherModal(itemId, itemOwnerId, currentUserId, 'post');
        });

        // 댓글 및 답글의 other-btn 클릭 시 모달 열기
        document.querySelectorAll('.comment-other-btn').forEach(button => {
            button.addEventListener('click', function(event) {
                event.stopPropagation();
                const itemElement = this.closest('.comment-item, .reply-item');
                
                console.log('itemElement:', itemElement);
                
                const itemId = itemElement.getAttribute('data-comment-id');
                const itemOwnerId = itemElement.getAttribute('data-user-id');
                const currentUserId = '${now_id}';
                const itemType = itemElement.classList.contains('reply-item') ? 'reply' : 'comment';

                console.log('itemId:', itemId);
                console.log('itemOwnerId:', itemOwnerId);
                console.log('itemType:', itemType);
                
                openOtherModal(itemId, itemOwnerId, currentUserId, itemType);
            });
        });
        // 스크롤바
        document.addEventListener("DOMContentLoaded", function () {
            // localStorage의 darkmodeOn 값 확인
            const darkmodeOn = localStorage.getItem("darkmodeOn");

            // darkmodeOn 값에 따라 스크롤바 스타일을 적용
            const styleSheet = document.getElementById("darkmode-scrollbar-styles");
            if (darkmodeOn === "1") {
                styleSheet.innerHTML = `
            html::-webkit-scrollbar { display: block; width: 0px; }
            html::-webkit-scrollbar-track { background: #2e2e2e; }
            html::-webkit-scrollbar-thumb { background-color: #555; border-radius: 4px; }
            html { overflow-y: auto; scroll-behavior: smooth; }
            body{background:#1f1f1f;}
        `;
            } else {
                styleSheet.innerHTML = `
            html::-webkit-scrollbar { display: block; width: 0px; }
            html::-webkit-scrollbar-track { background: #fff; }
            html::-webkit-scrollbar-thumb { background-color: #ccc; border-radius: 4px; }
            html { overflow-y: auto; scroll-behavior: smooth; }
        `;
            }
        });
    </script>
    
</body>
</html>