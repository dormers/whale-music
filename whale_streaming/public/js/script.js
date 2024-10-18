// 리사이즈
$(document).ready(() => {resize();});
$(window).resize(() => {resize();});
function resize() {
  var windowHeight = $(window).height();
  var headerHeight = $(".header").height();
  $('.main').css({'height': (windowHeight-headerHeight-1)+'px'});
};

document.addEventListener("DOMContentLoaded", () => {
  // 사용자 로그인 여부 확인
  fetch("/whale/check-login")
    .then((response) => response.json())
    .then((data) => {
      if (!data.loggedIn) {
        // 로그인되지 않은 경우 로그인 창 유지
      } else {
        // 서버에서 Spotify 액세스 토큰 확인
        fetch("/whale/refreshToken")
          .then((response) => response.json())
          .then((tokenData) => {
            if (tokenData.accessToken) {
              // Spotify 로그인 확인 후 Spring 메인 화면으로 이동
              window.location.replace("/whale/main");
            } else {
              // Spotify 로그인 필요
              window.location.replace("/whale/spotify/login");
            }
          }
        );
      }
    }
  );

  document.getElementById('login-form').addEventListener('submit', async (e) => {
    e.preventDefault();

    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;

    const response = await fetch('/whale/login', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ username, password }),
    });

    const result = await response.json();

    const messageDiv = document.getElementById('message');
    if (result.success) {
      // 로그인 성공 시 스포티파이 로그인 화면으로 이동
      window.location.replace("/whale/spotify/login");
    } else {
      messageDiv.innerText = result.message;
    }
  });
});
