<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>profileEdit</title>
<link rel="stylesheet" href="static/css/setting/settingStyle.css" />
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="static/js/setting/setting.js"></script>
<style>
.complete-btn {
	font-size: 15px;
	position: absolute;
	top: 15px;
	right: 7px;
	background-color: transparent; /* 버튼의 배경색을 투명으로 설정 */
	border: none;
	padding: 5px 10px;
	border-radius: 4px;
	cursor: pointer;
	font-weight: bold;
}

.complete-btn:hover {
	color: #5A5A5A;
}
.setting-item {
    flex-direction: column; /* 세로 방향으로 정렬 */
    padding: 10px;
}
.setting-item img {
    width: 100px;
    height: 100px;
    border-radius: 100px;
    margin-top: 10px;
}
.setting-item button {
	border-color: white;
	background-color: white;
	border-style: none;
    border: none;
    background: none;
    color: blue;
    cursor: pointer;
}
#editPhotoBtn {
	font-weight: bold;	
}
table{
	margin-top: 10px;
}
table tr td {
	font-weight: bold;
	padding: 10px 50px 3px 20px;
}
input[type="text"], input[type="password"], input[type="email"] {
	width: 100%;
	padding: 5px;
	background-color: #E2E2E2;
	border: none; /* 테두리 없애기 */
	border-bottom: 2px solid #ccc; /* 밑줄 추가 */
	outline: none; /* 포커스 시 파란 테두리 없애기 */
}
input[type="text"]:focus, input[type="password"]:focus, input[type="email"]:focus {
	border-bottom: 2px solid #7E7E7E; /* 포커스 시 밑줄 색 변경 */
}
</style>
<script>
window.onload = function() {
    var fileInput = document.getElementById("fileInput");

    // 사진 수정 버튼 클릭 시 파일 선택 창 열기
    document.getElementById("editPhotoBtn").addEventListener("click", function() {
        fileInput.click();
    });

    // 파일 선택 시 미리보기 및 서버에 파일 업로드
    fileInput.addEventListener("change", function(event) {
        previewAndUploadImage(event);
    });

    // 이미지 미리보기 및 서버로 파일 전송
    function previewAndUploadImage(event) {
        var reader = new FileReader();
        reader.onload = function(e) {
            document.getElementById("profileImage").src = e.target.result;
        };
        reader.readAsDataURL(event.target.files[0]);

        // 파일 서버에 업로드
        var formData = new FormData();
        formData.append('file', event.target.files[0]);

        fetch('/whale/uploadProfileImage', {
            method: 'POST',
            body: formData
        }).then(response => response.json())
          .then(data => {
              if (data.status === 'success') {
                  console.log('Image uploaded and saved in session: ' + data.fileName);
              } else {
                  console.error('Image upload failed');
              }
          }).catch(error => console.error('Error:', error));
    }
    
    var button = document.getElementById("editPhotoBtn");
      
      // 버튼이 눌렸을 경우
      button.addEventListener("mousedown", function() {
         this.style.color = "gray";
      });
      
	  // 버튼 뗐을 경우
      button.addEventListener("mouseup", function() {
         console.log("버튼 클릭")
         this.style.color = "blue";
      });
      
   	  // 완료 버튼 클릭 시 데이터 업데이트
      document.getElementById("completeBtn").addEventListener("click", function() {
          document.getElementById("profileForm").submit();
      });
};

</script>
</head>
<body>
	<div class="setting-body">
		<div class="setting-container">
			<div class="setting-header">
				프로필 편집
				<button type="button" id="completeBtn" class="complete-btn">완료</button> <!-- 버튼 클릭 시 폼 제출 -->
			</div>
			<!-- 프로필 정보 수정 폼 -->
			<form id="profileForm" action="/whale/updateProfile" method="post">
				<div class="setting-item">
					<img id="profileImage" src="static/images/setting/${profile.user_image_url}" alt="프로필 사진" />
					<!-- 파일 선택 필드 -->
					<input id="fileInput" type="file" name="file" style="display: none;" onchange="previewImage(event)"> <br>
					<!-- 사진 수정 버튼 -->
					<button type="button" id="editPhotoBtn">사진 수정</button>
					<hr />
				</div>
				<table>
					<tr>
						<td>아이디</td>
						<td><input type="text" name="user_nickname"
							value="${profile.user_nickname}" /></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="user_password"
							value="${profile.user_password}" /></td>
					</tr>
					<tr>
						<td>대표곡 설정</td>
						<td><a href="representiveSong">대표곡 설정</a></td>
					</tr>
					<tr>
						<td>이메일</td>
						<td><input type="email" name="user_email"
							value="${profile.user_email}" /></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>