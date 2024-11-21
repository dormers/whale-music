<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="content" name="content" id="content">

    <div class="accountSearch">
		<form action="adminNoticeListView" method="post" >
	        <select name="searchType" id="searchType">
			    <option value="user_id" selected >작성자</option>
			    <option value="post_title" <c:if test="${searchType == 'post_title'}">selected</c:if>>제목</option>
			</select>
	        <input type="text" name="sk" size="50" value="${not empty searchKeyword ? searchKeyword : ''}" />
	        <input type="submit" value="검색" />
		</form>
    </div>
	<div class="addWriting">
		<a href="adminNoticeRegView">글쓰기</a>
	</div>
    <table>
        <thead>
            <tr>
                <th>번호</th>
                <th>분류</th>
                <th>제목</th>
                <th>작성자</th>
                <th>등록일</th>
                <th>조회수</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
			<c:if test="${empty list}">
			    <tr>
			        <td colspan="6" align="center">결과가 없습니다.</td>
			    </tr>
			</c:if>
			<c:if test="${not empty list}">
	        <c:forEach items="${list }" var="dto" >
				<tr>
					<c:if test="${not empty dto.post_id && dto.post_id != 0}">
					<td>${dto.post_id }</td>
					<td>${dto.community_name }</td>
					<td>${dto.post_title }</td>
					<td>${dto.user_id }</td>
					<td><fmt:formatDate value="${dto.post_date}" pattern="yyyy.MM.dd" /></td>
					<td>${dto.post_cnt }</td>
					<td>
						<button onclick = "location.href = 'adminNoticeContentView?postId=${dto.post_id }&communityName=${dto.community_name }&page=${ulsearchVO.page}&sk=${searchKeyword}&searchType=${searchType }'">
							조회
						</button>&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
					</c:if>
				</tr>
			</c:forEach>
			</c:if>
        </tbody>
        <tfoot>
        	<tr>
			    <td colspan="7">
			        <c:choose>
			        
			            <c:when test="${not empty ulsearchVO}">
			                <a href="adminNoticeListView?page=1&sk=${searchKeyword}&searchType=${searchType}"
			                   class="${ulsearchVO.page == 1 ? 'pagination-disabled' : ''}">[처음]</a>
			
			                <a href="adminNoticeListView?page=${ulsearchVO.page - 1}&sk=${searchKeyword}&searchType=${searchType}"
			                   class="${ulsearchVO.page == 1 ? 'pagination-disabled' : ''}">[이전]</a>
			
			                <c:forEach begin="${ulsearchVO.pageStart}" end="${ulsearchVO.pageEnd}" var="i">
			                    <c:choose>
			                        <c:when test="${i eq ulsearchVO.page}">
			                            <span class="pagination-active">${i} &nbsp; &nbsp;</span>
			                        </c:when>
			                        <c:otherwise>
			                            <a href="adminNoticeListView?page=${i}&sk=${searchKeyword}&searchType=${searchType}">${i}</a> &nbsp; &nbsp;
			                        </c:otherwise>
			                    </c:choose>
			                </c:forEach>
			
			                <a href="adminNoticeListView?page=${ulsearchVO.page + 1}&sk=${searchKeyword}&searchType=${searchType}"
			                   class="${ulsearchVO.page == ulsearchVO.totPage ? 'pagination-disabled' : ''}">[다음]</a>
			
			                <a href="adminNoticeListView?page=${searchVO.totPage}&sk=${searchKeyword}&searchType=${searchType}"
			                   class="${ulsearchVO.page == ulsearchVO.totPage ? 'pagination-disabled' : ''}">[마지막]</a>
			            </c:when>
			            
			            <c:otherwise>
			                <a href="adminNoticeListView?page=1&sk=${searchKeyword}&searchType=${searchType}" class="pagination-disabled">[처음]</a>
			
			                <a href="adminNoticeListView?page=1&sk=${searchKeyword}&searchType=${searchType}" class="pagination-disabled">[이전]</a>
			
			                <span class="pagination-active">1 &nbsp; &nbsp;</span>
			
			                <a href="adminNoticeListView?page=1&sk=${searchKeyword}&searchType=${searchType}" class="pagination-disabled">[다음]</a>
			
			                <a href="adminNoticeListView?page=1&sk=${searchKeyword}&searchType=${searchType}" class="pagination-disabled">[마지막]</a>
			            </c:otherwise>
			            
			        </c:choose>
			    </td>
			</tr>
        </tfoot>
    </table>
</div>