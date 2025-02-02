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
    <title>Whale</title>
    <link rel="icon" href="static/images/main/whaleLogo.png">
    <link rel="stylesheet" href="static/css/main/mainStyle.css"/>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script src="https://sdk.scdn.co/spotify-player.js"></script>
    <script>
    	sessionStorage.accessToken = `${ accessToken }`;
    	sessionStorage.access_id = `${ access_id }`;
    	sessionStorage.user_id = `${ user_id }`;
    </script>
    <script type="module" src="static/js/main/mainVue.js" defer></script>
</head>
<body>
	<div id="main">
	    <main-header-component :header-menu-check="headerMenuCheck" :user-image-url="userInfo[1]"
	                           :noti-counts-sum="notiCounts.reduce((x,y) => (x+y))" @header-alarm-toggle="menuCheck"
	                           @header-profile-toggle="menuCheck" @reset-main="resetMain"></main-header-component>
	    <div class="main">
	        <main-center-component :frame-names="frameNames" :replace-iframe="replaceIframe" :start-page="startPage" :is-over="isOver"
	                               :track-info="trackInfo" :whale-address="whaleAddress"></main-center-component>
	        <main-header-menu-component :header-menu-check="headerMenuCheck" :user-nickname="userInfo[0]"
	                                    :notifications="notifications" :noti-counts="notiCounts"
	                                    :get-notification="getNotification" @header-close-menu="closeMenu"
	                                    @menu-redirect-iframe="changeRedirectIndex"></main-header-menu-component>
	    </div>
	    <main-footer-component :fetch-iframe="fetchIframe" :fetch-web-api="fetchWebApi" :start-page="startPage" :is-over="isOver"
	                           :track-info="trackInfo" @footer-music-toggle="changeRedirectIndex"></main-footer-component>
		<main-notification-component :get-notification="getNotification" @message-go="changeRedirectIndex"></main-notification-component>
	</div>
</body>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        // 페이지가 로드될 때 초기 다크 모드 설정 확인
        const darkmodeOn = localStorage.getItem('darkmodeOn');
        const mainElement = document.getElementById('main');

        if (darkmodeOn === "1") {
            mainElement.classList.add("dark");
            mainElement.classList.remove("light");
        } else {
            mainElement.classList.add("light");
            mainElement.classList.remove("dark");
        }

        // localStorage 값이 변경될 때마다 실행
        window.addEventListener('storage', function (event) {
            if (event.key === 'darkmodeOn') {
                if (event.newValue === "1") {
                    mainElement.classList.add("dark");
                    mainElement.classList.remove("light");
                } else {
                    mainElement.classList.add("light");
                    mainElement.classList.remove("dark");
                }
            }
        });
    });
</script>
</html>