<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.io.UnsupportedEncodingException" %>

<%
    response.setContentType("text/html; charset=UTF-8");
    response.setCharacterEncoding("UTF-8");

    String EMAIL = request.getParameter("EMAIL");
    String NAME = request.getParameter("NAME");
    String NICK = request.getParameter("NICK");
    String ACCESS_TOKEN = request.getParameter("ACCESS_TOKEN"); // access_token 추가
    
 	// NICK 인코딩 처리
    try {
        NICK = new String(NICK.getBytes("ISO-8859-1"), "UTF-8");
    } catch (UnsupportedEncodingException e) {
        e.printStackTrace();
    }
    
    // 사용자 정보를 세션에 저장
    HttpSession userSession = request.getSession();
    userSession.setAttribute("EMAIL", EMAIL);
    userSession.setAttribute("NAME", NAME);
    userSession.setAttribute("NICK", NICK);
    userSession.setAttribute("ACCESS_TOKEN", ACCESS_TOKEN); // access_token 세션에 저장

    // 세션에서 사용자 정보 가져오기
    String US_EMAIL = (String)userSession.getAttribute("EMAIL");
    String US_NAME = (String)userSession.getAttribute("NAME");
    String US_NICK = (String)userSession.getAttribute("NICK");

    // 로그인 정보가 없는 경우 오류페이지로 리다이렉트
    if (US_EMAIL == null || US_NAME == null || US_NICK == null) {
        response.sendRedirect("fail.jsp");
        return;
    }
	
%>

<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <title>로그인확인</title>
    <style>
		.logincheck-wrap{
			display:flex;
			justify-content: center;
			align-items: center;
    		margin-top: 120px;
		}
		
		.logincheck-success{
			flex: 1;
			margin-left: 100px;
		}
		
		.logincheck-image{
			flex: 1;
		}
		
		.submit {
		    padding: 10px 20px;
		    background-color: lightgray;
		    color: black;
		    border: none;
		    border-radius: 4px;
		    cursor: pointer;
		}
		
		.form{
			align: center;
		}
		
		.success{
			font-size:80px;
		}
		
		.welcome{
			color: orange;
			margin: 25px;
			font-size:30px;
		}
		
		.email{
			border: 1px solid black;
		    border-radius: 8px;
		    max-width: 300px;
		}
		
		.main{
			margin: 25px;
		}
		
    </style>
</head>
<body>
<div class="logincheck-wrap">
	<div class="logincheck-success">
		<div align="center">
			<div class="success">
	    		<div> Login Success!</div>
	    	</div>
	    <!-- 아이디: <%=US_NAME %> -->
	    <!-- 닉네임: <%=US_NICK %> -->
	    	<div class="welcome">
	    		<div>칵테일톡에 오신걸 환영합니다!</div>
	    	</div>
	    	<div class="email">
	    		<div>접속한 계정의 이메일: <%=US_EMAIL %></div>
	    	</div>
	    	<div class="main">
	    		<div>
				    <form action="JoinController" class="form">
				    	<input type="hidden" name="US_EMAIL" value="<%=US_EMAIL %>">
				    	<input type="hidden" name="US_NAME" value="<%=US_NAME %>">
				    	<input type="hidden" name="US_NICK" value="<%=US_NICK %>">
				        <input type="submit" class="submit" value="메인페이지로 이동">
				    </form>
	    		</div>
	    	</div>
	    </div>
	</div>
<div class="logincheck-image">
	<img src="images/test.png" class="image">
</div>
</div>


</body>
</html>
