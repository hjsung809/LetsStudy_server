<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean scope="session" id="studyGroupManager" class="study.StudyManager" />
<%@ page import="java.util.ArrayList" %>

<% 
  study.User user = (study.User)session.getAttribute("user");
  if (user == null) {
    out.println("<script>alert('로그인 정보가 유효하지 않습니다.')</script>");
    response.sendRedirect("signin.jsp");
  }

  ArrayList<study.StudyGroup> studyGroupList = (ArrayList<study.StudyGroup>)session.getAttribute("studyGroupList");
  if(studyGroupList == null) {
    out.println("<script>alert('잘못된 접근입니다.')</script>");
    response.sendRedirect("my_study.jsp");
  }
  String study_group_id_string = request.getParameter("study_group_id");
  if (study_group_id_string == null) {
    out.println("<script>alert('스터디 그룹 아이디가 필요합니다')</script>");
    response.sendRedirect("my_study.jsp");
  }

  int study_group_id = Integer.parseInt(study_group_id_string);
  study.StudyGroup studyGroup = null;
  for(study.StudyGroup tmp : studyGroupList) {
    if(tmp.getStudy_group_id() == study_group_id) {
      studyGroup = tmp;
    }
  }

  if(studyGroup == null) {
    out.println("<script>alert('접근할 수 없는 스터디 입니다.')</script>");
    response.sendRedirect("my_study.jsp");
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

    #study_details > input{
      width: 80%;
      display: block;
      margin: 5px auto;
    }

    #study_details > textarea{
      width: 80%;
      display: block;
      margin: 5px auto;
    }

    #study_details > button{
      width: 80%;
      display: block;
      margin: 5px auto;
    }


    #study_search_radio {
      width: 80%;
      margin: 5px auto;
    }
  </style>
</head>
<body>
   <%@ include file="header.jsp" %>
  <div id="content">
    <section id="main_section">
      <div id="study_details" method=post action="create_study.jsp">
        <h3>스터디 정보</h3>
        <label for="sg_name">스터디 이름</label>
        <input type="text" name="sg_name" readonly value="<%= studyGroup.getSg_name() %>">
        <label for="sg_description">스터디 소개글</label>
        <textarea name="sg_description" cols="30" rows="10" readonly><%= studyGroup.getSg_description() %></textarea>
        <label for="sg_max_size">스터디 최대 가입수</label>
        <input type="number" name="sg_max_size" placeholder="최대 인원수" value="<%= studyGroup.getSg_max_size()%>" readonly>
        <% if(studyGroup.getOwner_nickname().equals(user.getUsr_nickname())) { %>
          <button><a href="#">관리 하기</a></button>
        <% } else { %>
          <button><a href="#">탈퇴 하기</a></button>
        <% } %>
      </div>
    </section>

  </div>
  <footer id="main_footer">
    <h3>Let's study</h3>
  </footer>
</body>
</html>