<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@400;600&display=swap">
<script>
    function noticeDelete(postId,page,searchType,sk) {
        const deleteConfirm = confirm("공지를 삭제하시겠습니까?");
        if (deleteConfirm) {
        	window.location.href = 
        		"adminNoticeContentDelete?postId="+postId
        				+"&sk="+sk
        				+"&page="+page
        				+"&searchType="+searchType
        }
    }
    function postCommentsDelete(communityName,commentId,postId,page,searchType,sk) {
        const deleteConfirm = confirm("댓글을 삭제하시겠습니까?");
        if (deleteConfirm) {
        	window.location.href = encodeURI(
        		"adminBoardPostCommentsContentDelete?commentId="+commentId
        				+"&communityName="+encodeURIComponent(communityName)
        				+"&postId="+postId
        				+"&sk="+sk
        				+"&page="+page
        				+"&searchType="+searchType)
        }
    }
</script>
<div class="content">
    <div class="container">
        <!-- 페이지 상단 커뮤니티 이름 -->
        <div class="community-name">${comIdName.community_name}</div>

        <!-- 게시글 헤더 -->
        <div class="post-header">
            <h1 class="post-title">${postDetail.post_title}</h1>
            <div class="post-meta">
                <a href="adminAccountUserListView?sk=${postDetail.user_id}">
                    <img src="${postDetail.user_image_url}" alt="User Profile" class="profile-pic">
                </a>
                <span class="username">${postDetail.user_id}</span>
                <span class="post-date">${postDetail.post_date}</span>
                <!-- 기타 버튼 -->
                <div class="post-btn-box">
	                <button class="other-btn" onclick="noticeDelete('${postId }','${page}','${searchType }','${sk }')">
	                    삭제하기
	                </button>
	                <button class="other-btn" onclick="location.href='adminNoticeUpdateView?postId=${postId }&page=${page}&searchType=${searchType }&sk=${sk }'">
	                    수정하기
	                </button>
	                <button class="other-btn" onclick="location.href='adminNoticeListView?postId=${postId }&page=${page}&searchType=${searchType }&sk=${sk }'">
	                    목록
	                </button>
                </div>
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
                    <img src="/whale/static/images/btn/play_btn.png" alt="Play">
                </label>
                <label class="pause-button" onclick="pauseMusic(this, '${postDetail.track_id}')" style="display: none;">
                    <img src="/whale/static/images/btn/pause_btn.png" alt="Pause">
                </label>
            </div>
        </c:if>

        <!-- 좋아요 및 댓글 수 -->
        <div class="post-actions">
            <button type="button" class="like-btn" data-post-id="${postDetail.post_id}" data-now-id="${now_id}">
                <img src="/whale/static/images/btn/like_btn.png" alt="Like">
                <span class="like-count">${postDetail.likeCount}</span>
            </button>
            <div class="comment-btn">
                <img src="/whale/static/images/btn/comment_btn.png" alt="Comments">
                <span class="comment-count">${postDetail.commentsCount}</span>
            </div>
        </div>

        <!-- 댓글 섹션 -->
        <div class="comments-section">
            <!-- 댓글 목록 -->
            <c:forEach var="comment" items="${postDetail.comments}">
                <div class="comment-item" data-comment-id="${comment.post_comments_id}" data-user-id="${comment.user_id}">
                    <div class="comment-header">
                        <a href="adminAccountUserListView?sk=${comment.user_id}">
                            <img src="${comment.user_image_url}" alt="User Profile" class="profile-pic">
                        </a>
                        <span class="username">${comment.user_id}</span>
                        <span class="comment-date">${comment.post_comments_date}</span>
                        <!-- 댓글의 기타 버튼 -->
                        <button class="comment-other-btn" onclick="postCommentsDelete('${communityName}','${comment.post_comments_id}','${postDetail.post_id}','${page}','${searchType }','${sk }')">
                            삭제하기
                        </button>
                    </div>
                    <div class="comment-text">${comment.post_comments_text}</div>
                    <div class="comment-actions">
                        <button type="button" class="comment-like-btn" data-comment-id="${comment.post_comments_id}" data-now-id="${now_id}">
                            <img src="/whale/static/images/btn/like_btn.png" alt="Like">
                            <span class="comment-like-count">${comment.likeCount}</span>
                        </button>
                    </div>
                    <!-- 답글 목록 -->
                    <c:if test="${not empty comment.replies}">
                        <c:forEach var="reply" items="${comment.replies}">
                            <div class="reply-item" data-comment-id="${reply.post_comments_id}" data-user-id="${reply.user_id}">
                                <div class="comment-header">
                                    <a href="adminAccountUserListView?sk=${reply.user_id}">
                                        <img src="${reply.user_image_url}" alt="User Profile" class="profile-pic">
                                    </a>
                                    <span class="username">${reply.user_id}</span>
                                    <span class="comment-date">${reply.post_comments_date}</span>
                                    <!-- 답글의 기타 버튼 -->
                                    <button class="comment-other-btn" onclick="postCommentsDelete('${communityName}','${comment.post_comments_id}','${postDetail.post_id}','${page}','${searchType }','${sk }')">
                                    </button>
                                </div>
                                <div class="comment-text">${reply.post_comments_text}</div>
                                <div class="comment-actions">
                                    <button type="button" class="comment-like-btn" data-comment-id="${reply.post_comments_id}" data-now-id="${now_id}">
                                        <img src="/whale/static/images/btn/like_btn.png" alt="Like">
                                        <span class="comment-like-count">${reply.likeCount}</span>
                                    </button>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                </div>
            </c:forEach>
        </div>
    </div>
<br />
<br />
<br />
</div>
