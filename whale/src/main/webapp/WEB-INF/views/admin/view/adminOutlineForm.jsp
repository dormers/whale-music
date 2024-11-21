<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	
    <title>${pname }</title>
    <link rel="stylesheet" href="/whale/static/css/admin/menubar/adminSideBar.css">
    <link rel="stylesheet" href="/whale/static/css/admin/menubar/adminSubBar.css">
    <link rel="stylesheet" href="/whale/static/css/admin/menubar/adminHeader.css">
    <link rel="stylesheet" href="${contentBlockCss }">
    
</head>
<body>
    <%@ include file="../menubar/adminSideBar.jsp" %>
    <div class="mainview">
	   	<%@ include file="../menubar/adminHeader.jsp" %>
	    <div class="contentview">
	   		<%@ include file="../menubar/adminSubBar.jsp" %>
		    <jsp:include page="${contentBlockJsp }" />
	    </div>
	</div>
</body>
</html>

