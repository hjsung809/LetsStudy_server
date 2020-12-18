<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:useBean scope="session" id="studyGroupManager"
	class="study.StudyManager" />

<jsp:useBean scope="session" id="recruitmentManager"
	class="study.RecruitmentManager" />
	
<%@ page import="java.util.ArrayList"%>


<%
study.StudyGroup studyGroup = (study.StudyGroup) session.getAttribute("studyGroup");
int memberCount = studyGroupManager.countStudyGroupMember(studyGroup.getStudy_group_id());

if (request.getMethod().equals("POST")) {
	boolean success = recruitmentManager.createRecruitment(
			studyGroup.getStudy_group_id(),
			request.getParameter("rc_title"),
			request.getParameter("rc_description"),
			Integer.parseInt(request.getParameter("rc_size"))
			);
	
	if(success) {
		response.sendRedirect("study_management.jsp?study_group_id=" + request.getParameter("study_group_id"));
	} else {
	      out.println("<script>alert('스터디 모집 생성에 실패하였습니다.')</script>");
	}
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
	#main_section {
		height: 100%;
		display: flex;
		flex-direction: column;
  		justify-content: center;
	}
	
	#study_recruitment_form {
		width: 95%;
		height: 70%;
		display: flex;
		flex-direction: column;
		justify-content: space-between;
  		box-shadow: 4px 4px 10px 4px rgba(0,0,0,0.1);
  		padding: 30px;
	}
	
	#study_recruitment_form button {
		width: 200px;
	}

</style>
</head>
<body>
	<%@ include file="header.jsp"%>
	<div id="content">
		<section id="main_section">
			<form id="study_recruitment_form" method=post
				action="<%="study_recruitment.jsp?study_group_id=" + studyGroup.getStudy_group_id()%>">
				<h3>
					스터디 -
					<%=studyGroup.getSg_name()%></h3>
				<p><%=studyGroup.getSg_description()%></p>
				<br>
				<h3>스터디 모집</h3>
				<input type="text" name="rc_title" placeholder="모집 제목">
				<textarea name="rc_description" cols="30" rows="10"
					placeholder="모집 내용"></textarea>

				<label for="rc_size">모집 인원</label> <input type="number"
					name="rc_size"
					max=<%=studyGroup.getSg_max_size() - memberCount%>
					value="<%=studyGroup.getSg_max_size() - memberCount%>">

				<button type="submit">모 집</button>
			</form>
		</section>

	</div>
	<%@ include file="footer.jsp"%>
</body>
</html>