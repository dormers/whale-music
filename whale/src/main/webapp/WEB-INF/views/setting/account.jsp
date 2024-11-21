<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>account</title>
<link rel="stylesheet" href="static/css/setting/settingStyle.css" />
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="static/js/setting/setting.js"></script>
<script src="static/js/setting/darkMode.js"></script>
<style>
	a { text-decoration: none; color: black; }
	a:visited, a:hover, a:focus, a:active { color: black; text-decoration: none; }
	.setting-item { margin-top: 3px; margin-bottom: 3px; }
	#back { position: absolute; left: 15px; top: 55%; transform: translateY(-50%); }
</style>
</head>
<body>
<div class="setting-body">
	<div class="setting-container">
		<div class="setting-header">
			<a href="settingHome" id="back"><img src="static/images/setting/back.png" alt="back"></a>
			계정</div>
		<div class="setting-grid">
			<a href="profileEdit">
				<div class="setting-item">
					<div class="setting-item-text">
						<p>프로필 편집</p>
						<p class="sub-text">profile edit</p>
					</div>
				</div>
			</a>
			<a href="accountPrivacy">
				<div class="setting-item">
					<div class="setting-item-text">
						<p>계정 공개범위</p>
						<p class="sub-text">account public range</p>
					</div>
				</div>
			</a>
			<a href="deleteAccount">
				<div class="setting-item">
					<div class="setting-item-text">
						<p>회원 탈퇴</p>
						<p class="sub-text">delete account</p>
					</div>
				</div>
			</a>
		</div>
	</div>
</div>
</body>
</html>