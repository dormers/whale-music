<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Community</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&display=swap">
<style>
	/* 기본 설정 값 */
	* {margin: 0; padding: 0; box-sizing: 0;}
    body {
    	min-height: 100vh;
        font-family: 'Roboto', sans-serif;
    }
    .frame {
        display: flex;														/* 컨테이너 중앙 정렬 */
        justify-content: center;
        align-items: center;
        width: 100%-1.5px;
        background-color: #1f1f1f;											/* 배경 설정 */
        border: 1.5px solid #2e2e2e;
        border-radius: 30px;
    }
    .container {
        max-width: 900px;
        width: 50%;
        background-color: #2e2e2e;
        padding: 80px 80px;
        border-radius: 40px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    h3 {
    	margin-bottom: 40px;
    	padding: 0 20px 25px 20px;
    	border-bottom: 1.5px solid #1f1f1f;
        color: #fff;
        opacity: 0.7;
        text-align: left;
        font-size: 24px;
        font-weight: 600;
    }
    .grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 25px;
    }
    .card {
        background-color: #2e2e2e;
        border: 1px solid #1f1f1f;
        border-radius: 10px;
        padding: 24px 30px;
        transition: all 0.3s ease;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: flex-start;
        cursor: pointer;
        text-decoration: none;
        color: inherit;
        opacity: 0.8;
    }
    .card:hover {
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    }
    .card-title {
        font-size: 17px;
        font-weight: 600;
        margin-bottom: 14px;
        color: #ddd;
        opacity: 0.8;
    }
    .card-subtitle {
    	margin-left: 1px;
        font-size: 12px;
        color: #888;
        opacity: 0.7;
        font-weight: 400;
    }
</style>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
	//리사이즈
	$(document).ready(() => {resize();});
	$(window).resize(() => {resize();});
	function resize() {
		var windowHeight = $(window).height();
		$('.frame').css({'height': (windowHeight-3)+'px'});
	};
</script>
</head>
<body>
	<div class="frame">
		<div class="container">
	        <h3>커뮤니티</h3>
	        <div class="grid">
	            <c:forEach items="${list }" var="c">
	                <a href="communityPost?c=${c.community_id}" class="card">
	                    <div class="card-title">“${c.community_name}”</div>
	                    <div class="card-subtitle">${c.community_name_en}</div>
	                </a>
	            </c:forEach>
	        </div>
	    </div>
	</div>
</body>
</html>