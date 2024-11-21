<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="adminSubBar" name="adminSubBar" class="adminSubBar">
    <ul>
	    <c:forEach var="subbar" items="${subMenu }" >
    		<li><a href="${subbar.key }">${subbar.value }</a></li>
	    </c:forEach>
    </ul>
</div>