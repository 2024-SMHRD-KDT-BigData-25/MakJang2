<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // 세션 무효화
    HttpSession userSession = request.getSession(false);
    if (session != null) {
        session.invalidate();
    }
    
    // login.jsp로 리다이렉트
    response.sendRedirect("../member/login.jsp");
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
</body>
</html>