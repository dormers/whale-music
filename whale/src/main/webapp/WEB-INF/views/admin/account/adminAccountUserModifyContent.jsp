<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
    function confirmUpdate() {
        var result = confirm("저장하시겠습니까?");
        if (result) {
            document.getElementById("nicknameForm").submit();
        } else {
            alert("취소되었습니다.");
        }
    }
    
    function accessModify() {
        var result = confirm("저장하시겠습니까?");
        if (result) {
            document.getElementById("accessForm").submit();
        } else {
            alert("취소되었습니다.");
        }
    }

    function confirmDelete() {
        var result = confirm("삭제하시겠습니까?");
        if (result) {
        	document.getElementById("proImgForm").submit();
        } else {
            alert("취소되었습니다.");
        }
    }
    
    function accessUpdate() {
        var result = confirm("저장하시겠습니까?");
        if (result) {
            document.getElementById('accessAddForm').style.display = 'none';
            document.getElementById("accessForm").submit();
        } else {
            alert("취소되었습니다.");
        }
    }
    function statusUpdate() {
        var result = confirm("저장하시겠습니까?");
        if (result) {
            document.getElementById('userStatus').style.display = 'none';
            document.getElementById("userStatusForm").submit();
        } else {
            alert("취소되었습니다.");
        }
    }
    
    function companyNameText(){
		var selectedValue = document.querySelector('input[name="userAccess"]:checked').value;
        var companyNameField = document.getElementById('companyName');
        var submitButton = document.querySelector('#accessForm button[type="button"]');
        if (selectedValue === '2' || selectedValue === '3') {
            companyNameField.style.display = 'block';
        } else {
            companyNameField.style.display = 'none';
        }
        toggleAccessButton();
    	
    }
    function statusUpdateButton(){
		var selectedValue = document.querySelector('input[name="userStatus"]:checked').value;
        if (selectedValue) {
            companyNameField.style.display = 'block';
        } else {
            companyNameField.style.display = 'none';
        }
        toggleAccessButton();
    	
    }
    
    function toggleAccessButton(){
    	var selectedValue = document.querySelector('input[name="userAccess"]:checked');
    	var submitButton = document.querySelector('#accessForm button[type="button"]');
        
        if (selectedValue) {
            submitButton.disabled = false;
        } else {
            submitButton.disabled = true;
        }
    }
    function toggleStatusButton(){
    	var selectedValue = document.querySelector('input[name="userStatus"]:checked');
    	var submitButton = document.querySelector('#userStatusForm button[type="button"]');
        
        if (selectedValue) {
            submitButton.disabled = false;
        } else {
            submitButton.disabled = true;
        }
    }
    
    
    function openStatus() {
        document.getElementById('userStatus').style.display = 'block';
    }

    function closeStatus() {
        document.getElementById('userStatus').style.display = 'none';
    }
    function closeAccess() {
        document.getElementById('accessAddForm').style.display = 'none';
    }

    function openAccess() {
        document.getElementById('accessAddForm').style.display = 'block';
    }
    
    document.addEventListener('DOMContentLoaded', function() {
    	toggleAccessButton();
    	toggleStatusButton();
    });
    
    
</script>

