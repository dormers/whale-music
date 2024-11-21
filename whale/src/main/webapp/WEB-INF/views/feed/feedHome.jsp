<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="static/css/streaming/searchView.css"/>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;600&display=swap">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@400;600&display=swap">
    <title>Feed Page</title>
    <style>
        body {font-family: 'Noto Sans', Arial, sans-serif; margin: 0; padding: 0;}
        body, .music-info, .username, .post-text {font-family: 'Noto Sans KR', Arial, sans-serif !important;}
        ::-webkit-scrollbar {display: none;}
        .feed-container[data-darkmode="1"]{background-color: #434343; height: 100vh;}
        /* 상단 바 스타일 */
        .feed-container[data-darkmode="1"] .top-bar {background-color: #1f1f1f; display: flex; justify-content: center; align-items: center; padding: 10px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); position: sticky; top: 0; z-index: 1000; height: 20px;}
        .feed-container[data-darkmode="1"] .top-bar img {width: 80px; cursor: pointer; filter: invert(.7);}
        /* 글 작성 영역 */
        .feed-container[data-darkmode="1"] .write-area-container {max-height: 0; overflow: hidden; transition: max-height 0.5s ease; background-color: white; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); padding: 0 10px;}
        .feed-container[data-darkmode="1"] .write-area-container.open {max-height: 2000px; background: #1f1f1f;}
        .feed-container[data-darkmode="1"] .write-area textarea {width: 90%; height: 150px; padding: 10px; border-radius: 5px; resize: none; font-size: 1em; background: #434343; color: #e2e2e2;}
        .feed-container[data-darkmode="1"] .music-info {display: flex; align-items: center; justify-content: space-between; /* 양 끝에 요소 배치 */ padding: 10px; background-color: #434343; border-radius: 5px; margin-top: 15px;}
        .feed-container[data-darkmode="1"] .music-info > div {flex-grow: 1; /* 제목과 아티스트 영역이 남은 공간 차지 */ color: #e2e2e2;}
        .feed-container[data-darkmode="1"] .music-info label {margin-left: 10px; /* 버튼 간 간격 조정 */}
        .feed-container[data-darkmode="1"] .submit-btn {display: block; width: 90%; margin: 15px auto 20px auto; padding: 10px; background-color: #2e2e2e; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 1em;}
        /* 피드 레이아웃 */
        .feed-container[data-darkmode="1"] .feed {margin-top: 20px; display: flex; flex-direction: column; align-items: center;}
        .feed-container[data-darkmode="1"] .post {background-color: #2e2e2e; width: 90%; max-width: 600px; margin-bottom: 20px; border-radius: 10px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); padding: 15px; position: relative; cursor: pointer;}
        .feed-container[data-darkmode="1"] .user-info {display: flex; align-items: center;}
        .feed-container[data-darkmode="1"] .user-info .profile-pic {width: 40px; height: 40px; border-radius: 50%; margin: 5px 10px 0 4px;}
        .feed-container[data-darkmode="1"] .username {font-weight: bold; font-size: 1.2em; color: #e2e2e2;}
        .feed-container[data-darkmode="1"] .other-btn {position: absolute; top: 25px; right: 15px; background: none; border: none; cursor: pointer;}
        .feed-container[data-darkmode="1"] .other-btn img {width: 30px; height: 30px;}
        .feed-container[data-darkmode="1"] .post-image {width: 100%; height: auto; margin: 15px 0 0 0; border-radius: 10px;}
        .feed-container[data-darkmode="1"] .post-actions {display: flex; justify-content: space-around; align-items: center; /* 아이템들을 수직 가운데 정렬 */ margin-top: 22px; font-size: 1em;}
        .feed-container[data-darkmode="1"] .post-actions .like-btn,
        .feed-container[data-darkmode="1"] .post-actions .comments {display: flex; /* 수평 배치 */ align-items: center; /* 수직 가운데 정렬 */ background: none; border: none; cursor: pointer;}
        .feed-container[data-darkmode="1"] .post-actions .like-btn {background: none; border: none; cursor: pointer;}
        .feed-container[data-darkmode="1"] .post-actions .likebtn,
        .feed-container[data-darkmode="1"] .post-actions .commentbtn {width: 30px; /* 아이콘 크기 조정 */ height: 30px; margin-right: 5px; /* 아이콘과 텍스트 사이 간격 */}
        .feed-container[data-darkmode="1"] .like-count,
        .feed-container[data-darkmode="1"] .comment-count {font-size: 1em; /* 글자 크기 통일 */ color: #e2e2e2; /* 필요 시 색상 지정 */}
        .feed-container[data-darkmode="1"] .post-text {margin-top: 10px; color: #e2e2e2;}
        .feed-container[data-darkmode="1"] .post-time {text-align: right; font-size: 0.8em; color: gray;}
        .feed-container[data-darkmode="1"] .modal {display: none; /* 기본적으로 숨김 상태 */ position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.6); justify-content: center; align-items: center;}
        /* 모달 내용 */
        .feed-container[data-darkmode="1"] .modal-content {background-color: #414141; border-radius: 12px; width: 80%; max-width: 300px; max-height: 325px; text-align: center; overflow: hidden;}
        /* 모달 항목 스타일 */
        .feed-container[data-darkmode="1"] .modal-item {padding: 20px; border-bottom: 1px solid #626262; font-size: 16px; cursor: pointer; color: #e2e2e2;}
        .feed-container[data-darkmode="1"] .modal-item.red {color: red;}
        .feed-container[data-darkmode="1"] .modal-item.gray {color: gray;}
        .feed-container[data-darkmode="1"] .modal-item:last-child {border-bottom: none;}
        .feed-container[data-darkmode="1"] .modal-item:hover {background-color: #2e2e2e;}
        .feed-container[data-darkmode="1"] .music-info #music-title {font-weight: bold; font-size: 1em; color: #e2e2e2; /* 기본 검정색 */}
        .feed-container[data-darkmode="1"] .music-info #artist-name {font-weight: normal; font-size: 0.9em; color: #e7e7e7; /* 회색 */}
    /*    ---------------------------------------------------------------------------------------------------*/
        .feed-container[data-darkmode="0"]{background-color: #f0f0f0;}
        /* 상단 바 스타일 */
        .feed-container[data-darkmode="0"] .top-bar {background-color: #fff; display: flex; justify-content: center; align-items: center; padding: 10px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); position: sticky; top: 0; z-index: 1000; height: 20px;}
        .feed-container[data-darkmode="0"] .top-bar img {width: 80px; cursor: pointer;}
        /* 글 작성 영역 */
        .feed-container[data-darkmode="0"] .write-area-container {max-height: 0; overflow: hidden; transition: max-height 0.5s ease; background-color: white; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); padding: 0 10px;}
        .feed-container[data-darkmode="0"] .write-area-container.open {max-height: 2000px;}
        .feed-container[data-darkmode="0"] .write-area textarea {width: 90%; height: 150px; padding: 10px; border: 1px solid #ccc; border-radius: 5px; resize: none; font-size: 1em;}
        .feed-container[data-darkmode="0"] .music-info {display: flex; align-items: center; justify-content: space-between; /* 양 끝에 요소 배치 */ padding: 10px; background-color: #f9f9f9; border-radius: 5px; margin-top: 15px;}
        .feed-container[data-darkmode="0"] .music-info > div {flex-grow: 1; /* 제목과 아티스트 영역이 남은 공간 차지 */}
        .feed-container[data-darkmode="0"] .music-info label {margin-left: 10px; /* 버튼 간 간격 조정 */}
        .feed-container[data-darkmode="0"] .submit-btn {display: block; width: 90%; margin: 15px auto 20px auto; padding: 10px; background-color: #4CAF50; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 1em;}
        /* 피드 레이아웃 */
        .feed-container[data-darkmode="0"] .feed {margin-top: 20px; display: flex; flex-direction: column; align-items: center;}
        .feed-container[data-darkmode="0"] .post {background-color: white; width: 90%; max-width: 600px; margin-bottom: 20px; border-radius: 10px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); padding: 15px; position: relative; cursor: pointer;}
        .feed-container[data-darkmode="0"] .user-info {display: flex; align-items: center;}
        .feed-container[data-darkmode="0"] .user-info .profile-pic {width: 40px; height: 40px; border-radius: 50%; margin: 5px 10px 0 4px;}
        .feed-container[data-darkmode="0"] .username {font-weight: bold; font-size: 1.2em;}
        .feed-container[data-darkmode="0"] .other-btn {position: absolute; top: 25px; right: 15px; background: none; border: none; cursor: pointer;}
        .feed-container[data-darkmode="0"] .other-btn img {width: 30px; height: 30px;}
        .feed-container[data-darkmode="0"] .post-image {width: 100%; height: auto; margin: 15px 0 0 0; border-radius: 10px;}
        .feed-container[data-darkmode="0"] .post-actions {display: flex; justify-content: space-around; align-items: center; /* 아이템들을 수직 가운데 정렬 */ margin-top: 22px; font-size: 1em;}
        .feed-container[data-darkmode="0"] .post-actions .like-btn,
        .feed-container[data-darkmode="0"] .post-actions .comments {display: flex; /* 수평 배치 */ align-items: center; /* 수직 가운데 정렬 */ background: none; border: none; cursor: pointer;}
        .feed-container[data-darkmode="0"] .post-actions .like-btn {background: none; border: none; cursor: pointer;}
        .feed-container[data-darkmode="0"] .post-actions .likebtn,
        .feed-container[data-darkmode="0"] .post-actions .commentbtn {width: 30px; /* 아이콘 크기 조정 */ height: 30px; margin-right: 5px; /* 아이콘과 텍스트 사이 간격 */}
        .feed-container[data-darkmode="0"] .like-count,
        .feed-container[data-darkmode="0"] .comment-count {font-size: 1em; /* 글자 크기 통일 */ color: #333; /* 필요 시 색상 지정 */}
        .feed-container[data-darkmode="0"] .post-text {margin-top: 10px;}
        .feed-container[data-darkmode="0"] .post-time {text-align: right; font-size: 0.8em; color: gray;}
        .feed-container[data-darkmode="0"] .modal {display: none; /* 기본적으로 숨김 상태 */ position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.6); justify-content: center; align-items: center;}
        /* 모달 내용 */
        .feed-container[data-darkmode="0"] .modal-content {background-color: white; border-radius: 12px; width: 80%; max-width: 300px; max-height: 325px; text-align: center; overflow: hidden;}
        /* 모달 항목 스타일 */
        .feed-container[data-darkmode="0"] .modal-item {padding: 20px; border-bottom: 1px solid #eee; font-size: 16px; cursor: pointer;}
        .feed-container[data-darkmode="0"] .modal-item.red {color: red;}
        .feed-container[data-darkmode="0"] .modal-item.gray {color: gray;}
        .feed-container[data-darkmode="0"] .modal-item:last-child {border-bottom: none;}
        .feed-container[data-darkmode="0"] .modal-item:hover {background-color: #f9f9f9;}
        .feed-container[data-darkmode="0"] .music-info #music-title {font-weight: bold; font-size: 1em; color: #333; /* 기본 검정색 */}
        .feed-container[data-darkmode="0"] .music-info #artist-name {font-weight: normal; font-size: 0.9em; color: #777; /* 회색 */}

    </style>
    <style id="darkmode-scrollbar-styles"></style>
    <script src="static/js/setting/darkMode.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const feedElement = document.querySelector('.feed-container');
            const toggleSlide = document.getElementById('toggle-slide');

            // localStorage에서 다크 모드 상태 확인 및 초기화
            let darkmodeOn = localStorage.getItem('darkmodeOn') || "0";
            console.log("Initial darkmodeOn from localStorage:", darkmodeOn);

            feedElement.setAttribute("data-darkmode", darkmodeOn);
            console.log("Initial data-darkmode attribute set to:", darkmodeOn);

            toggleSlide.checked = darkmodeOn === "1";
            console.log("Initial toggleSlide checked status:", toggleSlide.checked);

            // 토글 변경 시 localStorage 업데이트
            toggleSlide.addEventListener('change', function () {
                darkmodeOn = this.checked ? "1" : "0";
                console.log("Toggle changed, new darkmodeOn:", darkmodeOn);

                // localStorage 업데이트
                localStorage.setItem('darkmodeOn', darkmodeOn);
                console.log("Updated localStorage darkmodeOn to:", darkmodeOn);

                // data-darkmode 속성 업데이트
                feedElement.setAttribute("data-darkmode", darkmodeOn);
                console.log("Updated data-darkmode attribute to:", darkmodeOn);
            });

            // 다른 iframe 또는 탭에서 localStorage가 업데이트될 때 적용
            window.addEventListener('storage', function (event) {
                if (event.key === 'darkmodeOn') {
                    darkmodeOn = event.newValue || "0";
                    console.log("storage event detected, new darkmodeOn from localStorage:", darkmodeOn);

                    // data-darkmode 속성 업데이트
                    feedElement.setAttribute("data-darkmode", darkmodeOn);
                    console.log("Updated data-darkmode attribute due to storage event to:", darkmodeOn);

                    // 토글 버튼 상태 업데이트
                    toggleSlide.checked = darkmodeOn === "1";
                    console.log("Updated toggleSlide checked status due to storage event:", toggleSlide.checked);
                }
            });
        });
    </script>
</head>
<body>
<div class="feed-container" data-darkmode="${darkMode.scndAttrName}">
    <!-- 상단 바 -->
    <div class="top-bar">
        <img src="static/images/feed/pencel.png" alt="Apple Pencil" id="writeButton">
    </div>

    <!-- 글 작성 영역 (jsp:include로 가져옴) -->
    <div class="write-area-container" id="writeAreaContainer">
        <jsp:include page="feedWrite.jsp"/>
    </div>

    <!-- 피드 섹션 -->
    <div class="feed">
        <!-- 반복문으로 글 출력 -->
        <c:forEach var="feed" items="${feedList}">
            <div class="post" data-post-id="${feed.feed_id}" data-user-id="${feed.user_id}">
                <div class="user-info">
                    <a href="profileHome?u=${feed.user_id}"><img src="${feed.user_image_url}" alt="User Profile"
                                                                 class="profile-pic"></a>
                    <span class="username">${feed.user_id}</span>
                </div>

                <button class="other-btn">
                    <img src="static/images/btn/other_btn.png" alt="Other Button">
                </button>

                <!-- 이미지가 존재할 때만 출력 -->
                <c:if test="${not empty feed.feed_img_url}">
                    <img src="${feed.feed_img_url}" alt="Post Image" class="post-image">
                </c:if>

                <c:if test="${not empty feed.track_id}">
                    <div id="music-info" class="music-info">
                        <img id="album-icon" src="${feed.track_cover}" alt="Album Icon"
                             style="width: 50px; height: 50px; margin-left: 5px; margin-right: 5px;">
                        <div>
                            <span class="music-title" id="music-title">${feed.track_name}</span> -
                            <span class="artist-name" id="artist-name">${feed.track_artist}</span>
                        </div>
                        <label class="play-button" onclick="playMusic(this, '${feed.track_id}')"
                               style="display: inline-block;">
                            <img src="static/images/btn/play_btn.png" alt="play" style="width: 40px; height: 40px; margin-top: 4px; margin-right: 10px;"/>
                        </label>
                        <!-- Pause 버튼 -->
                        <label class="pause-button" onclick="pauseMusic(this, '${feed.track_id}')"
                               style="display: none;">
                            <img src="static/images/btn/pause_btn.png" alt="pause" style="width: 40px; height: 40px; margin-top: 4px;x` margin-right: 10px;"/>
                        </label>
                    </div>
                </c:if>
                <div class="post-text">
                    <p style="margin-left: 5px;">${feed.feed_text}</p>
                    <p class="post-time">${feed.feed_date}</p>
                </div>
                <div class="post-actions">
                    <button type="button" class="like-btn" data-feed-id="${feed.feed_id}" data-now-id="${now_id}">
                        <img class="likebtn" src="static/images/btn/like_btn.png" alt="like"/>
                        <span class="like-count">${feed.likeCount}</span>
                    </button>
                    <button type="button" class="comments"
                            onclick="window.location.href='feedDetail?f=${feed.feed_id}'">
                        <img class="commentbtn" src="static/images/btn/comment_btn.png" alt="comments" style="width: 28px; height: 28px;"/>
                        <span class="comment-count">${feed.commentsCount}</span>
                    </button>
                </div>
            </div>
        </c:forEach>
    </div>

    <div id="otherModal" class="modal">
        <div class="modal-content">
            <div id="goToPost" class="modal-item">게시글로 이동</div>
            <div id="publicPost" class="modal-item">피드 공유</div>
            <div id="deletePost" class="modal-item red" style="display: none;">게시글 삭제</div>
            <div id="hidePost" class="modal-item" style="display: none;">게시글 숨기기</div>
            <div id="reportPost" class="modal-item red" style="display: none;">게시글 신고</div>
            <div class="modal-item gray" onclick="closeOtherModal()">취소</div>
        </div>
    </div>
</div>

<script>
    let selectedPostId = null;
    let isOwner = false;

    function openOtherModal(postId, postOwnerId, currentUserId) {
        selectedPostId = postId;
        isOwner = (postOwnerId === currentUserId);

        document.getElementById("deletePost").style.display = isOwner ? "block" : "none";
        document.getElementById("hidePost").style.display = isOwner ? "block" : "none";
        document.getElementById("reportPost").style.display = isOwner ? "none" : "block";

        document.getElementById("otherModal").style.display = "flex";
    }

    function closeOtherModal() {
        document.getElementById("otherModal").style.display = "none";
        selectedPostId = null;
    }

    document.getElementById("publicPost").addEventListener("click", function () {
        window.location.href = `linkMessage?f=\${selectedPostId}`;
        closeOtherModal();
    });

    document.getElementById("goToPost").addEventListener("click", function () {
        window.location.href = `feedDetail?f=\${selectedPostId}`;
        closeOtherModal();
    });

    document.getElementById("deletePost").addEventListener("click", function () {
        if (confirm("정말로 게시글을 삭제하시겠습니까?")) {
            window.location.href = `feedDel?f=\${selectedPostId}`;
        }
        closeOtherModal();
    });

    document.getElementById("hidePost").addEventListener("click", function () {
        alert("게시글을 숨깁니다.");
        window.location.href = `feedHide?f=\${selectedPostId}`;
        closeOtherModal();
    });

    document.getElementById("reportPost").addEventListener("click", function () {
        window.location.href = `report?f=\${selectedPostId}`;
        closeOtherModal();
    });

    window.addEventListener('click', function (event) {
        const modal = document.getElementById("otherModal");
        if (event.target === modal) {
            closeOtherModal();
        }
    });

    // other-btn 클릭 시 모달 열기
    document.querySelectorAll('.other-btn').forEach(button => {
        button.addEventListener('click', function (event) {
            event.stopPropagation();  // 부모로의 클릭 이벤트 전파 방지
            const postElement = this.closest('.post');
            const postId = postElement.getAttribute('data-post-id');
            const postOwnerId = postElement.getAttribute('data-user-id');
            const currentUserId = '${now_id}'; // 현재 사용자 ID

            openOtherModal(postId, postOwnerId, currentUserId);
        });
    });

    // 좋아요 버튼 클릭 이벤트
    document.querySelectorAll('.like-btn').forEach(button => {
        button.addEventListener('click', function (event) {
            event.stopPropagation(); // 클릭 이벤트 전파 방지
            const feedId = this.getAttribute('data-feed-id');
            const nowId = this.getAttribute('data-now-id');

            fetch('/whale/feedLike', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: new URLSearchParams({
                    'feedId': feedId,
                    'now_id': nowId
                })
            })
                .then(response => response.json()) // 서버에서 JSON 응답을 기대
                .then(data => {
                    if (data.success) {
                        // 좋아요 수 업데이트
                        this.querySelector('.like-count').textContent = data.newLikeCount;
                    } else {
                        alert("좋아요 처리에 실패했습니다.");
                    }
                })
                .catch(error => console.error('Error:', error));
        });
    });

    // 피드 클릭 시 상세 페이지로 이동
    document.querySelectorAll('.post').forEach(post => {
        post.addEventListener('click', function () {
            const postId = this.getAttribute('data-post-id');
            window.location.href = `feedDetail?f=\${postId}`;
        });
    });

    document.querySelectorAll('label[onclick^="playMusic"], label[onclick^="pauseMusic"]').forEach(element => {
        element.addEventListener('click', function (event) {
            event.stopPropagation(); // 이벤트 전파 방지
        });
    });

    // 내부 요소 클릭 시 이벤트 전파 방지
    document.querySelectorAll('.post .other-btn, .post .like-btn, .post .comments, .post .user-info a').forEach(element => {
        element.addEventListener('click', function (event) {
            event.stopPropagation();
        });
    });

    document.querySelector('.feed').addEventListener('click', function (event) {
        // 좋아요 버튼 처리
        if (event.target.closest('.like-btn')) {
            const button = event.target.closest('.like-btn');
            const feedId = button.getAttribute('data-feed-id');
            /* const nowId = button.getAttribute('data-now-id'); */
            var nowId = "${sessionScope.user_id}";

            fetch('/whale/feedLike', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: new URLSearchParams({
                    'feedId': feedId,
                    'now_id': nowId
                })
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        button.querySelector('.like-count').textContent = data.newLikeCount;
                    } else {
                        alert("좋아요 처리에 실패했습니다.");
                    }
                })
                .catch(error => console.error('Error:', error));
            event.stopPropagation(); // 클릭 이벤트 전파 방지
        }

        // 모달 열기 처리
        if (event.target.closest('.other-btn')) {
            const button = event.target.closest('.other-btn');
            const postElement = button.closest('.post');
            const postId = postElement.getAttribute('data-post-id');
            const postOwnerId = postElement.getAttribute('data-user-id');
            const currentUserId = '${now_id}'; // 현재 사용자 ID

            openOtherModal(postId, postOwnerId, currentUserId);
            event.stopPropagation(); // 클릭 이벤트 전파 방지
        }

        // 피드 상세 페이지 이동 처리
        if (event.target.closest('.post') && !event.target.closest('.like-btn') && !event.target.closest('.other-btn')) {
            const postId = event.target.closest('.post').getAttribute('data-post-id');
            window.location.href = `feedDetail?f=\${postId}`;
        }
    });

    var offset = 10;  // 첫 로딩에서 시작하는 offset 값
    const size = 10;  // 한 번에 가져올 피드 수
    var isLastPage = false;  // 마지막 페이지 여부를 추적
    var isLoading = false;  // 로딩 상태를 추적

    function loadMoreFeeds() {
        if (isLoading || isLastPage) {
            return;  // 이미 로딩 중이거나 마지막 페이지라면 더 이상 요청하지 않음
        }

        isLoading = true;  // 로딩 시작 상태로 변경

        // 서버로 offset과 size를 전송하여 피드 데이터를 가져옴
        fetch(`/whale/loadMoreFeeds?offset=\${offset}&size=\${size}`)
            .then(response => response.text())
            .then(newFeeds => {
                const feedContainer = document.querySelector('.feed');
                feedContainer.insertAdjacentHTML('beforeend', newFeeds);  // 피드를 추가합니다.

                offset += size;  // 다음 요청을 위해 offset 값을 업데이트

                // 서버로부터 마지막 페이지 여부 확인 (예: hidden input으로 받았다고 가정)
                const isLastPageElement = document.getElementById('isLastPage');
                if (isLastPageElement) {
                    isLastPage = isLastPageElement.value === "true";
                }

                isLoading = false;  // 로딩 상태 해제
            })
            .catch(error => {
                console.error("피드 로드 실패:", error);
                isLoading = false;  // 실패 시에도 로딩 상태 해제
            });
    }

    // 스크롤 이벤트로 페이지 끝에 도달했을 때 추가 피드 로드
    window.addEventListener('scroll', () => {
        if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight) {
            loadMoreFeeds();  // 페이지 끝에 도달하면 피드 로드를 시작
        }
    });

    // 펜 이미지를 클릭하면 글 작성 영역이 확장됨
    document.getElementById('writeButton').addEventListener('click', function () {
        const writeAreaContainer = document.getElementById('writeAreaContainer');
        writeAreaContainer.classList.toggle('open'); // 클릭 시 open 클래스를 토글
        
        writeAreaContainer.scrollIntoView({ behavior: 'smooth', block: 'start' });
    });


    function playMusic(element, spotifyId) {
        resetAllButtons();
        fetch(`/whale/feedPlayMusic?id=\${spotifyId}`)
            .then(response => {
                if (response.ok) {
                    // Play 버튼 숨기고 Pause 버튼 보이기
                    element.style.display = 'none';
                    const pauseBtn = element.parentElement.querySelector('label[onclick^="pauseMusic"]');
                    if (pauseBtn) {
                        pauseBtn.style.display = 'inline-block';
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
        fetch('/whale/feedPauseMusic?id=${spotifyId}')
            .then(response => {
                if (response.ok) {
                    // Pause 버튼 숨기고 Play 버튼 보이기
                    element.style.display = 'none';
                    const playBtn = element.parentElement.querySelector('label[onclick^="playMusic"]');
                    if (playBtn) {
                        playBtn.style.display = 'inline-block';
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

    function resetAllButtons() {
        // 모든 play 버튼을 표시하고 pause 버튼을 숨깁니다.
        document.querySelectorAll('.play-button').forEach(playBtn => {
            playBtn.style.display = 'inline-block';
        });

        document.querySelectorAll('.pause-button').forEach(pauseBtn => {
            pauseBtn.style.display = 'none';
        });
    }

    document.addEventListener("DOMContentLoaded", function () {
        const settingElement = document.querySelector('.setting-body');
        const feedElement = document.querySelector('.feed-container');
        const toggleSlide = document.getElementById('toggle-slide');
        let darkmodeOn = localStorage.getItem('darkmodeOn') || "0";

        const updateScrollbarStyle = () => {
            const styleSheet = document.getElementById("darkmode-scrollbar-styles");
            if (darkmodeOn === "1") {
                styleSheet.innerHTML = `
                html::-webkit-scrollbar {display: block; width: 8px;}
                html::-webkit-scrollbar-track {background: #2e2e2e;}
                html::-webkit-scrollbar-thumb {background-color: #555; border-radius: 4px;}
                html {width: 100%; height: 190px; overflow-y: auto; scroll-behavior: smooth; display: flex; flex-direction: column;}
            `;
            } else {
                styleSheet.innerHTML = `
                html::-webkit-scrollbar {display: block; width: 8px;}
                html::-webkit-scrollbar-track {background: #fff;}
                html::-webkit-scrollbar-thumb {background-color: #ccc; border-radius: 4px;}
                html {width: 100%; height: 190px; overflow-y: auto; scroll-behavior: smooth; display: flex; flex-direction: column;}
            `;
            }
        };

        if (settingElement) {
            settingElement.setAttribute("data-darkmode", darkmodeOn);
            const isDarkMode = darkmodeOn === "1";
            toggleSlide.checked = isDarkMode;
            settingElement.classList.toggle("dark", isDarkMode);
            settingElement.classList.toggle("light", !isDarkMode);

            toggleSlide.addEventListener('change', function () {
                darkmodeOn = this.checked ? "1" : "0";
                localStorage.setItem('darkmodeOn', darkmodeOn);
                settingElement.setAttribute("data-darkmode", darkmodeOn);
                settingElement.classList.toggle("dark", darkmodeOn === "1");
                settingElement.classList.toggle("light", darkmodeOn !== "1");
                window.parent.postMessage({ darkmodeOn: darkmodeOn }, "*");

                const xhr = new XMLHttpRequest();
                xhr.open('POST', '/whale/updateDarkmode', true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xhr.send('darkmode_setting_onoff=' + darkmodeOn);
            });
        }

        if (feedElement) {
            feedElement.setAttribute("data-darkmode", darkmodeOn);
            const isDarkMode = darkmodeOn === "1";
            feedElement.classList.toggle("dark", isDarkMode);
            feedElement.classList.toggle("light", !isDarkMode);

            window.addEventListener('message', function (event) {
                if (event.data && event.data.darkmodeOn !== undefined) {
                    darkmodeOn = event.data.darkmodeOn;
                    feedElement.setAttribute("data-darkmode", darkmodeOn);
                    const isDarkMode = darkmodeOn === "1";
                    feedElement.classList.toggle("dark", isDarkMode);
                    feedElement.classList.toggle("light", !isDarkMode);

                    updateScrollbarStyle(); // 스크롤바 스타일 업데이트
                }
            });
        }

        window.addEventListener('storage', function (event) {
            if (event.key === 'darkmodeOn') {
                darkmodeOn = event.newValue || "0";
                if (settingElement) {
                    settingElement.setAttribute("data-darkmode", darkmodeOn);
                    const isDark = darkmodeOn === "1";
                    settingElement.classList.toggle("dark", isDark);
                    settingElement.classList.toggle("light", !isDark);
                    toggleSlide.checked = isDark;
                }
                if (feedElement) {
                    feedElement.setAttribute("data-darkmode", darkmodeOn);
                    const isDark = darkmodeOn === "1";
                    feedElement.classList.toggle("dark", isDark);
                    feedElement.classList.toggle("light", !isDark);
                }
                updateScrollbarStyle(); // 스크롤바 스타일 업데이트
            }
        });

        // 초기 페이지 로드 시 스크롤바 스타일 적용
        updateScrollbarStyle();
    });
</script>

</body>
</html>