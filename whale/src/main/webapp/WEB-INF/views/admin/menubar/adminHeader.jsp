<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="pagename">
	<div id="pname"><div id="header-pname">${pname }</div></div>
   	<img src="/whale/static/images/main/whaleLogo.png" alt="돌고래" id="logoImage" style="cursor: pointer;" />
</div>

<script>
    document.getElementById("logoImage").addEventListener("click", function() {
        window.location.href = "adminMainView";  // 첫 페이지로 이동
    });
</script>