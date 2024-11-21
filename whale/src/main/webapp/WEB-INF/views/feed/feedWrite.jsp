<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="write-area">
    <form action="feedWriteDo" method="post" enctype="multipart/form-data" onsubmit="validateForm(event)">
        <div class="form-content">
            <br />
			<label for="music-upload" class="music-upload-btn">
			    <img src="static/images/btn/music_btn.png" alt="업로드" style="vertical-align: middle; width: 40px; height: 40px;">
			</label>
			<input type="file" id="imageInput" accept="image/*" onchange="uploadImageAndDisplayPreview()" style="display:none;">
			<label for="imageInput" class="file-upload-btn">
			    <img src="static/images/btn/upload_btn.png" alt="이미지 업로드" style="vertical-align: middle; width: 40px; height: 40px;">
			</label>
			<img id="preview" src="#" alt="이미지 미리보기" style="display:none; max-width:100%; height:auto;">
			<input type="hidden" name="feedImageUrl" id="feedImageUrl">
            <br>
            <div id="music-info" class="music-info" style="display: none; width: 80%; max-width: 1200px; margin: 15px auto;">
                <img id="album-icon" src="" alt="Album Icon" style="width: 50px; height: 50px; margin-left: 10px;">
                <div style="margin-left: -25px;">
                    <span id="music-title"></span> - <span id="artist-name"></span>
                </div>
            </div>
            <input type="hidden" name="selectedTrackId" id="selectedTrackId">
            <br />
            <textarea name="feedText" placeholder="Write something..."></textarea>
            <br>
            <button type="submit" class="submit-btn"><img class="write-btn" src="static/images/btn/write_btn.png" alt="글 작성" /></button>
        </div>
    </form>
</div>

<div id="musicModal" class="modal">
    <div class="modal-content-music">
	  	<div class="searchContainer" style="margin-top: 20px;">
			<div class="headerSearch" style="width: 60%;">
				<button class="searchBtn" id="search-button">
					<img src="static/images/streaming/searchBtn.png" alt="Music Whale Search Button" height="14px">
			    </button>
			    <input class="headerInput" id="search-input" placeholder="어떤 콘텐츠를 감상하고 싶으세요?" onfocus="this.placeholder=''" onblur="this.placeholder='어떤 콘텐츠를 감상하고 싶으세요?'">
			</div>
		</div>
		<div class="search-result-container">
			<div id="pagination" style="margin-top: 3px;"></div>
			<div id="search-results"></div>
		</div>
		<div class="modal-item gray" id="completeBtn" style="margin-top: -14px;">완료</div>
        <div class="modal-item gray" onclick="closeMusicModal()">취소</div>
    </div>
</div>
    
