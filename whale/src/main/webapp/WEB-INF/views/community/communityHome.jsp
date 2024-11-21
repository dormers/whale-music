<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Community</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&display=swap">
	<script src="static/js/setting/darkMode.js"></script>
	<style>
		::-webkit-scrollbar {display: none;}
		/* 기본 설정 값 */
		.container[data-darkmode="0"]{padding: 50px;}
		.container[data-darkmode="0"] * {margin: 0; padding: 0; box-sizing: border-box;}
		.container[data-darkmode="0"] body {min-height: 100vh; font-family: 'Roboto', sans-serif; background-color: #f5f5f5; color: #333333;}
		.container[data-darkmode="0"] .frame {display: flex; justify-content: center; align-items: center; width: 100%; background-color: #ffffff; border-radius: 10px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); padding: 20px; height: auto;}
		.container[data-darkmode="0"] .container {max-width: 900px; width: 100%; padding: 40px; background-color: #ffffff; border-radius: 20px;}
		.container[data-darkmode="0"] h3 {margin-bottom: 40px; color: #333; text-align: left; font-size: 28px; font-weight: 600; border-bottom: 2px solid #ddd; padding-bottom: 10px;}
		.container[data-darkmode="0"] .grid {display: grid; grid-template-columns: repeat(2, 1fr); gap: 25px;}
		.container[data-darkmode="0"] .card {background-color: #ffffff; border: 1px solid #e0e0e0; border-radius: 10px; padding: 20px; transition: all 0.3s ease; display: flex; justify-content: space-between; align-items: center; color: inherit; text-decoration: none;}
		.container[data-darkmode="0"] .card:hover {box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);}
		.container[data-darkmode="0"] .card-title {font-size: 18px; font-weight: 600; color: #333;}
		.container[data-darkmode="0"] .card-subtitle {font-size: 14px; color: #777;}
		.container[data-darkmode="0"] .bookmark-btn {width: 24px; height: 24px; cursor: pointer;}
		/*	---------------------------------------------------------------------------------------------*/
		.container[data-darkmode="1"]{padding: 50px;}
		.container[data-darkmode="1"] * {margin: 0; padding: 0; box-sizing: border-box;}
		.container[data-darkmode="1"] body {min-height: 100vh; font-family: 'Roboto', sans-serif; background-color: #434343; color: whitesmoke;}
		.container[data-darkmode="1"] .frame {display: flex; justify-content: center; align-items: center; width: 100%; background-color: #434343; border-radius: 10px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); padding: 20px; height: auto;}
		.container[data-darkmode="1"] .container {max-width: 900px; width: 100%; padding: 40px; background-color: #434343; border-radius: 20px;}
		.container[data-darkmode="1"] h3 {margin-bottom: 40px; color: whitesmoke; text-align: left; font-size: 28px; font-weight: 600; border-bottom: 2px solid #ddd; padding-bottom: 10px;}
		.container[data-darkmode="1"] .grid {display: grid; grid-template-columns: repeat(2, 1fr); gap: 25px;}
		.container[data-darkmode="1"] .card {background-color: #434343; border: 1px solid #e0e0e0; border-radius: 10px; padding: 20px; transition: all 0.3s ease; display: flex; justify-content: space-between; align-items: center; color: inherit; text-decoration: none;}
		.container[data-darkmode="1"] .card:hover {box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);}
		.container[data-darkmode="1"] .card-title {font-size: 18px; font-weight: 600; color: whitesmoke;}
		.container[data-darkmode="1"] .card-subtitle {font-size: 14px; color: whitesmoke;}
		.container[data-darkmode="1"] .bookmark-btn {width: 24px; height: 24px; cursor: pointer; filter: invert(1)}
	</style>
	<style id="darkmode-scrollbar-styles"></style>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
/* 	$(document).ready(function() {
	    resize();
	});

	$(window).resize(function() {
	    resize();
	});

	function resize() {
	    var windowHeight = $(window).height();
	    $('.frame').css({'height': (windowHeight - 40) + 'px'});
	} */

	var contextPath = '${pageContext.request.contextPath}';
	// 즐겨찾기 버튼 클릭 시 AJAX 요청
    function toggleBookmark(communityId, element) {
        $.ajax({
            url: contextPath + '/toggleBookmark', // 컨텍스트 패스 포함
            type: 'POST',
            data: { communityId: communityId },
            dataType: 'text', // 서버 응답 타입 명시
            success: function(response) {
                if (response === 'followed') {
                    $(element).attr('src', contextPath + '/static/images/btn/starlike_btn.png'); // 즐겨찾기된 이미지
                } else if (response === 'unfollowed') {
                    $(element).attr('src', contextPath + '/static/images/btn/starunlike_btn.png'); // 즐겨찾기되지 않은 이미지
                } else {
                    alert('즐겨찾기 설정에 실패했습니다. 다시 시도해 주세요.');
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.log('AJAX error:', textStatus, errorThrown);
                alert('즐겨찾기 설정에 실패했습니다. 다시 시도해 주세요.');
            }
        });
	}
// 스크롤바
document.addEventListener("DOMContentLoaded", function () {
	// localStorage의 darkmodeOn 값 확인
	const darkmodeOn = localStorage.getItem("darkmodeOn");

	// darkmodeOn 값에 따라 스크롤바 스타일을 적용
	const styleSheet = document.getElementById("darkmode-scrollbar-styles");
	if (darkmodeOn === "1") {
		styleSheet.innerHTML = `
            html::-webkit-scrollbar { display: block; width: 0px; }
            html::-webkit-scrollbar-track { background: #2e2e2e; }
            html::-webkit-scrollbar-thumb { background-color: #555; border-radius: 4px; }
            html { overflow-y: auto; scroll-behavior: smooth; }
            body{background:#1f1f1f;}
        `;
	} else {
		styleSheet.innerHTML = `
            html::-webkit-scrollbar { display: block; width: 0px; }
            html::-webkit-scrollbar-track { background: #fff; }
            html::-webkit-scrollbar-thumb { background-color: #ccc; border-radius: 4px; }
            html { overflow-y: auto; scroll-behavior: smooth; }
        `;
	}
});
</script>

</head>
<body>
	<div class="frame">
	    <div class="container" data-darkmode="${darkMode.scndAttrName}">
	        <h3>커뮤니티</h3>
	        <div class="grid">
	            <c:forEach items="${list}" var="c">
	                <a href="communityPost?c=${c.community_id}" class="card">
	                    <div>
	                        <div class="card-title">${c.community_name}</div>
	                        <div class="card-subtitle">${c.community_name_en}</div>
	                    </div>
	                    <!-- 즐겨찾기 버튼 -->
	                    <c:choose>
	                        <c:when test="${c.bookmarked}">
	                            <img src="static/images/btn/starlike_btn.png" 
	                                 class="bookmark-btn" 
	                                 onclick="event.preventDefault(); toggleBookmark(${c.community_id}, this);">
	                        </c:when>
	                        <c:otherwise>
	                            <img src="static/images/btn/starunlike_btn.png" 
	                                 class="bookmark-btn" 
	                                 onclick="event.preventDefault(); toggleBookmark(${c.community_id}, this);">
	                        </c:otherwise>
	                    </c:choose>
	                </a>
	            </c:forEach>
	        </div>
	    </div>
	</div>
	</body>
	</html>
	         