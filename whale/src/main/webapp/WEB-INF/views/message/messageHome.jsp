<?xml version="1.0" encoding="UTF-8" ?>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8"/>
	<title>Message Home</title>
	<style>
		* {margin: 0; padding: 0; box-sizing: 0;}
		body {min-height: 100vh;}
		
		.message-container {display: flex; justify-content: center; align-items: center; width: 100%-1.5px; border: 1.5px solid #E2E2E2; border-radius: 30px; background-color: #f2f2f2;}
	</style>
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script>
		//리사이즈
		$(document).ready(() => {resize();});
		$(window).resize(() => {resize();});
		function resize() {
			var windowHeight = $(window).height();
			$('.message-container').css({'height': (windowHeight-3)+'px'});
		};
	</script>
</head>
<body>
	<div class="message-container">
		<h1>Message Home</h1>
	</div>
</body>
</html>