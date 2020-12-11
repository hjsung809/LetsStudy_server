<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	study.User userTmp = (study.User)session.getAttribute("user");
%>


<header>
	<a href="study_main.jsp" id="main_icon"><img src="./icons/main-icon.png" alt="main-icon" /></a>
  	<a href="study_search.jsp" id="search_icon"><img src="./icons/search-icon.png" alt="search-icon"/></a>
  	<a href="study_list.jsp" id="list_icon"><img src="./icons/user-icon.png" alt="user-icon"/></a> 
  	<% if (userTmp != null) { %>
  		<%= userTmp.getUsr_nickname() %>
  	<% } %>
</header>