<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Community Board</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@400;600&display=swap">
<style>
    body {
        font-family: 'Noto Sans', sans-serif;
        margin: 0;
        padding: 0;
        color: #ffffff;
        overflow: hidden;
        padding: 40px;
        overflow-y: auto;
        background-image: linear-gradient(to right bottom, rgb(31,31,31), rgb(46,46,46));
    }
    
    /* 이 부분은 보이지 않아서 하지 못함  */
    /* Webkit-based browsers (Chrome, Edge, Safari) */
    body::-webkit-scrollbar {
        width: 8px;
    }

    body::-webkit-scrollbar-track {
        background: #E0E0E0; /* 밝은 색으로 스크롤바 트랙 색상 변경 */
        border-radius: 8px;
    }

    body::-webkit-scrollbar-thumb {
        background-color: #B0B0B0;
        border-radius: 8px;
        border: 2px solid #E0E0E0;
    }

    body::-webkit-scrollbar-thumb:hover {
        background-color: #888888;
    }

    body {
        scrollbar-width: thin;
        scrollbar-color: #B0B0B0 #E0E0E0;
    }
    /* 여기까지 못함 */

    h2 {
        font-size: 24px;
        font-weight: 600;
        margin: 30px 20px 15px 0;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        background-color: #3f3f3f; /* 내부 테이블 배경 화이트로 */
        border-radius: 8px;
        overflow: hidden;
    }

    th, td {
        padding: 10px;
        border-bottom: 1px solid #2e2e2e; /* 구분선을 밝은 회색으로 */
        text-align: center;
        font-size: 14px;
        color: #ffffff; /* 글자를 블랙으로 */
    }

    th {
        background-color: #4f4f4f; /* 테이블 헤더 배경을 밝은 회색으로 */
        font-weight: 600;
        font-size: 14px;
    }

    td a {
        color: #ffffff; /* 링크도 블랙으로 */
        text-decoration: none;
        font-weight: 600;
    }

    td a:hover {
        text-decoration: underline;
    }

    tr:hover {
        background-color: #5e5e5e; /* 행에 마우스를 올렸을 때 배경을 밝게 */
    }

    .btn {
        display: inline-block;
        padding: 10px 20px;
        background-color: #2e2e2e; /* 버튼 배경을 블랙으로 */
        color: #FFFFFF; /* 버튼 글자를 화이트로 */
        opacity: 0.8;
        border-radius: 8px;
        text-decoration: none;
        font-size: 13px;
        font-weight: 600;
        text-align: center;
        transition: background-color 0.3s;
        margin-top: 10px;
    }

    .btn:hover {
        background-color: #333333; /* 버튼 호버 시 약간 더 밝게 */
    }

    .pagination {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: 15px;
    }

    .pagination .page-controls {
        flex: 1;
        display: flex;
        justify-content: space-between;
    }

    .pagination .page-numbers {
        flex: 2;
        display: flex;
        justify-content: center;
    }

    .pagination a, .pagination span {
        padding: 8px 12px;
        border: 1px solid #D0D0D0; /* 테두리를 밝은 회색으로 */
        border-radius: 8px;
        text-decoration: none;
        color: #000000; /* 페이지네이션 글자를 블랙으로 */
        font-weight: 600;
        transition: background-color 0.3s, color 0.3s;
    }

    .pagination a:hover {
        background-color: #F0F0F0; /* 페이지네이션 호버 시 밝게 */
        color: #000000;
    }

    .pagination span {
        background-color: #E0E0E0;
        color: #000000;
    }

    .disabled {
        cursor: not-allowed;
        opacity: 0.5;
        pointer-events: none;
    }


    .search-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        background-color: #2e2e2e;
        margin: 20px 0;
        padding: 10px 40px;
        border-radius: 10px;
        margin-top: 15px;
    }

    .search-bar input[type="text"] {
        width: 30%;
        padding: 10px;
        border: 1px solid #D0D0D0;
        border-radius: 8px;
        background-color: #FFFFFF;
        color: #000000;
        font-family: 'Noto Sans', sans-serif;
        font-weight: 400;
    }

    .search-bar input[type="submit"] {
        padding: 10px 20px;
        background-color: #000000;
        border: none;
        color: #FFFFFF;
        cursor: pointer;
        border-radius: 8px;
        transition: background-color 0.3s;
        font-family: 'Noto Sans', sans-serif;
        font-weight: 600;
    }

    .search-bar input[type="submit"]:hover {
        background-color: #333333;
    }

    .footer {
        text-align: center;
        padding: 16px 0;
        font-size: 12px;
        color: #666666;
        border-top: 1px solid #2E2E2E;
        margin-top: 15px;
    }

    /* 모달 스타일 */
    .modal {
        display: none; /* 기본적으로 숨겨진 상태 */
        position: fixed;
        z-index: 1;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.4);
    }

    .modal-content {
        background-color: #FFFFFF;
        margin: 15% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 80%;
        color: #000000;
    }

    .close {
        color: #888;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }

    .close:hover,
    .close:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
    }
    
    .user-id {
    cursor: pointer;
    color: #ffffff;
    font-weight: bold;
	}
	
	.user-id:hover {
	    color: #e2e2e2;
	}
	
	.community-link {
	    color: #f2f2f2;
	    opacity: 0.7;
	    text-decoration: none;
	    font-size: 24px;
        font-weight: 600;
	}
	
	.community-link:hover {
	    color: #ffffff;
	    opacity: 0.5;
	    text-decoration: none;
	}
    
