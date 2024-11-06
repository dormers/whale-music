<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>newChat</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/message/messageHome.css" />
    <style>
        .header {
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .header #back {
            position: absolute;
            left: 2px;
            top: 50%;
            transform: translateY(-50%);
        }
        .header #back img {
            width: 30px;
            height: 30px;
        }
        .new-message{
            font-size: 20px;
        }
        .follow-list{
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        .follow-list img{
            width: 50px;
            height: 50px;
            border-radius: 50%;
            margin-right: 10px;
        }
        .user-nickname {
            font-weight: bold;
            margin: 0;
            padding: 0;
            text-align: left;
        }
        .user-id {
            color: #999999;
            margin: 0;
            padding: 0;
            text-align: left;
        }
        .user-info {
            display: flex;
            flex-direction: column; /* 세로로 배치 */
            margin: 0;
            padding: 0;
            font-size: 15px;
        }
    </style>
</head>
<body>
<h1>newChat</h1>
<div class="container">
    <div class="header">
        <a href="${pageContext.request.contextPath}/message/home" id="back"><img src="${pageContext.request.contextPath}/static/images/message/back.png" alt="back"></a>
        <div class="new-message">새 메시지</div>
    </div>
    <div class="search">
        받는 이: 검색란
    </div>
    <br>
    <c:forEach var="follow" items="${followList}">
        <div class="follow-list">
            <img src="${pageContext.request.contextPath}/static/images/setting/${follow.follow_user_image_url}" alt="user-img">
            <div class="user-info">
                <div class="user-nickname">
                    <span>${follow.follow_user_nickname}</span>
                </div>
                <div class="user-id">
                    <span>${follow.follow_user_id}</span>
                </div>
            </div>

        </div>
    </c:forEach>
</div>
</body>
</html>