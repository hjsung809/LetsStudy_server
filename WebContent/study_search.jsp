<%@page import="study.Recruitment"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean scope="session" id="studyGroupManager"
	class="study.StudyManager" />

<jsp:useBean scope="session" id="recruitmentManager"
	class="study.RecruitmentManager" />

<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>

<% 
	study.User user = (study.User) session.getAttribute("user");
	List<study.Recruitment> recruitments = null;
	String searchString = request.getParameter("searchString");
	String searchType = request.getParameter("searchType");
	String pageIndexString = request.getParameter("pageIndex");
	int pageIndex = 0;
	
	boolean isValid = (searchString != null) && (searchType != null);

	if(request.getMethod().equals("POST")) {
		if (isValid) {
			if(pageIndexString != null) {
				pageIndex = Integer.parseInt(pageIndexString);
			}
			
			if(searchType.equals("sg_name")) {
				recruitments = (List<study.Recruitment>)recruitmentManager.searchRecruitment(study.RecruitmentManager.QUERY_BY_SG_NAME, searchString);
			} else {
				recruitments = (List<study.Recruitment>)recruitmentManager.searchRecruitment(study.RecruitmentManager.QUERY_BY_RC_TITLE, searchString);
			}
			
			pageIndex = Math.max(pageIndex, 0);
			pageIndex = Math.min((int)((recruitments.size() - 1)/10), pageIndex);

			int startPoint = pageIndex * 10;
			int endPoint = Math.min((pageIndex + 1) * 10 - 1, recruitments.size());
			// System.out.println(recruitments.size() + ",");
			recruitments = recruitments.subList(startPoint, endPoint);
			// System.out.println(recruitments.size());
		} else {
			out.write("<script>alert('검색어와 검색 유형을 입력해주세요')</script>");
		}
		
	}
	if (recruitments == null) {
		recruitments = (List<study.Recruitment>)recruitmentManager.getRecentRecruitment(user.getUser_id());
	}
	
	session.setAttribute("recruitments", recruitments);
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <link rel="stylesheet" type="text/css" href="init.css">
  
  <style>
  	#study_search_form h2{
  	  margin: 10px 0;
  	}
  	
  	#study_search_word_input {
  	  display: flex;
  	  align-items: center;
  	  justify-content: center;
  	  margin:10px 0;
  	}
  	
    #study_search_word_input input{
    	display: flex;
    	flex: 1;
    }
    #study_search_word_input button{
      width: 100px;
      margin-left: 10px;
    }


    #study_list {
      width: calc(100%-40px);
      height: 460px;
      overflow: auto;
  	  box-shadow: 4px 4px 10px 4px rgba(0,0,0,0.1);
  	  margin-top: 10px;
  	  padding: 20px;
    }

    #study_list table {
      width: 100%;
      text-align: center;
      border-collapse: collapse;
    }
    
    #study_list tr {
      height: 50px;
    }
   
    #study_list tr:nth-child(even) {
      background-color: rgba(0,0,0,0.05);
    }

  </style>
</head>
<body>
  <%@ include file="header.jsp" %>
  <div id="content">
    <section id="main_section">
      <form id="study_search_form" method=post>
      	<h2>스터디 검색</h2>
        <div id="study_search_word_input">
          <input type="text" name="searchString">
          <button type="submit">검색</button>
        </div>
        <div id="study_search_radio">
          <input id="study_type_choice1" type="radio" name="searchType" value="sg_name">
          <label for="study_type_choice1">스터디 이름</label>
          <input id="study_type_choice2" type="radio" name="searchType" value="rc_title">
          <label for="study_type_choice2">모집 내용</label>
         <br>
        </div>
      </form>
      <div id="study_list">
		<table>
			<tr>
				<th>번호</th>
				<th>스터디 이름</th>
				<th>모집 제목</th>
				<th>모집 인원</th>
				<th>지원자 수</th>
				<th>지원하기</th>
				</tr>
				<%
					if (recruitments != null) {
					for (int i = 0; i < recruitments.size(); i++) {
						study.Recruitment recruitment = recruitments.get(i);
						int applicant_count = recruitmentManager.countApplicant(recruitment.getRecruitment_id());
				%>
				<tr>
					<td><%=i + pageIndex * 10 + 1%></td>
					<td><%=recruitment.getSg_name()%></td>
					<td><%=recruitment.getRc_title()%></td>
					<td><%=recruitment.getRc_size() %></td>
					<td><%=applicant_count%></td>					
					<td><a
						href="study_search_detail.jsp?recruitment_id=<%=recruitment.getRecruitment_id()%>">지원</a></td>
				</tr>
				<%
					}
				}
				%>
		</table>
      </div>
    </section>
  </div>
  <%@ include file="footer.jsp" %>
</body>
</html>