<div class="content" name="content" id="content">
	<div calss="userInfoForm">
		<h2>유저상세</h2>
		<table class="userInfo">
			<tr>
				<td rowspan="5" class="proImg" style="width: 40%;">
					<div>
						<c:if test="${not empty AccountUserInfo.user_image_url }">
							<img src="${AccountUserInfo.user_image_url }" alt="프사" />
						</c:if>
						<c:if test="${empty AccountUserInfo.user_image_url }">
							프로필사진 없음
						</c:if>
					</div>
					<form id="proImgForm" action="adminUserImgDelete" method="post">
						<input type="hidden" name="userImgUrl" value="${AccountUserInfo.user_image_url }" />
						<input type="hidden" name="userId" value="${AccountUserInfo.user_id }" />
						<input type="hidden" name="page" value="${page}" />
						<input type="hidden" name="searchType" value="${searchType}" />
						<input type="hidden" name="searchOrderBy" value="${searchOrderBy }" />
						<input type="hidden" name="sk" value="${sk}" />
					</form>
					<button onclick="confirmDelete()" >사진 삭제</button>
				</td>
				<td style="width: 10%;">아이디</td>
				<td style="width: 50%;">${AccountUserInfo.user_id }</td>
			</tr>
			<tr>
				<td>닉네임</td>
				<form id="nicknameForm" action="adminUserNicknameModify" method="post">
				<td>
					<input type="hidden" name="searchOrderBy" value="${searchOrderBy}" />
					<input type="hidden" name="page" value="${page}" />
					<input type="hidden" name="sk" value="${sk}" />
					<input type="hidden" name="searchType" value="${searchType}" />
					<input type="hidden" name="userId" value="${AccountUserInfo.user_id }" />&nbsp;
					<input type="text" name="userNickname" value="${AccountUserInfo.user_nickname }" />
					<button onclick="confirmUpdate()" >수정</button>
				</td>
				</form>
			</tr>
			<tr>
				<td>이메일</td>
				<td>${AccountUserInfo.user_email }</td>
			</tr>
			<tr>
				<td>권한</td>
				<td>
					${AccountUserInfo.user_access_str }
					<button type="button" onclick="openAccess()">수정하기</button>
				</td>
			</tr>
			<tr>
				<td>계정상태</td>
				<td>
					${AccountUserInfo.user_status_str } &nbsp;
					<button type="button" onclick="openStatus()">수정하기</button>
				</td>
			</tr>
		</table>
	</div>
	
	<div id="userStatus" class="userStatus" style="display: none;">
	    <div class="userStatusContent">
	        <h2>계정상태 수정</h2>
	        <form id="userStatusForm" action="adminUserStatusModify" method="post">
	        	<table style="border-top: 1px solid #999;">
	        		<tr>
	        			<td>계정상태변경</td>
	        			<td>
	        				<label>
	        					<input type="radio" name="userStatus" value="0" onclick="toggleStatusButton()"/>
	        					활동
	        				</label>
	        				&nbsp;&nbsp;
	        				<label>
	        					<input type="radio" name="userStatus" value="1" onclick="toggleStatusButton()"/>
	        					정지
	        				</label>
	        			</td>
	        		</tr>
	        		<tr>
	        			<td>변경사유</td>
	        			<td>
	        				<textarea name="statusReason" id="statusReason" cols="60" rows="20"></textarea>
	        			</td>
	        		</tr>
	        		<tr style="border-bottom: none;">
	        			<td colspan="2" style="margin: 0 auto;">
	        				<input type="hidden" name="searchOrderBy" value="${searchOrderBy}" />
							<input type="hidden" name="page" value="${page}" />
							<input type="hidden" name="sk" value="${sk}" />
							<input type="hidden" name="searchType" value="${searchType}" />
	        				<input type="hidden" name="userId" value="${AccountUserInfo.user_id }" />
	        				<button type="button" onclick="statusUpdate()">저장</button>
	            			<button type="button" onclick="closeStatus()">취소</button>
	        			</td>
	        		</tr>
	        	</table>
	        </form>
	        <div>
	            
	        </div>
	    </div>
	</div>
	<div id="accessAddForm" class="accessAddForm" style="display: none;">
		<h2>권한 수정</h2>
		<form id="accessForm" action="adminUserAccessModify" method="post">
			<table class="accessAddTable" style="border-top: 1px solid #999;">
				<tr>
					<td class="tdName">상호명</td>
					<td class="tdContent">
						<input type="text" name="companyName" id="companyName" style="display: none; margin: 0 auto; width:430px;"  />
					</td>
				</tr>
				<tr>
					<td class="tdName">권한</td>
					<td class="tdContent">
						<label>
					        <input type="radio" name="userAccess" value="0" onclick="companyNameText()"/>
					        유저
					    </label>
					    &nbsp;&nbsp;
						<label>
					        <input type="radio" name="userAccess" value="1" onclick="companyNameText()"/>
					        관리자
					    </label>
					</td>
				</tr>
				<tr>
					<td class="tdName">변경사유</td>
					<td class="tdContent">
						<textarea name="accessReason" id="accessReason" cols="60" rows="20"></textarea>
					</td>
				</tr>
				<tr style="border-bottom: none;">
					<td colspan="2">
						<div class="submit" style="margin: 0 auto;">
							<input type="hidden" name="searchOrderBy" value="${searchOrderBy}" />
							<input type="hidden" name="page" value="${page}" />
							<input type="hidden" name="sk" value="${sk}" />
							<input type="hidden" name="searchType" value="${searchType}" />
							<input type="hidden" name="userId" value="${AccountUserInfo.user_id }" />
							<input type="hidden" name="userAccessNow" value="${AccountUserInfo.user_access_id }" />
							<button type="button" onclick="accessUpdate()" disabled>저장</button>
							<button type="button" onclick="closeAccess()">취소</button>
						</div>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<br />
	<br />
	<br />
</div>