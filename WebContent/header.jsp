<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        <div>${user.usr_nickname}</div>
      </a>
    </nav>
</header>