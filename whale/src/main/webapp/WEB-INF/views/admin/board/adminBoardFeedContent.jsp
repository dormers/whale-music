<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="content" name="content" id="content">
	<div class="post" data-post-id="${feedDetail.feed_id}" data-user-id="${feedDetail.user_id}">
	    <div class="user-info">
	        <a href="adminAccountUserInfo?userId=${feedDetail.user_id}">
	            <img src="${feedDetail.user_image_url}" alt="User Profile" class="profile-pic">
	        </a>
	        <span class="username">${feedDetail.user_id}</span>
	    </div>
	
	    <button class="other-btn" onclick="feedDelete('${feedDetail.feed_id}','${page}','${searchType }','${sk }')">
	        삭제
	    </button>
	
	    <!-- 이미지가 존재할 때만 출력 -->
	    <c:if test="${not empty feedDetail.feed_img_url}">
	        <img src="${feedDetail.feed_img_url}" alt="Post Image" class="post-image">
	    </c:if>
	
	    <div class="post-text">
	        <p>${feedDetail.feed_text}</p>
	        <span class="post-time">${feedDetail.feed_date}</span>
	    </div>
	
	    <div class="post-actions">
	        <button type="button" class="like-btn" data-feed-id="${feedDetail.feed_id}" data-now-id="${now_id}">
	            <img class="likebtn" src="/whale/static/images/btn/like_btn.png" alt="like" />
	            <span class="like-count">${feedDetail.likeCount}</span>
	        </button>
	        <div class="comments">
	            <img class="commentbtn" src="/whale/static/images/btn/comment_btn.png" alt="comments" />
	            <span class="comment-count">${feedDetail.commentsCount}</span>
	        </div>
	    </div>
	</div>
	
	<div class="comments-section">
		<c:if test="${not empty feedDetail.feedComments}">
	    <c:forEach var="comment" items="${feedDetail.feedComments}">
		    <div class="comment" data-feed-id="${comment.feed_id}" data-comment-id="${comment.feed_comments_id}" data-user-id="${comment.user_id}">
		         <!-- 댓글 헤더 -->
		         <div class="comment-header">
		             <!-- 프로필 사진 -->
		             <a href="adminAccountUserInfo?userId=${comment.user_id}">
		                 <img src="${comment.user_image_url}" alt="User Profile" class="profile-pic">
		             </a>
		             <!-- 아이디와 날짜 -->
		             <div class="comment-meta">
		                 <span class="username">${comment.user_id}</span>
		                 <span class="comment-date">${comment.feed_comments_date}</span>
		             </div>
		             <!-- other_btn -->
		             <button class="comment-other-btn" onclick="feedCommentsDelete('${comment.feed_comments_id}','${feedDetail.feed_id}','${page}','${searchType }','${sk }')">
		                 삭제
		             </button>
		         </div>
		         <!-- 댓글 내용 -->
		         <p class="comment-text">${comment.feed_comments_text}</p>
		         <!-- 좋아요 및 답글 아이콘 -->
		         <div class="comment-actions">
		             <button type="button" class="comment-like-btn" data-comment-id="${comment.feed_comments_id}" data-now-id="${now_id}">
		                 <img class="likebtn" src="/whale/static/images/btn/like_btn.png" alt="like" />
		                 <span class="comment-like-count">${comment.likeCount}</span>
		             </button>
		             <button type="button" class="reply-btn" >
		                 <img class="commentbtn" src="/whale/static/images/btn/comment_btn.png" alt="답글" />
		                 <span class="comment-reply-count">${comment.replyCount}</span>
		             </button>
		         </div>
		         <!-- 답글 표시 -->
		         <c:if test="${not empty comment.replies}">
		             <div class="replies">
		                 <c:forEach var="reply" items="${comment.replies}">
		                     <div class="reply" data-feed-id="${reply.feed_id}" data-comment-id="${reply.feed_comments_id}" data-user-id="${reply.user_id}">
		                         <!-- 답글 헤더 -->
		                         <div class="comment-header">
		                             <!-- 프로필 사진 -->
		                             <a href="adminAccountUserInfo?userId=${reply.user_id}">
		                                 <img src="${reply.user_image_url}" alt="User Profile" class="profile-pic">
		                             </a>
		                             <!-- 아이디와 날짜 -->
		                             <div class="comment-meta">
		                                 <span class="username">${reply.user_id}</span>
		                                 <span class="comment-date">${reply.feed_comments_date}</span>
		                             </div>
		                             <!-- other_btn -->
		                             <button class="comment-other-btn" onclick="feedCommentsDelete('${reply.feed_comments_id}','${feedDetail.feed_id}','${page}','${searchType }','${sk }')">
		                                 삭제
		                             </button>
		                         </div>
		                         <!-- 답글 내용 -->
		                         <p class="comment-text">${reply.feed_comments_text}</p>
		                         <!-- 좋아요 아이콘 -->
		                         <div class="comment-actions">
		                             <button type="button" class="comment-like-btn" data-comment-id="${reply.feed_comments_id}" data-now-id="${now_id}">
		                                 <img class="likebtn" src="/whale/static/images/btn/like_btn.png" alt="like" />
		                                 <span class="comment-like-count">${reply.likeCount}</span>
		                             </button>
		                         </div>
		                     </div>
		                 </c:forEach>
		             </div>
		         </c:if>
		     </div>
		</c:forEach>
		</c:if>
		<c:if test="${empty feedDetail.feedComments}">
			댓글이 없습니다.
		</c:if>
	</div>
<br />
<br />
<br />
</div>

<script type="text/javascript">

function feedDelete(feedId,page,searchType,sk) {
    const deleteConfirm = confirm("피드를 삭제하시겠습니까?");
    if (deleteConfirm) {
    	window.location.href = 
    		"adminBoardFeedContentDelete?feedId="+feedId
    				+"&sk="+sk
    				+"&page="+page
    				+"&searchType="+searchType
    }
}
function feedCommentsDelete(commentId,feedId,page,searchType,sk) {
    const deleteConfirm = confirm("댓글을 삭제하시겠습니까?");
    if (deleteConfirm) {
    	window.location.href = 
    		"adminBoardFeedCommentsContentDelete?commentId="+commentId
    				+"&feedId="+feedId
    				+"&sk="+sk
    				+"&page="+page
    				+"&searchType="+searchType
    }
}

</script>
