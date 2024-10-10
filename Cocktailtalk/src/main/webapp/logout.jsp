<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    HttpSession userSession = request.getSession(false);

    if (userSession != null) {
        userSession.invalidate(); // 세션 무효화
    }
%>

<!DOCTYPE html>
<html lang="kr">
<head>
<meta charset="UTF-8">
<title>로그아웃</title>
</head>
<body>
<script>
       // 로그아웃 완료 후 로그인 페이지로 리다이렉트
       window.location.href = "login.jsp";
</script>
</body>
</html>