<script>
    window.addEventListener('click', function(event) {
        const modal = document.getElementById("musicModal");
        if (event.target === modal) {
            closeOtherModal();
        }
    });

    document.querySelectorAll('.music-upload-btn').forEach(button => {
        button.addEventListener('click', function(event) {
            event.stopPropagation();  // 부모로의 클릭 이벤트 전파 방지
            openMusicModal();  // 모달을 여는 함수 호출
        });
    });
    
    function openMusicModal() {
        const musicModal = document.getElementById("musicModal");
        musicModal.style.display = "flex";  // 모달을 표시
    }

    function closeMusicModal() {
        const musicModal = document.getElementById("musicModal");
        musicModal.style.display = "none";  // 모달을 닫음
    }

    window.addEventListener('click', function(event) {
        const musicModal = document.getElementById("musicModal");
        if (event.target === musicModal) {
            closeMusicModal();  // 모달 바깥을 클릭하면 닫음
        }
    });
    
    document.getElementById("completeBtn").addEventListener("click", function() {
        const selectedTrackInput = document.querySelector('input[name="track"]:checked');
        if (!selectedTrackInput) {
            alert("음악을 선택해주세요.");
            return;
        }

        // 선택한 트랙의 정보를 가져옵니다 (JSON 문자열로 가정)
        const body = selectedTrackInput.value;

        // 서버로 선택한 트랙 정보를 POST 요청으로 전송합니다
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

            // 서버로부터 받은 데이터를 사용하여 music-info 섹션을 업데이트합니다
            const musicInfo = {
                albumIcon: data.track_cover,
                musicTitle: data.track_name,
                artistName: data.track_artist
            };

            // 음악 정보를 미리보기 영역에 표시
            document.getElementById("album-icon").src = musicInfo.albumIcon;
            document.getElementById("music-title").textContent = musicInfo.musicTitle;
            document.getElementById("artist-name").textContent = musicInfo.artistName;

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

<script src="static/js/streaming/searchView.js"></script>
    
<script type="text/javascript">
	function uploadImageAndDisplayPreview() {
	    const fileInput = document.getElementById("imageInput");
	    const file = fileInput.files[0];
	    if (file) {
	        const formData = new FormData();
	        formData.append("file", file);
	
	        $.ajax({
	            url: "/whale/uploadImageFeed",
	            type: "POST",
	            data: formData,
	            contentType: false,
	            processData: false,
	            success: function(response) {
	                const imageUrl = response.imageUrl;
	                document.getElementById("feedImageUrl").value = imageUrl;
	                // 미리보기 이미지 설정
	                const preview = document.getElementById('preview');
	                preview.src = imageUrl;
	                preview.style.display = 'block';
	            },
	            error: function(error) {
	                console.error("Image upload failed:", error);
	                alert("이미지 업로드에 실패하였습니다.");
	            }
	        });
	    }
	}
    
    function validateForm(event) {
        var feedImage = document.getElementsByName("feedImageUrl")[0].value.trim();
        var feedText = document.getElementsByName("feedText")[0].value.trim();
        if (feedImage === "" || feedText === "") {
            alert("사진과 글을 모두 작성해주세요.");
            event.preventDefault();  // 폼 제출을 중단
            return false;
        }
        return true;
    }
</script>

<style>
	.feed-container[data-darkmode="1"] .music-info { display: flex; align-items: center; gap: 10px; padding: 10px; background-color: #434343; border-radius: 5px; margin-bottom: 10px; }
	.feed-container[data-darkmode="1"] .modal { display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.6); justify-content: center; align-items: center; }
	.feed-container[data-darkmode="1"] .modal .modal-content-music { background-color: #414141; border-radius: 12px; width: 50%; height: 80%; text-align: center; overflow: hidden; }
	.feed-container[data-darkmode="1"] .write-area { text-align: center; }
	.feed-container[data-darkmode="1"] .form-content { width: 80%; max-width: 1200px; margin: 0 auto; text-align: center; }
	.feed-container[data-darkmode="1"] textarea { width: 100%; max-width: 100%; box-sizing: border-box; padding: 10px; margin-bottom: 10px; }
	.feed-container[data-darkmode="1"] input[type="file"] { display: none; }
	.feed-container[data-darkmode="1"] .file-upload-btn { width: 80%; max-width: 1200px; background-color: #2e2e2e; color: #333; border: none; padding: 10px 20px; font-size: 16px; cursor: pointer; border-radius: 5px; transition: background-color 0.3s; display: inline-block; margin-bottom: 10px; }
	.feed-container[data-darkmode="1"] .file-upload-btn:hover { background-color: #252525; }
	.feed-container[data-darkmode="1"] .music-upload-btn { width: 80%; max-width: 1200px; background-color: #2e2e2e; color: #333; border: none; padding: 10px 20px; font-size: 16px; cursor: pointer; border-radius: 5px; transition: background-color 0.3s; display: inline-block; margin-bottom: 10px; }
	.feed-container[data-darkmode="1"] .music-upload-btn:hover { background-color: #252525; }
	.feed-container[data-darkmode="1"] img#preview { max-width: 60%; height: auto; display: block; margin: 10px auto; }
	.feed-container[data-darkmode="1"] .write-btn { width: 40px; height: 40px; }
	.feed-container[data-darkmode="1"] .submit-btn { background-color: #2e2e2e; color: #333; border: none; padding: 10px 20px; font-size: 16px; cursor: pointer; border-radius: 5px; transition: background-color 0.3s; }
	.feed-container[data-darkmode="1"] .submit-btn:hover { background-color: #335580; }
	.feed-container[data-darkmode="1"] .submit-btn:hover img{filter: brightness(100);}
	.pageBtn { margin-top: 2px; }
/*-----------------------------------------------------------------------------------------------------------------------------*/
	.feed-container[data-darkmode="0"] .music-info { display: flex; align-items: center; gap: 10px; padding: 10px; background-color: #f9f9f9; border-radius: 5px; margin-bottom: 10px; }
	.feed-container[data-darkmode="0"] .modal { display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.6); justify-content: center; align-items: center; }
	.feed-container[data-darkmode="0"] .modal .modal-content-music { background-color: white; border-radius: 12px; width: 50%; height: 80%; text-align: center; overflow: hidden; }
	.feed-container[data-darkmode="0"] .write-area { text-align: center; }
	.feed-container[data-darkmode="0"] .form-content { width: 80%; max-width: 1200px; margin: 0 auto; text-align: center; }
	.feed-container[data-darkmode="0"] textarea { width: 100%; max-width: 100%; box-sizing: border-box; padding: 10px; margin-bottom: 10px; }
	.feed-container[data-darkmode="0"] input[type="file"] { display: none; }
	.feed-container[data-darkmode="0"] .file-upload-btn { width: 80%; max-width: 1200px; background-color: #f0f0f0; color: #333; border: none; padding: 10px 20px; font-size: 16px; cursor: pointer; border-radius: 5px; transition: background-color 0.3s; display: inline-block; margin-bottom: 10px; }
	.feed-container[data-darkmode="0"] .file-upload-btn:hover { background-color: #e0e0e0; }
	.feed-container[data-darkmode="0"] .music-upload-btn { width: 80%; max-width: 1200px; background-color: #f0f0f0; color: #333; border: none; padding: 10px 20px; font-size: 16px; cursor: pointer; border-radius: 5px; transition: background-color 0.3s; display: inline-block; margin-bottom: 10px; }
	.feed-container[data-darkmode="0"] .music-upload-btn:hover { background-color: #e0e0e0; }
	.feed-container[data-darkmode="0"] img#preview { max-width: 60%; height: auto; display: block; margin: 10px auto; }
	.feed-container[data-darkmode="0"] .write-btn { width: 40px; height: 40px; }
	.feed-container[data-darkmode="0"] .submit-btn { background-color: #f0f0f0; color: #333; border: none; padding: 10px 20px; font-size: 16px; cursor: pointer; border-radius: 5px; transition: background-color 0.3s; }
	.feed-container[data-darkmode="0"] .submit-btn:hover { background-color: #e0e0e0; }
	.pageBtn { margin-top: 2px; }
</style>