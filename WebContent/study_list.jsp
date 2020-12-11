<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean scope="session" id="studyGroupManager" class="study.StudyManager" />
<%@ page import="java.util.ArrayList" %>

<% 
  study.User user = (study.User)session.getAttribute("user");

  ArrayList<study.StudyGroup> studyGroupList = studyGroupManager.getStudyGroupList(user.getUser_id());
  session.setAttribute("studyGroupList", studyGroupList);
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <link rel="stylesheet" type="text/css" href="init.css">

  <style>
    #my_study_info {
      border: 1px solid black;
      padding: 10px;
      margin: 10px;
    }

    #my_study_list {
      border: 1px solid black;
      width: 100%;
      height: 500px;
      background-color: darksalmon;
    }

    #my_study_list > table {
      width: 100%;
      padding: 5px;
      border: 1px solid black;
      text-align: center;
    }

    #my_study_list td {
      border: 1px solid black;
    }
  </style>
</head>
<body>
  <%@ include file="header.jsp" %>
  <div id="content">
    <section id="main_section">
      <div id="my_study_info">
        <h3>가입된 스터디</h3>
        <div id="my_study_list">
          <table>
            <tr><th>스터디 이름</th><th>스터디 관리자</th><th>현재 멤버 수</th><th>최대 멤버 수</th><th>생성일</th><th>자세히</th></tr>
            <%
              for(study.StudyGroup studyGroup : studyGroupList) {
            	  int memberCount = studyGroupManager.countStudyGroupMember(studyGroup.getStudy_group_id());
            %>
              <tr>
                <td><%=studyGroup.getSg_name()%></td>
                <td><%=studyGroup.getOwner_nickname()%></td>
                <td><%=memberCount%></td>
                <td><%=studyGroup.getSg_max_size()%></td>
                <td><%=studyGroup.getCreated_at()%></td>
                <%-- <td><%=studyGroup.getSg_meeting_count()%></td> --%>
                <td><a href="study_detail.jsp?study_group_id=<%=studyGroup.getStudy_group_id()%>">이동</a></td>
              </tr>
            <%
              }
            %>
          </table>
        </div>
        찾으시는 스터디가 없으신가요? <a href="study_create.jsp"> 스터디 생성하기</a>
      </div>
    </section>

  </div>
  <footer id="main_footer">
    <h3>Let's study</h3>
  </footer>
</body>
</html>