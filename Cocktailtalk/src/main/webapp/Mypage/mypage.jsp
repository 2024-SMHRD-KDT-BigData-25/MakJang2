<%@page import="com.smhrd.model.CockDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.smhrd.model.MemberDAO" %>
<%@ page import="com.smhrd.model.MyMember" %>
<%@ page import="java.util.List" %>
<%@ page import="com.smhrd.model.Cocktail_Info" %>

<%
    response.setContentType("text/html; charset=UTF-8");
    response.setCharacterEncoding("UTF-8");

    HttpSession userSession = request.getSession();
    String US_EMAIL = (String) userSession.getAttribute("EMAIL");

    if (US_EMAIL == null) {
        response.sendRedirect("fail.jsp");
        return;
    }

    MemberDAO dao = new MemberDAO();
    MyMember member = dao.getMemberByEmail(US_EMAIL);
    String US_NICK = member != null ? member.getUS_NICK() : null;

    if (US_NICK == null) {
        response.sendRedirect("fail.jsp");
        return;
    }
    
    List<Cocktail_Info> bookmarkList = dao.selectBookmarkByEmail(US_EMAIL);
%>

<%
			CockDAO dao1 = new CockDAO();
			List<Cocktail_Info> Info = dao1.Cockinfo();
%>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../Mypage/mypage.css">
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <script>
        function confirmDelete() {
            if(confirm("회원탈퇴를 하시겠습니까?")) {
                window.location.href="../DeleteController?US_EMAIL=<%=US_EMAIL %>";
            }
        }
    </script>
</head>
<body>
    <jsp:include page="${contextPath }/header/header.jsp" />
    <div class="mypage-wrap">
        <div class="mypage-container">
            <h1>마이페이지</h1>
        
            <!-- 프로필 영역 -->
            <div class="profile-section">
                <div>
                    <img src="../images/0.png" alt="프로필 이미지" class="profile-img" style="width: 150px; height: auto;">
                    <div class="profile-info">
                        <div class="email-section">
                            <label for="email">이메일:</label>
                            <input type="text" id="email" disabled value="<%= US_EMAIL %>">
                        </div>
                        
                        <div class="nickname-section">
                            <label for="nickname">닉네임:</label>
                            <input type="text" id="nickname" value="<%= US_NICK %>">
                        </div>
                        
                        <a href="../member/changeinfo.jsp"><button>회원정보수정</button></a>
                    </div>
                </div>
            </div>
        
            <!-- 계정 탈퇴 버튼 -->
            <div class="account-deletion-section">
                <button id="deleteAccount" onclick="confirmDelete()">계정 탈퇴</button>
                <div class="deleteAccount-info">계정 탈퇴시 모든 정보는 삭제됩니다</div>
            </div>
        </div>
    
        <div class="jjim-container">
            <div>
                <div class="jjim-info">
                    <h1>내가 한 찜</h1>
                </div>
                
                <div class="jjim-list">
                    <div>
                        <div class="cocktail-list">
                            <%
                            if (bookmarkList != null && !bookmarkList.isEmpty()) {
                                for (Cocktail_Info cocktail : bookmarkList) {
                            %>
                            <div class="cocktail-item">
                                <form action="../BM_ToggleBookmarkController" method="post" style="position: absolute; top: 10px; right: 10px;">
                                    <input type="hidden" name="US_EMAIL" value="<%=US_EMAIL%>">
                                    <input type="hidden" name="COCKTAIL_NO" value="<%= cocktail.getCOCKTAIL_NO() %>">
                                    <span class="wishlist-button" onclick="this.closest('form').submit()">✔ 찜취소</span>
                                </form>
                                <br>
                                <br>
                                <h2><%= cocktail.getCOCKTAIL_NAME() %></h2>
                                <img src="<%= request.getContextPath() + "/CocokTail_Img/" + cocktail.getCOCKTAIL_IMG() %>" alt="<%= cocktail.getCOCKTAIL_NAME() %>" style="width: 200px; height: auto;"> 
                                <br>
                                <br>
                                <h3><%= cocktail.getCOCKTAILS_POINT() %></h3>
                                <br>
                            	<div class="ingredients"><%= cocktail.getCOCKTAIL_BASE() %></div>
                            	<p>-------------------------------------------------------</p>
                            	<div class="ingredients">레시피(RECIPE)</div>
                				<div class="ingredients"><%= cocktail.getCOCKTAIL_RECIPE() %></div>
                            </div>
                            <%
                                }
                            } else {
                            %>
                                <p>찜한 칵테일이 없습니다.</p>
                            <%
                            }
                            %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // DOM 요소 가져오기
        const nicknameInput = document.getElementById('nickname');
        const saveChangesButton = document.getElementById('saveChanges');

        // 초기 닉네임 값 저장
        let initialNickname = nicknameInput.value;

        // 닉네임이 변경될 때 이벤트 처리
        nicknameInput.addEventListener('input', function() {
            // 현재 닉네임이 초기 닉네임과 다르면 버튼 활성화
            if (nicknameInput.value !== initialNickname) {
                saveChangesButton.classList.remove('disabled');
                saveChangesButton.disabled = false;
            } else {
                saveChangesButton.classList.add('disabled');
                saveChangesButton.disabled = true;
            }
        });
    </script>

    <jsp:include page="${contextPath }/footer/footer.jsp" />
</body>
</html>
