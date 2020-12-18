<%@page import="study.Recruitment"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean scope="session" id="studyGroupManager"
	class="study.StudyManager" />

<jsp:useBean scope="session" id="recruitmentManager"
	class="study.RecruitmentManager" />
<%@ page import="java.util.List"%>

<%
study.User user = (study.User) session.getAttribute("user");

List<study.Recruitment> recruitments = (List<study.Recruitment>) session.getAttribute("recruitments");
String recruitment_id_string = request.getParameter("recruitment_id");
Recruitment recruitment = null;
int memberCount = 0;
int applicant_count = 0;

if (recruitments != null && recruitment_id_string != null) {
	int recruitment_id = Integer.parseInt(recruitment_id_string);
	for (Recruitment tmp : recruitments) {
		if (tmp.getRecruitment_id() == recruitment_id) {
	recruitment = tmp;
		}
	}

	if (recruitment == null) {
		response.sendRedirect("study_search.jsp");
	} else {
		memberCount = studyGroupManager.countStudyGroupMember(recruitment.getStudy_group_id());
		applicant_count = recruitmentManager.countApplicant(recruitment.getRecruitment_id());
	}
} else {
	response.sendRedirect("study_search.jsp");
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="stylesheet" type="text/css" href="init.css">

<style>
	#main_section {
		height: 100%;
		display: flex;
		flex-direction: column;
  		align-items: center;
  		justify-content: center;
	}
	.recruitment_infos {
		display: flex;
		flex-direction: row;
	}	
	
	.recruitment_info {
		width: 600px;
		height: 400px;
		display: flex;
		flex-direction: column;
  		box-shadow: 4px 4px 10px 4px rgba(0,0,0,0.1);
  		padding: 30px;
	}
	
	.recruitment_info h3 {
		margin-bottom: 20px;
	}
	
	.recruitment_info + .recruitment_info {
		margin-left: 20px;
	}
	
	#buttons {
		display: flex;
		flex-direction: column;
		justify-content: center;
		flex-direction: row;
		margin-top: 80px;
	}
	
	#buttons button {
		width: 200px;
	}
	
	#buttons > button {
		margin-left: 50px;
	}
</style>
</head>
<body>
	<%@ include file="header.jsp"%>
	<div id="content">
		<section id="main_section">
			<div class="recruitment_infos">
			<div class="recruitment_info">
				<%
					if (recruitment != null) {
				%>
				<h3>스터디 정보</h3>
				<div class="input_wrapper">
				<label for="sg_name">스터디 이름</label> <input type="text"
					name="sg_name"
					value="<%=recruitment.getSg_name()%>" readonly>
				</div>
				<div class="input_wrapper">
				<label for="sg_description">스터디 소개</label> <textarea type="text"
					name="sg_description"
					readonly><%=recruitment.getSg_description()%></textarea>
				</div>
				<div class="input_wrapper">
				<label for="memberCount">현재 멤버 수</label> <input type="number"
					name="memberCount"
					value="<%=memberCount%>" readonly>
				</div>
				<%
					}
				%>
			</div>
			
			<div class="recruitment_info">
				<%
					if (recruitment != null) {
				%>
					
				<h3>모집 정보</h3>
				<div class="input_wrapper">
				<label for="rc_title">모집 제목</label> <input type="text"
					name="rc_title"
					value="<%=recruitment.getRc_title()%>" readonly>
				</div>
				<div class="input_wrapper">
				<label for="rc_description">모집 내용</label> <textarea type="text"
					name="rc_description"
					readonly><%=recruitment.getRc_description()%></textarea>
				</div>
				<div class="input_wrapper">
				<label for="rc_size">추가 모집 인원</label> <input type="number"
					name="rc_size"
					value="<%=recruitment.getRc_size()%>" readonly>
				</div>
				<div class="input_wrapper">
				<label for="applicant_count">현재 지원 인원</label> <input type="number"
					name="applicant_count"
					value="<%=applicant_count%>" readonly>
				</div>
				<%
					}
				%>
			</div>
			</div>
			<div id="buttons">
			<form method=get action="study_apply.jsp">
				<input type="hidden" name="recruitment_id" value="<%=recruitment_id_string %>">
				<button type="submit">지원하기</button>
			</form>
			<button type="button" onclick="location.href='study_search.jsp'">뒤로가기</button>
			</div>
		</section>

	</div>
	<%@ include file="footer.jsp"%>
</body>
</html>