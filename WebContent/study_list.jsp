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
      padding: 20px;
    }

    #my_study_list {
      height: 480px;
   	  overflow: auto;
   	  box-shadow: 4px 4px 10px 4px rgba(0,0,0,0.1);
   	  padding: 20px;
   	  margin: 20px 0;
    }
    
    #my_study_list table {
      width: 100%;
      text-align: center;
      border-collapse: collapse;
    }
    
    #my_study_list tr {
      height: 50px;
    }
   
    #my_study_list tr:nth-child(even) {
      background-color: rgba(0,0,0,0.05);
    }
  </style>
</head>
<body>
  <%@ include file="header.jsp" %>
  <div id="content">
    <section id="main_section">
      <div id="my_study_info">
        <h2>가입된 스터디</h2>
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
  <%@ include file="footer.jsp" %>
</body>
</html>