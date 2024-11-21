<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="${pageContext.request.contextPath}/static/js/setting/darkMode.js"></script>
	<style>
		.container[data-darkmode="0"] { background: #f8f9fa; height: 100vh; overflow: hidden; display: flex; justify-content: center; align-items: center; font-family: 'Arial', sans-serif; color: #333; }
		.container[data-darkmode="0"] form { background: #ffffff; padding: 30px 40px; border-radius: 20px; box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); font-weight: 500; font-size: 1rem; width: 100%; max-width: 500px; box-sizing: border-box; }
		.container[data-darkmode="0"] input[type="text"], .container[data-darkmode="0"] textarea { width: 100%; padding: 10px 15px; margin: 10px 0 20px 0; border: 1px solid #ccc; border-radius: 8px; font-size: 1rem; box-sizing: border-box; }
		.container[data-darkmode="0"] input[type="text"]:focus, .container[data-darkmode="0"] textarea:focus { outline: none; border: 1px solid #007bff; box-shadow: 0 0 5px rgba(0, 123, 255, 0.3); }
		.container[data-darkmode="0"] textarea { resize: none; height: 120px; }
		.container[data-darkmode="0"] input[type="submit"], .container[data-darkmode="0"] input[type="button"] { background: #007bff; color: #ffffff; border: none; padding: 10px 20px; margin: 10px 5px 0 0; border-radius: 8px; cursor: pointer; font-size: 1rem; transition: background 0.3s ease; }
		.container[data-darkmode="0"] input[type="button"].cancel { background: #6c757d; }
		.container[data-darkmode="0"] input[type="submit"]:hover { background: #0056b3; }
		.container[data-darkmode="0"] input[type="button"].cancel:hover { background: #5a6268; }
		.container[data-darkmode="0"] label { font-weight: bold; margin-bottom: 5px; display: inline-block; }
		@media (max-width: 600px) { .container[data-darkmode="0"] form { padding: 20px; font-size: 0.9rem; } .container[data-darkmode="0"] input[type="submit"], .container[data-darkmode="0"] input[type="button"] { font-size: 0.9rem; padding: 8px 15px; } }
		/* ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
		.container[data-darkmode="1"] { background: #1f1f1f; height: 100vh; overflow: hidden; display: flex; justify-content: center; align-items: center; font-family: 'Arial', sans-serif; color: whitesmoke; }
		.container[data-darkmode="1"] form { background: #434343; padding: 30px 40px; border-radius: 20px; box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); font-weight: 500; font-size: 1rem; width: 100%; max-width: 500px; box-sizing: border-box; color: whitesmoke; }
		.container[data-darkmode="1"] input[type="text"], .container[data-darkmode="1"] textarea { width: 100%; padding: 10px 15px; margin: 10px 0 20px 0; background-color: #6c6c6c; border: 1px solid #434343; border-radius: 8px; font-size: 1rem; box-sizing: border-box; color: whitesmoke; }
		.container[data-darkmode="1"] input[type="text"]:focus, .container[data-darkmode="1"] textarea:focus { outline: none; border: 1px solid #007bff; box-shadow: 0 0 5px rgba(0, 123, 255, 0.3); }
		.container[data-darkmode="1"] textarea { resize: none; height: 120px; }
		.container[data-darkmode="1"] input[type="submit"], .container[data-darkmode="1"] input[type="button"] { background: #007bff; color: #ffffff; border: none; padding: 10px 20px; margin: 10px 5px 0 0; border-radius: 8px; cursor: pointer; font-size: 1rem; transition: background 0.3s ease; }
		.container[data-darkmode="1"] input[type="button"].cancel { background: #6c757d; }
		.container[data-darkmode="1"] input[type="submit"]:hover { background: #0056b3; }
		.container[data-darkmode="1"] input[type="button"].cancel:hover { background: #5a6268; }
		.container[data-darkmode="1"] label { font-weight: bold; margin-bottom: 5px; display: inline-block; }
		@media (max-width: 600px) { .container[data-darkmode="1"] form { padding: 20px; font-size: 0.9rem; } .container[data-darkmode="1"] input[type="submit"], .container[data-darkmode="1"] input[type="button"] { font-size: 0.9rem; padding: 8px 15px; } }
	</style>

</head>
<body class="container">
	<form action="reportDo" method="post">
		신고 항목  <input type="text" name="report_tag" value="${report_tag}" readonly />
	    <br />

	    <input type="hidden" name="now_id" value="${now_id}" />
	    <input type="hidden" name="report_type_id" value="${report_type_id}" />
	    <input type="hidden" name="userId" value="${userId}" />
	    
		신고 사유
		<textarea name="report_why" id="report_why" class="content">신고 사유를 입력해주십시오.</textarea> <br />
		<br />
		<input type="submit" value="Save" />
		<input type="button" value="Cancel" class="cancel" onClick="history.back();" />
	</form>
</body>
<script>

</script>
</html>