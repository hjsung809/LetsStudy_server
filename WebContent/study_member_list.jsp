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
      padding: 20px;
    }

    #study_member_list {
      height: 480px;
   	  overflow: auto;
   	  box-shadow: 4px 4px 10px 4px rgba(0,0,0,0.1);
   	  padding: 20px;
   	  margin: 20px 0;
    }
    
    #study_member_list table {
      width: 100%;
      text-align: center;
      border-collapse: collapse;
    }
    
    #study_member_list tr {
      height: 50px;
    }
   
    #study_member_list tr:nth-child(even) {
      background-color: rgba(0,0,0,0.05);
    }
    
</style>
</head>
<body>
	<%@ include file="header.jsp"%>
	<div id="content">
		<section id="main_section">
			<div id="study_member_info">
				<h2>멤버 목록</h2>
				<div id="study_member_list">
					<table>
				<tr>
					<th>닉네임</th>
					<th>전화 번호</th>
					<th>이메일</th>
					<!-- <th>자세히</th> -->
				</tr>
				<%
					if (members != null) {
					for (study.User member : members) {
				%>
				<tr>
					<td><%=member.getUsr_nickname()%></td>
					<td><%=member.getUsr_phone_number()%></td>
					<td><%=member.getUsr_email()%></td>
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
	<%@ include file="footer.jsp"%>
</body>
</html>