<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${communityName}</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@400;600&display=swap">
<style>
    html, body {
        font-family: 'Noto Sans', sans-serif;
        background-color: #FFFFFF; /* 배경을 흰색으로 */
        color: #000000; /* 글자를 검정색으로 */
        margin: 0;
        padding: 20px;
    }

    h2 {
        color: #000000;
    }

    .community-link {
        color: #000000; /* 검정색으로 고정 */
        text-decoration: none; /* 밑줄 없애기 */
    }

    .community-link:hover {
        color: #000000; /* 마우스를 올려도 검정색 고정 */
        text-decoration: none; /* 호버 시에도 밑줄 없애기 */
    }

    table {
        width: 100%;
        border-collapse: collapse;
        background-color: #F8F8F8; /* 테이블 배경을 밝은 회색으로 */
        border: 1px solid #D0D0D0;
        margin-top: 20px;
        border-radius: 8px;
    }

    th, td {
        padding: 12px;
        text-align: left;
        border-bottom: 1px solid #D0D0D0;
        color: #000000;
    }

    th {
        background-color: #E0E0E0;
        font-weight: 600;
    }

    tr:nth-child(even) {
        background-color: #F0F0F0;
    }

    a {
        color: #000000; /* 링크도 검정색으로 */
        text-decoration: none;
        font-weight: 600;
        margin-right: 10px;
    }

    a:hover {
        text-decoration: underline;
    }

    .btn {
        padding: 10px 20px;
        background-color: #000000; /* 버튼 배경을 검정색으로 */
        color: #FFFFFF; /* 글자를 흰색으로 */
        border: none;
        border-radius: 8px;
        text-decoration: none;
        font-weight: 600;
        transition: background-color 0.3s;
        margin-top: 20px;
        display: inline-block;
    }

    .btn:hover {
        background-color: #333333; /* 버튼 호버 시 약간 더 밝게 */
    }
</style>
</head>
<body>
    <h2><a href="communityPost?c=${param.c}" class="community-link">" ${communityName} "</a></h2>
    
    <table class="table">
        <colgroup>
            <col width="15%" />
            <col width="35%" />
            <col width="15%" />
            <col width="35%" />
        </colgroup>
        <tbody>
            <tr>
                <th>태그</th>
                <td>${postDetail.post_tag_text }</td>
                <th>작성자</th>
                <td>${postDetail.user_id }</td>
            </tr>
            <tr>
                <th>조회수</th>
                <td>${postDetail.post_cnt }</td>
                <th>등록일</th>
                <td>${postDetail.post_date }</td>
            </tr>
            <tr>
                <th>제목</th>
                <td colspan="3">${postDetail.post_title }</td>
            </tr>
            <tr>
                <th>내용</th>
                <td colspan="3">${postDetail.post_text }</td>
            </tr>
			<tr>
			    <th>이미지</th>
			    <td colspan="3">
			        <c:forEach var="image" items="${postDetail.images}">
			        	<img src="static/images/community/${image.post_img_name}" alt="Post Image">
			        </c:forEach>
			    </td>
			</tr>
        </tbody>
    </table>
	<br />
	<form action="communityDetail/like" method="post">
	    <input type="hidden" name="postId" value="${postDetail.post_id}">
	    <input type="hidden" name="userId" value="kim">
	    <input type="hidden" name="c" value="${param.c}"> <!-- 커뮤니티 ID -->
	    <button type="submit">좋아요</button>
		<span id="likeCount">${postDetail.likeCount}</span> <!-- 좋아요 수 표시 -->
	</form>
    <c:if test="${postDetail.user_id eq now_id}">
        <a href="communityUpdate?c=${param.c }&p=${postDetail.post_id }" class="btn">수정</a>
        <a href="communityDetailDel?c=${param.c }&p=${postDetail.post_id }" class="btn">삭제</a>
    </c:if>

    <a href="communityPost?c=${param.c }" class="btn">목록</a>

<table class="table">
    <colgroup>
        <col style="width: 15%;"> <!-- 작성자 칸 -->
        <col style="width: 55%;"> <!-- 코멘트 칸 (넓게) -->
        <col style="width: 20%;"> <!-- 날짜 칸 (좁게) -->
        <col style="width: 10%;"> <!-- 관리 칸 -->
    </colgroup>
    <thead>
        <tr>
            <th>작성자</th>
            <th>코멘트</th>
            <th>작성일</th>
            <c:if test= "${comment.user_id eq now_id}">
	            <th>관리</th>
			</c:if>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="comment" items="${postDetail.comments}">
            <tr>
                <td>${comment.user_id}</td> <!-- 작성자 열 -->
                <td>${comment.post_comments_text}</td> <!-- 코멘트 열 -->
                <td>${comment.post_comments_date}</td> <!-- 작성일 열 -->
                <td>
                    <form action="communityDetail/deleteComment" method="post">
                        <input type="hidden" name="postCommentsId" value="${comment.post_comments_id}" />
                        <input type="hidden" name="postId" value="${postDetail.post_id}" />
                        <input type="hidden" name="communityId" value="${param.c}" />
                        <c:if test= "${comment.user_id eq now_id}">
	                        <button type="submit">삭제</button>
						</c:if>
                    </form>
                </td> <!-- 관리(삭제) 열 -->
            </tr>
        </c:forEach>

        <!-- 코멘트 입력 폼 -->
        <tr>
            <td>${now_id}</td> <!-- 작성자 열 -->
            <td>
                <form action="communityDetail/comments" method="post">
                    <input type="hidden" name="postId" value="${postDetail.post_id}">
                    <input type="hidden" name="userId" value="${now_id}">
                    <input type="hidden" name="c" value="${param.c}"> <!-- 커뮤니티 ID -->
                    <input type="text" name="comments" id="comment" style="width: 80%;">
                    <button type="submit" class="btn">입력</button>
                </form>
            </td> <!-- 코멘트 입력 열 -->
            <td colspan="2"></td> <!-- 작성일 및 관리 열은 비워둠 -->
        </tr>
    </tbody>
</table>
	
	<!-- 코멘트 입력 폼 -->
</body>
</html>
