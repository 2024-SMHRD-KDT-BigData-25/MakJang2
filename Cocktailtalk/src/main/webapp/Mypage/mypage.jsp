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
    // 찜 목록에 칵테일 번호가 있는지 확인
    int cocktailNo = 2; // 예시로 사용할 칵테일 번호
    boolean isBookmarked = bookmarkList.stream()
        .anyMatch(cocktail -> cocktail.getCOCKTAIL_NO() == cocktailNo);
%>

<script>
	function confirmDelete() {
		if(confirm("회원탈퇴를 하시겠습니까?")) {
			window.location.href="DeleteController?US_EMAIL=<%=US_EMAIL %>";
		}
	}
</script>

<link rel="stylesheet" href="../Mypage/mypage.css">

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
</head>
<body>
	<jsp:include page="${contextPath }/header/header.jsp" />
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
                        <div class="nickname-section">
                            <label for="nickname">닉네임:</label>
                            <input type="text" id="nickname" value="<%= US_NICK %>">
                        </div>
                        <a href="changeinfo.jsp" ><button>회원정보수정</button></a>
                    </div>
                </div>
            </div>
        
            <!-- 계정 탈퇴 버튼 -->
            <div class="account-deletion-section">
                <button id="deleteAccount" onclick="confirmDelete()">계정 탈퇴</button>
                <div class="deleteAccount-info"> 계정 탈퇴시 모든 정보는 삭제됩니다</div>
            </div>
        </div>
    
        <div class="jjim-container">
            <div>
                <div class="jjim-info">
                    <div>
                        <h1>내가 한 찜</h1>
                    </div>
                </div>
                <div class="jjim-list">
                    <div>
                        <div class="cocktail-list">
                            <div class="cocktail-item">
                                    <button class="wishlist-button">
                                        ♡ 찜
                                    </button>
                                    
                                    <%
        							if (bookmarkList != null && !bookmarkList.isEmpty()) {
            							for (Cocktail_Info cocktail : bookmarkList) {
                						%>
                					<div>
                    					<h3><%= cocktail.getCOCKTAIL_NAME() %></h3>
                    						<img src="<%= request.getContextPath() + "/CocokTail_Img/" + cocktail.getCOCKTAIL_IMG() %>" alt="<%= cocktail.getCOCKTAIL_NAME() %>" />
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
                                    
                                    <!--
                                    <h2>마가리타</h2>
                                    <div class="clickable-div" data-title="상품 1" data-description="상품 1의 레시피입니다." data-history="상품 1의 역사입니다">
                                    <img src="/hompage/image/icon1.svg">
                                    <p>라임 주스와 테킬라가 어우러진 상큼한 칵테일</p>
                                    <div class="ingredients">테킬라, 라임 주스, 삼각 설탕</div>
                                    <div class="tags">
                                        <span class="tag">상큼</span>
                                        <span class="tag">짭짤</span>
                                    </div>
                                	</div>
                                	-->
                            </div>
                
                            <div class="cocktail-item">
                                    <button class="wishlist-button">
                                        ♡ 찜
                                    </button>
                                    <h2>모히토</h2>
                                    <div class="clickable-div" data-title="상품 2" data-description="상품 2의 상세 설명입니다." data-history="상품 2의 역사입니다">
                                    <img src="/hompage/image/icon2.svg">
                                    <p>라임과 민트 잎이 들어간 상쾌한 칵테일</p>
                                    <div class="ingredients">럼, 라임, 민트, 설탕, 탄산수</div>
                                    <div class="tags">
                                        <span class="tag">상쾌</span>
                                        <span class="tag">달콤</span>
                                    </div>
                                </div>
                            </div>
                
                            <div class="cocktail-item">
                                    <button class="wishlist-button">
                                        ♡ 찜
                                    </button>
                                    <h2>네그로니</h2>
                                    <div class="clickable-div" data-title="상품 3" data-description="상품 3의 상세 설명입니다." data-history="상품 3의 역사입니다">
                                    <img src="/hompage/image/icon0.svg">
                                    <p>진, 캄파리, 베르무트가 들어간 클래식 칵테일</p>
                                    <div class="ingredients">진, 캄파리, 스위트 베르무트</div>
                                    <div class="tags">
                                        <span class="tag">쌉싸름</span>
                                        <span class="tag">강렬</span>
                                    </div>
                                </div>
                            </div>
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

        // 모든 찜하기 버튼에 대해 이벤트 리스너 추가
        const wishlistButtons = document.querySelectorAll('.wishlist-button');

        wishlistButtons.forEach(button => {
            button.addEventListener('click', function() {
                this.classList.toggle('active');
                this.textContent = this.classList.contains("active") ? "✔ 취소됨" : "♡ 찜"; // 텍스트 변경
            });
        });
    </script>

<!-- 찜하기/찜삭제 기능 -->
    <form action="../BM_ToggleBookmarkController" method="post">
        <input type="hidden" name="US_EMAIL" value="<%=US_EMAIL%>">
        <input type="hidden" name="COCKTAIL_NO" value= 2 >
        <button type="submit"><%= isBookmarked ? "찜취소" : "찜하기" %></button>
    </form>
    
<jsp:include page="${contextPath }/footer/footer.jsp" />

</body>
</html>
