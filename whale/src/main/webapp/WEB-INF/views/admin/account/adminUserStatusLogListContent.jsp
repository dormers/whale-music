<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="content" name="content" id="content">

    <div class="accountSearch">
		<form action="adminUserStatusLogListView" method="post" >
	        <select name="searchType" id="searchType">
			    <option value="user_id" selected >아이디</option>
			    <option value="status_admin_id" <c:if test="${searchType == 'status_admin_id'}">selected</c:if>>관리자</option>
			</select>
	        <input type="text" name="sk" size="50" value="${not empty searchKeyword ? searchKeyword : ''}" />
	        <input type="submit" value="검색" />
		</form>
    </div>
    <table>
        <thead>
            <tr>
                <th>구분</th>
                <th>아이디</th>
                <th>사유</th>
                <th>처리자</th>
                <th>날짜</th>
            </tr>
        </thead>
        <tbody>
			<c:if test="${empty list}">
			    <tr style="height: 50px;">
			        <td colspan="5" align="center">결과가 없습니다.</td>
			    </tr>
			</c:if>
			<c:if test="${not empty list}">
	        <c:forEach items="${list }" var="dto" >
				<tr style="height: 50px;">
					<c:if test="${dto.user_status == 0}">
						<td>활성화</td>
					</c:if>
					<c:if test="${dto.user_status == 1}">
						<td>정지</td>
					</c:if>
					<td>${dto.user_id }</td>
					<td>${dto.user_status_reason }</td>
					<td>${dto.status_admin_id }</td>
					<td><fmt:formatDate value="${dto.user_status_date}" pattern="yyyy.MM.dd" /></td>
				</tr>
			</c:forEach>
			</c:if>
        </tbody>
        <tfoot>
        	<tr>
			    <td colspan="5">
			        <c:choose>
			        
			            <c:when test="${not empty ulsearchVO}">
			                <a href="adminUserStatusLogListView?page=1&sk=${searchKeyword}&searchType=${searchType}"
			                   class="${ulsearchVO.page == 1 ? 'pagination-disabled' : ''}">[처음]</a>
			
			                <a href="adminUserStatusLogListView?page=${ulsearchVO.page - 1}&sk=${searchKeyword}&searchType=${searchType}"
			                   class="${ulsearchVO.page == 1 ? 'pagination-disabled' : ''}">[이전]</a>
			
			                <c:forEach begin="${ulsearchVO.pageStart}" end="${ulsearchVO.pageEnd}" var="i">
			                    <c:choose>
			                        <c:when test="${i eq ulsearchVO.page}">
			                            <span class="pagination-active">${i} &nbsp; &nbsp;</span>
			                        </c:when>
			                        <c:otherwise>
			                            <a href="adminUserStatusLogListView?page=${i}&sk=${searchKeyword}&searchType=${searchType}">${i}</a> &nbsp; &nbsp;
			                        </c:otherwise>
			                    </c:choose>
			                </c:forEach>
			
			                <a href="adminUserStatusLogListView?page=${ulsearchVO.page + 1}&sk=${searchKeyword}&searchType=${searchType}"
			                   class="${ulsearchVO.page == ulsearchVO.totPage ? 'pagination-disabled' : ''}">[다음]</a>
			
			                <a href="adminUserStatusLogListView?page=${searchVO.totPage}&sk=${searchKeyword}&searchType=${searchType}"
			                   class="${ulsearchVO.page == ulsearchVO.totPage ? 'pagination-disabled' : ''}">[마지막]</a>
			            </c:when>
			            
			            <c:otherwise>
			                <a href="adminUserStatusLogListView?page=1&sk=${searchKeyword}&searchType=${searchType}" class="pagination-disabled">[처음]</a>
			
			                <a href="adminUserStatusLogListView?page=1&sk=${searchKeyword}&searchType=${searchType}" class="pagination-disabled">[이전]</a>
			
			                <span class="pagination-active">1 &nbsp; &nbsp;</span>
			
			                <a href="adminUserStatusLogListView?page=1&sk=${searchKeyword}&searchType=${searchType}" class="pagination-disabled">[다음]</a>
			
			                <a href="adminUserStatusLogListView?page=1&sk=${searchKeyword}&searchType=${searchType}" class="pagination-disabled">[마지막]</a>
			            </c:otherwise>
			            
			        </c:choose>
			    </td>
			</tr>
        </tfoot>
    </table>
</div>