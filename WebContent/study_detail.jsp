<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean scope="session" id="studyGroupManager"
	class="study.StudyManager" />
<%@ page import="java.util.ArrayList"%>

<%
study.User user = (study.User) session.getAttribute("user");
study.StudyGroup studyGroup = (study.StudyGroup)session.getAttribute("studyGroup");
int memberCount = studyGroupManager.countStudyGroupMember(studyGroup.getStudy_group_id());

if(request.getMethod().equals("POST")) {
	if(request.getParameter("_method").equals("deleteStudyGroup")) {
		System.out.println("delete study groups");
		boolean success = studyGroupManager.deleteStudyGroup(studyGroup.getStudy_group_id());
		
		if(success) {
			response.sendRedirect("study_list.jsp");
		}
	} else if(request.getParameter("_method").equals("deleteThisUser")) {
		System.out.println("delete this user study groups");
		boolean success = studyGroupManager.deleteUserFromStudyGroup(studyGroup.getStudy_group_id(), user.getUser_id());
		
		if(success) {
			response.sendRedirect("study_list.jsp");
		}
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

<style>
#study_details {
	border: 1px solid black;
	padding: 10px;
	margin: 10px;
}

#study_details>input {
	width: 80%;
	display: block;
	margin: 5px auto;
}

#study_details>textarea {
	width: 80%;
	display: block;
	margin: 5px auto;
}

#study_details>button {
	width: 80%;
	display: block;
	margin: 5px auto;
}

#study_details form button {
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
			<div id="study_details" method=post action="study_create.jsp">
				<h3>스터디 정보</h3>
				<label for="sg_name">스터디 이름</label> <input type="text"
					name="sg_name" readonly value="<%=studyGroup.getSg_name()%>">
				<label for="sg_description">스터디 소개글</label>
				<textarea name="sg_description" cols="30" rows="10" readonly><%=studyGroup.getSg_description()%></textarea>
				
				<label for="sg_current_size">스터디 현재 가입수</label> <input type="number"
					name="sg_current_size"
					value="<%=memberCount%>" readonly>
					
				<label for="sg_max_size">스터디 최대 가입수</label> <input type="number"
					name="sg_max_size" placeholder="최대 인원수"
					value="<%=studyGroup.getSg_max_size()%>" readonly>
					
					
				<form method="get" action="study_member_list.jsp">
						<input type="hidden" name="study_group_id" value=<%=studyGroup.getStudy_group_id()%> >
						<button type=submit" onclick=>스터디 구성원 목록</button>
				</form>
					
				<%
					if (studyGroup.getOwner_nickname().equals(user.getUsr_nickname())) {
				%>

				<form method=get action="study_management.jsp" >
					<input type=hidden name=study_group_id value=<%=studyGroup.getStudy_group_id()%>>
					<button type=submit>관리하기</button>
				</form>
				
				<form method=post action="study_detail.jsp" >
					<input type=hidden name=action value=deleteStudyGroup>
					<input type=hidden name=study_group_id value=<%=studyGroup.getStudy_group_id()%>>
					<button type=submit>그룹 삭제</button>
				</form>

				<%
					} else {
				%>
				
				<form method=post action="study_detail.jsp" >
					<input type=hidden name=_method value=deleteThisUser>
					<input type=hidden name=study_group_id value=<%=studyGroup.getStudy_group_id()%>>
					<button type=submit>탈퇴하기</button>
				</form>
				
				<%
					}
				%>
				<button type="button" onclick="location.href='study_list.jsp'">뒤로가기</button>
			</div>
		</section>

	</div>
	<footer id="main_footer">
		<h3>Let's study</h3>
	</footer>
</body>
</html>