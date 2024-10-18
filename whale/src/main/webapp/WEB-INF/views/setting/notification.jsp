<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>notification</title>
<link rel="stylesheet" href="static/css/setting/settingStyle.css" />
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="static/js/setting/setting.js"></script>
<style>
    .setting-item{
        justify-content: space-between; /* 요소 사이에 공간을 균등하게 배분 */
    }
    .toggle-slide {
        display: none; /* 체크박스를 숨김 */
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
        background-color: #e5e5e5; /* 슬라이더 기본 색상 */
        border-radius: 25px; /* 원형 슬라이더 */
        top: 4px;
        left: 4px;
        transition: 0.5s;
    }
    .toggle-slide:checked + label {
        background-color: black; /* 토글 ON 상태일 때 배경색 */
    }
    .toggle-slide:checked + label::after {
        left: 29px; /* 토글 ON 상태일 때 슬라이더 이동 */
    }
</style>
</head>
<body>
<div class="setting-body">
	<div class="setting-container">
	    <div class="setting-header">알림</div>
	    <div class="setting-item">
	        모든 알림 해제
	        <input type="checkbox" id="toggle-slide-1" class="toggle-slide" />
	        <label for="toggle-slide-1"></label>
	    </div>
	    <div class="setting-item">
	        좋아요
	        <input type="checkbox" id="toggle-slide-2" class="toggle-slide" />
	        <label for="toggle-slide-2"></label>
	    </div>
	    <div class="setting-item">
	        댓글
	        <input type="checkbox" id="toggle-slide-3" class="toggle-slide" />
	        <label for="toggle-slide-3"></label>
	    </div>
	    <div class="setting-item">
	        메시지
	        <input type="checkbox" id="toggle-slide-4" class="toggle-slide" />
	        <label for="toggle-slide-4"></label>
	    </div>
	</div>
</div>
<script>
	// JSP에서 서버로부터 받은 알림 설정 값을 자바스크립트 변수로 전달
	var allNotificationOff= ${allNotificationOff};
	var likeNotificationOn = ${likeNotificationOn};
	var commentNotificationOn = ${commentNotificationOn};
	var messageNotificationOn = ${messageNotificationOn};


	// 페이지가 로드될 때 기본 값 설정
	window.onload = function() {
		// 모든 알림 해제가 1이면 토글 버튼을 선택된 상태로 표현
		document.getElementById('toggle-slide-1').checked = allNotificationOff == 1;
		document.getElementById('toggle-slide-2').checked = likeNotificationOn == 1;
		document.getElementById('toggle-slide-3').checked = commentNotificationOn == 1;
		document.getElementById('toggle-slide-4').checked = messageNotificationOn == 1;
	};

	document.getElementById('toggle-slide-1').addEventListener('change', function() {
	    let allNotificationOff = this.checked ? 1 : 0;
	
	    // AJAX 요청
	    const xhr = new XMLHttpRequest();
	    xhr.open('POST', '/whale/updateNotifications', true); // 서버에 POST 요청 보냄
	    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	
	    // 서버로 데이터 전송
	    xhr.send('all_notification_off=' + allNotificationOff + '&like_notification_onoff=0&comment_notification_onoff=0&message_notification_onoff=0');
	
	    xhr.onreadystatechange = function() {
	        if (xhr.readyState === XMLHttpRequest.DONE) {
	            if (xhr.status === 200) {
	                console.log('Notification settings updated in DB.');
	            } else {
	                console.error('Error updating notification settings. Status:', xhr.status, 'Response:', xhr.responseText);
	            }
	        }
	    };
	
	    if (allNotificationOff) {
	        console.log('모든 알림 해제 ON');
	        
	        // 아래 세 개의 알림을 OFF 상태로 설정하고 비활성화
	        document.getElementById('toggle-slide-2').checked = false;
	        document.getElementById('toggle-slide-3').checked = false;
	        document.getElementById('toggle-slide-4').checked = false;
	
	        document.getElementById('toggle-slide-2').disabled = true;
	        document.getElementById('toggle-slide-3').disabled = true;
	        document.getElementById('toggle-slide-4').disabled = true;
	    } else {
	        console.log('모든 알림 해제 OFF');
	        document.getElementById('toggle-slide-2').disabled = false;
	        document.getElementById('toggle-slide-3').disabled = false;
	        document.getElementById('toggle-slide-4').disabled = false;
	    }
	});
	
	function updateIndividualNotification(notificationType, isOn) {
		const xhr = new XMLHttpRequest();
		xhr.open('POST', '/whale/updateIndividualNotification', true);
		xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
		xhr.send(notificationType + "=" + (isOn ? 1 : 0));
		
		xhr.onreadystatechange = function() {
			if(xhr.readyState === XMLHttpRequest.DONE) {
				if(xhr.status === 200) {
					console.log(notificationType + ' setting updated in DB.');
				} else {
					console.error('Error updating ' + notificationType + ' setting. Status:', xhr.status, 'Response:', xhr.responseText);
				}
			}
		};
	}
	
	document.getElementById('toggle-slide-2').addEventListener('change', function() {
		updateIndividualNotification('like_notification_onoff', this.checked);
	});
	document.getElementById('toggle-slide-3').addEventListener('change', function() {
		updateIndividualNotification('comment_notification_onoff', this.checked);
	});
	document.getElementById('toggle-slide-4').addEventListener('change', function() {
		updateIndividualNotification('message_notification_onoff', this.checked);
	});
</script>
</body>
</html>
