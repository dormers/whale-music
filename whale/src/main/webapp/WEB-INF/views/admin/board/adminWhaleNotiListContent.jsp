<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script>
	function formSubmit(){
		if(confirm("공지알람을 보내시겠습니까?")){
			document.getElementById("whale-form").submit();
		}
	}
</script>

<div class="content" name="content" id="content">

    <div class="accountSearch">
		<form action="adminWhaleNotiListView" method="post" >
	        <select name="searchType" id="searchType">
			    <option value="user_id" selected >작성자</option>
			    <option value="whale_text" <c:if test="${searchType == 'whale_text'}">selected</c:if>>제목</option>
			</select>
	        <input type="text" name="sk" size="50" value="${not empty searchKeyword ? searchKeyword : ''}" />
	        <input type="submit" value="검색" />
		</form>
    </div>
    
    <div class="div-form">
    	<form id="whale-form" action="adminWhaleNotiRegDo" method="post" style="display:flex; justify-content: center; align-items: center; gap: 20px; margin-bottom: 20px;">
    		<textarea name="whale_text" id="whale_text" cols="130" rows="3" placeholder="공지알람 입력란 :" style="resize: none;"></textarea>
    		<input type="hidden" name="searchType" value="${searchType }" />
    		<input type="hidden" name="sk" value="${searchKeyword }" />
    		<input type="hidden" name="page" value="${ulsearchVO.page}" />
    		<button id="whale-btn" onclick="formSubmit()" >공지등록</button>
    	</form>
    </div>
    
    <table>
        <thead>
            <tr>
                <th>번호</th>
                <th>내용</th>
                <th>작성자</th>
                <th>등록일</th>
            </tr>
        </thead>
        <tbody>
			<c:if test="${empty list}">
			    <tr>
			        <td colspan="4" align="center">결과가 없습니다.</td>
			    </tr>
			</c:if>
			<c:if test="${not empty list}">
	        <c:forEach items="${list }" var="dto" >
				<tr style="height: 50px;">
					<c:if test="${not empty dto.notice_id && dto.notice_id != 0}">
					<td>${dto.notice_id }</td>
					<td>${dto.notice_text }</td>
					<td>${dto.user_id }</td>
					<td><fmt:formatDate value="${dto.notice_date}" pattern="yyyy.MM.dd" /></td>
					</c:if>
				</tr>
			</c:forEach>
			</c:if>
        </tbody>
        <tfoot>
        	<tr>
			    <td colspan="4">
			        <c:choose>
			        
			            <c:when test="${not empty ulsearchVO}">
			                <a href="adminWhaleNotiListView?page=1&sk=${searchKeyword}&searchType=${searchType}"
			                   class="${ulsearchVO.page == 1 ? 'pagination-disabled' : ''}">[처음]</a>
			
			                <a href="adminWhaleNotiListView?page=${ulsearchVO.page - 1}&sk=${searchKeyword}&searchType=${searchType}"
			                   class="${ulsearchVO.page == 1 ? 'pagination-disabled' : ''}">[이전]</a>
			
			                <c:forEach begin="${ulsearchVO.pageStart}" end="${ulsearchVO.pageEnd}" var="i">
			                    <c:choose>
			                        <c:when test="${i eq ulsearchVO.page}">
			                            <span class="pagination-active">${i} &nbsp; &nbsp;</span>
			                        </c:when>
			                        <c:otherwise>
			                            <a href="adminWhaleNotiListView?page=${i}&sk=${searchKeyword}&searchType=${searchType}">${i}</a> &nbsp; &nbsp;
			                        </c:otherwise>
			                    </c:choose>
			                </c:forEach>
			
			                <a href="adminWhaleNotiListView?page=${ulsearchVO.page + 1}&sk=${searchKeyword}&searchType=${searchType}"
			                   class="${ulsearchVO.page == ulsearchVO.totPage ? 'pagination-disabled' : ''}">[다음]</a>
			
			                <a href="adminWhaleNotiListView?page=${searchVO.totPage}&sk=${searchKeyword}&searchType=${searchType}"
			                   class="${ulsearchVO.page == ulsearchVO.totPage ? 'pagination-disabled' : ''}">[마지막]</a>
			            </c:when>
			            
			            <c:otherwise>
			                <a href="adminWhaleNotiListView?page=1&sk=${searchKeyword}&searchType=${searchType}" class="pagination-disabled">[처음]</a>
			
			                <a href="adminWhaleNotiListView?page=1&sk=${searchKeyword}&searchType=${searchType}" class="pagination-disabled">[이전]</a>
			
			                <span class="pagination-active">1 &nbsp; &nbsp;</span>
			
			                <a href="adminWhaleNotiListView?page=1&sk=${searchKeyword}&searchType=${searchType}" class="pagination-disabled">[다음]</a>
			
			                <a href="adminWhaleNotiListView?page=1&sk=${searchKeyword}&searchType=${searchType}" class="pagination-disabled">[마지막]</a>
			            </c:otherwise>
			            
			        </c:choose>
			    </td>
			</tr>
        </tfoot>
    </table>
</div>