<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Profile</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@400;600&display=swap">
<style>
	::-webkit-scrollbar { display: none; }
	.container[data-darkmode="0"] { display: flex; justify-content: center; align-items: center;}
	body[data-darkmode="0"] { display: flex; justify-content: center; align-items: center; font-family: 'Noto Sans', sans-serif; margin: 0; padding: 0; }
	.container[data-darkmode="0"] .tab-container { display: flex; justify-content: space-around; align-items: center; border-bottom: 1px solid #dbdbdb; height: 80px; }
	.container[data-darkmode="0"] .tab { display: flex; justify-content: space-around; align-items: center; width: 40px; height: 50%; padding-bottom: 10px; cursor: pointer; font-weight: bold; color: #777; }
	.container[data-darkmode="0"] .tab.active { color: #333; border-bottom: 2px solid #333; }
	.container[data-darkmode="0"] .tab active img {width: 40px; height: 40px; }
	.container[data-darkmode="0"] .tab img {width: 40px; height: 40px; }
	.container[data-darkmode="0"] .tab-content { display: none; margin-top: 20px; }
	.container[data-darkmode="0"] .tab-content.active { display: block; }
	.container[data-darkmode="0"] .containerX { width: 100%; max-width: 650px; min-height: 1000px; padding: 20px; background-color: #fff; border: 1px solid #dbdbdb; }
	.container[data-darkmode="0"] .profile-header { display: flex; align-items: center; justify-content: space-between; padding-bottom: 30px; border-bottom: 1px solid #dbdbdb; }
	.container[data-darkmode="0"] .profile-info { position: relative; display: flex; align-items: center; width: 100%; }
	.container[data-darkmode="0"] .profile-image { border-radius: 50%; width: 100px; height: 100px; margin: 20px 20px 0 20px; background-color: #eee; }
	.container[data-darkmode="0"] .details { position: absolute; top: 26px; left: 150px; display: flex; flex-direction: column; width: 74%; }
	.container[data-darkmode="0"] .username-container { display: flex; align-items: center; justify-content: left; width: 100%; }
	.container[data-darkmode="0"] .lockbtn { width: 30px; height: 30px; border: none; background: none; }
	.container[data-darkmode="0"] .username { font-size: 20px; font-weight: bold; color: #333; margin-left: 5px; }
	.container[data-darkmode="0"] .stats div span { font-weight: bold; color: whitesmoke; }
	.container[data-darkmode="0"] .profile-info .user-id { font-size: 14px; color: #aaa; text-align: center; margin-top: 5px; }
	.container[data-darkmode="0"] .profile-actions { position: absolute; display: flex; gap: 10px; top: 1px; right: 0px; }
	.container[data-darkmode="0"] .profile-actions button { padding: 6px 12px; height: 100%; background-color: #0095f6; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 14px; font-weight: 600; transition: background-color 0.3s ease; }
	.container[data-darkmode="0"] .profile-actions button.message { background-color: #fff; color: #0095f6; border: 1px solid #dbdbdb; }
	.container[data-darkmode="0"] .profile-actions button:hover { background-color: #007ac1; }
	.container[data-darkmode="0"] .profile-actions button.message:hover { background-color: #f1f1f1; }
	.container[data-darkmode="0"] .stats a { color: inherit; text-decoration: none; font-weight: bold; }
	.container[data-darkmode="0"] .stats a:active { opacity: 0.8; }
	.container[data-darkmode="0"] .stats a:hover { color: inherit; text-decoration: none; }
	.container[data-darkmode="0"] .feed-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 2px; margin-top: 10px; }
	.container[data-darkmode="0"] .feed-grid img { width: 100%; height: 200px; object-fit: cover; }
	.container[data-darkmode="0"] .privacy-account { padding: 10px 0 0 10px; color: #aaa; }
	.container[data-darkmode="0"] .no-feed-message { text-align: center; font-size: 16px; color: #aaa; margin-top: 20px; }
	.container[data-darkmode="0"] .music-item { position: relative; display: inline-block; overflow: hidden; width: 100%; }
	.container[data-darkmode="0"] .music-item img { width: 100%; height: auto; transition: filter 0.3s ease; }
	.container[data-darkmode="0"] .music-item:hover img { filter: brightness(0.7); }
	.container[data-darkmode="0"] .overlay { position: absolute; top: 0; left: 0; width: 100%; height: 100%; display: flex; align-items: center; justify-content: center; background-color: rgba(0, 0, 0, 0.6); opacity: 0; transition: opacity 0.3s ease; color: white; flex-direction: column; gap: 8px; pointer-events: none; }
	.container[data-darkmode="0"] .music-item:hover .overlay { opacity: 1; pointer-events: auto; }
	.container[data-darkmode="0"] .music-item .overlay .play-button { width: 20px; height: 20px; margin-bottom: 10px; cursor: pointer; }
	.container[data-darkmode="0"] .music-info { text-align: center; }
	.container[data-darkmode="0"] .music-title { font-size: 16px; font-weight: bold; }
	.container[data-darkmode="0"] .music-artist { font-size: 14px; }
	.container[data-darkmode="0"] .stats-and-featured-music { display: flex; flex-direction: column; align-items: flex-start; border-top: 1px solid #dbdbdb; padding-top: 15px; padding-left: 10px; margin-top: 15px; width: 100%; }
	.container[data-darkmode="0"] .stats { display: flex; gap: 30px; font-size: 16px; color: #777; }
	.container[data-darkmode="0"] .stats div span { font-weight: bold; color: #333; }
	.container[data-darkmode="0"] .featured-music { display: flex; align-items: center; margin-top: 20px; width: 100%; }
	.container[data-darkmode="0"] .featured-music-icon { width: 30px; height: 30px; border-radius: 3px; margin-right: 8px; }
	.container[data-darkmode="0"] .featured-marquee-container { overflow: hidden; width: calc(80% - 38px); position: relative; }
	.container[data-darkmode="0"] .featured-marquee { display: inline-block; white-space: nowrap; overflow: hidden; }
	.container[data-darkmode="0"] .animated { animation: marquee 10s linear infinite; animation-delay: 1s; animation-play-state: paused; }
	.container[data-darkmode="0"] @keyframes marquee { 0% { transform: translateX(1%); } 100% { transform: translateX(-50%); } }
	.container[data-darkmode="0"] .featured-music-title { font-size: 14px; font-weight: bold; color: #333; }
	.container[data-darkmode="0"] .featured-music-artist { font-size: 12px; color: #777; margin-left: 10px; }
	.container[data-darkmode="0"] .featured-play-button, .container[data-darkmode="0"] .featured-pause-button { width: 20px; height: 20px; background: none; border: none; cursor: pointer; filter: invert(0);}
	.container[data-darkmode="0"] .featured-play-button img, .featured-pause-button img { width: 20px; height: 20px; }
	.container[data-darkmode="0"] .now-playing-icon { height: 20px; margin-left: 2.5px; visibility: hidden; opacity: 0; transition: opacity 0.3s ease; transform: translateX(-15px);}
	.container[data-darkmode="0"] .deleteAccount { display: flex; justify-content: center; align-items: center; font-family: 'Noto Sans', sans-serif; font-weight: 600; height: 100vh; text-align: center; }
	/* --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
	.container[data-darkmode="1"] { display: flex; justify-content: center; align-items: center; background-color: #1f1f1f;}
	body[data-darkmode="1"] { display: flex; justify-content: center; align-items: center; font-family: 'Noto Sans', sans-serif; margin: 0; padding: 0; background-color: #1f1f1f; color: whitesmoke; }
	.container[data-darkmode="1"] .tab-container { display: flex; justify-content: space-around; align-items: center; border-bottom: 1px solid #dbdbdb; height: 80px; }
	.container[data-darkmode="1"] .tab { display: flex; justify-content: space-around; align-items: center; width: 40px; height: 50%; padding-bottom: 10px; cursor: pointer; font-weight: bold; color: #777; }
	.container[data-darkmode="1"] .tab active img {width: 40px; height: 40px; filter: invert(1); }
	.container[data-darkmode="1"] .tab img {width: 40px; height: 40px; filter: invert(1);}
	.container[data-darkmode="1"] .tab.active { color: whitesmoke; border-bottom: 2px solid whitesmoke; }
	.container[data-darkmode="1"] .tab-content { display: none; margin-top: 20px; }
	.container[data-darkmode="1"] .tab-content.active { display: block; }
	.container[data-darkmode="1"] .containerX { width: 100%; max-width: 650px; min-height: 1000px; padding: 20px; background-color: #434343; border: 1px solid #434343; }
	.container[data-darkmode="1"] .profile-header { display: flex; align-items: center; justify-content: space-between; padding-bottom: 30px; border-bottom: 1px solid #dbdbdb; }
	.container[data-darkmode="1"] .profile-info { position: relative; display: flex; align-items: center; width: 100%; }
	.container[data-darkmode="1"] .profile-image { border-radius: 50%; width: 100px; height: 100px; margin: 20px 20px 0 20px; background-color: #eee; }
	.container[data-darkmode="1"] .details { position: absolute; top: 26px; left: 150px; display: flex; flex-direction: column; width: 74%; }
	.container[data-darkmode="1"] .username-container { display: flex; align-items: center; justify-content: left; width: 100%; }
	.container[data-darkmode="1"] .lockbtn { width: 30px; height: 30px; border: none; background: none; filter: invert(1);}
	.container[data-darkmode="1"] .username { font-size: 20px; font-weight: bold; color: whitesmoke; margin-left: 5px; }
	.container[data-darkmode="1"] .stats div span { font-weight: bold; color: whitesmoke; }
	.container[data-darkmode="1"] .profile-info .user-id { font-size: 14px; color: #aaa; text-align: center; margin-top: 5px; }
	.container[data-darkmode="1"] .profile-actions { position: absolute; display: flex; gap: 10px; top: 1px; right: 0px; }
	.container[data-darkmode="1"] .profile-actions button { padding: 6px 12px; height: 100%; background-color: #0095f6; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 14px; font-weight: 600; transition: background-color 0.3s ease; }
	.container[data-darkmode="1"] .profile-actions button.message { background-color: #fff; color: #0095f6; border: 1px solid #dbdbdb; }
	.container[data-darkmode="1"] .profile-actions button:hover { background-color: #007ac1; }
	.container[data-darkmode="1"] .profile-actions button.message:hover { background-color: #f1f1f1; }
	.container[data-darkmode="1"] .stats a { color: inherit; text-decoration: none; font-weight: bold; }
	.container[data-darkmode="1"] .stats a:active { opacity: 0.8; }
	.container[data-darkmode="1"] .stats a:hover { color: inherit; text-decoration: none; }
	.container[data-darkmode="1"] .feed-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 2px; margin-top: 10px; }
	.container[data-darkmode="1"] .feed-grid img { width: 100%; height: 200px; object-fit: cover; }
	.container[data-darkmode="1"] .privacy-account { padding: 10px 0 0 10px; color: #ccc; }
	.container[data-darkmode="1"] .no-feed-message { text-align: center; font-size: 16px; color: #ccc; margin-top: 20px; }
	.container[data-darkmode="1"] .music-item { position: relative; display: inline-block; overflow: hidden; width: 100%; }
	.container[data-darkmode="1"] .music-item img { width: 100%; height: auto; transition: filter 0.3s ease; }
	.container[data-darkmode="1"] .music-item:hover img { filter: brightness(0.7); }
	.container[data-darkmode="1"] .overlay { position: absolute; top: 0; left: 0; width: 100%; height: 100%; display: flex; align-items: center; justify-content: center; background-color: rgba(0, 0, 0, 0.6); opacity: 0; transition: opacity 0.3s ease; color: white; flex-direction: column; gap: 8px; pointer-events: none; }
	.container[data-darkmode="1"] .music-item:hover .overlay { opacity: 1; pointer-events: auto; }
	.container[data-darkmode="1"] .music-item .overlay .play-button { width: 20px; height: 20px; margin-bottom: 10px; cursor: pointer; }
	.container[data-darkmode="1"] .music-info { text-align: center; }
	.container[data-darkmode="1"] .music-title { font-size: 16px; font-weight: bold; }
	.container[data-darkmode="1"] .music-artist { font-size: 14px; }
	.container[data-darkmode="1"] .stats-and-featured-music { display: flex; flex-direction: column; align-items: flex-start; border-top: 1px solid #dbdbdb; padding-top: 15px; padding-left: 10px; margin-top: 15px; width: 100%; color: whitesmoke;}
	.container[data-darkmode="1"] .stats-and-featured-music > * { color: whitesmoke !important;}
	.container[data-darkmode="1"] .stats { display: flex; gap: 30px; font-size: 16px; color: #777; }
	.container[data-darkmode="1"] .featured-music { display: flex; align-items: center; margin-top: 20px; width: 100%; }
	.container[data-darkmode="1"] .featured-music-icon { width: 30px; height: 30px; border-radius: 3px; margin-right: 8px; }
	.container[data-darkmode="1"] .featured-marquee-container { overflow: hidden; width: calc(80% - 38px); position: relative; color: whitesmoke;}
	.container[data-darkmode="1"] .featured-marquee { display: inline-block; white-space: nowrap; overflow: hidden; }
	.container[data-darkmode="1"] .animated { animation: marquee 10s linear infinite; animation-delay: 1s; animation-play-state: paused; }
	.container[data-darkmode="1"] @keyframes marquee { 0% { transform: translateX(1%); } 100% { transform: translateX(-50%); } }
	.container[data-darkmode="1"] .featured-music-title { font-size: 14px; font-weight: bold; color: whitesmoke; }
	.container[data-darkmode="1"] .featured-music-artist { font-size: 12px; color: whitesmoke; margin-left: 10px; }
	.container[data-darkmode="1"] .featured-play-button, .container[data-darkmode="1"] .featured-pause-button { width: 20px; height: 20px; background: none; border: none; cursor: pointer; filter: invert(1);}
	.container[data-darkmode="1"] .featured-play-button img, .featured-pause-button img { width: 20px; height: 20px; }
	.container[data-darkmode="1"] .now-playing-icon { height: 20px; margin-left: 2.5px; visibility: hidden; opacity: 0; transition: opacity 0.3s ease; transform: translateX(-15px); filter: invert(1);}
	.container[data-darkmode="1"] .deleteAccount { display: flex; justify-content: center; align-items: center; font-family: 'Noto Sans', sans-serif; font-weight: 600; height: 100vh; text-align: center; }

</style>
<script src="static/js/setting/darkMode.js"></script>
</head>
<body>
<c:choose>
	<c:when test="${profile.account_privacy == 2}">
		<div class="deleteAccount">탈퇴한 사용자입니다.</div>
	</c:when>
	<c:otherwise>
<div class="container" data-darkmode="${darkMode.scndAttrName}">
	<div class="containerX">
		<%-- 팔로워 상태 체크 --%>
		<c:set var="isFollower" value="false" />
		<c:forEach items="${followerList}" var="follower">
			<c:if test="${follower.user_id == now_id}">
				<c:set var="isFollower" value="true" />
			</c:if>
		</c:forEach>

		<%-- 프로필 정보 영역 --%>
		<div class="profile-header">
			<div class="profile-info">

				<div>
					<img class="profile-image" src="${profile.user_image_url}" alt="User Profile Image">
					<div class="user-id">@${userId}</div>
				</div>
				<div class="details">
					<div class="username-container">
						<c:if test="${profile.account_privacy == 1}">
							<img class="lockbtn" src="static/images/btn/lock_btn.png" alt="secret" />
						</c:if>
						<div class="username">${profile.user_nickname}</div>
								<c:if test="${now_id != userId && userId != WHALE}">
								<div class="profile-actions">
									<c:choose>
										<c:when test="${isFollower}">
											<a href="DoUnfollowing?u=${userId}"><button>팔로우 취소</button></a>
										</c:when>
										<c:otherwise>
											<c:choose>
												<c:when test="${profile.account_privacy == 1}">
													<c:choose>
														<c:when test="${profile2.target_user_id == now_id}">
															<a href="CancelFollowingPlease?u=${userId}"><button>요청됨</button></a>
														</c:when>
														<c:otherwise>
															<a href="DosecretFollowing?u=${userId}"><button>팔로우 요청</button></a>
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise>
													<a href="DoFollowing?u=${userId}"><button>팔로우</button></a>
												</c:otherwise>
											</c:choose>
										</c:otherwise>
									</c:choose>
									<a href="messageGo?u=${userId}"><button class="message">메시지</button></a>
								</div>
							</c:if>							
					</div>
					<div class="stats-and-featured-music">
						<div class="stats">
							<div>
								<a href="javascript:void(0);">게시물&nbsp;&nbsp;</a>
								<span>${fdCount}</span></div>
							<div>
								<c:choose>
									<c:when test="${now_id == userId || isFollower || profile.account_privacy != 1}">
										<a href="followers?u=${userId}">팔로워&nbsp;&nbsp;<span>${frCount}</span></a>
									</c:when>
									<c:otherwise>
										<span>팔로워&nbsp;&nbsp;<span>${frCount}</span></span>
									</c:otherwise>
								</c:choose>
							</div>
							<div>
								<c:choose>
									<c:when test="${now_id == userId || isFollower || profile.account_privacy != 1}">
										<a href="following?u=${userId}">팔로잉&nbsp;&nbsp;<span>${fnCount}</span></a>
									</c:when>
									<c:otherwise>
										<span>팔로잉&nbsp;&nbsp;<span>${fnCount}</span></span>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<c:if test="${profile.track_cover != null}">

						<div class="featured-music">
							<img src="${profile.track_cover}" alt="대표곡" class="featured-music-icon">
							<div class="featured-marquee-container">
								<div class="featured-marquee" id="featuredMarquee">
									<span class="featured-music-title">${profile.track_name}</span>
									<span class="featured-music-artist">${profile.track_artist}</span>
								</div>
							</div>
							<img src="static/images/btn/moving_music2.gif" alt="now-playing" class="now-playing-icon" />
							<button class="featured-play-button" onclick="playProMusic(this, '${profile.track_id}')">
								<img src="static/images/btn/play_btn.png" alt="Play Button" />
							</button>
							<button class="featured-pause-button" onclick="pauseMusic(this, '${profile.track_id}')" style="display: none;">
								<img src="static/images/btn/pause_btn.png" alt="Pause Button" />
							</button>
						</div>
						</c:if>
					</div>
				</div>

			</div>
		</div>

		<%-- 피드 표시 영역 --%>
		<div class="tab-container">
			<div class="tab active" onclick="showTabContent('feed')"><img src="static/images/btn/write_btn.png" alt="피드" /></div>
			<div class="tab" onclick="showTabContent('music')"><img src="static/images/btn/promusic_btn.png" alt="음악" style="width: 24px; height: 24px;" /></div>
		</div>

		<!-- 피드 탭 콘텐츠 -->
		<div id="feed" class="tab-content active">
			<%-- 기존 피드 표시 코드 --%>
			<c:choose>
				<c:when test="${profile.account_privacy == 1 && !isFollower && now_id != userId}">
					<div class= "privacy-account">비공개 계정입니다.</div>
				</c:when>
				<c:when test="${empty feedList}">
					<div class="no-feed-message">작성한 피드가 없습니다</div>
				</c:when>
				<c:otherwise>
					<div class="feed-grid">
						<c:forEach items="${feedList}" var="feed">
							<a href="feedDetail?f=${feed.feed_id}">
								<img src="${feed.feed_img_url}" onerror="this.style.display='none'">
							</a>
						</c:forEach>
					</div>
				</c:otherwise>
			</c:choose>
		</div>

		<!-- 음악 탭 콘텐츠 -->
		<div id="music" class="tab-content">
			<!-- 추후 추가할 음악 이미지나 콘텐츠를 여기에 표시 -->
			 <c:choose>
				<c:when test="${profile.account_privacy == 1 && !isFollower && now_id != userId}">
					<div class= "privacy-account">비공개 계정입니다.</div>
				</c:when>
				<c:when test="${empty feedList}">
					<div class="no-feed-message">작성한 피드가 없습니다</div>
				</c:when>
				<c:otherwise>
					<div class="feed-grid">
						<c:forEach items="${feedList}" var="feed">
							<c:if test="${feed.track_id != null}">
								<div class="music-item">
									<img src="${feed.track_cover}" onerror="this.style.display='none'">
									<div class="overlay">
										<img src="static/images/btn/play_btn.png" alt="Play Button" class="play-button" onclick="playMusic(this, '${feed.track_id}')" />
										<div class="music-info">
											<div class="music-title">${feed.track_name}</div>
											<div class="music-artist">${feed.track_artist}</div>
										</div>
									</div>
								</div>
							</c:if>
						</c:forEach>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>
</c:otherwise>
</c:choose>

<script>

	window.addEventListener('DOMContentLoaded', () => {
	    const marqueeElement = document.getElementById('featuredMarquee');
	    const containerWidth = marqueeElement.parentElement.offsetWidth;
	    const textWidth = marqueeElement.scrollWidth;
	
	    // 텍스트가 컨테이너보다 넓을 경우에만 애니메이션 클래스 추가
	    if (textWidth > containerWidth) {
	        marqueeElement.classList.add('animated');
	        
	        setTimeout(() => {
	            marqueeElement.style.animationPlayState = 'running'; // 애니메이션 시작
	        }, 1000); // 2초 후 애니메이션 시작
	    }
	});

	function playMusic(element, spotifyId) {
	    fetch(`/whale/feedPlayMusic?id=\${spotifyId}`)
	        .then(response => {
	        })
	        .catch(error => {
	            console.error('에러 발생:', error);
	            alert('음악 재생 중 오류가 발생했습니다.');
	        });
	}
	

    // 탭 콘텐츠 전환 함수
    function showTabContent(tabId) {
        // 모든 탭 및 콘텐츠에서 active 클래스 제거
        document.querySelectorAll('.tab').forEach(tab => tab.classList.remove('active'));
        document.querySelectorAll('.tab-content').forEach(content => content.classList.remove('active'));

        // 클릭한 탭 및 해당 콘텐츠에 active 클래스 추가
        document.querySelector('.tab-container .tab[onclick="showTabContent(\'' + tabId + '\')"]').classList.add('active');
        document.getElementById(tabId).classList.add('active');
    }
    
    function playProMusic(element, spotifyId) {
        fetch(`/whale/feedPlayMusic?id=\${spotifyId}`)
            .then(response => {
                if (response.ok) {
                    element.style.display = 'none';
                    const pauseBtn = element.nextElementSibling;
                    const nowPlayingIcon = document.querySelector('.now-playing-icon');
                    if (pauseBtn) {
                        pauseBtn.style.display = 'inline-block';
                    }
                    if (nowPlayingIcon) {
                        nowPlayingIcon.style.visibility = 'visible';
                        nowPlayingIcon.style.opacity = '1'; // 재생 중 아이콘을 보이게
                    }
                } else {
                    alert('음악 재생에 실패했습니다.');
                }
            })
            .catch(error => {
                console.error('에러 발생:', error);
                alert('음악 재생 중 오류가 발생했습니다.');
            });
    }

    function pauseMusic(element, spotifyId) {
        fetch(`/whale/feedPauseMusic?id=\${spotifyId}`)
            .then(response => {
                if (response.ok) {
                    element.style.display = 'none';
                    const playBtn = element.previousElementSibling;
                    const nowPlayingIcon = document.querySelector('.now-playing-icon');
                    if (playBtn) {
                        playBtn.style.display = 'inline-block';
                    }
                    if (nowPlayingIcon) {
                        nowPlayingIcon.style.visibility = 'hidden';
                        nowPlayingIcon.style.opacity = '0'; // 재생 중 아이콘을 숨기기
                    }
                } else {
                    alert('음악 일시정지에 실패했습니다.');
                }
            })
            .catch(error => {
                console.error('에러 발생:', error);
                alert('음악 일시정지 중 오류가 발생했습니다.');
            });
    }
    
</script>

</body>
</html>