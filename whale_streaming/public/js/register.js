// public/js/register.js

$(document).ready(function() {
  // 리사이즈
  resize();
  $(window).resize(resize);

  function resize() {
    var windowHeight = $(window).height();
    var headerHeight = $(".header").height();
    $('.main').css({'height': (windowHeight - headerHeight - 1) + 'px'});
  }

  // 서버로부터 Spotify 이메일 가져오기
  $.ajax({
    url: '/whale/getSpotifyUserData',
    method: 'GET',
    xhrFields: {
      withCredentials: true
    },
    success: function(data) {
      if (data.email) {
        $('#email').val(data.email);
      }
    },
    error: function(err) {
      console.error('이메일 정보를 가져오는 데 실패했습니다:', err);
    }
  });

  // 회원가입 폼 제출 처리
  $('#register-form').on('submit', function(e) {
    e.preventDefault();

    const username = $('#username').val().trim();
    const password = $('#password').val().trim();
    const email = $('#email').val();
    const nickname = $('#user_nickname').val().trim();

    // 클라이언트 측 유효성 검사 (간단한 예시)
    if (!username || !nickname || !password || !email) {
      $('#message').text('모든 필드를 입력해주세요.');
      return;
    }

    $.ajax({
      url: '/whale/register/complete', // 올바른 엔드포인트로 수정
      method: 'POST',
      contentType: 'application/json',
      xhrFields: {
        withCredentials: true
      },
      data: JSON.stringify({ username, password, email, nickname }),
      success: function(response) {
        if (response.success) {
          // 회원가입 완료 메시지 표시
          alert(response.message); // "회원가입 완료되었습니다."
          // 회원가입 성공 시 서버에서 받은 redirectTo URL로 이동
          window.location.replace(response.redirectTo);
        } else {
          $('#message').text(response.message);
        }
      },
      error: function(err) {
        console.error('회원가입 중 오류 발생:', err);
      }
    });
  });
});
