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
</head>
<body>
<fieldset>
	<table align="center">
		<tr>
    		<td><h1 align="center">로그인 성공!</h1></td>
    	</tr>
    <!-- 아이디: <%=US_NAME %> -->
    <!-- 닉네임: <%=US_NICK %> -->
    	<tr>
    		<td><h2 align="center">칵테일톡에 오신걸 환영합니다!</h2></td>
    	</tr>
    	<tr>
    		<td><p align="center">접속한 계정의 이메일: <%=US_EMAIL %></p></td>
    	</tr>
    	<tr>
    		<td>
			    <form action="JoinController">
			    	<input type="hidden" name="US_EMAIL" value="<%=US_EMAIL %>">
			    	<input type="hidden" name="US_NAME" value="<%=US_NAME %>">
			    	<input type="hidden" name="US_NICK" value="<%=US_NICK %>">
			        <input type="submit" value="메인페이지로 이동">
			    </form>
    		</td>
    		<td>
    			<a href="logout.jsp"><button>로그아웃</button></a>
    		</td>
    	</tr>
    </table>
</fieldset>
</body>
</html>
