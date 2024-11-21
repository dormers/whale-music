<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="content" name="content" id="content">

    <div class="accountSearch">
		<form action="adminBoardDelLogListView" method="post" >
	        <select name="searchType" id="searchType">
			    <option value="admin_id" selected >관리자</option>
			    <option value="writing_id" <c:if test="${searchType == 'writing_id'}">selected</c:if>>글번호</option>
			</select>
	        <input type="text" name="sk" size="50" value="${not empty searchKeyword ? searchKeyword : ''}" />
	        <input type="submit" value="검색" />
		</form>
    </div>
    <table>
        <thead>
            <tr>
                <th>구분</th>
                <th>글번호</th>
                <th>사유</th>
                <th>관리자</th>
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
					<c:if test="${not empty dto.feed_del_log_id && empty dto.comments_id  }">
						<td>피드</td>
					</c:if>
					<c:if test="${not empty dto.feed_del_log_id && not empty dto.comments_id}">
						<td>피드댓글</td>
					</c:if>
					<c:if test="${not empty dto.post_del_log_id && empty dto.comments_id }">
						<td>커뮤</td>
					</c:if>
					<c:if test="${not empty dto.post_del_log_id && not empty dto.comments_id}">
						<td>커뮤댓글</td>
					</c:if>
					<c:if test="${not empty dto.comments_id }">
						<td>${dto.comments_id }</td>
					</c:if>
					<c:if test="${empty dto.comments_id }">
						<td>${dto.writing_id }</td>
					</c:if>
					<td>${dto.del_reason }</td>
					<td>${dto.admin_id }</td>
					<td><fmt:formatDate value="${dto.del_date}" pattern="yyyy.MM.dd" /></td>
				</tr>
			</c:forEach>
			</c:if>
        </tbody>
        <tfoot>
        	<tr>
			    <td colspan="5">
			        <c:choose>
			        
			            <c:when test="${not empty ulsearchVO}">
			                <a href="adminBoardDelLogListView?page=1&sk=${searchKeyword}&searchType=${searchType}"
			                   class="${ulsearchVO.page == 1 ? 'pagination-disabled' : ''}">[처음]</a>
			
			                <a href="adminBoardDelLogListView?page=${ulsearchVO.page - 1}&sk=${searchKeyword}&searchType=${searchType}"
			                   class="${ulsearchVO.page == 1 ? 'pagination-disabled' : ''}">[이전]</a>
			
			                <c:forEach begin="${ulsearchVO.pageStart}" end="${ulsearchVO.pageEnd}" var="i">
			                    <c:choose>
			                        <c:when test="${i eq ulsearchVO.page}">
			                            <span class="pagination-active">${i} &nbsp; &nbsp;</span>
			                        </c:when>
			                        <c:otherwise>
			                            <a href="adminBoardDelLogListView?page=${i}&sk=${searchKeyword}&searchType=${searchType}">${i}</a> &nbsp; &nbsp;
			                        </c:otherwise>
			                    </c:choose>
			                </c:forEach>
			
			                <a href="adminBoardDelLogListView?page=${ulsearchVO.page + 1}&sk=${searchKeyword}&searchType=${searchType}"
			                   class="${ulsearchVO.page == ulsearchVO.totPage ? 'pagination-disabled' : ''}">[다음]</a>
			
			                <a href="adminBoardDelLogListView?page=${searchVO.totPage}&sk=${searchKeyword}&searchType=${searchType}"
			                   class="${ulsearchVO.page == ulsearchVO.totPage ? 'pagination-disabled' : ''}">[마지막]</a>
			            </c:when>
			            
			            <c:otherwise>
			                <a href="adminBoardDelLogListView?page=1&sk=${searchKeyword}&searchType=${searchType}" class="pagination-disabled">[처음]</a>
			
			                <a href="adminBoardDelLogListView?page=1&sk=${searchKeyword}&searchType=${searchType}" class="pagination-disabled">[이전]</a>
			
			                <span class="pagination-active">1 &nbsp; &nbsp;</span>
			
			                <a href="adminBoardDelLogListView?page=1&sk=${searchKeyword}&searchType=${searchType}" class="pagination-disabled">[다음]</a>
			
			                <a href="adminBoardDelLogListView?page=1&sk=${searchKeyword}&searchType=${searchType}" class="pagination-disabled">[마지막]</a>
			            </c:otherwise>
			            
			        </c:choose>
			    </td>
			</tr>
        </tfoot>
    </table>
</div>