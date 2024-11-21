<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- CKEditor CDN -->
<script src="https://cdn.ckeditor.com/4.20.0/standard/ckeditor.js"></script>
<link rel="stylesheet" href="/whale/static/css/streaming/searchView.css" />
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<!-- CKEditor 초기화 -->
<script type="text/javascript">
	window.onload = function() {
	    CKEDITOR.replace('post_text', {
	        language: 'ko',
	        height: 500
	    });
	};

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
<script src="/whale/static/js/streaming/searchView.js" ></script>

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

<div class="content" name="content" id="content">
    <div class="container">
        <h1>게시글 수정</h1>
        <form action="adminNoticeUpdateDo" method="post" enctype="multipart/form-data" onsubmit="validateForm(event)">
            <!-- 포스트 아이디 전달 -->
            <input type="hidden" name="post_id" value="${postDetail.post_id}" />
            <div class="form-group">
                <label for="post_tag_id">태그</label>
                <input type="text" name="post_tag_text" id="post_tag_text" value="${postDetail.post_tag_text}" readonly />
                <input type="hidden" name="post_tag_id" id="post_tag_id" value="${postDetail.post_tag_id}"/>
            </div>

            <div class="form-group">
                <label for="community_name">커뮤니티</label>
                <input type="text" name="community_name" id="community_name" value="${comIdName.community_name}" readonly />
                <input type="hidden" name="community_id" value="${comIdName.community_id}" />
            </div>

            <div class="form-group">
                <label for="post_title">제목</label>
                <input type="text" name="post_title" id="post_title" value="${postDetail.post_title}" />
            </div>

            <div class="form-group">
                <label for="user_id">글쓴이</label>
                <input type="text" name="user_id" id="user_id" value="${myId}" readonly />
            </div>

            <div class="form-group">
                <label for="post_text">내용</label>
                <textarea name="post_text" id="post_text">${postDetail.post_text}</textarea>
            </div>

            <div class="button-group">
                <input type="hidden" name="searchType" value="${searchType }" />
                <input type="hidden" name="sk" value="${sk}" />
                <input type="hidden" name="page" value="${page}" />
                <input type="submit" value="업데이트" />
                <input type="button" value="취소" onClick="location.href='adminNoticeContentView?postId=${postDetail.post_id}&searchType=${searchType }&sk=${sk }$page=${page }'" />
            </div>
        </form>
    </div>
    
</div>
    
