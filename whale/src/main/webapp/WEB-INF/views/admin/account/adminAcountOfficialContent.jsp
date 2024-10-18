<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<div class="content" name="content" id="content">

    <div class="accountSearch">
	<form action="" method="post">
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
                <th>이름</th>
                <th>분야</th>
                <th>인증날짜</th>
                <th>특이사항</th>
            </tr>
        </thead>
        <tbody>
        	
			<c:forEach begin="1" end="10" var="cnt" >
				<tr onclick="location.href=''" style="cursor:pointer;">
					<td>1</td>
					<td>2</td>
					<td>3</td>
					<td>4</td>
					<td>5</td>
				</tr>
			</c:forEach>
        	
        </tbody>
        <tfoot>
        	<tr>
        		<td colspan="5" class="pagenum"><a href="">&lt;</a> 1/56 <a href="">&gt;</a></td>
        	</tr>
        </tfoot>
    </table>
</div>