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
      margin-top: 40px;
      box-shadow: 4px 4px 10px 4px rgba(0,0,0,0.1);
      display: flex;
      flex-direction: column;
      padding: 20px;
    }
    
    #study_details > * + * {
      margin-top: 20px;
    } 
    
    #buttons {
		display: flex;
		justify-content: center;
		flex-direction: row;
	}
	
	#buttons button {
		width: 200px;
		margin: 0 10px;
	}

</style>
</head>
<body>
	<%@ include file="header.jsp"%>
	<div id="content">
		<section id="main_section">
			<div id="study_details" method=post action="study_create.jsp">
				<h2>스터디 정보</h2>
				<div class="input_wrapper">
				<label for="sg_name">스터디 이름</label> <input type="text"
					name="sg_name" readonly value="<%=studyGroup.getSg_name()%>">
				</div>
				<div class="input_wrapper">
				<label for="sg_description">스터디 소개글</label>
				<textarea name="sg_description" cols="30" rows="10" readonly><%=studyGroup.getSg_description()%></textarea>
				</div>
				<div class="input_wrapper">
				<label for="sg_current_size">스터디 현재 가입수</label> <input type="number"
					name="sg_current_size"
					value="<%=memberCount%>" readonly>
				</div>
				<div class="input_wrapper">
				<label for="sg_max_size">스터디 최대 가입수</label> <input type="number"
					name="sg_max_size" placeholder="최대 인원수"
					value="<%=studyGroup.getSg_max_size()%>" readonly>
				</div>
				<div id="buttons">
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
			</div>
		</section>
		<%@ include file="footer.jsp"%>
	</div>
</body>
</html>