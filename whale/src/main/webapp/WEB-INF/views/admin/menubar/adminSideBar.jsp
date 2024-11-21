<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script type="text/javascript">
        function logoutWhale() {
            // 스프링 서버 정보 초기화
            location.href = '/whale/main/logout';
        }
</script>

<div id="adminSideBar" name="adminSideBar" class="adminSideBar">
	<div class="profile-container">
	 	<div class="profile">
		 	<div class="proImgBox"  onclick = "location.href = 'adminAccountUserInfo?userId=${myId }&page=1&sk=&searchType=&searchOrderBy='">
		 		<img src="${myImgUrl }" alt="user_img" class="proImg"/> <br />
		 	</div>
		 	<div class="logoutstr">
		        <a href="adminAccountUserInfo?userId=${myId }&page=1&sk=&searchType=&searchOrderBy=">${myId }</a>
		        <a href="#" onclick="logoutWhale()">로그아웃</a>
		    </div>
	    </div>
    </div>
    <ul>
		<li><a href="adminMainView">관리자메인</a></li>
	    <li><a href="adminAccountUserListView">계정관리</a></li>
	    <li><a href="adminBoardListView">게시판</a></li>
	    <li><a href="adminReportListView">신고문의</a></li>
	    <li><a href="adminStatisticCFView">통계</a></li>
	    <li><a href="/whale/main">Whale</a></li>
	</ul>
</div>