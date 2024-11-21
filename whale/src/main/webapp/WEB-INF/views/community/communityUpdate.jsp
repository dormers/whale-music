<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
<!-- CKEditor CDN -->
<script src="https://cdn.ckeditor.com/4.20.0/standard/ckeditor.js"></script>
<script src="static/js/setting/darkMode.js"></script>
<link rel="stylesheet" href="static/css/streaming/searchView.css" />
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<!-- CSS 스타일 추가 -->
<style>
    /* 전체 레이아웃 설정 */
    body {
        font-family: 'Nanum Gothic', '돋움', 'Dotum', sans-serif;
        margin: 0;
        padding: 0;
    }
    
    ::-webkit-scrollbar {
    	display: none;
    }

    /* 컨테이너 */
    .container {
        width: 700px;
        margin: 50px auto;
        padding: 40px;
        box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    }
    
    .container[data-darkmode="0"] {background-color: #ffffff;}
    .container[data-darkmode="1"] {background-color: #2e2e2e;}

    /* 제목 */
    h1 {
        font-size: 24px;
        margin-bottom: 20px;
    }
    
    .container[data-darkmode="0"] h1 {color: #333333;}
    .container[data-darkmode="1"] h1 {color: whitesmoke; opacity: 0.6;}

    /* 폼 요소 */
    .form-group {
        margin-bottom: 20px;
    }

    .form-group label {
        display: block;
        font-size: 14px;
        margin-bottom: 5px;
    }
    
    .container[data-darkmode="0"] .form-group label {color: #666666;}
    .container[data-darkmode="1"] .form-group label {color: whitesmoke; opacity: 0.8;}

    .form-group input[type="text"],
    .form-group select {
        width: 100%;
        padding: 10px;
        border: 1px solid #dddddd;
        border-radius: 4px;
        font-size: 14px;
    }
    
    .container[data-darkmode="1"] .form-group input[type="text"], .form-group select {background-color: #d2d2d2; opacity: 0.8;}
    
    .container[data-darkmode="0"] .form-group input[readonly] {background-color: #f0f0f0;}
    .container[data-darkmode="1"] .form-group input[readonly] {background-color: whitesmoke; opacity: 0.8;}

    /* CKEditor 스타일 조정 */
    #post_text {
        width: 100%;
        height: 800px;
    }

    /* 음악 업로드 버튼 */
    .music-upload-btn {
        display: inline-block;
        background-color: #ffffff;
        border: 1px solid #dddddd;
        padding: 10px 15px;
        font-size: 14px;
        cursor: pointer;
        border-radius: 4px;
        margin-top: 10px;
    }
    
    .container[data-darkmode="0"] .form-group .music-upload-btn {color: gray;}
    .container[data-darkmode="1"] .form-group .music-upload-btn {color: #1f1f1f; opacity: 0.8;}

    .music-upload-btn img {
        vertical-align: middle;
        margin-right: 5px;
    }

    .music-upload-btn:hover {
        background-color: #f9f9f9;
    }

    /* 음악 정보 미리보기 */
    .music-info {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 10px;
        background-color: #f9f9f9;
        border: 1px solid #dddddd;
        border-radius: 4px;
        margin-top: 10px;
    }

    .music-info img {
        width: 50px;
        height: 50px;
        border-radius: 4px;
        margin: 0 5px;
    }
    
    .music-info #music-title {font-weight: bold; font-size: 1em; color: #333; /* 기본 검정색 */}
    .music-info #artist-name {font-weight: normal; font-size: 0.9em; color: #777; /* 회색 */}

    /* 버튼 스타일 */
    .button-group {
        text-align: center;
        margin-top: 30px;
    }

    .button-group input[type="submit"],
    .button-group input[type="button"] {
        background-color: #777777;
        color: black;
        border: none;
        padding: 13px 30px;
        font-size: 16px;
        cursor: pointer;
        border-radius: 4px;
        margin: 0 15px;
        font-weight: 600;
    }

    .button-group input[type="button"] {
        background-color: #d2d2d2;
    }

    .button-group input[type="submit"]:hover,
    .button-group input[type="button"]:hover {
        background-color: #f2f2f2;
    }

    /* 모달 스타일 */
    .modal {
        display: none;
        position: fixed;
        z-index: 1000;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.6);
        justify-content: center;
        align-items: center;
    }

    .modal .modal-content {
        width: 60%;
        border-radius: 4px;
        max-width: 600px;
        max-height: 700px;
        text-align: center;
        overflow: hidden;
    }
    
    #musicModal[data-darkmode="0"] .modal-content {background-color: #ffffff;}
    #musicModal[data-darkmode="1"] .modal-content {background-color: #2e2e2e;}
    #musicModal[data-darkmode="1"] .search-result-container {color: whitesmoke;}
    #musicModal[data-darkmode="1"] .pageBtn {color: whitesmoke;}

    /* 검색 섹션 스타일 */
    .searchContainer {
    	margin-top: 20px;
    }

    .headerSearch {
        display: flex;
        align-items: center;
        width: 60&;
    }
    
    .search-result-container {
    	margin: 0 0 15px 0;
    }

    /* 모달 버튼 */
    
	.modal-button-group {
	    display: flex;
	    justify-content: center; /* 버튼을 가운데 정렬 */
	    margin: 0 0 30px 0;
	}
	
	.modal-btn {
	    background-color: transparent;
	    color: gray;
	    border: 1px solid #d2d2d2;
	    padding: 10px 30px;
	    font-size: 14px;
	    cursor: pointer;
	    border-radius: 4px;
	    transition: background-color 0.3s;
	}
	
	.modal-btn:hover {
	    background-color: #f2f2f2;
	}

    #remove-music-btn {
	    margin-left: auto;
	    background-color: transparent;
	    border: none;
	    font-size: 20px;
	    cursor: pointer;
	    color: #888888;
	}

	#remove-music-btn:hover {
	    color: #ff0000;
	}

</style>
</head>
<body>
    <div class="container" data-darkmode="${darkMode.scndAttrName}">
        <h1>게시글 수정</h1>
        <form action="communityUpdateDo" method="post" enctype="multipart/form-data" onsubmit="validateForm(event)">
            <!-- 포스트 아이디 전달 -->
            <input type="hidden" name="post_id" value="${post.post_id}" />
            <div class="form-group">
                <label for="post_tag_id">태그</label>
                <select name="post_tag_id" id="post_tag_id">
                    <c:forEach items="${postTag}" var="p">
                        <option value="${p.post_tag_id}" <c:if test="${p.post_tag_id == post.post_tag_id}">selected</c:if>>
                            ${p.post_tag_text}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group">
                <label for="community_name">커뮤니티</label>
                <input type="text" name="community_name" id="community_name" value="${communityName}" readonly />
                <input type="hidden" name="community_id" value="${communityId}" />
            </div>

            <div class="form-group">
                <label for="post_title">제목</label>
                <input type="text" name="post_title" id="post_title" value="${post.post_title}" />
            </div>

            <div class="form-group">
                <label for="user_id">글쓴이</label>
                <input type="text" name="user_id" id="user_id" value="${now_id}" readonly />
            </div>

            <div class="form-group">
                <label for="post_text">내용</label>
                <textarea name="post_text" id="post_text">${post.post_text}</textarea>
            </div>

            <div class="form-group">
                <label class="music-upload-btn">
                    <img src="static/images/btn/music_btn.png" alt="음악 업로드" width="20" height="20">
                    음악 추가
                </label>
                <input type="hidden" name="selectedTrackId" id="selectedTrackId" value="${post.track_id != null ? post.track_id : ''}">
            </div>

            <!-- 음악 정보 미리보기 영역 -->
            <div id="music-info" class="music-info" style="display: ${post.track_id != null ? 'flex' : 'none'};">
                <img id="album-icon" src="${post.track_cover != null ? post.track_cover : ''}" alt="Album Icon">
                <div>
                    <strong id="music-title">${post.track_name != null ? post.track_name : ''}</strong><br>
                    <span id="artist-name">${post.track_artist != null ? post.track_artist : ''}</span>
                </div>
                    <button type="button" id="remove-music-btn" style="margin-left: auto; background-color: transparent; border: none; cursor: pointer;">
				        ✕
				    </button>
            </div>

            <div class="button-group">
                <input type="submit" value="업데이트" />
                <input type="button" value="취소" onClick="location.href='communityPost?c=${param.c}'" />
            </div>
        </form>
    </div>

    <!-- 음악 선택 모달 -->
    <div id="musicModal" class="modal">
        <div class="modal-content">
            <div class="searchContainer">
                <div class="headerSearch">
                    <input class="headerInput" id="search-input" placeholder="어떤 음악을 찾으시나요?" onfocus="this.placeholder=''" onblur="this.placeholder='어떤 음악을 찾으시나요?'">
                    <button class="searchBtn" id="search-button">
                        <img src="static/images/streaming/searchBtn.png" alt="검색 버튼" height="14px">
                    </button>
                </div>
            </div>
            <div class="search-result-container">
                <div id="pagination"></div>
                <div id="search-results"></div>
            </div>
            <div class="modal-button-group">
                <button class="modal-btn" id="completeBtn">완료</button>
            </div>
        </div>
    </div>

    <!-- CKEditor 초기화 -->
    <script type="text/javascript">
        CKEDITOR.replace('post_text', {
            language: 'ko',
            height: 500
        });
    </script>

    <!-- 음악 업로드 관련 스크립트 -->
    <script>
    
    document.getElementById("remove-music-btn").addEventListener("click", function() {
        // 음악 미리보기 영역 숨기기
        document.getElementById("music-info").style.display = "none";

        // selectedTrackId 값을 빈 문자열로 설정
        document.getElementById("selectedTrackId").value = "";
    });
    
    function openMusicModal() {
        const musicModal = document.getElementById("musicModal");
        musicModal.style.display = "flex";
    }

    function closeMusicModal() {
        const musicModal = document.getElementById("musicModal");
        musicModal.style.display = "none";
    }

    document.querySelector('.music-upload-btn').addEventListener('click', function(event) {
        event.preventDefault();
        openMusicModal();
    });

    window.addEventListener('click', function(event) {
        const musicModal = document.getElementById("musicModal");
        if (event.target === musicModal) {
            closeMusicModal();
        }
    });

    document.getElementById("completeBtn").addEventListener("click", function() {
        const selectedTrackInput = document.querySelector('input[name="track"]:checked');
        if (!selectedTrackInput) {
            alert("음악을 선택해주세요.");
            return;
        }

        const body = selectedTrackInput.value;

        fetch('/whale/updateMusic', {
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            method: 'POST',
            body: body
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('서버 응답에 문제가 있습니다: ' + response.statusText);
            }
            return response.json();
        })
        .then(data => {
            console.log('서버로부터 받은 데이터:', data);

            // 음악 정보를 미리보기 영역에 표시
            document.getElementById("album-icon").src = data.track_cover;
            document.getElementById("music-title").textContent = data.track_name;
            document.getElementById("artist-name").textContent = data.track_artist;

            // 음악 정보 영역을 보여주도록 설정
            document.getElementById("music-info").style.display = "flex";

            // 음악 정보를 숨겨진 필드에 저장 (폼 제출 시 전송하기 위해)
            document.getElementById("selectedTrackId").value = data.track_id;

            // 모달을 닫습니다
            closeMusicModal();
        })
        .catch(error => {
            console.error('에러 발생:', error);
            alert('음악 정보를 가져오는 중 오류가 발생했습니다.');
        });
    });
    </script>

    <!-- 음악 검색 및 페이징 기능 스크립트 추가 -->
    <script src="static/js/streaming/searchView.js"></script>

    <!-- 폼 검증 함수 -->
    <script type="text/javascript">
        function validateForm(event) {
            var post_title = document.getElementById("post_title").value.trim();
            var post_text = CKEDITOR.instances.post_text.getData().trim();

            if (post_title === "" || post_text === "") {
                alert("제목과 내용을 모두 작성해 주세요.");
                event.preventDefault();  // 폼 제출을 중단
                return false;
            }

            return true;
        }
    </script>

    <!-- 이미지 삭제 관련 스크립트 제거 -->
</body>
</html>