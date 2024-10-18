<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<div class="content" name="content" id="content">

    <div class="accountSearch">
	<form action="" method="post" >
        <select name="searchType2" id="searchType2">
            <option value="btitle">아이디</option>
            <option value="bcontent">이름</option>
            <option value="bother">날짜</option>
        </select>
        
        <input type="text" name="sk" size="50" />
        <input type="submit" value="검색" />
	</form>
	<a href="adminOfficialAddView" id="add">+ 추가</a>
    </div>
	
    <table>
        <thead>
            <tr>
                <th>아이디</th>
                <th>게시글</th>
                <th>댓글</th>
                <th>가입일</th>
                <th>마지막접속일</th>
                <th>계정상태</th>
            </tr>
        </thead>
        <tbody>
        	
			<c:forEach begin="1" end="10" var="cnt" >
				<tr onclick="location.href=''" style="cursor:pointer;">
					<td>userID_vvvvv${cnt }</td>
					<td>31</td>
					<td>45</td>
					<td>2019.12.1${cnt }</td>
					<td>2020.9.1${cnt }</td>
					<td>정지</td>
				</tr>
			</c:forEach>
        	
        </tbody>
        <tfoot>
        	<tr>
        		<td colspan="5" class="pagenum"><a href="#">&lt;</a> 1/56 <a href="#">&gt;</a></td>
        	</tr>
        </tfoot>
    </table>
</div>