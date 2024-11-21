<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="com.tech.whale.main.models.MainAuthorizationCode" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"/>
    <link rel="icon" href="${pageContext.request.contextPath}/static/images/main/whaleLogo.png">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/search/searchStyles.css"/>
    <title>Whale Search</title>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/search/searchFunction.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/setting/darkMode.js"></script>
</head>
<body class="searchHomeBody">
<header>
	<div class="header">
		<div class="headerSearch">
			<button class="searchBtn">
				<input type="image" src="/whale/static/images/streaming/searchBtn.png" alt="검색" style="height: 14px;" class="searchBtn"/>
			</button>
			<input id="searchInput" class="headerSearchInput" type="text" name="keyword" placeholder="검색어를 입력하세요" required/>
	    </div>
	</div>
</header>
<div class="mainSearch">
<div class="mainSearchContainer">
	<div class="mainSearchTab">
		<p class="mainSearchUser active" data-type="user">유저</p>
		<p class="mainSearchCommunity" data-type="post">게시글</p>
		<p class="mainSearchFeed" data-type="feed">피드</p>
	</div>
	<div class="mainSearchResult">
		<!-- 검색 결과가 여기 표시됩니다 -->
	</div>
</div>
</div>
</body>
</html>