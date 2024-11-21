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

  // 회원가입 폼 제출 처리
  $('#register-form').on('submit', function(e) {
    e.preventDefault();

    const username = $('#username').val().trim();
    const password = $('#password').val().trim();
    const passwordCheck = $('#passwordCheck').val().trim();
    const email = $('#email').val();
    const nickname = $('#user_nickname').val().trim();
    const passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$/;
    const koreanPattern = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;

    // 클라이언트 측 유효성 검사
    if (!username || !nickname || !password || !email) {
      $('#messageSub').text('모든 필드를 입력해주세요.');
      return;
    }

    // 아이디에 한글 포함 여부 확인
    if (koreanPattern.test(username)) {
      $('#messageSub').text('아이디에는 한글을 사용할 수 없습니다.');
      return;
    }


    if (password !== passwordCheck) {
      $('#messageSub').text('비밀번호가 일치하지 않습니다.');
      return;
    }

    if (!passwordPattern.test(password)) {
      $('#messageSub').text('비밀번호는 8자리 이상이며, 특수문자, 대문자, 소문자, 숫자를 각각 최소 1개 이상 포함해야 합니다.');
      return;
    }

    $.ajax({
      url: '/whale/register/complete',
      method: 'POST',
      contentType: 'application/json',
      data: JSON.stringify({ username, password, email, nickname }),
      success: function(response) {
        if (response.success) {
          alert(response.message);
          window.location.replace(response.redirectTo);
        } else {
          $('#messageSub').text(response.message);
        }
      },
      error: function(err) {
        console.error('회원가입 중 오류 발생:', err);
        $('#messageSub').text('서버 오류로 인해 회원가입에 실패했습니다.');
      }
    });
  });
});
