<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<% 
  study.User user = (study.User)session.getAttribute("user");
  if (user == null) {
    out.println("<script>alert('로그인 정보가 유효하지 않습니다.')</script>");
    response.sendRedirect("signin.jsp");
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
    #study_search_div {
      float: left;
    }

    #study_search_div > a{
      display: block;
      width: 460px;
      margin: 0 auto;
      text-align: center;
      height: 460px;
      line-height: 480px;
      border: 1px solid black;
      background-color: white;
    }

    #study_search_div > a:hover{
      background-color: black;
      color: white;
    }

    #my_study_div {
      float: right;
    }

    #my_study_div > a{
      display: block;
      width: 460px;
      margin: 0 auto;
      text-align: center;
      height: 460px;
      line-height: 480px;
      border: 1px solid black;
      background-color: white;
    }

    #my_study_div > a:hover{
      background-color: black;
      color: white;
    }
  </style>

</head>
<body>
  <%@ include file="header.jsp" %>
  <div id="content">
    <section id="main_section">
      <div id="study_search_div">
        <a href="study_search.jsp">
        스터디 검색
        </a>
      </div>
      <div id="my_study_div">
        <a href="my_study.jsp">
        스터디 관리
        </a>
      </div>
    </section>

  </div>
  <footer id="main_footer">
    <h3>Let's study</h3>
  </footer>
</body>
</html>