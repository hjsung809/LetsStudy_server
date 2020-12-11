<%@page import="study.Applicant"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:useBean scope="session" id="studyGroupManager"
	class="study.StudyManager" />

<jsp:useBean scope="session" id="recruitmentManager"
	class="study.RecruitmentManager" />

<%@ page import="java.util.List"%>


<%
study.User user = (study.User) session.getAttribute("user");
study.StudyGroup studyGroup = (study.StudyGroup)session.getAttribute("studyGroup");

study.Recruitment recruitment= (study.Recruitment) recruitmentManager.getRecruitment(studyGroup.getStudy_group_id());
List<study.Applicant> applicants = null;

if (recruitment == null) {
	response.sendRedirect("study_management.jsp?study_group_id=" + studyGroup.getStudy_group_id());
} else {
	applicants = (List<study.Applicant>) recruitmentManager.geApplicantList(recruitment.getRecruitment_id());
	session.setAttribute("applicants", applicants);
}

%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="stylesheet" type="text/css" href="init.css">

<style type="text/css">
#applicant_info {
	border: 1px solid black;
	padding: 10px;
	margin: 10px;
}

#applicant_list {
	border: 1px solid black;
	width: 100%;
	height: 500px;
	background-color: darksalmon;
}

#applicant_list>table {
	width: 100%;
	padding: 5px;
	border: 1px solid black;
	text-align: center;
}

#applicant_list td {
	border: 1px solid black;
}
</style>
</head>
<body>
	<%@ include file="header.jsp"%>
	<div id="content">
		<section id="main_section">
			<div id="applicant_info">
				<h3>지원자 목록 - (<%=studyGroup.getSg_name()%>)</h3>
				<div id="applicant_list">

					<table>
						<tr>
							<th>지원자</th>
							<th>전화 번호</th>
							<th>지원 제목</th>
							<th>자세히</th>
						</tr>
						<%
							if (applicants != null) {
							for (study.Applicant applicant : applicants) {
						%>
						<tr>
							<td><%=applicant.getUser().getUsr_nickname()%></td>
							<td><%=applicant.getUser().getUsr_phone_number()%></td>
							<td><%=applicant.getUr_apply_title()%></td>
							<td>
							
							<form method=get action="study_applicant_detail.jsp">
								<input type="hidden" name="study_group_id" value=<%=studyGroup.getStudy_group_id()%>>
								<input type="hidden" name="applicant_user_id" value=<%=applicant.getUser().getUser_id()%>>
								<input type="hidden" name="recruitment_id" value=<%=applicant.getRecruitment_id()%>>
								<button type="submit">이동</button>
							</form>
							</td>
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