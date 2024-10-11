<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.smhrd.model.MemberPartyDAO" %>
<%@ page import="com.smhrd.model.MyMember" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보수정</title>

<link rel="stylesheet" href="Mypage/mypage.css">
</head>
<body>
<%
HttpSession userSession = request.getSession();
    String US_EMAIL = (String) userSession.getAttribute("EMAIL");
    
    // 로그인 정보가 없는 경우 오류페이지로 리다이렉트
    if (US_EMAIL == null) {
        response.sendRedirect("fail.jsp");
        return;
    }

    // MemberDAO를 사용하여 현재 회원정보를 가져옵니다.
    MemberPartyDAO dao = new MemberPartyDAO();
    MyMember member = dao.getMemberByEmail(US_EMAIL);

    // 닉네임을 DB에서 가져온 값으로 설정
    String US_NICK = member.getUS_NICK();

    // errorMessage 가져오기
    String errorMessage = (String) request.getAttribute("errorMessage");
%>
    
<h1>회원정보 수정</h1>

<div class="mypage-wrap">
    <div class="mypage-container">
        <h1>마이페이지</h1>
        
        <!-- 프로필 영역 -->
        <div class="profile-section">
            <div>
                <img src="0.png" alt="프로필 이미지" class="profile-img">
                <div class="profile-info">
                    <div class="email-section">
                        <label for="email">이메일:</label>
                        <input type="text" id=email disabled value="<%= US_EMAIL %>">
                    </div>
                     
                    <form action="UpdateController" method="post">
						<input type="hidden" name="US_EMAIL" value="<%=US_EMAIL %>">
						닉네임: <input type="text" name="US_NICK" id="nickname" value="<%=US_NICK %>"><br>
						<input type="submit" class="submit" value="변경하기">
					</form>
                        
                    <% if (errorMessage != null) { %>
						<div style="color: red;"><%= errorMessage %></div>
					<% } %>
                </div>
            </div>
        </div>    
        
 
</body>
</html>
