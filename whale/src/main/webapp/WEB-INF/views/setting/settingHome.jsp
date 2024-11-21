<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>settingHome</title>
<link rel="stylesheet" href="static/css/setting/settingStyle.css" />
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="static/js/setting/setting.js"></script>
<script src="static/js/setting/darkMode.js"></script>
<style>
a { text-decoration: none; color: black; }
a:visited, a:hover, a:focus, a:active { color: black; text-decoration: none; }
</style>
</head>
<body>
	<div class="setting-body">
		<div class="setting-container">
			<div class="setting-header">환경설정</div>
			<div class="setting-grid">
				<a href="account">
					<div class="setting-item">
						<img src="static/images/setting/account.png" alt="계정" />
						<div class="setting-item-text">
							<p>계정</p>
							<p class="sub-text">account</p>
						</div>
					</div>
				</a>
				<a href="hiddenFeed">
					<div class="setting-item">
						<img src="static/images/setting/archive1.png" alt="보관" />
						<div class="setting-item-text">
							<p>보관</p>
							<p class="sub-text">storage</p>
						</div>
					</div>
				</a>
				<a href="activity">
					<div class="setting-item">
						<img src="static/images/setting/activity.png" alt="활동" />
						<div class="setting-item-text">
							<p>활동</p>
							<p class="sub-text">activity</p>
						</div>
					</div>
				</a>
				<a href="notification">
					<div class="setting-item">
						<img src="static/images/setting/notification.png" alt="알림" />
						<div class="setting-item-text">
							<p>알림</p>
							<p class="sub-text">notification</p>
						</div>
					</div>
				</a>
				<a href="accessibility">
					<div class="setting-item">
						<img src="static/images/setting/accessibility.png" alt="접근성" />
						<div class="setting-item-text">
							<p>접근성</p>
							<p class="sub-text">accessibility</p>
						</div>
					</div>
				</a>
			</div>
		</div>
	</div>
</body>
</html>