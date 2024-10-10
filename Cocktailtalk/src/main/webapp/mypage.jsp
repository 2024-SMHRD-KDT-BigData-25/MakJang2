<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.smhrd.model.MemberDAO" %>
<%@ page import="com.smhrd.model.MyMember" %>

<%
    response.setContentType("text/html; charset=UTF-8");
    response.setCharacterEncoding("UTF-8");

    // 현재 세션을 가져옴
    HttpSession userSession = request.getSession();
    String US_EMAIL = (String) userSession.getAttribute("EMAIL");

    // 로그인 정보가 없는 경우 오류 페이지로 리다이렉트
    if (US_EMAIL == null) {
        response.sendRedirect("fail.jsp");
        return;
    }

    // MemberDAO를 사용하여 DB에서 사용자 정보를 가져옴
    MemberDAO dao = new MemberDAO();
    MyMember member = dao.getMemberByEmail(US_EMAIL); // DB에서 닉네임 조회

    String US_NICK = member != null ? member.getUS_NICK() : null;

    // 닉네임이 없으면 오류 페이지로 리다이렉트
    if (US_NICK == null) {
        response.sendRedirect("fail.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
</head>
<body>

<h1>마이페이지</h1>
이메일: <%= US_EMAIL %><br>
아이디: <%= member.getUS_NAME() %><br>
닉네임: <%= US_NICK %><br>
<a href="changeinfo.jsp"><button>회원정보수정</button></a>

</body>
</html>
