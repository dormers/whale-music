<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>blockList</title>
<link rel="stylesheet" href="static/css/setting/settingStyle.css" />
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="static/js/setting/setting.js"></script>
<style>
.setting-item{
	justify-content: space-between;
}
.setting-item img{
	width: 40px;
	height: 40px;
}
.profile-info{
	display: flex;
	align-items: center;
}
.profile-info img{
	border-radius: 50%;
	margin-right: 10px;
}
.user-details{
	display: flex;
	flex-direction: column;
	font-size: 14px;
}
.unblock-button{
	background-color: #121212;
	color: white;
	border: none;
	padding: 5px 10px;
	border-radius: 4px;
	cursor: pointer;
}
.unblock-button:hover{
	background-color: #ccc;
}
#user-nickname{
	font-weight: bold;
	margin-bottom: 3px;
}
.no-block-message{
	margin-left: 5px;
	margin-top: 5px;
	color: #ccc;
}
</style>
</head>
<body>
<div class="setting-body">
	<div class="setting-container">
		<div class="setting-header">차단 목록</div>
		<c:choose>
			<c:when test="${empty blockList }">
				<div class="no-block-message">차단 목록이 없습니다.</div>
			</c:when>
			<c:otherwise>
				<!-- 차단된 사용자 목록 출력 -->
			    <%-- <c:forEach var="block" items="${blockList}"> --%>
			        <div class="setting-item">
			        	<div class="profile-info">
				        	<!-- 프로필 이미지 누르면 그 사람의 프로필 페이지로 이동하도록 설정 -->
				        	<a href="#####"><img src="static/images/setting/${blockList.user_image_url}" alt="프로필 이미지" /> </a>
				        	<div class="user-details">
				        		<span id="user-nickname">${blockList.user_nickname }</span>
				        		<span>${blockList.user_id}</span>
				        	</div>
				        </div>
				        <!-- 클릭이벤트로 보낼 때, 클릭된 사용자의 user_id(차단된 사용자)를 같이 전달 -->
				        <button class="unblock-button" onclick="blockcancel('${blockList.user_id}');">차단 해제</button>
				    </div>
			   <%--  </c:forEach> --%>
			</c:otherwise>
		</c:choose>
	</div>
</div>
<script>
	window.onload = function() {
		let buttons = document.querySelectorAll('.unblock-button');
		
		buttons.forEach(function(button) {
			button.addEventListener("mousedown", function() {
				this.style.backgroundColor = "gray";
				this.style.color = "block";
			});
			button.addEventListener("mouseup", function() {
				this.style.backgroundColor = "#ccc";
				this.style.color = "white";
			});
		});
	}

	function blockcancel(user_id) {
		console.log("차단 해제 요청: ", user_id); // 확인용
		
		// AJAX 요청을 통해 차단 해제
		$.ajax({
			url: '/whale/unblockUser', // 서버에서 처리할 URL
			type: 'POST',
			data: { user_id: user_id }, // user_id를 데이터로 전송
			success: function(response) {
				console.log("응답: ", response.message);
				// 요청 성공하면 blockList 페이지를 다시 호출
				window.location.href = '/whale/blockList';
			},
			error: function(xhr, status, error) {
				console.error('차단 해제 실패', error);
				console.log(xhr.responseText); // 오류 메시지 확인
			}
		});
	}
</script>
</body>
</html>