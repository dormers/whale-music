<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	
    <title>관리자메인</title>
    <link rel="stylesheet" href="/whale/static/css/admin/menubar/adminSideBar.css">
    <c:if test="${not empty subBarBlockCss}">
        <link rel="stylesheet" href="${subBarBlockCss}">
    </c:if>
    <link rel="stylesheet" href="/whale/static/css/admin/menubar/adminHeader.css">
    <link rel="stylesheet" href="${contentBlockCss }">
    
</head>
<body>
    <%@ include file="../menubar/adminSideBar.jsp" %>
    <div class="mainview">
	   	<%@ include file="../menubar/adminHeader.jsp" %>
	    <div class="contentview">
			<c:if test="${not empty subBarBlockJsp}">
                <jsp:include page="${subBarBlockJsp}" />
            </c:if>
		    <jsp:include page="${contentBlockJsp }" />
	    </div>
	</div>
</body>
</html>