</style>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
	//리사이즈
	$(document).ready(() => {resize();});
	$(window).resize(() => {resize();});
	function resize() {
		var windowHeight = $(window).height();
		$('body').css({'height': (windowHeight-80)+'px'});
	};
</script>
</head>
<body>
    <h2><a href="communityPost?c=${param.c}" class = "community-link" style="color: #ffffff;">" ${communityName} " </a></h2>
    <br />

    <table>
        <tr>
            <th>번호</th>
            <th>태그</th>
            <th>제목</th>
            <th>작성자</th>
            <th>등록일</th>
            <th>조회수</th>
        </tr>
        <c:forEach items="${list}" var="p">
            <tr>
                <td>${p.post_num}</td>
                <td>${p.post_tag_text}</td>
                <td><a href="communityDetail?c=${param.c}&p=${p.post_id}">${p.post_title}</a></td>
                <td>
                    <span class="user-id" data-user-id="${p.user_id}">${p.user_id}</span>
                </td>
                <td>${p.post_date}</td>
                <td>${p.post_cnt}</td>
            </tr>
        </c:forEach>
    </table>

    <!-- 모달 영역 -->
    <div id="userModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2>사용자 정보</h2>
            <p>아래의 링크로 사용자와 관련된 작업을 수행할 수 있습니다.</p>
            <a href="" id="profile-link">프로필</a> <br />
            <a href="" id="message-link">쪽지 보내기</a> <br />
            <a href="" id="block-link">차단</a>
        </div>
    </div>

    <script>
    document.addEventListener('DOMContentLoaded', function () {
        const modal = document.getElementById('userModal');
        const span = document.getElementsByClassName('close')[0];

        document.addEventListener('click', function (event) {
            if (event.target.classList.contains('user-id')) {
                const userId = event.target.getAttribute('data-user-id');
                console.log('User ID Clicked: ', userId);

                // 모달 안의 링크를 업데이트
                document.getElementById('profile-link').setAttribute('href', `/profile/${userId}`);
                document.getElementById('message-link').setAttribute('href', `/sendMessage/${userId}`);
                document.getElementById('block-link').setAttribute('href', `/blockUser/${userId}`);

                modal.style.display = 'block';
            }
        });

        // 모달 닫기
        span.onclick = function () {
            modal.style.display = 'none';
        };

        // 외부 클릭 시 모달 닫기
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = 'none';
            }
        };
    });
    </script>

    <br />
    <br />
    <a href="postReg.do" class="btn">글쓰기</a>
    <br />
    <br />

    <c:if test="${totRowcnt > 0}">
        <div class="pagination">
            <div class="page-controls">
                <c:choose>
                    <c:when test="${searchVO.page == 1}">
                        <span class="disabled">◁</span>
                        <span class="disabled">◀</span>
                    </c:when>
                    <c:otherwise>
                        <a href="communityPost?c=${param.c}&page=1&sk=${searchKeyword}&tagId=${param.tagId}&searchType=${param.searchType}">◁</a>
                        <a href="communityPost?c=${param.c}&page=${searchVO.page - 1}&sk=${searchKeyword}&tagId=${param.tagId}&searchType=${param.searchType}">◀</a>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="page-numbers">
                <c:forEach begin="${searchVO.pageStart}" end="${searchVO.pageEnd}" var="i">
                    <c:choose>
                        <c:when test="${i eq searchVO.page}">
                            <span>${i}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="communityPost?c=${param.c}&page=${i}&sk=${searchKeyword}&tagId=${param.tagId}&searchType=${param.searchType}">${i}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>

            <div class="page-controls">
                <c:choose>
                    <c:when test="${searchVO.page == searchVO.totPage || totRowcnt == 0}">
                        <span class="disabled">▶</span>
                        <span class="disabled">▷</span>
                    </c:when>
                    <c:otherwise>
                        <a href="communityPost?c=${param.c}&page=${searchVO.page + 1}&sk=${searchKeyword}&tagId=${param.tagId}&searchType=${param.searchType}">▶</a>
                        <a href="communityPost?c=${param.c}&page=${searchVO.totPage}&sk=${searchKeyword}&tagId=${param.tagId}&searchType=${param.searchType}">▷</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </c:if>

    <form action="communityPost" class="search-bar">
        <input type="hidden" name="c" value="${param.c}" />
        
            <c:choose>
                <c:when test="${title}">
                    <input type="checkbox" name="searchType" value="title" checked /> 제목
                </c:when>
                <c:otherwise>
                    <input type="checkbox" name="searchType" value="title" /> 제목
                </c:otherwise>
            </c:choose>
            <c:choose>
                <c:when test="${content}">
                    <input type="checkbox" name="searchType" value="content" checked /> 내용
                </c:when>
                <c:otherwise>
                    <input type="checkbox" name="searchType" value="content" /> 내용
                </c:otherwise>
            </c:choose>
            <select name="tagId">
                <option value="">모든 태그</option>
                <c:forEach items="${tlist}" var="t">
                    <option value="${t.post_tag_id}" ${param.tagId == t.post_tag_id ? "selected" : "" }>${t.post_tag_text}</option>
                </c:forEach>
            </select>
            <input type="text" name="sk" value="${searchKeyword}" placeholder="검색어를 입력하세요" />
            <input type="submit" value="검색" />
        
    </form>

    <div class="footer">
        &copy; Whale Community
    </div>
</body>
</html>
