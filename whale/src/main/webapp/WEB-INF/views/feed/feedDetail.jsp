<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Feed Detail</title>
    <style>
        /* 기존 feedHome 페이지와 동일한 스타일 사용 */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f0f0;
        }

        .post {
            position: relative;
            background-color: white;
            width: 90%;
            max-width: 600px;
            margin: 20px auto;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 15px;
        }

        .user-info {
            display: flex;
            align-items: center;
        }

        .profile-pic {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
        }

        .username {
            font-weight: bold;
            font-size: 1.2em;
        }

        .post-image {
            width: 100%;
            height: auto;
            margin: 10px 0;
            border-radius: 10px;
        }

        .post-actions {
            display: flex;
            justify-content: space-around;
            margin-top: 10px;
            font-size: 1em;
        }

        .post-text {
            margin-top: 10px;
        }

        .post-time {
            font-size: 0.8em;
            color: gray;
        }

        /* 게시글 삭제 아이콘 버튼 */
        .delete-post-btn {
            position: absolute;
            top: 25px;
            right: 10px;
            background: none;
            border: none;
            cursor: pointer;
        }

        .delete-post-btn img {
            width: 25px;
            height: 25px;
        }

        /* 댓글 스타일 */
        .comments-section {
            margin-top: 30px;
            padding: 15px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 90%;
            max-width: 600px;
            margin: 20px auto;
        }

        .comment {
            display: flex;
            padding: 10px 0;
            border-bottom: 1px solid #e0e0e0;
        }

        .comment:last-child {
            border-bottom: none;
        }

        .comment .profile-pic {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            margin-right: 10px;
        }

        .comment-info {
            display: flex;
            flex-direction: column;
        }

        .comment-info .username {
            font-size: 0.9em;
            font-weight: bold;
            margin-top: 5px;
        }

        .comment .comment-text {
            flex-grow: 1;
        }

        .comment .comment-date {
            font-size: 0.8em;
            color: gray;
        }

        .comment-form {
            display: flex;
            align-items: center;
            margin-top: 10px;
        }

        .comment-form input[type="text"] {
            flex-grow: 1;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-right: 10px;
        }

        .comment-form button {
            padding: 8px 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        /* 댓글 삭제 아이콘 버튼 */
        .delete-comment-btn {
            background: none;
            border: none;
            cursor: pointer;
        }

        .delete-comment-btn img {
            width: 20px;
            height: 20px;
        }
    </style>
</head>
<body>

    <div class="post">
        <div class="user-info">
            <a href="profileHome?u=${feedDetail.user_id}">
                <img src="static/images/setting/${feedDetail.user_image_url}" alt="User Profile" class="profile-pic">
            </a>
            <span class="username">${feedDetail.user_id}</span>
        </div>

        <!-- 게시글 삭제 아이콘 (작성자에게만 표시) -->
        <c:if test="${feedDetail.user_id eq now_id}">
            <button class="delete-post-btn" onclick="location.href='feedDel?f=${feedDetail.feed_id}'">
                <img src="static/images/setting/delete_button.png" alt="Delete Button">
            </button>
        </c:if>

        <!-- 이미지가 존재할 때만 출력 -->
        <c:if test="${not empty feedDetail.feed_img_name}">
            <img src="static/images/feed/${feedDetail.feed_img_name}" alt="Post Image" class="post-image">
        </c:if>

        <div class="post-text">
            <p>${feedDetail.feed_text}</p>
            <span class="post-time">${feedDetail.feed_date}</span>
        </div>
        <div class="post-actions">
            <button type="button" class="like-btn" data-feed-id="${feedDetail.feed_id}" data-now-id="${now_id}">
                ❤ <span class="likes">${feedDetail.likeCount}</span>
            </button>
            <span class="comments">💬 ${feedDetail.commentsCount}</span>
        </div>
    </div>

    <!-- 댓글 섹션 -->
    <div class="comments-section">
        <h3>댓글</h3>
        <c:forEach var="comment" items="${feedDetail.feedComments}">
            <div class="comment">
                <a href="profileHome?u=${comment.user_id}"><img src="static/images/setting/${comment.user_image_url}" alt="User Profile" class="profile-pic"></a>
                <div class="comment-info">
                    <span class="username">${comment.user_id}</span>  <!-- 아이디를 사진 아래에 위치 -->
                    <p>${comment.feed_comments_text}</p>
                </div>
                <div style="display: flex; flex-direction: column; align-items: flex-end; margin-left: auto;">
                    <c:if test="${comment.user_id eq now_id}">
                        <form action="feedDetail/deleteComment" method="post" style="margin: 0;">
                            <input type="hidden" name="feedCommentsId" value="${comment.feed_comments_id}" />
                            <input type="hidden" name="feedId" value="${feedDetail.feed_id}" />
                            <button type="submit" class="delete-comment-btn">
                                <img src="static/images/setting/delete_button.png" alt="Delete Button">
                            </button>
                        </form>
                    </c:if>
                    <div class="comment-date" style="font-size: 0.8em; color: gray; margin-top: 5px;">${comment.feed_comments_date}</div>
                </div>
            </div>
        </c:forEach>

        <!-- 코멘트 입력 폼 -->
        <div class="comment-form">
            <form action="feedDetail/comments" method="post">
                <input type="hidden" name="feedId" value="${feedDetail.feed_id}">
                <input type="hidden" name="userId" value="${now_id}">
                <input type="text" name="comments" placeholder="댓글을 입력하세요" />
                <button type="submit" class="btn">입력</button>
            </form>
        </div>
    </div>

    <script>
        // 좋아요 처리 로직
        document.querySelector('.like-btn').addEventListener('click', function() {
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
                    this.querySelector('.likes').textContent = data.newLikeCount;
                } else {
                    alert("좋아요 처리에 실패했습니다.");
                }
            })
            .catch(error => console.error('Error:', error));
        });
    </script>

</body>
</html>