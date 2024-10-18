<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>startpageSetting</title>
<link rel="stylesheet" href="static/css/setting/settingStyle.css" />
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="static/js/setting/setting.js"></script>
<style>
.setting-item{
    padding: 20px 0px;
    border-bottom: none;
    justify-content: space-between;
}
.option{
	text-align: left;
	flex: 1; /* 두 option을 동일한 크기도 만듦 */
	margin: 0 20px;
}
.option img{
	width: 270px;
	height: 270px;
	max-width: 100%;
	max-height: 270px;
	object-fit: contain;
}
.radio-group{
	display: flex;
	flex-direction: column;
}
.radio-group label{
	margin-bottom: 5px;
}
.leftright{
	margin-bottom: 5px;
	font-weight: bold;
}
input[type='radio'] {
	/* 기본스타일 지우고 라디오 버튼 구현 */
	-webkit-appearance: none; /* 웹킷 브라우저에서 기본 스타일 제거  */
	-moz-appearance: none; /* 모질라 브라우저에서 기본 스타일 제거 */
	appearance: none; /* 기본 브라우저에서 기본 스타일 제거 */
	width: 13px;
	height: 13px;
	border: 1px solid #ccc; /* 체크되지 않았을 때의 테두리 색상 */
	border-radius: 50%;
	outline: none; /* focus 시에 나타나는 기본 스타일 제거 */
	cursor: pointer; 
	margin-right: 7px;
}
input[type='radio']:checked {
	background-color: black; /* 체크 시 내부 원으로 표시될 색상 */
	border: 3px solid #ccc; /* 테두리와 원 사이의 색상 */
	box-shadow: 0 0 0 1.6px black; /* 테두리, 그림자로 테두리를 직접 만들어야 함 (퍼지는 정도를 0으로 주면 테두리처럼 보임, 그림자가 없으면 그냥 설정한 색상이 꽉 찬 원으로 나옴) */
}
</style>
</head>
<body>
<div class="setting-body">
	<div class="setting-container">
		<div class="setting-header">시작페이지 설정</div>
			<div class="setting-item">
				<div class="option">
					<div class="leftright" >left</div>
					<img src="static/images/setting/music.png" alt="left_image" />
					<div class="radio-group">
						<label><input type="radio" id="left-music" name="left" value="music" />음악</label>
						<label><input type="radio" id="left-feed" name="left" value="feed"/>피드</label>
						<label><input type="radio" id="left-community" name="left" value="community"/>커뮤니티</label>
						<label><input type="radio" id="left-message" name="left" value="message"/>메시지</label>
					</div>
				</div>
				<div class="option">
					<div class="leftright">right</div>
					<img src="static/images/setting/music.png" alt="right_image" />
					<div class="radio-group">
						<label><input type="radio" id="right-music" name="right" value="music"/>음악</label>
						<label><input type="radio" id="right-feed" name="right" value="feed" />피드</label>
						<label><input type="radio" id="right-community" name="right" value="community"/>커뮤니티</label>
						<label><input type="radio" id="right-message" name="right" value="message"/>메시지</label>
					</div>
				</div>
			</div>
	</div>
</div>
<script>
	var music = ${music};
	var feed = ${feed};
	var community = ${community};
	var message = ${message};
	
	window.onload = function() {
		document.getElementById('left-music').checked = music == 1;
		document.getElementById('left-feed').checked = feed == 1;
		document.getElementById('left-community').checked = community == 1;
		document.getElementById('left-message').checked = message == 1;
		document.getElementById('right-music').checked = music == 2;
		document.getElementById('right-feed').checked = feed == 2;
		document.getElementById('right-community').checked = community == 2;
		document.getElementById('right-message').checked = message == 2;
		
		document.querySelector('.setting-container').addEventListener('change', function(event) {
			if(event.target.name === 'left' || event.target.name === 'right') {
				updateStartpageSetting();
			}
		});
	}
	
	function updateStartpageSetting(selectedValue, position) {
		const leftValue = document.querySelector('input[name="left"]:checked').value;
		const rightValue = document.querySelector('input[name="right"]:checked').value;
		
		$.ajax({
			url: '/whale/updateStartpageSetting',
			type: 'POST',
			data: JSON.stringify({
				left: leftValue,
				right: rightValue
			}),
			contentType: 'application/json',
			success: function (response) {
				console.log('응답: ', response.message);
			},
			error: function (xhr, status, error) {
				console.log('업데이트 실패: ', error)
			}
		});
	}
</script>
</body>
</html>