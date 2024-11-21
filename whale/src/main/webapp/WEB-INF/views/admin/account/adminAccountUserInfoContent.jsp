<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="content" name="content" id="content">
	<h1>유저상세</h1>
	<table class="userInfo">
		<tr>
			<td rowspan="9" class="proImg" style="width: 40%;">
				<div>
					<c:if test="${not empty AccountUserInfo.user_image_url }">
						<img src="${AccountUserInfo.user_image_url }" alt="프사" />
					</c:if>
					<c:if test="${empty AccountUserInfo.user_image_url }">
						null
					</c:if>
				</div>
			</td>
			<td style="width: 10%;">아이디</td>
			<td style="width: 50%;">${AccountUserInfo.user_id }</td>
		</tr>
		<tr>
			<td>닉네임</td>
			<td>${AccountUserInfo.user_nickname }</td>
		</tr>
		<tr>
			<td>이메일</td>
			<td>${AccountUserInfo.user_email }</td>
		</tr>
		<tr>
			<td>가입일</td>
			<td><fmt:formatDate value="${AccountUserInfo.user_date}" pattern="yyyy.MM.dd" /></td>
		</tr>
		<tr>
			<td>등급</td>
			<td>${AccountUserInfo.user_access_str }</td>
		</tr>
		<tr>
			<td>계정상태</td>
			<td>${AccountUserInfo.user_status_str }</td>
		</tr>
		<tr>
			<td>게시글</td>
			<td>${AccountUserInfo.post_count }</td>
		</tr>
		<tr>
			<td>피드</td>
			<td>${AccountUserInfo.feed_count }</td>
		</tr>
		<tr>
			<td>댓글</td>
			<td>${AccountUserInfo.comments_count }</td>
		</tr>
	</table>
	<h1>최근활동</h4>
	<h2>게시글</h2>
	<table id="postList" style="border-top: 1px solid #999;">
		<tr>
			<th>번호</th>
			<th>커뮤니티</th>
			<th>제목</th>
			<th>등록일</th>
			<th>조회수</th>
		</tr>
		<c:if test="${empty AccountUserPostList}">
		    <tr>
		        <td colspan="5" align="center">결과가 없습니다.</td>
		    </tr>
		</c:if>
		<c:if test="${not empty AccountUserPostList}">
        <c:forEach items="${AccountUserPostList }" var="dto" >
			<tr>
				<td>${dto.post_id }</td>
				<td>${dto.community_name }</td>
				<td>${dto.post_title }</td>
				<td><fmt:formatDate value="${dto.post_date }" pattern="yyyy.MM.dd" /></td>
				<td>${dto.post_cnt }</td>
			</tr>
		</c:forEach>
		</c:if>
	</table>
	<hr />
	<h2>피드</h2>
	<table id="feedList" style="border-top: 1px solid #999;">
		<tr>
			<th>번호</th>
			<th>내용</th>
			<th>등록일</th>
		</tr>
		<c:if test="${empty AccountUserFeedList}">
		    <tr>
		        <td colspan="3" align="center">결과가 없습니다.</td>
		    </tr>
		</c:if>
		<c:if test="${not empty AccountUserFeedList}">
        <c:forEach items="${AccountUserFeedList }" var="dto" >
			<tr>
				<td>${dto.feed_id }</td>
				<td>${dto.feed_text }</td>
				<td><fmt:formatDate value="${dto.feed_date }" pattern="yyyy.MM.dd" /></td>
			</tr>
		</c:forEach>
		</c:if>
	</table>
	<hr />
	<h2>댓글</h2>
	<table id="commentList" style="border-top: 1px solid #999;">
		<tr>
			<th>커뮤니티/피드</th>
			<th>번호</th>
			<th>내용</th>
			<th>등록일</th>
		</tr>
		<c:if test="${empty AccountUserCommentsList}">
		    <tr>
		        <td colspan="4" align="center">결과가 없습니다.</td>
		    </tr>
		</c:if>
		<c:if test="${not empty AccountUserCommentsList}">
	        <c:forEach items="${AccountUserCommentsList }" var="dto" >
	        	<c:if test="${dto.feed_comments_id !=0 && not empty dto.feed_comments_id}">
		        	<tr>
						<td>피드</td>
						<td>${dto.feed_comments_id }</td>
						<td>${dto.feed_comments_text }</td>
						<td><fmt:formatDate value="${dto.comments_date }" pattern="yyyy.MM.dd" /></td>
					</tr>
	        	</c:if>
	        	<c:if test="${dto.post_comments_id != 0 && not empty dto.post_comments_id}">
				<tr>
					<td>커뮤니티</td>
					<td>${dto.post_comments_id }</td>
					<td>${dto.post_comments_text }</td>
					<td><fmt:formatDate value="${dto.comments_date }" pattern="yyyy.MM.dd" /></td>
				</tr>
				</c:if>
			</c:forEach>
		</c:if>
	</table>
	<br /><br /><br /><br />	
</div>