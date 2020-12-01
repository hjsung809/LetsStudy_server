<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean scope="session" id="studyGroupManager" class="study.StudyManager" />

<% 
  study.User user = (study.User)session.getAttribute("user");
  if (user == null) {
    out.println("<script>alert('로그인 정보가 유효하지 않습니다.')</script>");
    response.sendRedirect("signin.jsp");
  }
  
  if(request.getMethod().equals("POST")) {
    boolean success = studyGroupManager.createStudyGroup(
    user.getUser_id(),
      request.getParameter("sg_name"),
      request.getParameter("sg_description"),
      request.getParameter("sg_max_size")
    );

    if (success) {
      out.println("<script>alert('스터디 생성에 성공했습니다.')</script>");
      response.sendRedirect("my_study.jsp");
    } else {
      out.println("<script>alert('스터디 생성에 실패했습니다.')</script>");
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
    #study_create_form {
      border: 1px solid black;
      padding: 10px;
      margin: 10px;
    }

    #study_create_form > input{
      width: 80%;
      display: block;
      margin: 5px auto;
    }

    #study_create_form > textarea{
      width: 80%;
      display: block;
      margin: 5px auto;
    }

    #study_create_form > button{
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
      <form id="study_create_form" method=post action="create_study.jsp">
        <h3>스터디 생성</h3>
        <input type="text" name="sg_name" placeholder="스터디 이름">
        <textarea name="sg_description" cols="30" rows="10" placeholder="스터디 소개글"></textarea>
        <%-- <div id="study_search_radio">
          스터디 종류:
          <input id="study_type_choice1" type="radio" name="study_type" value="job">
          <label for="study_type_choice1">진로</label>
          <input id="study_type_choice2" type="radio" name="study_type" value="hobby">
          <label for="study_type_choice2">취미</label>
        </div> --%>
        <input type="number" name="sg_max_size" placeholder="최대 인원수" min="1" max="20">
        <button type="submit">스터디 생성</button>
      </form>
    </section>

  </div>
  <footer id="main_footer">
    <h3>Let's study</h3>
  </footer>
</body>
</html>