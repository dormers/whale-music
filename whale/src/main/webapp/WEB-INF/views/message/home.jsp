<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>messageHome</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/message/messageHome.css" />
<style>
.header{
    display: flex;
    justify-content: space-between;
    align-items: center;
}
.left{
    display: flex;
    align-items: center;
}
.nowId{
    font-size: 25px;
    line-height: 30px; /* 이미지 높이와 동일하게 설정 */
}
#back img, #new-chat img {
    display: block;
    width: 30px;
    height: 30px;
}
</style>
</head>
<body>
<h1>message</h1>
<div class="container">
    <div class="header">
        <div class="left">
            <a href="##" id="back"><img src="${pageContext.request.contextPath}/static/images/message/back.png" alt="back"></a>
            <div class="nowId">${now_id}</div>
        </div>
        <a href="${pageContext.request.contextPath}/message/newChat" id="new-chat"><img src="${pageContext.request.contextPath}/static/images/message/newchatIcon.png" id="newchat" alt="newchatIcon"></a>
    </div>

    <div class="room-list">

    </div>
</div>
</body>
</html>