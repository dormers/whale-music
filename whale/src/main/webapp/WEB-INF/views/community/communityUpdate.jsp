<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Post</title>
</head>
<body>
    
    <form action="communityUpdateDo" method="post" enctype="multipart/form-data">
	    <!-- 포스트 아이디 전달 -->
	    <input type="hidden" name="post_id" value="${post.post_id}" />
	    
	    커뮤니티 : 
	        <input type="text" name="community_name" value="${communityName}" readonly />
	        <br />
	
	        <!-- 실제로 전송할 커뮤니티 ID는 숨김 필드로 설정 -->
	        <input type="hidden" name="community_id" value="${communityId}" />
	        <br />
	    
	    <!-- 태그 선택 -->
	    태그: <select name="post_tag_id">
	        <c:forEach items="${postTag}" var="tag">
	            <option value="${tag.post_tag_id}" ${tag.post_tag_id == post.post_tag_id ? 'selected' : ''}>
	                ${tag.post_tag_text}
	            </option>
	        </c:forEach>
	    </select> <br />

	    <!-- 제목 -->
	    제목: <input type="text" name="post_title" value="${post.post_title}" /> <br />
	    
	   	글쓴이 : 
	        <input type="text" name="user_id" value="${now_id}" readonly />
	        <br /><br />
	    
	    <!-- 내용 -->
	    내용: <textarea name="post_text">${post.post_text}</textarea> <br />
	    
	    
		<div id="existing-images">
		    <c:forEach items="${post.images}" var="image">
		        <div class="image-item" id="image-${image.post_img_id}">
		            <img src="static/images/community/${image.post_img_name}" alt="${image.post_img_name}" width="100" height="100"/>
		            <button type="button" onclick="deleteImage(${image.post_img_id})">이미지 삭제</button>
		        </div>
		    </c:forEach>
		</div>
	
	    <!-- 삭제할 이미지 ID들을 담을 숨은 필드 -->
	    <input type="hidden" id="deletedImages" name="deletedImages" />
	
	    <!-- 새로운 이미지 업로드 필드 -->
	    <label>새 이미지 추가:</label>
	    <input type="file" name="file" multiple /><br />
	    
	    <input type="submit" value="업데이트" />
	</form>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
	// 이미지 삭제 함수
	function deleteImage(imageId) {
	    if (confirm("정말로 이미지를 삭제하시겠습니까?")) {
	        // Ajax 요청 보내기
	        $.ajax({
	            url: 'deleteImage', // 서버에서 이미지 삭제를 처리할 URL
	            type: 'POST',
	            data: { imageId: imageId },
	            success: function(response) {
	                if (response.success) {
	                    // 삭제 성공 시 DOM에서 해당 이미지와 버튼을 삭제
	                    $('#image-' + imageId).remove();
	                    console.log("이미지 삭제 성공:", imageId);
	                } else {
	                    console.log("이미지 삭제 실패:", imageId);
	                }
	            },
	            error: function(xhr, status, error) {
	                console.error("Ajax 요청 실패:", error);
	            }
	        });
	    }
	}
	</script>
	
</body>
</html>