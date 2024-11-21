<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>newChat</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/message/messageHome.css" />
    <script src="${pageContext.request.contextPath}/static/js/setting/darkMode.js"></script>
    <style>
        .container[data-darkmode="0"] { padding: 20px 20px; width: 100%; box-sizing: border-box; }
        .container[data-darkmode="0"] .scroll-content { flex: 1; overflow-y: auto; }
        .container[data-darkmode="0"] .header { position: relative; display: flex; justify-content: center; align-items: center; width: 100%; margin-bottom: 10px; }
        .container[data-darkmode="0"] .header #back { position: absolute; left: 2px; top: 50%; transform: translateY(-50%); }
        .container[data-darkmode="0"] .header #back img { width: 30px; height: 30px; }
        .container[data-darkmode="0"] .search { display: flex; flex-direction: column; align-items: center; margin-bottom: 10px; }
        .container[data-darkmode="0"] #search { background-color: whitesmoke; font-size: 15px; color: #B8B8B8; border: 1px solid #ccc; padding: 10px; border-radius: 5px; }
        .container[data-darkmode="0"] .new-message { font-size: 20px; }
        .container[data-darkmode="0"] .follow-list { display: flex; align-items: center; margin-bottom: 10px; padding: 10px; }
        .container[data-darkmode="0"] .follow-list img { width: 50px; height: 50px; border-radius: 50%; margin-right: 10px; }
        .container[data-darkmode="0"] .user-nickname { font-weight: bold; margin: 0; padding: 0; text-align: left; }
        .container[data-darkmode="0"] .user-id { color: #999999; margin: 0; padding: 0; text-align: left; }
        .container[data-darkmode="0"] .user-info { display: flex; flex-direction: column; margin: 0; padding: 0; font-size: 15px; }
        .container[data-darkmode="0"] a { text-decoration: none; color: black; }
        .container[data-darkmode="0"] a:visited, a:hover, a:focus, a:active { color: black; text-decoration: none; }
        .container[data-darkmode="0"] .follow-list.user-item:hover { background-color: #f9f9f9; }
        /* ---------------------------------------------------------------------------------------------------------------- */
        .container[data-darkmode="1"] { padding: 20px 20px; width: 100%; box-sizing: border-box; background-color: #1f1f1f; color: whitesmoke; }
        .container[data-darkmode="1"] .scroll-content { flex: 1; overflow-y: auto; }
        .container[data-darkmode="1"] .header { position: relative; display: flex; justify-content: center; align-items: center; width: 100%; margin-bottom: 10px; }
        .container[data-darkmode="1"] .header #back { position: absolute; left: 2px; top: 50%; transform: translateY(-50%); }
        .container[data-darkmode="1"] .header #back img { width: 30px; height: 30px; filter: invert(1); }
        .container[data-darkmode="1"] .search { display: flex; flex-direction: column; align-items: center; margin-bottom: 10px; }
        .container[data-darkmode="1"] #search { color: whitesmoke; background-color: rgb(46, 46, 46); font-size: 15px; padding: 5px; border-radius: 10px; border: none; }
        .container[data-darkmode="1"] .new-message { font-size: 20px; }
        .container[data-darkmode="1"] .follow-list { display: flex; align-items: center; margin-bottom: 10px; padding: 10px; }
        .container[data-darkmode="1"] .follow-list img { width: 50px; height: 50px; border-radius: 50%; margin-right: 10px; }
        .container[data-darkmode="1"] .user-nickname { font-weight: bold; margin: 0; padding: 0; text-align: left; color: whitesmoke; }
        .container[data-darkmode="1"] .user-id { color: #999999; margin: 0; padding: 0; text-align: left; color: #aaa; }
        .container[data-darkmode="1"] .user-info { display: flex; flex-direction: column; margin: 0; padding: 0; font-size: 15px; }
        .container[data-darkmode="1"] a { text-decoration: none; color: black; }
        .container[data-darkmode="1"] a:visited, a:hover, a:focus, a:active { color: black; text-decoration: none; }
        .container[data-darkmode="1"] .follow-list.user-item:hover { background-color: #434343; }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <a href="${pageContext.request.contextPath}/message/home" id="back"><img src="${pageContext.request.contextPath}/static/images/message/back.png" alt="back"></a>
        <div class="new-message">새 메시지</div>
    </div>
    <div class="search">
        <input type="text" id="search" placeholder="사용자 검색">
    </div>
    <br>
    <div class="scroll-content">
        <c:forEach var="follow" items="${followList}">
            <a href="${pageContext.request.contextPath}/messageGo?u=${follow.follow_user_id}">
                <div class="follow-list user-item" tabindex="0" data-username="${follow.follow_user_nickname}" data-userid="${follow.follow_user_id}" >
                    <img src="${follow.follow_user_image_url}" alt="user-img">
                    <div class="user-info">
                        <div class="user-nickname">
                            <span>${follow.follow_user_nickname}</span>
                        </div>
                        <div class="user-id">
                            <span>${follow.follow_user_id}</span>
                        </div>
                    </div>
                </div>
            </a>
        </c:forEach>
    </div>
</div>
<script>
    document.addEventListener('DOMContentLoaded', function() {
       const searchInput = document.getElementById('search');
       const userItems = document.querySelectorAll('.user-item');

       searchInput.addEventListener('input', function() {
          const searchText = searchInput.value.toLowerCase();

          userItems.forEach(function(item) {
              const username = item.getAttribute('data-username').toLowerCase();
              const userid = item.getAttribute('data-userid').toLowerCase();

              if(username.includes(searchText) || userid.includes(searchText)) {
                  item.style.display = 'flex'; // 원래의 display 속성으로 변경
              } else {
                  item.style.display = 'none';
              }
          })
       });

        // 리사이즈
        function resize() {
            var searchWidth = document.querySelector('.container .search input').offsetWidth;
            console.log(searchWidth);

            document.querySelectorAll('.scroll-content a').forEach((el) => {
                el.style.width = (searchWidth - 1) + 'px';
                el.style.display = 'block';
                el.style.margin = '0 auto';
            });
        }

        // 초기 리사이즈 호출
        resize();

        // 윈도우 리사이즈 이벤트에 연결
        window.addEventListener('resize', resize);
    });
</script>
</body>
</html>