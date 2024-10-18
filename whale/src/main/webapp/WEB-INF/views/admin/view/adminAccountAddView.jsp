<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<link rel="stylesheet" href="static/css/admin/menubar/adminSideBar.css">
    <link rel="stylesheet" href="static/css/admin/menubar/adminSubBar.css">
    <link rel="stylesheet" href="static/css/admin/menubar/pagename.css">
    <link rel="stylesheet" href="static/css/admin/account/adminAccountAddContent.css">
</head>
<body>

	<%@ include file="../menubar/adminSideBar.jsp" %>
    <div class="mainview">
	   	<%@ include file="../menubar/adminHeader.jsp" %>
	    <div class="contentview">
			<%@ include file="../menubar/adminSubBar.jsp" %>
		    <%@ include file="../account/adminAccountAddContent.jsp" %>
	    </div>
	</div>


</body>
</html>