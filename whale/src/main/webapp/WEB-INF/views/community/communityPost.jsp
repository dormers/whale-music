<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Community Board</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@400;600&display=swap">
<script src="static/js/setting/darkMode.js"></script>
<style>
	::-webkit-scrollbar {display: none;}
    .content-wrapper[data-darkmode="0"] body {font-family: 'Noto Sans', sans-serif; margin: 0; padding: 0; color: #333333; background-color: #f8f9fa;}
    .content-wrapper[data-darkmode="0"] h2 {font-size: 24px; font-weight: bold; color: #444; text-align: center; margin-bottom: 20px;}
    .content-wrapper[data-darkmode="0"] h2 a {color: #333333; text-decoration: none;}
    .content-wrapper[data-darkmode="0"] .content-wrapper {max-width: 1200px; margin: auto; padding: 20px; background-color: #ffffff;}
    .content-wrapper[data-darkmode="0"] .community-link {margin-top: 60px;}
    .content-wrapper[data-darkmode="0"] .table-container {display: flex; justify-content: center; align-items: center; margin-top: 20px;}
    .content-wrapper[data-darkmode="0"] table {width: 92%; border-collapse: collapse;}
    .content-wrapper[data-darkmode="0"] th, td {padding: 10px; border-bottom: 1px solid #d2d2d2; text-align: left; font-size: 14px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;}
    .content-wrapper[data-darkmode="0"] th {background-color: #f1f3f5; font-weight: 700; color: #495057;}
    .content-wrapper[data-darkmode="0"] td {color: #495057;}
    .content-wrapper[data-darkmode="0"] tr:hover td {background-color: #d2d2d2;}
    .content-wrapper[data-darkmode="0"] .fixed {color: #f03e3e; font-weight: bold;}
    .content-wrapper[data-darkmode="0"] .notice-icon, .post-stats {color: #adb5bd; font-size: 0.9em;}
    .content-wrapper[data-darkmode="0"] td a {color: black; text-decoration: none;}
    .content-wrapper[data-darkmode="0"] td a:hover {text-decoration: underline;}
    .content-wrapper[data-darkmode="0"] .pagination {display: flex; justify-content: center; margin-top: 20px;}
    .content-wrapper[data-darkmode="0"] .pagination a, .pagination span {padding: 8px 12px; margin: 0 5px; background-color: transparent; border: 1px solid #dee2e6; border-radius: 4px; color: #626262; text-decoration: none; font-weight: 500;}
    .content-wrapper[data-darkmode="0"] .pagination a:hover {background-color: #e9ecef;}
    .content-wrapper[data-darkmode="0"] .pagination .disabled {color: #adb5bd; pointer-events: none;}
    .content-wrapper[data-darkmode="0"] .footer {text-align: center; margin: 30px 0; font-size: 12px; color: #868e96;}
    .content-wrapper[data-darkmode="0"] .announcement {background-color: #f2f2f2; /* 연한 회색 배경 */ font-weight: bold; /* 글씨를 굵게 */}
    #userModal[data-darkmode="0"] {display: none; position: fixed; z-index: 1; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.6);}
    #userModal[data-darkmode="0"] .modal-content {background-color: #ffffff; margin: 20% auto; padding: 20px; border-radius: 8px; width: 270px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);}
    #userModal[data-darkmode="0"] .close {color: #aaa; float: right; font-size: 28px; font-weight: bold; cursor: pointer; margin-top: 10px;}
    #userModal[data-darkmode="0"] .close:hover, .close:focus {color: #333; text-decoration: none; cursor: pointer;}
    #userModal[data-darkmode="0"] .modal-links a {display: block; padding: 15px 10px; margin-top: 10px; text-align: center; background-color: #d2d2d2; color: #1f1f1f; border-radius: 5px; text-decoration: none; font-weight: bold;}
    #userModal[data-darkmode="0"] .modal-links a:hover {background-color: #f2f2f2;}
    #userModal[data-darkmode="0"] .user-id {font-weight: bold; cursor: pointer;}
    #userModal[data-darkmode="0"] .user-id:hover {color: #1666c1;}
    #userModal[data-darkmode="0"] .pagination .current {font-weight: bold; color: #1a73e8;}
    /* ------------------------------------------------------------------------------------------------ */
    .content-wrapper[data-darkmode="1"] body {font-family: 'Noto Sans', sans-serif; margin: 0; padding: 0; color: whitesmoke; background-color: #1f1f1f;}
    .content-wrapper[data-darkmode="1"] h2 {font-size: 24px; font-weight: bold; color: whitesmoke; text-align: center; margin-bottom: 20px;}
    .content-wrapper[data-darkmode="1"] h2 a {color: whitesmoke; text-decoration: none;}
    .content-wrapper[data-darkmode="1"] h2 a:visited {color: whitesmoke; text-decoration: none;}
    .content-wrapper[data-darkmode="1"] .content-wrapper {max-width: 1200px; margin: auto; padding: 20px; background-color: #1f1f1f;}
    .content-wrapper[data-darkmode="1"] .community-link {margin-top: 60px;}
    .content-wrapper[data-darkmode="1"] .table-container {display: flex; justify-content: center; align-items: center; margin-top: 20px;}
    .content-wrapper[data-darkmode="1"] table {width: 92%; border-collapse: collapse; background-color: #4e4e4e}
    .content-wrapper[data-darkmode="1"] th, td {padding: 10px; border-bottom: 1px solid #d2d2d2; text-align: left; font-size: 14px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;}
    .content-wrapper[data-darkmode="1"] th {background-color: #4e4e4e; font-weight: 700; color: whitesmoke;}
    .content-wrapper[data-darkmode="1"] td {color: whitesmoke;}
    .content-wrapper[data-darkmode="1"] tr:hover td {background-color: #9e9e9e;}
    .content-wrapper[data-darkmode="1"] .fixed {color: #f03e3e; font-weight: bold;}
    .content-wrapper[data-darkmode="1"] .notice-icon, .post-stats {color: #adb5bd; font-size: 0.9em;}
    .content-wrapper[data-darkmode="1"] td a {color: whitesmoke; text-decoration: none;}
    .content-wrapper[data-darkmode="1"] td a:hover {text-decoration: underline;}
    .content-wrapper[data-darkmode="1"] .pagination {display: flex; justify-content: center; margin-top: 20px;}
    .content-wrapper[data-darkmode="1"] .pagination a, .pagination span {padding: 8px 12px; margin: 0 5px; background-color: gray; border: 1px solid #dee2e6; border-radius: 4px; color: #626262; text-decoration: none; font-weight: 500;}
    .content-wrapper[data-darkmode="1"] .pagination a:hover {background-color: lightgray;}
    .content-wrapper[data-darkmode="1"] .pagination .disabled {background-color: white; color: #adb5bd; pointer-events: none;}
    .content-wrapper[data-darkmode="1"] .footer {text-align: center; margin: 30px 0; font-size: 12px; color: whitesmoke;}
    .content-wrapper[data-darkmode="1"] .announcement {background-color: #3f3f3f; /* 연한 회색 배경 */ font-weight: bold; /* 글씨를 굵게 */}
    .content-wrapper[data-darkmode="1"] .pagination .current {background-color: white; font-weight: bold; color: #adb5bd;}
    #userModal[data-darkmode="1"] {display: none; position: fixed; z-index: 1; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.6);}
    #userModal[data-darkmode="1"] .modal-content {background-color: #2e2e2e; margin: 20% auto; padding: 20px; border-radius: 8px; width: 270px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);}
    #userModal[data-darkmode="1"] .modal-header {color: whitesmoke;}
    #userModal[data-darkmode="1"] .close {color: #aaa; float: right; font-size: 28px; font-weight: bold; cursor: pointer; margin-top: 10px;}
    #userModal[data-darkmode="1"] .close:hover, .close:focus {color: whitesmoke; text-decoration: none; cursor: pointer;}
    #userModal[data-darkmode="1"] .modal-links a {display: block; padding: 15px 10px; margin-top: 10px; text-align: center; background-color: #d2d2d2; color: #1f1f1f; border-radius: 5px; text-decoration: none; font-weight: bold;}
    #userModal[data-darkmode="1"] .modal-links a:hover {background-color: #f2f2f2;}
    #userModal[data-darkmode="1"] .user-id {font-weight: bold; cursor: pointer;}
    #userModal[data-darkmode="1"] .user-id:hover {color: #335580;}
	

    .search-bar {
        display: flex;
        justify-content: center;
        align-items: center;
        background-color: transparent;
        margin: 40px auto 0 auto;
        padding: 10px 40px;
        border: 1px solid #d2d2d2;
        border-radius: 10px;
        width: 80%;
    }

    .search-bar input[type="text"] {
        width: 30%;
        padding: 7px;
        border: 1px solid #D0D0D0;
        border-radius: 8px;
        background-color: #FFFFFF;
        color: #000000;
        font-family: 'Noto Sans', sans-serif;
        font-weight: 400;
        margin: 0 20px;
    }

    .search-bar input[type="submit"] {
        padding: 7px 20px;
        background-color: transparent;
        border: 1px solid #D0D0D0;
        color: #626262;
        cursor: pointer;
        border-radius: 8px;
        transition: background-color 0.3s;
        font-family: 'Noto Sans', sans-serif;
        font-weight: 600;
    }

    .search-bar input[type="submit"]:hover {
        background-color: #D0D0D0;
    }
    
    .search-bar span, select {
    	color: #626262;
        font-size: 14px;
        margin: 0 20px 0 10px;
    }
    
    .content-wrapper[data-darkmode="1"] .search-bar {background-color: #4e4e4e; border: none;}
    .content-wrapper[data-darkmode="1"] input[type="text"] {color: white;}
    .content-wrapper[data-darkmode="1"] input[type="submit"] {color: white;}
    .content-wrapper[data-darkmode="1"] span {color: white;}
</style>
</head>
<body>

<div class="content-wrapper" data-darkmode="${darkMode.scndAttrName}">
    <h2 class="community-link"><a href="communityPost?c=${param.c}">${communityName}</a></h2>

    <div class="table-container">
        <table style="display: table; table-layout: fixed;">
            <tr>
                <th style="width: 5%;">번호</th>
                <th style="width: 10%;">태그</th>
                <th style="width: 45%;">제목</th>
                <th style="width: 10%;">작성자</th>
                <th style="width: 10%;">등록일</th>
                <th style="width: 10%;">조회수</th>
                <th style="width: 10%;">좋아요</th>
            </tr>
            <c:forEach items="${list}" var="p">
                <tr 
	                <c:if test="${p.post_tag_text == '[공지]'}">
	                    class="announcement"
	                </c:if>
            	>
                    <td style="width: 5%;">${p.post_num}</td>
                    <td style="width: 10%;">${p.post_tag_text}</td>
                    <td style="width: 45%; display: table-cell; width: 100%; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;"><a href="communityDetail?c=${param.c}&p=${p.post_id}">${p.post_title} 
                    	<c:if test="${p.commentsCount != 0}">
                    	(${p.commentsCount})
                    	</c:if>
                    	</a></td>
                    <td style="width: 10%;">
					    <span class="user-id" 
					          data-user-id="${p.user_id}" 
					          data-user-nickname="${p.user_nickname}" 
					          data-user-image-url="${p.user_image_url}" 
					          onclick="openModal(this)">
					        ${p.user_nickname}
					    </span>
					</td>
                    <td style="width: 10%;">${p.post_date}</td>
                    <td style="width: 10%;">${p.post_cnt}</td>
                    <td style="width: 10%;">${p.likeCount}</td> <!-- 좋아요 수 추가 -->
                </tr>
            </c:forEach>
        </table>
    </div>
    
    <form action="communityPost" class="search-bar">
	    <input type="hidden" name="c" value="${param.c}" />
	    
	        <c:choose>
	            <c:when test="${title}">
	                <input type="checkbox" name="searchType" value="title" checked /><span>제목</span>
	            </c:when>
	            <c:otherwise>
	                <input type="checkbox" name="searchType" value="title" /><span>제목</span>
	            </c:otherwise>
	        </c:choose>
	        <c:choose>
	            <c:when test="${content}">
	                <input type="checkbox" name="searchType" value="content" checked /><span>내용</span>
	            </c:when>
	            <c:otherwise>
	                <input type="checkbox" name="searchType" value="content" /><span>내용</span>
	            </c:otherwise>
	        </c:choose>
	        <select name="tagId">
	            <option value="">모든 태그</option>
	            <c:forEach items="${tlist}" var="t">
	                <option value="${t.post_tag_id}" ${param.tagId == t.post_tag_id ? "selected" : "" }>${t.post_tag_text}</option>
	            </c:forEach>
	        </select>
	        <input type="text" name="sk" value="${searchKeyword}" placeholder="검색어를 입력하세요" />
	        <input type="submit" value="검색" />
	    
	</form>

    <div style="text-align: right; margin: 40px 40px 0 0;">
        <a href="communityReg?c=${param.c}" style="background: transparent; border: 1px solid #d2d2d2; color: gray; font-size: 14px; padding: 10px 20px; border-radius: 4px; text-decoration: none; font-weight: bold;">글 작성</a>
    </div>

    <div class="pagination">
        <c:choose>
            <c:when test="${searchVO.page > 1}">
                <a href="communityPost?c=${param.c}&page=${searchVO.page - 1}">이전</a>
            </c:when>
            <c:otherwise>
                <span class="disabled">이전</span>
            </c:otherwise>
        </c:choose>
	    <c:forEach var="i" begin="1" end="${searchVO.totPage}">
	        <c:choose>
	            <c:when test="${i == searchVO.page}">
	                <span class="current">${i}</span>
	            </c:when>
	            <c:otherwise>
	                <a href="communityPost?c=${param.c}&page=${i}">${i}</a>
	            </c:otherwise>
	        </c:choose>
	    </c:forEach>
        <c:choose>
            <c:when test="${searchVO.page < searchVO.totPage}">
                <a href="communityPost?c=${param.c}&page=${searchVO.page + 1}">다음</a>
            </c:when>
            <c:otherwise>
                <span class="disabled">다음</span>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="footer">
        &copy; Whale Community
    </div>
</div>

<div id="userModal" class="modal" style="display: none;" data-darkmode="${darkMode.scndAttrName}">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <div class="modal-header" style="display: flex; align-items: center; margin-bottom: 20px;">
            <img id="modal-user-image" src="" alt="User Image" style="width: 80px; height: 80px; border-radius: 50%; margin: 0 15px;">
            <div class="modal-info">
                <h2 id="modal-user-nickname"></h2>
                <p id="modal-user-id"></p>
            </div>
        </div>
        <div class="modal-links">
            <a href="" id="profile-link" class="modal-link">프로필</a> 
            <a href="" id="message-link" class="modal-link">메시지 보내기</a>
        </div>
    </div>
</div>

<script>
    // 모달 열기
    function openModal(element) {
        const userId = element.getAttribute("data-user-id");
        const userNickname = element.getAttribute("data-user-nickname");
        const userImageUrl = element.getAttribute("data-user-image-url");

        // 모달에 값 채우기
        document.getElementById("modal-user-id").innerText = "@" + userId;
        document.getElementById("modal-user-nickname").innerText = userNickname;
        document.getElementById("modal-user-image").src = userImageUrl;

        // 링크 설정
        document.getElementById('profile-link').href = "profileHome?u=" + userId;
        document.getElementById('message-link').href = "messageGo?u=" + userId;

        // 모달 열기
        document.getElementById("userModal").style.display = "block";
    }

    // 모달 닫기
    function closeModal() {
        document.getElementById("userModal").style.display = "none";
    }

    // 모달 외부 클릭 시 닫기
    window.onclick = function(event) {
        const modal = document.getElementById("userModal");
        if (event.target == modal) {
            closeModal();
        }
    };
</script>

</body>
</html>