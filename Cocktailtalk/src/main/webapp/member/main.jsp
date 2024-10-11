<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.smhrd.model.MemberDAO" %>
<%@ page import="com.smhrd.model.MyMember" %>

<%
    response.setContentType("text/html; charset=UTF-8");
    response.setCharacterEncoding("UTF-8");

    // 현재 세션을 가져옴
    HttpSession userSession = request.getSession();
    String email = (String) userSession.getAttribute("EMAIL"); // 이메일을 email 변수에 저장

    // 로그인 정보가 없는 경우 오류 페이지로 리다이렉트
    if (email == null) {
        response.sendRedirect("fail.jsp");
        return;
    }

    // MemberDAO를 사용하여 DB에서 사용자 정보를 가져옴
    MemberDAO dao = new MemberDAO();
    MyMember member = dao.getMemberByEmail(email); // DB에서 닉네임 조회

    String nick = null; // 닉네임을 저장할 변수
    if (member != null) {
        nick = member.getUS_NICK(); // DB에서 닉네임을 가져옴
    }

    // 닉네임이 없으면 오류 페이지로 리다이렉트
    if (nick == null) {
        response.sendRedirect("fail.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>메인페이지</title>
</head>
<body>

<h1>메인페이지</h1>
<h3>안녕하세요! <%= nick %>님!</h3> <!-- 수정된 변수 사용 -->
<a href="mypage.jsp"><button>마이페이지</button></a>
<a href="event.jsp"><button>이벤트</button></a>
</body>
</html>
