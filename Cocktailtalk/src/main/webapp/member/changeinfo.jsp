<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.smhrd.model.MemberDAO" %>
<%@ page import="com.smhrd.model.MyMember" %>

<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="../Mypage/mypage.css">
	<meta charset="UTF-8">
	<title>회원정보수정</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
    MemberDAO dao = new MemberDAO();
    MyMember member = dao.getMemberByEmail(US_EMAIL);

    // 닉네임을 DB에서 가져온 값으로 설정
    String US_NICK = member.getUS_NICK();

    // errorMessage 가져오기
    String errorMessage = (String) request.getAttribute("errorMessage");
%>
    
<jsp:include page="${contextPath }/header/header.jsp" />

<div class="mypage-wrap">
    <div class="mypage-container">
        <h1>마이페이지</h1>
        
        <!-- 프로필 영역 -->
        <div class="profile-section">
            <div>
                <img src="../images/0.png" alt="프로필 이미지" class="profile-img" style="width: 150px; height: auto";>
                <div class="profile-info">
                    <div class="email-section">
                        <label for="email">이메일:</label>
                        <input type="text" id="email" disabled value="<%= US_EMAIL %>">
                    </div>
                    
                    <div>
                    <input type="hidden" id="US_EMAIL" value="<%=US_EMAIL %>">
                    닉네임: <input type="text" id="nickname" value="<%=US_NICK %>"><br>
                    <% if (errorMessage != null) { %>
                        <div style="color: red;"><%= errorMessage %></div>
                    <% } %>
                    </div>
                    <button id="saveChanges">변경하기</button>
                </div>
            </div>
        </div>    
        
    </div>
</div>

<script>
    $(document).ready(function() {
        $('#saveChanges').click(function() {
            const US_EMAIL = $('#US_EMAIL').val();
            const US_NICK = $('#nickname').val();

            // 이전 오류 메시지 삭제
            $('.error-message').remove();

            $.post('../UpdateController', { US_EMAIL: US_EMAIL, US_NICK: US_NICK }, function(data) {
                if (data.success) {
                    // 성공 시 세션에 저장된 닉네임 업데이트 후 마이페이지로 이동
                    window.location.href = '../Mypage/mypage.jsp'; 
                } else {
                    // 에러 메시지 표시
                    $('.profile-info').append('<div class="error-message" style="color: red;">' + data.errorMessage + '</div>');
                }
            }, 'json');
        });
    });
</script>

</body>
</html>
