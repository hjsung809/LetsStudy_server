<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<% 
  study.User user = (study.User)session.getAttribute("user");
  if (user == null) {
    // session.setAttribute("user_id",5);
    out.println("<script>alert('로그인 정보가 유효하지 않습니다.')</script>");
    response.sendRedirect("signin.jsp");
  } else {
    response.sendRedirect("main.jsp");
   }
%>
<%-- 
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <link rel="stylesheet" type="text/css" href="init.css">

</head>
<body>
  <header id="main_header">
    <div id="title">
      <h1>Let's Study</h1>
      <h2>Main Page</h2>
    </div>
    <nav id="main_gnb">
      <ul>
        <li><a href="main.jsp">메인 화면</a></li>
        <li><a href="study_search.jsp">검색 화면</a></li>
      </ul>
    </nav>
    <nav id="main_lnb">
      <ul>
        <li><a href="#">로컬 기능 1</a></li>
        <li><a href="#">로컬 기능 2</a></li>
      </ul>
    </nav>
    <nav id="main_user">
      <a href="#">
        <img src="user.png">
        <div>${user.usr_email}</div>
      </a>
    </nav>
  </header>
  <div id="content">
    <section id="main_section">

    </section>
    <aside id="main_aside">aside</aside>
  </div>
  <footer id="main_footer">
    <h3>Let's study</h3>
  </footer>
</body>
</html> --%>