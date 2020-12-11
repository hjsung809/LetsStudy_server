<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean scope="application" id="passport" class="study.Passport" />

<%
  if(request.getMethod().equals("POST")) {
    if(request.getParameter("password").equals(request.getParameter("password2"))) {
      boolean success = passport.signUp(
          request.getParameter("email"),
          request.getParameter("nickname"),
          request.getParameter("password"),
          request.getParameter("phone_number"), 
          request.getParameter("description")
        );

      if (success) {
        out.println("<script>alert('회원가입에 성공했습니다.')</script>");
        out.println("<script>alert('로그인 정보가 유효하지 않습니다.')</script>");
response.sendRedirect("signin.jsp");
      } else {
        out.println("<script>alert('회원가입에 실패했습니다.')</script>");
      }
    } else {
      out.println("<script>alert('비밀 번호를 확인해 주세요.')</script>");
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
  	#signup_content {
  		width: 100%;
  		height: calc(100% - 100px);
  		display: flex;
  		align-items: center;
  		justify-content: center;
  	}
  	
  	#signup_section {
  		width: 480px;
  		height: 600px;
  		display: flex;
  		align-items: center;
  		justify-content: center;
  		box-shadow: 4px 4px 10px 4px rgba(0,0,0,0.1);
  	}
  	
    #signup_form {
      width: 80%;
      height: 70%;
      display: flex;
  	  align-items: center;
  	  justify-content: space-between;
  	  flex-direction: column;
    }
    
    #signup_go_signin {
      width: 100%;
      display: flex;
  	  align-items: center;
  	  justify-content: center;
  	  flex-direction: row;
    }
    
    #signup_go_signin a {
      padding-left: 10px;
    }
  </style>
</head>
<body>
  <%@ include file="header.jsp" %>
  <div id="signup_content">
    <section id="signup_section">
      <form id="signup_form" method=post action="signup.jsp">
          <div id="input_wrapper">
           <label for="email">이메일</label>
           <input type="email" name="email">
          </div>
         <div id="input_wrapper">
            <label for="nickname">닉네임</label>
            <input type="text" name="nickname">
          </div>
          <div id="input_wrapper">
           <label for="password">비밀번호</label>
           <input type="password" name="password">
          </div>
          <div id="input_wrapper">
           <label for="password2">비밀번호 확인</label>
           <input type="password" name="password2">
          </div>
         <div id="input_wrapper">
           <label for="phone_number">휴대전화</label>
           <input type="tel" name="phone_number">
          </div>
          <div id="input_wrapper">
           <label for="description">자기 소개</label>
           <textarea name="description"></textarea>
          </div>
          <div id="signup_go_signin">
            이미 회원이신가요? <a href="signin.jsp">로그인</a>
          </div>
          <button type="submit">회원가입</button>
      </form>
    </section>
  </div>
  <%@ include file="footer.jsp" %>
</body>
</html>