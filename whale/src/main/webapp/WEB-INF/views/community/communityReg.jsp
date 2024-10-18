<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="communityRegDo" method="post" enctype="multipart/form-data">
	<br />
		태그 : <select name = "post_tag_id">
<c:forEach items="${postTag}" var="p">
	<option value = "${p.post_tag_id}">${p.post_tag_text}</option>
</c:forEach>
			</select>
	    커뮤니티 : <input type="text" name="community_name" value="${communityName}" readonly />
	    <br />
	
	    <!-- 실제로 전송할 커뮤니티 ID는 숨김 필드로 설정 -->
	    <input type="hidden" name="community_id" value="${communityId}" />
	
	    <br />
		제목 : <input type="text" name="post_title" /> <br />
		<br />
		글쓴이 : <input type="text" name="user_id" value="${now_id}" readonly /><br />
		<br />
		내용 : 
		<textarea name="post_text" id="post_text" class="content">텍스트를 입력해주십시오.</textarea> <br />
		<br />
		<td>첨부</td>
		<td><input multiple type="file" name="file" size="50" /></td> <!-- type이 multiple type이면 파일 2개 선택 가능 -->
		<input type="submit" value="Save" />
		<input type="button" value="Cancel" class="cancel" onClick="location.href='communityPost?c=${param.c}'" />
	</form>
</body>
</html>