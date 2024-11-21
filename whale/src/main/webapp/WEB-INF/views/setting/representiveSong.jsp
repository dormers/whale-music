<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>representiveSong</title>
	<link rel="stylesheet" href="static/css/setting/settingStyle.css" />
	<link rel="stylesheet" href="static/css/streaming/searchView.css" />
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script src="static/js/setting/setting.js"></script>
	<script src="static/js/setting/darkMode.js"></script>
	<style>
		.setting-body[data-darkmode="0"] .complete-btn { font-size: 20px; position: absolute; top: 15px; right: 7px; background-color: transparent; border: none; padding: 5px 10px; border-radius: 4px; cursor: pointer; }
		.setting-body[data-darkmode="0"] .complete-btn:hover { color: #5A5A5A; }
		.setting-body[data-darkmode="0"] #back { position: absolute; left: 15px; top: 55%; transform: translateY(-50%); }
		.setting-body[data-darkmode="0"] input[type='radio'] { margin-left: auto; margin-right: 0; -webkit-appearance: none; -moz-appearance: none; appearance: none; width: 13px; height: 13px; border: 1px solid #ccc; border-radius: 50%; outline: none; cursor: pointer; }
		.setting-body[data-darkmode="0"] input[type='radio']:checked { background-color: black; border: 3px solid #ccc; box-shadow: 0 0 0 1.6px black; }
		/* ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
		.setting-body[data-darkmode="1"] .complete-btn { font-size: 20px; position: absolute; top: 15px; right: 7px; background-color: transparent; border: none; padding: 5px 10px; border-radius: 4px; cursor: pointer; }
		.setting-body[data-darkmode="1"] .complete-btn:hover { color: lightgray; }
		.setting-body[data-darkmode="1"] #back { position: absolute; left: 15px; top: 55%; transform: translateY(-50%); }
		.setting-body[data-darkmode="1"] input[type='radio'] { margin-left: auto; margin-right: 0; -webkit-appearance: none; -moz-appearance: none; appearance: none; width: 13px; height: 13px; border: 1px solid #ccc; border-radius: 50%; outline: none; cursor: pointer; }
		.setting-body[data-darkmode="1"] input[type='radio']:checked { background-color: black; border: 3px solid #ccc; box-shadow: 0 0 0 1.6px black; }
		.setting-body[data-darkmode="1"] .search-result-container #pagination .pageBtn { color: whitesmoke; }
		.setting-body[data-darkmode="1"] .search-result-container #pagination span { color: whitesmoke; }
		.setting-body[data-darkmode="1"] .search-result-container #search-results .track-details div { color: whitesmoke; }
		.setting-body[data-darkmode="1"] .search-result-container #search-results .track-details .artist-name { color: whitesmoke; }
		.setting-body[data-darkmode="1"] .track-item { border-bottom: 1.5px solid #5a5a5a; }
	</style>
</head>
<body>
	<div class="setting-body">
		<div class="setting-container">
			<div class="setting-header">
				<a href="profileEdit" id="back"><img src="static/images/setting/back.png" alt="back"></a>
				대표곡 설정
				<button type="button" id="completeBtn" class="complete-btn">완료</button>
			</div>
			<div class="searchContainer">
				<div class="headerSearch">
					<button class="searchBtn" id="search-button">
						<img src="static/images/streaming/searchBtn.png" alt="Music Whale Search Button" height="14px">
				    </button>
				    <input class="headerInput" id="search-input" placeholder="어떤 콘텐츠를 감상하고 싶으세요?" onfocus="this.placeholder=''" onblur="this.placeholder='어떤 콘텐츠를 감상하고 싶으세요?'">
				</div>
			</div>
			<div class="search-result-container">
				<div id="pagination"></div>
				<div id="search-results"></div>
			</div>
		</div>
	</div>
	<script src="static/js/streaming/searchView.js"></script>
	<script>
		// 완료 버튼 클릭 시 데이터 업데이트
		document.getElementById("completeBtn").addEventListener("click", function() {
			const body = $('input[name="track"]:checked')[0].value; // 사용자가 선택한 트랙의 값 가져오기(체크된 라디오 버튼의 value)

			// 서버로 요청 전송
			fetch(`/whale/updateRepresentive`, {
				headers: {
					'Accept': 'application/json',
		            'Content-Type': 'application/json' // 요청 데이터의 Content-Type 설정
		        },
		        method: 'POST',
		        body: body // 요청 본문에 사용자가 선택한 트랙 정보를 포함
			})
			// 서버 응답 처리
			.then(response => {
				if(response.ok) {
					// 서버에서 성공 응답을 받은 경우 profileEdit 페이지로 이동
					window.location.href = '/whale/profileEdit';
				} else {
					console.log('서버 응답에 오류가 있습니다.'); // debug
				}
			})
			.catch(error => {
				console.log('요청 중 오류 발생:', error); // debug
			});
		});
	</script>
</body>
</html>