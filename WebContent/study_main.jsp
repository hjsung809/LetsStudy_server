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
  	#main_content {
  	  width: 100%;
  	  height: calc(100% - 100px);
  	  display: flex;
  	  align-items: center;
  	  justify-content: center;
  	}
  	
  	#main_section {
  	  width: 600px;
  	  height: 250px;
  	  display: flex;
  	  align-items: center;
  	  justify-content: space-between;
  	  flex-direction: column;
  	}
  	
  	#main_title {
   	  font-size: 60px;
   	  font-weight: bold;
  	}
  	
  	#main_des {
  	  width: 450px;
  	  font-size: 20px;
  	  line-height: 30px;
  	  word-break: keep-all;
  	  text-align: center;
  	}
  	
  	#main_button_wrapper {
  	  width: 450px;
  	  display: flex;
  	  align-items: center;
  	  justify-content: space-between;
  	  flex-direction: row;
  	}
  	
  	#main_button_wrapper a {
  	  height: 50px;
      width: 40%;
  	}
  	
  	#main_button_wrapper a button {
  	  width: 100%;
  	  height: 100%;
  	  color: white;
  	  font-size: 20px;
  	}

  </style>
</head>
<body>
  <%@ include file="header.jsp" %>
  <div id="main_content">
  	<section id="main_section">
    <p id="main_title">LET'S STUDY!</p>
    <p id="main_des">자유롭게 스터디를 만들고 참여할 수 있는 공간이에요. 다양한 스터디를 만나고 참여해보세요!</p>
    <div id="main_button_wrapper">
      <a href="study_search.jsp">
	    <button>스터디 검색 </button>
      </a>
      <a href="study_list.jsp">
       <button>스터디 관리</button>
      </a>
    </div>
    </section>
  </div>
  <%@ include file="footer.jsp" %>
</body>
</html>