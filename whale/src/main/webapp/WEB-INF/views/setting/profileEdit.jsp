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
<script src="static/js/setting/darkMode.js"></script>
<style>
    .setting-body[data-darkmode="0"] a { text-decoration: none; color: #335580; }
    .setting-body[data-darkmode="0"] a:visited, .setting-body[data-darkmode="0"] a:focus, .setting-body[data-darkmode="0"] a:active { color: #335580; text-decoration: none; }
    .setting-body[data-darkmode="0"] a:hover { color: black; }
    .setting-body[data-darkmode="0"] table { margin-top: 10px; }
    .setting-body[data-darkmode="0"] table tr td { padding: 10px 75px 10px 50px; }
    .setting-body[data-darkmode="0"] #back { position: absolute; left: 15px; top: 55%; transform: translateY(-50%); }
    .setting-body[data-darkmode="0"] .complete-btn { font-size: 20px; position: absolute; top: 15px; right: 7px; background-color: transparent; border: none; padding: 5px 10px; border-radius: 4px; cursor: pointer; }
    .setting-body[data-darkmode="0"] .complete-btn:hover { color: #5A5A5A; }
    .setting-body[data-darkmode="0"] .setting-item { flex-direction: column; padding: 10px; border: none; border-radius: 0px; border-bottom: 1px solid #EAEAEA; }
    .setting-body[data-darkmode="0"] .setting-item img { width: 130px; height: 130px; border-radius: 100px; margin-top: 30px; margin-left: 20px; }
    .setting-body[data-darkmode="0"] .setting-item button { border-color: white; background-color: white; border-style: none; border: none; background: none; color: #335580; cursor: pointer; margin-top: 20px; margin-bottom: 10px; }
    .setting-body[data-darkmode="0"] #editPhotoBtn { font-weight: bold; color: #335580; }
    .setting-body[data-darkmode="0"] #editPhotoBtn:active, .setting-body[data-darkmode="0"] #editPhotoBtn:focus { color: #335580; }
    .setting-body[data-darkmode="0"] input[type="text"], .setting-body[data-darkmode="0"] input[type="password"], .setting-body[data-darkmode="0"] input[type="email"] { width: 100%; padding: 5px; background-color: #FCFCFC; border: none; border-bottom: 2px solid #ccc; outline: none; }
    .setting-body[data-darkmode="0"] input[type="text"]:focus, .setting-body[data-darkmode="0"] input[type="password"]:focus, .setting-body[data-darkmode="0"] input[type="email"]:focus { border-bottom: 2px solid #7E7E7E; }
    /* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
    .setting-body[data-darkmode="1"] #back { position: absolute; left: 15px; top: 55%; transform: translateY(-50%); }
    .setting-body[data-darkmode="1"] a { text-decoration: none; color: lightgray; }
    .setting-body[data-darkmode="1"] a:visited, .setting-body[data-darkmode="1"] a:focus, .setting-body[data-darkmode="1"] a:active { color: lightgray; text-decoration: none; }
    .setting-body[data-darkmode="1"] a:hover { color: whitesmoke; }
    .setting-body[data-darkmode="1"] table { margin-top: 10px; }
    .setting-body[data-darkmode="1"] table tr td { padding: 10px 75px 10px 50px; }
    .setting-body[data-darkmode="1"] .complete-btn { font-size: 20px; position: absolute; top: 15px; right: 7px; background-color: transparent; border: none; padding: 5px 10px; border-radius: 4px; cursor: pointer; }
    .setting-body[data-darkmode="1"] .complete-btn:hover { color: lightgray; }
    .setting-body[data-darkmode="1"] .setting-item { flex-direction: column; padding: 10px; border: none; border-radius: 0px; border-bottom: 1px solid #7E7E7E; }
    .setting-body[data-darkmode="1"] .setting-item img { width: 130px; height: 130px; border-radius: 100px; margin-top: 30px; margin-left: 20px; }
    .setting-body[data-darkmode="1"] .setting-item button { border-color: rgb(46, 46, 46); background-color: rgb(46, 46, 46); border-style: none; border: none; background: none; color: whitesmoke; cursor: pointer; margin-top: 20px; margin-bottom: 10px; }
    .setting-body[data-darkmode="1"] #editPhotoBtn { font-weight: bold; color: whitesmoke; }
    .setting-body[data-darkmode="1"] #editPhotoBtn:active, .setting-body[data-darkmode="1"] #editPhotoBtn:focus { color: whitesmoke; }
    .setting-body[data-darkmode="1"] input[type="text"], .setting-body[data-darkmode="1"] input[type="password"], .setting-body[data-darkmode="1"] input[type="email"] { width: 100%; padding: 5px; color: whitesmoke; background-color: rgb(46, 46, 46); border: none; border-bottom: 2px solid #ccc; outline: none; }
    .setting-body[data-darkmode="1"] input[type="text"]:focus, .setting-body[data-darkmode="1"] input[type="password"]:focus, .setting-body[data-darkmode="1"] input[type="email"]:focus { border-bottom: 2px solid #f1f1f1; }
</style>
</head>
<body>
    <div class="setting-body">
        <div class="setting-container">
            <div class="setting-header">
                <a href="account" id="back"><img src="static/images/setting/back.png" alt="back"></a>
                프로필 편집
                <button type="button" id="completeBtn" class="complete-btn">완료</button>
            </div>
            <!-- 프로필 정보 수정 폼 -->
            <form id="profileForm" action="/whale/updateProfile" method="post">
                <div class="setting-item">
                    <img id="profileImage" src="${profile.user_image_url}" alt="profile-img" />
                    <!-- 파일 선택 필드 -->
                    <input id="fileInput" type="file" accept="image/*" style="display: none;">
                    <!-- 이미지 URL을 저장할 숨겨진 필드 -->
                    <input type="hidden" name="user_profile_image_url" id="user_profile_image_url">
                    <!-- 사진 수정 버튼 -->
                    <button type="button" id="editPhotoBtn">사진 수정</button>
                </div>
                <table>
                    <tr>
                        <td>닉네임</td>
                        <td><input type="text" name="user_nickname" value="${profile.user_nickname}" /></td>
                    </tr>
                    <tr>
                        <td>비밀번호</td>
                        <td><a href="updatePassword">비밀번호 변경</a></td>
                    </tr>
                    <tr>
                        <td>대표곡 설정</td>
                        <c:choose>
                            <c:when test="${profile.user_track_id == 'DEFAULT'}">
                                <td><a href="representiveSong">대표곡 설정</a></td>
                            </c:when>
                            <c:otherwise>
                                <td>
                                    ${profile.track_artist} - ${profile.track_name} &nbsp;
                                    <a href="representiveSong">변경</a>
                                </td>
                            </c:otherwise>
                        </c:choose>
                    </tr>
                    <tr>
                        <td>이메일</td>
                        <td><input type="email" name="user_email" value="${profile.user_email}" /></td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
    <script>
    // 페이지가 로드되었을 때 실행될 초기화 함수
    $(document).ready(function() {
        // 사진 수정 버튼 클릭 시 파일 선택 창 열기
        $('#editPhotoBtn').on('click', function() {
            $('#fileInput').click();
        });

        // 파일 선택 시 이미지 업로드 및 미리보기 함수 호출
        $('#fileInput').on('change', uploadImageAndPreview);

        // 완료 버튼 클릭 시 폼 제출
        $('#completeBtn').on('click', function() {
            $('#profileForm').submit();
        });

        // 사진 수정 버튼이 눌렸을 경우
        $('#editPhotoBtn').on('mousedown', function() {
            $(this).css('color', 'gray');
        });

        // 버튼 뗐을 경우, 다크모드 여부에 따라 색상 설정
        $('#editPhotoBtn').on('mouseup', function() {
            if ($('.setting-body').attr('data-darkmode') === '1') {
                $(this).css('color', 'whitesmoke'); // 다크모드일 경우
            } else {
                $(this).css('color', '#335580'); // 라이트모드일 경우
            }
        });
    });

    // 이미지 업로드 및 미리보기 함수
    function uploadImageAndPreview(event) {
        var file = event.target.files[0]; // 사용자가 선택한 파일 가져오기(input[type = "file"]의 change 이벤트로 전달된 파일)

        // 사용자가 파일을 선택한 경우에만 실행
        if (file) {
            // 1. 이미지 미리보기
            var reader = new FileReader(); // FileReader 객체 생성해서 파일 내용 읽을 준비

            // FileReader가 파일 읽기를 완료했을 때 호출될 콜백 함수 정의
            reader.onload = function(e) {
                // 읽은 파일 데이터를 <img> 태그의 src 속성에 설정해서 미리보기를 표시
                document.getElementById("profileImage").src = e.target.result;
            };

            // 파일을 Base64 데이터 url로 읽어오기(이미지 미리보기용)
            reader.readAsDataURL(file);

            // 2. 서버로 이미지 파일 업로드
            var formData = new FormData(); // FormData 객체 생성(파일 데이터를 서버로 전송하기 위한 포맷)
            formData.append('file', file); // FormData에 파일 데이터를 'file'이라는 키로 추가

            // jQuery AJAX 요청을 사용해 서버에 데이터 전송(구글 클라우드 스토리지에 업로드)
            $.ajax({
                url: '/whale/uploadImageSetting', // 업로드를 처릴할 서버의 url
                type: 'POST',
                data: formData, // 전송할 데이터(FormData 객체)
                contentType: false, // jQuery에서 기본적으로 데이터 url 인코딩하는 설정을 비활성화(파일 전송이므로 필요)
                processData: false, // jQuery에서 데이터를 자동으로 처리하지 않돋록 설정(파일 전송이므로 필요)
                dataType: 'json',
                // 서버로부터 성공적인 응답을 받았을 때 실행될 콜백 함수
                success: function(response) {
                    console.log('Server response:', response); // debug
                    if (response.status === 'success') {
                        var imageUrl = response.imageUrl; // 서버에서 반환된 이미지 url 저장
                        document.getElementById("user_profile_image_url").value = imageUrl; // 업로드한 이미지 url을 숨겨진 <input> 필드에 저장
                    } else {
                        console.error('Image upload failed');
                        alert('이미지 업로드에 실패했습니다.');
                    }
                },
                // 서버 요청 도중 에러 발생 시 실행될 콜백 함수
                error: function(error) {
                    console.error('Error:', error);
                    alert('이미지 업로드 중 오류가 발생했습니다.');
                }
            });
        }
    }
    </script>
</body>
</html>