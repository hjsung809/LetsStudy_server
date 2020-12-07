<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
study.User user = (study.User) session.getAttribute("user");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="stylesheet" type="text/css" href="init.css">

<style>
#study_info {
	border: 1px solid black;
	padding: 10px;
	margin: 10px;
}

#study_join_form {
	border: 1px solid black;
	padding: 10px;
	margin: 10px;
}

#study_join_form input {
	width: 80%;
	display: block;
	margin: 5px auto;
}

#study_join_form textarea {
	width: 80%;
	display: block;
	margin: 5px auto;
}

#study_join_form button {
	width: 80%;
	display: block;
	margin: 5px auto;
}
</style>
</head>
<body>
	<%@ include file="header.jsp"%>
	<div id="content">
		<section id="main_section">
			<div id="study_info">
				<h3>스터디 이름</h3>
				스터디 소개글 <br>
				<div width="100%">스터디 소개글 자리입니다.</div>
				모집 인원: 0/5
			</div>
			<form id="study_join_form">
				<h3>가입 신청</h3>
				<div>
					<input type="text" placeholder="제목"></input>
					<textarea name="" id="" cols="30" rows="10">자기 소개</textarea>
					<button type="submit">가입 신청</button>
				</div>
			</form>
		</section>
	</div>
	<footer id="main_footer">
		<h3>Let's study</h3>
	</footer>
</body>
</html>