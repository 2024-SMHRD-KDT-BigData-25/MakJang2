<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>칵테일 검색</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="header.css">
</head>
<body>
    <div class="intro_bg">
        <div class="header">
            <div class="logo"><a href="">칵테일톡</a></div>
            <ul class="nav">
                <li><a href="#">칵테일 검색</a></li>
                <li><a href="#">커뮤니티</a>
                    <ul class="dropdown">
                        <li><a href="/Board/moim/list.html">모임 게시판</a></li>
                        <li><a href="/Board/jaU/list.html">자유 게시판</a></li>
                        <li><a href="/Board/changjak/list.html">창작 게시판</a></li>
                        <li><a href="/Board/injeung/list.html">인증 게시판</a></li>
                    </ul>
                    
                </li>
                <li><a href="#">즐길거리</a>
                    <div display : block>
                        <ul class="dropdown">
                            <li><a href="">먹었어요 월드컵</a></li>
                            <li><a href="">먹고 싶어요 월드컵</a></li>
                        </ul>
                    </div>
                </li>
                <li><a href="#">행사</a></li>
            </ul>
            <div>
                <ul class="my_page">
                    <li><a href="">로그아웃</a></li>
                    <li><a href="">마이페이지</a></li>
                </ul>
            </div>
        </div>
    </div>
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
                <button class="ingredient-button" data-ingredient="테킬라">테킬라</button>
            </div>
    

            <div class="tag-selection">
                <h3>태그로 필터링:</h3>
                <button class="tag-button" data-tag="상큼">상큼</button>
                <button class="tag-button" data-tag="짭짤">짭짤</button>
                <button class="tag-button" data-tag="상쾌">상쾌</button>
                <button class="tag-button" data-tag="달콤">달콤</button>
                <button class="tag-button" data-tag="쌉싸름">쌉싸름</button>
                <button class="tag-button" data-tag="강렬">강렬</button>
            </div>
        </div>

        <div class="cocktail-list">
            <div class="cocktail-item">
                    <button class="wishlist-button">
                        ♡ 찜
                    </button>
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

            <!--모달-->
        
            <div id="myModal" class="modal">
                <span class="close">&times;</span>
                <div class="modal-content">
                    <h2 id="modalTitle"> 칵테일 이름 넣으세요</h2>
                    <p id="modalDescription">레시피 작성해주세요</p>
                    <p id="modalHistory">역사 작성해주세요</p>
                </div>
            </div>
        
        </div>
    </div>

     <!-- 자바스크립트를 이용한 필터링 기능 -->
     <script>
        const nameSearchInput = document.getElementById('searchInput');
        const cocktailItems = document.querySelectorAll('.cocktail-item');
        const tagButtons = document.querySelectorAll('.tag-button');
        const ingredientButtons = document.querySelectorAll('.ingredient-button');
        const subIngredientLists = document.querySelectorAll('.sub-ingredient-list');
        const subIngredientButtons = document.querySelectorAll('.sub-ingredient-button');

        // 이름 검색 기능
        document.querySelector('.search-bar button').addEventListener('click', function() {
            const searchValue = nameSearchInput.value.toLowerCase();

            cocktailItems.forEach(item => {
                const cocktailName = item.querySelector('h2').textContent.toLowerCase();
                if (cocktailName.includes(searchValue)) {
                    item.style.display = 'block';
                } else {
                    item.style.display = 'none';
                }
            });
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
        const modalDescription = document.getElementById("modalDescription");

        const clickableDivs = document.querySelectorAll(".clickable-div");

        clickableDivs.forEach(div => {
            div.onclick = function() {
                modal.style.display = "block"; // 모달 표시
                modalTitle.textContent = this.getAttribute("data-title"); // 제목 설정
                modalDescription.textContent = this.getAttribute("data-description"); // 설명 설정
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

</body>
</html>
