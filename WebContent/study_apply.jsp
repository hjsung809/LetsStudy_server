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
		if (request.getMethod().equals("POST")) {
			String ur_apply_title = request.getParameter("ur_apply_title");
			String ur_apply_description = request.getParameter("ur_apply_description");
			
			if (ur_apply_title != null && ur_apply_description != null) {
				boolean success = recruitmentManager.applyRecruitment(
						user.getUser_id(),
						recruitment.getRecruitment_id(),
						ur_apply_title,
						ur_apply_description);
				
				if (success) {
					out.print("<script>alert('가입 신청이 완료되었습니다.')</script>");
					response.sendRedirect("study_search_detail.jsp?recruitment_id=" + recruitment_id_string);
				} else {
					out.print("<script>alert('가입신청을 할 수 없습니다.')</script>");
					response.sendRedirect("study_search_detail.jsp?recruitment_id=" + recruitment_id_string);
				}
			} else {
				out.print("<script>alert('잘못 입력입니다')</script>");
			}
		}
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
  		align-items: center;
  		justify-content: center;
	}
	
   .study_apply {
      width: 800px;
      height: 400px;
      box-shadow: 4px 4px 10px 4px rgba(0,0,0,0.1);
      display: flex;
      flex-direction: column;
      padding: 30px 20px;
    }
    .study_apply form {
      display: flex;
      flex-direction: column;
    }
    
    .study_apply form textarea {
      height: 150px;
    }
    
     .study_apply form > * + * {
      margin-top: 10px;
      margin-bottom: 10px;
     }
    
    .study_apply > * + * {
      margin-top: 10px;
      margin-bottom: 10px;
    } 
    
    button {
   	  width: 200px;
   	  align-self: center;
    }
    
</style>
</head>
<body>
	<%@ include file="header.jsp"%>
	<div id="content">
		<section id="main_section">
			<div class="study_apply">
				<% if (recruitment != null) { %>
				<form method=post action="study_apply.jsp">
					<input type="hidden" name="recruitment_id"
						value="<%=recruitment_id_string%>">
					<h3>
						스터디 지원 -
						(<%=recruitment.getSg_name()%>)</h3>
					<input type="text" name="ur_apply_title" placeholder="신청 제목">
					<textarea name="ur_apply_description" placeholder="신청 내용"></textarea>
					<button type="submit">신청하기</button>
				</form>


				<form method=get action="study_search_detail.jsp">
					<input type="hidden" name="recruitment_id"
						value="<%=recruitment_id_string%>">
					<button type="submit">뒤로가기</button>
				</form>
				<% } %>
			</div>


		</section>

	</div>
	<%@ include file="footer.jsp"%>
</body>
</html>