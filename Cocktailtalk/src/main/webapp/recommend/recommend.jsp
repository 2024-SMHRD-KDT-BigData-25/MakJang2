<%@page import="com.smhrd.model.Cocktail_Info"%>
<%@page import="java.util.List"%>
<%@page import="com.smhrd.model.CockDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.smhrd.model.MemberDAO" %>
<%@ page import="com.smhrd.model.MyMember" %>
<%
    response.setContentType("text/html; charset=UTF-8");
    response.setCharacterEncoding("UTF-8");

    HttpSession userSession = request.getSession();
    String US_EMAIL = (String) userSession.getAttribute("EMAIL");

    if (US_EMAIL == null) {
        response.sendRedirect("fail.jsp");
        return;
    }

    MemberDAO dao1 = new MemberDAO();
    MyMember member = dao1.getMemberByEmail(US_EMAIL);
    String US_NICK = member != null ? member.getUS_NICK() : null;

    if (US_NICK == null) {
        response.sendRedirect("fail.jsp");
        return;
    }
    
    List<Cocktail_Info> bookmarkList = dao1.selectBookmarkByEmail(US_EMAIL);
    // 찜 목록에 칵테일 번호가 있는지 확인
    int cocktailNo = 2; // 예시로 사용할 칵테일 번호
    boolean isBookmarked = bookmarkList.stream()
        .anyMatch(cocktail -> cocktail.getCOCKTAIL_NO() == cocktailNo);
%>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>칵테일 검색</title>
    <link rel="stylesheet" href="styles.css" type="text/css">
