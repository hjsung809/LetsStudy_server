<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:useBean scope="session" id="studyGroupManager"
	class="study.StudyManager" />

<jsp:useBean scope="session" id="recruitmentManager"
	class="study.RecruitmentManager" />

<%@ page import="java.util.ArrayList"%>


<%
study.StudyGroup studyGroup = (study.StudyGroup) session.getAttribute("studyGroup");
ArrayList<study.User> members = studyGroupManager.getStudyMember(studyGroup.getStudy_group_id());
/* if (request.getMethod().equals("POST")) {
	boolean success = recruitmentManager.createRecruitment(
	studyGroup.getStudy_group_id(),
	request.getParameter("rc_title"),
	request.getParameter("rc_description"),
	Integer.parseInt(request.getParameter("rc_size"))
	);
	
	if(success) {
		response.sendRedirect("study_management.jsp?study_group_id=" + studyGroup.getStudy_group_id());
	} else {
	      out.println("<script>alert('스터디 모집 생성에 실패하였습니다.')</script>");
	}
} */
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="stylesheet" type="text/css" href="init.css">

<style type="text/css">
#study_member_info {
	border: 1px solid black;
	padding: 10px;
	margin: 10px;
}

#study_member_list {
	border: 1px solid black;
	width: 100%;
	height: 500px;
	background-color: darksalmon;
}

#study_member_list > table {
	width: 100%;
	padding: 5px;
	border: 1px solid black;
	text-align: center;
}

#study_member_list td {
	border: 1px solid black;
}
</style>
</head>
<body>
	<%@ include file="header.jsp"%>
	<div id="content">
		<section id="main_section">
			<div id="study_member_info">
				<h3>멤버 목록</h3>
				<div id="study_member_list">
					<table>
				<tr>
					<th>닉네임</th>
					<th>전화 번호</th>
					<th>이메일</th>
					<th>자세히</th>
				</tr>
				<%
					if (members != null) {
					for (study.User member : members) {
				%>
				<tr>
					<td><%=member.getUsr_nickname()%></td>
					<td><%=member.getUsr_phone_number()%></td>
					<td><%=member.getUsr_email()%></td>
					<td><a
						href="">이동</a></td>
				</tr>
				<%
					}
				}
				%>
			</table>
				</div>
			</div>
		</section>

	</div>
	<footer id="main_footer">
		<h3>Let's study</h3>
	</footer>
</body>
</html>