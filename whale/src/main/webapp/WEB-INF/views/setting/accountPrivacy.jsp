<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>accountPrivacy</title>
<link rel="stylesheet" href="static/css/setting/settingStyle.css" />
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="static/js/setting/setting.js"></script>
<style>
	.setting-item{
		justify-content: space-between; /* 요소 사이에 공간을 균등하게 배분 */
	}
	#toggle-slide {
		display: none;
	}
	label {
		width: 50px;
		height: 25px;
		background-color: #808080; /* 초기 배경색 */
		text-indent: -9999px;
		border-radius: 25px;
		position: relative;
		cursor: pointer;
		transition: 0.5s;
	}
	label::after {
		content: '';
		position: absolute;
		width: 17px;
		height: 17px;
		background-color: #e5e5e5;
		border-radius: 25px;
		top: 4px;
		left: 4px;
		transition: 0.5s;
	}	
	#toggle-slide:checked + label {
		background-color: black; /* 토글 선택 시 배경색 변경 */
	}
	#toggle-slide:checked + label::after {
		left: 29px;
	}
</style>
</head>
<body>
<div class="setting-body">
	<div class="setting-container">
		<div class="setting-header">계정 공개범위</div>
		<div class="setting-item">
			비공개 계정
			<input type="checkbox" id="toggle-slide" />
			<label for="toggle-slide">on/off</label>
		</div>
	</div>
</div>
<script>
	// JSP에서 서버로부터 받아온 비공개 계정 설정 값을 자바스크립트 변수로 전달
	var accountPrivacyOn = ${accountPrivacyOn};

	window.onload = function() {
		// 비공개 계정이 1이면 토글 버튼을 선택된 상태로 표현
		document.getElementById('toggle-slide').checked = accountPrivacyOn == 1;
	};

	document.getElementById('toggle-slide').addEventListener('change', function() {
		let accountPrivacy = this.checked ? 1 : 0; // 토글 상태에 따라 1 또는 0 설정
		
		// AJAX 요청
		const xhr = new XMLHttpRequest();
		xhr.open('POST', '/whale/updatePrivacy', true); // 서버에 POST 요청을 보냄
		xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded'); // 전송할 데이터 형식 설정
		
		// 서버로 데이터 전송
		xhr.send('account_privacy=' + accountPrivacy); 
		
		// 서버 응답 처리
		xhr.onreadystatechange = function() {
			if(xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200) {
				console.log('Privacy setting updated successfully');
			}
		};
	});
</script>
</body>
</html>
