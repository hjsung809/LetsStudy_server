<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean scope="session" id="studyGroupManager" class="study.StudyManager" />

<% 	
	  study.User user = (study.User)session.getAttribute("user");
	  
	  if(request.getMethod().equals("POST")) {
	    boolean success = studyGroupManager.createStudyGroup(
	    user.getUser_id(),
	      request.getParameter("sg_name"),
	      request.getParameter("sg_description"),
	      request.getParameter("sg_max_size")
	    );
	
	    if (success) {
	      out.println("<script>alert('스터디 생성에 성공했습니다.')</script>");
	      response.sendRedirect("study_list.jsp");
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
    #main_section {
		height: 100%;
		display: flex;
  		align-items: center;
  		justify-content: center;
	}
	
    #study_create_form {
      width: 800px;
      height: 400px;
      box-shadow: 4px 4px 10px 4px rgba(0,0,0,0.1);
      display: flex;
      flex-direction: column;
      padding: 30px 20px;
    }
    
    #study_create_form > * + * {
      margin-top: 20px;
    } 
    
    #buttons {
		display: flex;
		justify-content: center;
		flex-direction: row;
	}
	
	#buttons button {
		width: 200px;
	}
	
	#buttons button:nth-child(2) {
		margin-left: 50px;
	}

  </style>
</head>
<body>
   <%@ include file="header.jsp" %>
  <div id="content">

    <section id="main_section">
      <form id="study_create_form" method=post action="study_create.jsp">
        <h3>스터디 생성</h3>
        <input type="text" name="sg_name" placeholder="스터디 이름">
        <textarea name="sg_description" cols="30" rows="10" placeholder="스터디 소개글"></textarea>
       
        <input type="number" name="sg_max_size" placeholder="최대 인원수" min="1" max="20">
        <div id="buttons">
        <button type="submit">스터디 생성</button>
        <button type="button" onclick="location.href='study_list.jsp'">취 소</button>
        </div>
      </form>
    </section>

  </div>
  <%@ include file="footer.jsp" %>
</body>
</html>