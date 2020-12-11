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
List<study.Applicant> applicants = (List<study.Applicant>)session.getAttribute("applicants");
String applicant_user_id_string = request.getParameter("applicant_user_id");
study.Applicant applicant = null; 


if (recruitment != null && applicants != null && applicant_user_id_string != null) {
	int applicant_user_id = Integer.parseInt(applicant_user_id_string);
	
	for (study.Applicant tmp : applicants) {
		if (tmp.getRecruitment_id() == recruitment.getRecruitment_id() && tmp.getUser().getUser_id() == applicant_user_id) {
			applicant = tmp;
			break;
		}
	}
	
	if (applicant != null) {
		if(request.getMethod().equals("POST")){
			boolean success = recruitmentManager.acceptApplicant(
					applicant.getUser().getUser_id(),
					studyGroup.getStudy_group_id(),
					recruitment.getRecruitment_id()
					);
			
			if(success) {
				out.println("<script>alert('새로운 스터디원이 생겼습니다.')</script>");
				response.sendRedirect("study_management.jsp?study_group_id" + studyGroup.getStudy_group_id());
			} else {
				out.println("<script>alert('합격처리에 실패하였습니다.')</script>");
			}
		}
	} else {
		response.sendRedirect("study_management.jsp?study_group_id" + studyGroup.getStudy_group_id());
	}
} else {	
	response.sendRedirect("study_management.jsp?study_group_id" + studyGroup.getStudy_group_id());
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

.recruitment_info {
	border: 1px solid black;
	padding: 10px;
	margin: 10px;
}

.recruitment_info input {
	width: 80%;
	display: block;
	margin: 5px auto;
}

.recruitment_info textarea {
	width: 80%;
	display: block;
	margin: 5px auto;
}

.recruitment_info button {
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
			<div class="recruitment_info">
				<%
					if (applicant != null) {
				%>
				<h3>지원자 정보</h3>
				<label for="nick_name">지원자 닉네임</label> <input type="text"
					name="nick_name"
					value="<%=applicant.getUser().getUsr_nickname()%>" readonly>
					
				<label for="email">지원자 이메일</label> <input type="text"
					name="email"
					value="<%=applicant.getUser().getUsr_email()%>" readonly>
					
				<label for="phone_number">지원자 전화번호</label> <input type="text"
					name="phone_number"
					value="<%=applicant.getUser().getUsr_phone_number()%>" readonly>
				
					
				<label for="description">지원자 소개글</label> <input type="text"
					name="description"
					value="<%=applicant.getUser().getUsr_description()%>" readonly>
				
				<h3>지원자 내용</h3>
				<label for="ur_title">지원 제목</label> <input type="text"
					name="ur_title"
					value="<%=applicant.getUr_apply_title()%>" readonly>
					
				<label for="ur_description">지원 내용</label> <textarea
					name="ur_description"
					readonly><%=applicant.getUr_apply_description()%></textarea>
				
				
				<form method=post action="study_applicant_detail.jsp">
					<input type="hidden" name="study_group_id" value=<%=studyGroup.getStudy_group_id()%> >
					<input type="hidden" name="applicant_user_id" value=<%=applicant.getUser().getUser_id()%>>
					<input type="hidden" name="recruitment_id" value=<%=applicant.getRecruitment_id()%>>
					<button type="submit">합격 처리</button>
				</form>
				<%
					}
				%>
			</div>
		</section>

	</div>
	<footer id="main_footer">
		<h3>Let's study</h3>
	</footer>
</body>
</html>