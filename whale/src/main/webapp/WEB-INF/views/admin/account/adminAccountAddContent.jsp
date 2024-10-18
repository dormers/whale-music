<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="officialAddForm">
	<form action="" method="post">
		<table class="officialAddTable">
			<tr>
				<td class="tdName">아이디</td>
				<td class="tdContent">
					<input type="text" />
					<button onclick="location.href=''">조회</button>
				</td>
			</tr>
			<tr>
				<td class="tdName">official 이름</td>
				<td class="tdContent">
				<input type="text" />
				</td>
			</tr>
			<tr>
				<td class="tdName">분야</td>
				<td class="tdContent">
				<input type="text" />
				</td>
			</tr>
			<tr>
				<td class="tdName">권한</td>
				<td class="tdContent">
					<label>
				        <input type="radio" name="userType" value="official" />
				        오피셜
				    </label>
				    
				    <label>
				        <input type="radio" name="userType" value="advertiser" />
				        광고주
				    </label>
				    
				    <label>
				        <input type="radio" name="userType" value="admin" />
				        관리자
				    </label>
				</td>
			</tr>
			<tr>
				<td class="tdName">인증내용</td>
				<td class="tdContent">
				<textarea name="" id="" cols="30" rows="10"></textarea>
				</td>
			</tr>
		</table>
		<div class="submit">
			<input type="submit" value="저장" />
			<button type="button" onclick="history.back()">취소</button>
		</div>
	</form>
</div>