</head>
<body>
	<jsp:include page="${contextPath }/header/header.jsp" />
    
    <div class="container">
        <div class="top">
            <h1>칵테일 검색</h1>

            <div class="search-bar">
                <input type="text" id="searchInput" placeholder="칵테일 이름을 입력하세요">
                <button class="name-button" type="button">이름 검색</button>
            </div>

            <div class="ingredient-selection">
                <h3>재료로 필터링:</h3>
                <button class="ingredient-button" data-ingredient="럼">럼</button>
                <button class="ingredient-button" data-ingredient="위스키">위스키</button>
                <button class="ingredient-button" data-ingredient="진">진</button>
                <button class="ingredient-button" data-ingredient="보드카">보드카</button>
                <button class="ingredient-button" data-ingredient="데킬라">테킬라</button>
                <button class="ingredient-button" data-ingredient="포도주">포도주</button>
                <button class="ingredient-button" data-ingredient="리큐르">리큐르</button>
            </div>
    

            <div class="tag-selection">
                <h3>맛 태그로 필터링:</h3>
                <button class="tag-button" data-tag="상큼">상큼</button>
                <button class="tag-button" data-tag="짭짤">짭짤</button>
                <button class="tag-button" data-tag="상쾌">상쾌</button>
                <button class="tag-button" data-tag="달콤">달콤</button>
                <button class="tag-button" data-tag="쌉싸름">쌉싸름</button>
                <button class="tag-button" data-tag="강렬">강렬</button>
            </div>
        </div>

		<%
			CockDAO dao = new CockDAO();
			List<Cocktail_Info> Info = dao.Cockinfo();
		%>
		
 	<div class="cocktail-list">
		<%for(Cocktail_Info c:Info){ %>
            <div class="cocktail-item">
        			<input type="hidden" name="COCKTAIL_NO" value="<%= c.getCOCKTAIL_NO() %>">
        			<button class="wishlist-button" data-cocktail-no="<%= c.getCOCKTAIL_NO() %>" data-us-email="<%= US_EMAIL %>">
    					<%= bookmarkList.stream().anyMatch(bookmark -> bookmark.getCOCKTAIL_NO() == c.getCOCKTAIL_NO()) ? "✔ 찜됨" : "♡ 찜" %>
					</button>
                    <h2><%=c.getCOCKTAIL_NAME() %></h2>
                    <div class="clickable-div" data-title="<%=c.getCOCKTAIL_NAME() %>"  data-recipe="<%=c.getCOCKTAIL_RECIPE() %>" data-history="<%=c.getCOCKTAIL_HIS() %>" data-image="../CocokTail_Img/<%=c.getCOCKTAIL_IMG() %>">>
                    <img src="../CocokTail_Img/<%=c.getCOCKTAIL_IMG() %>">
                    <p><%=c.getCOCKTAILS_POINT() %></p>
                    <div class="ingredients"><%=c.getCOCKTAIL_BASE() %></div>
                    <div class="tags">
                        <span class="tag"><%=c.getCOCKTAIL_TAG_1() %></span>
                    <%if(c.getCOCKTAIL_TAG_2()!=null){ %>   
                        <span class="tag"><%=c.getCOCKTAIL_TAG_2() %></span>
                       <%} %>
                    </div>
                </div>
            </div>
         <%} %>
   </div>
           
            <!--모달-->
        
            <div id="myModal" class="modal">
                <span class="close">&times;</span>
                <div class="modal-content">
                    <div class="modal-title-recipe">
                        <div class="modal-title-info">
                            <h2 id="modalTitle"></h2>
                            <img id="modalImage" src="" alt="상품 이미지" style="width: 100%; max-height: 300px; object-fit: contain;">
                        </div>
                        <div class="modal-recipe-info">
                            <h3>레시피</h3>
                            <p id="modalRecipe"></p>
                        </div>
                    </div>
                    <div class="modal-history-info">
                        <h3>역사</h3>
                    <p id="modalHistory"></p>
                    </div>
                </div>
            </div>
    	</div>
        
    </div>
   	<jsp:include page="${contextPath }/footer/footer.jsp" />

     <!-- 자바스크립트를 이용한 필터링 기능 -->
     <script>
     const nameSearchInput = document.getElementById('searchInput');
     const cocktailItems = document.querySelectorAll('.cocktail-item');
     const tagButtons = document.querySelectorAll('.tag-button');
     const ingredientButtons = document.querySelectorAll('.ingredient-button');

     // 이름 검색 기능
     function searchCocktails() {
         const searchValue = nameSearchInput.value.toLowerCase();

         cocktailItems.forEach(item => {
             const cocktailName = item.querySelector('h2').textContent.toLowerCase();
             if (cocktailName.includes(searchValue)) {
                 item.style.display = 'block'; // 검색된 아이템은 표시
             } else {
                 item.style.display = 'none'; // 검색되지 않은 아이템은 숨김
             }
         });

         // 검색 후 카운팅하여 위치 조정
         const visibleItems = Array.from(cocktailItems).filter(item => item.style.display === 'block');
         visibleItems.forEach((item, index) => {
             item.style.order = index; // 순서대로 정렬
         });
     }

     // 버튼 클릭 시 검색
     document.querySelector('.search-bar button').addEventListener('click', searchCocktails);

     // 엔터 키를 눌렀을 때 검색
     nameSearchInput.addEventListener('keydown', function(event) {
         if (event.key === 'Enter') {
             searchCocktails();
         }
     });

     // 태그 버튼 클릭 시 필터링 기능
     tagButtons.forEach(button => {
         button.addEventListener('click', function() {
             const selectedTag = button.getAttribute('data-tag').toLowerCase();

             cocktailItems.forEach(item => {
                 const tags = Array.from(item.querySelectorAll('.tag')).map(tag => tag.textContent.toLowerCase());
                 if (tags.includes(selectedTag)) {
                     item.style.display = 'block';
                 } else {
                     item.style.display = 'none';
                 }
             });
         });
     });

     // 재료 버튼 클릭 시 필터링 기능
     ingredientButtons.forEach(button => {
         button.addEventListener('click', function() {
             const selectedIngredient = button.getAttribute('data-ingredient').toLowerCase();

             cocktailItems.forEach(item => {
                 const ingredients = item.querySelector('.ingredients').textContent.toLowerCase();
                 if (ingredients.includes(selectedIngredient)) {
                     item.style.display = 'block';
                 } else {
                     item.style.display = 'none';
                 }
             });
         });
     });

        // 모든 찜하기 버튼에 대해 이벤트 리스너 추가
        const wishlistButtons = document.querySelectorAll('.wishlist-button');

        wishlistButtons.forEach(button => {
            button.addEventListener('click', function() {
                this.classList.toggle('active');
                this.textContent = this.classList.contains("active") ? "✔ 찜됨" : "♡ 찜"; // 텍스트 변경
            });
        });

        //모달
        const modal = document.getElementById("myModal");
        const closeBtn = document.getElementsByClassName("close")[0];
        const modalTitle = document.getElementById("modalTitle");
        const modalRecipe = document.getElementById("modalRecipe");
        const modalHistory = document.getElementById("modalHistory");
        const modalImage = document.getElementById("modalImage");

        const clickableDivs = document.querySelectorAll(".clickable-div");

        clickableDivs.forEach(div => {
            div.onclick = function() {
                modal.style.display = "block"; // 모달 표시
                modalTitle.textContent = this.getAttribute("data-title"); // 제목 설정
                modalImage.src = this.getAttribute("data-image"); // 이미지 설정
                modalRecipe.textContent = this.getAttribute("data-recipe"); // 레시피 설정
                modalHistory.textContent = this.getAttribute("data-history"); // 역사 설정
        
            }
        });

        // 모달 닫기
        closeBtn.onclick = function() {
            modal.style.display = "none"; // 모달 숨김
        }

        // 모달 외부 클릭 시 닫기
        window.onclick = function(event) {
            if (event.target === modal) {
                modal.style.display = "none"; // 모달 숨김
            }
        }

    </script>


<script>
document.querySelectorAll('.wishlist-button').forEach(button => {
    button.addEventListener('click', function() {
        const cocktailNo = this.getAttribute('data-cocktail-no');
        const usEmail = this.getAttribute('data-us-email');

        // AJAX 요청
        const xhr = new XMLHttpRequest();
        xhr.open('POST', '../BM_ToggleController', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                const response = JSON.parse(xhr.responseText); // JSON 형식으로 응답을 받음
                if (response.success) {
                    // 버튼 상태 변경
                    button.textContent = response.newStatus; // 서버에서 받은 새로운 상태로 변경
                }
            }
        };

        xhr.send('US_EMAIL=' + encodeURIComponent(usEmail) + '&COCKTAIL_NO=' + encodeURIComponent(cocktailNo));
    });
});



</script>


</body>
</html>
