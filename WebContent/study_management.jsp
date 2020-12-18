<%@page import="study.Recruitment"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean scope="session" id="studyGroupManager"
	class="study.StudyManager" />
	
<jsp:useBean scope="session" id="recruitmentManager"
	class="study.RecruitmentManager" />
	
<%@ page import="java.util.ArrayList"%>

<%
study.User user = (study.User) session.getAttribute("user");
study.StudyGroup studyGroup = (study.StudyGroup)session.getAttribute("studyGroup");
int memberCount = studyGroupManager.countStudyGroupMember(studyGroup.getStudy_group_id());

study.Recruitment recruitment= (study.Recruitment) recruitmentManager.getRecruitment(studyGroup.getStudy_group_id());
int applicant_count = 0;

if (recruitment != null) {
	applicant_count = recruitmentManager.countApplicant(recruitment.getRecruitment_id());
}

if(request.getMethod().equals("POST")) {
	if (request.getParameter("action").equals("modify")) {
		boolean success = studyGroupManager.updateStudyGroup(
	    		request.getParameter("study_group_id"),
	    		request.getParameter("sg_name"),
	    		request.getParameter("sg_description"),
	    		request.getParameter("sg_max_size"));

	    if (success) {
	        out.println("<script>alert('스터디 정보를 수정하였습니다.')</script>");
	        ArrayList<study.StudyGroup> studyGroupList = studyGroupManager.getStudyGroupList(user.getUser_id());
	        session.setAttribute("studyGroupList", studyGroupList);
	        response.sendRedirect("study_detail.jsp?study_group_id=" + studyGroup.getStudy_group_id());
	    } else {
	      out.println("<script>alert('스터디 정보 수정에 실패하였습니다.')</script>");
	    }
	}else if (request.getParameter("action").equals("deleteRecruitment")) {
		if (recruitment != null) {
			boolean success = recruitmentManager.deleteRecruitment(recruitment.getRecruitment_id());		
			
			 if (success) {
			        out.println("<script>alert('스터디 모집을 취소하였습니다.')</script>");
			        recruitment = null;
			 } else {
			      out.println("<script>alert('스터디 모집 취소 실패하였습니다.')</script>");
			 }
		}

	}else {
		out.println("<script>alert('알수 없는 요청입니다.')</script>");
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
  		align-items: center;
  		justify-content: center;
	}
	#study_management {
		display: flex;
		flex-direction: row;
	}	
	
	#study_modify_form, #study_recruitment_info {
		width: 600px;
		display: flex;
		flex-direction: column;
  		box-shadow: 4px 4px 10px 4px rgba(0,0,0,0.1);
  		padding: 30px;
	}

	#study_modify_form * + *, #study_recruitment_info * + * {
		margin-top: 10px;
	}
	
	#study_modify_form + #study_recruitment_info {
		margin-left: 20px;
	}
	
	#buttons {
		display: flex;
		flex-direction: row;
		align-items: center;
  		justify-content: center;
	}
	
	#buttons button{
		margin-left: 10px;
		margin-right: 10px;
	}
	
	button {
		margin:0 0 0 auto;
		align-self: flex-end;
		width: 200px;
	}


</style>
</head>
<body>
	<%@ include file="header.jsp"%>
	<div id="content">
		<section id="main_section">
			<div id="study_management">
			<div id="study_modify_form">
				<form method="post"
					action="<%="study_management.jsp?action=modify&study_group_id=" + studyGroup.getStudy_group_id()%>">
					<h3>스터디 정보 수정</h3>
					<div class="input_wrapper">
					<label for="sg_name">스터디 이름</label> <input type="text"
						name="sg_name" value="<%=studyGroup.getSg_name()%>"> 
						</div>
						<div class="input_wrapper">
						<label
						for="sg_description">스터디 소개글</label>
					<textarea name="sg_description" cols="30" rows="10"><%=studyGroup.getSg_description()%></textarea>
					</div>
					<div class="input_wrapper">
					<label for="sg_max_size">스터디 최대 가입수</label> <input type="number"
						name="sg_max_size" placeholder="최대 인원수"
						value="<%=studyGroup.getSg_max_size()%>">
					</div>
					<button type="submit">수정 하기</button>
				</form>
				<h3>현재 가입 인원</h3>
				<input
						name="sg_current_size" placeholder="현재 인원수"
						value="<%=memberCount%>" readonly>
				<form method="get" action="study_member_list.jsp">
						<input type="hidden" name="study_group_id" value=<%=studyGroup.getStudy_group_id()%> >
						<button type=submit" onclick=>스터디 구성원 목록</button>
				</form>
				
				<%
					if (recruitment == null) {
						System.out.println("studyGroup.getStudy_group_id(): " + studyGroup.getStudy_group_id());
				%>
					<%-- <button
					onclick=<%="location.href='study_recruitment.jsp?study_group_id=" + studyGroup.getStudy_group_id() + "'"%>>모집 하기</button> --%>
					<form method="get" action="study_recruitment.jsp">
						<h3>스터디 모집 광고</h3>
						<input type="hidden" name="study_group_id" value=<%=studyGroup.getStudy_group_id()%> >
						<button type=submit" onclick=>모집 하기</button>
					</form>
				<%}%>
			</div>
			
			<div id="study_recruitment_info">
				<h3>스터디 모집 정보</h3>
				<%
					if (recruitment == null) {
				%>
				<p>현재 스터디를 모집하고 있지 않습니다.</p>
				<%} else { %>
					<div class="input_wrapper">
					<label for="rc_title">모집 제목</label>
					<input type="text" name="rc_title" value=<%=recruitment.getRc_title()%> readonly>
					</div>
					<div class="input_wrapper">
					<label for="rc_description">모집 내용</label>
					<textarea name="rc_description" cols="30" rows="10" readonly><%=recruitment.getRc_description()%></textarea>
					</div>
					<div class="input_wrapper">
					<label for="rc_size"> 모집 수</label> <input type="number"
						name="rc_size" placeholder="모집 수" readonly
						value="<%=recruitment.getRc_size()%>">
					</div>
					<div class="input_wrapper">
					<label for="applicant_size"> 지원자 수</label> <input type="number"
						name="applicant_size" placeholder="모집 수" readonly
						value="<%=applicant_count%>">
					</div>
					<div id="buttons">
					<form class="recruitment_form" method="get"
						action="study_applicant_list.jsp">
						<input type="hidden" name="study_group_id" value=<%=studyGroup.getStudy_group_id()%> >
						<input type="hidden" name="recruitment_id" value=<%=recruitment.getRecruitment_id()%> >
						<button type=submit" onclick=>지원자 보기</button>
					</form>
					
					<form class="recruitment_form" method="post"
						action="<%="study_management.jsp?action=deleteRecruitment&study_group_id=" + studyGroup.getStudy_group_id()%>">
						<button type=submit" onclick=>모집 취소</button>
					</form>
					</div>
				<% } %>
			</div>
			</div>
		</section>

	</div>
	<%@ include file="footer.jsp"%>
</body>
</html>