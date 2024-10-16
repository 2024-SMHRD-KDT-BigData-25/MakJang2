<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.smhrd.model.Winner"%>
<%@page import="java.util.List"%>
<%@page import="com.smhrd.model.WinnerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
	<link rel="stylesheet" type="text/css" href="../css/index_style.css"> 
    

</head>
<body>
<% 
	WinnerDAO dao = new WinnerDAO();

	int totalCount = dao.CountWinnertb();
	
	List<Winner> list = dao.CountWinner();
	
	int i = 1;
%>


    <div class="wrap">
      <jsp:include page="${contextPath }/header/header.jsp" />
        
        <div class=main_bg>
            <div class="main_text">
                <p class="comecome">칵테일 톡에 오신걸 환영합니다!</p>
                <br>
                <p>여러분의 특별한 순간을 함께 나누고, 새로운 친구를 만나며,</p>
                <p>나만의 칵테일 레시피를 자랑할 수 있는 공간이 바로 여기에 있습니다!</p>
            </div>
        </div>

        <div class="main_text1">
            <h1>이번주 추천 칵테일</h1>
            <div class="px24">매주 새로운 칵테일을 추천해 드립니다</div>
            <div class="service" >
                <div class="cock_photo" id="weekly-recommendation">
                     <img src="../image/Black Russian.png" alt="추천 칵테일">
                </div>
                <div class="cock_info" id="cocktail-description">
                    <h2>블랙 러시안(Black Russian)</h2>
                    <h3>
                    	<ul>
                    	<li>보드카 50 ml (1 2/3 oz)</li>
                    	<li>커피 리큐어 (칼루아 등) 20 ml (2/3 oz)</li>
                    	<li>얼음</li>
                    	</ul>
                    </h3>
                    <p>공산주의의 맹주였던 구 소련이 암흑의 세계로서 철의 장벽으로 막혀 있던 시절, 아무도 항거할 수 없었던 KGB의 횡포에 저항하겠다는 의미가 담긴 칵테일이다.</p>
                      
                </div>
            </div>
        </div>
    </div>
    
    <div class="main_text2">
        <h1>월드컵</h1>
        <div class="px24">이번주 웝드컵에 참여하세요!</div>
        <div class="ranking-wrap">
            <div class="rank-info">
                <h2>칵테일 이상형 월드컵 결과</h2>
                
				<div class="ranking-container">
				<%for(Winner w:list){ 
                	int rank = Integer.parseInt(w.getWINNER_IMAGE());
                %>
				    <div class="ranking"><%= i++ %>등: <%=w.getWINNER_NAME()%> (<%= (int)((double)rank / (double)totalCount * 100.0) %>%)
				    		<%int a = (int)((double)rank / (double)totalCount * 100.0); %>
				        <div class="percentage-bar" style="width: <%=a%>%;"></div>
				    </div> <%if(i==9){break;}} %>
				    <!-- <div class="ranking">2등: 화이트 러시안 (25%)
				        <div class="percentage-bar" style="width: 25%;"></div>
				    </div>
				    <div class="ranking">3등: 올드 패션드 (20%)
				        <div class="percentage-bar" style="width: 20%;"></div>
				    </div>
				    <div class="ranking">4등: 네그로니 (10%)
				        <div class="percentage-bar" style="width: 10%;"></div>
				    </div>
				    <div class="ranking">5등: 마가리타 (5%)
				        <div class="percentage-bar" style="width: 5%;"></div>
				    </div>
				    <div class="ranking">6등: 피나 콜라다 (3%)
				        <div class="percentage-bar" style="width: 3%;"></div>
				    </div>
				    <div class="ranking">7등: 다이키리 (2%)
				        <div class="percentage-bar" style="width: 2%;"></div>
				    </div>
				    <div class="ranking">8등: 블루 하와이 (1%)
				        <div class="percentage-bar" style="width: 1%;"></div>
				    </div> -->
				</div>

            </div>
            <div class="rank" id="cocktail-description">
                <img src="../image/worldcup4.png">
            </div>
        </div>
    </div>
    <div class="event-wrap">
    	<h1>행사</h1>
    	<div class="px24">이번주 행사들 보고 가세요!</div>
    	<div class="carousel">
    	    <button class="arrow left-arrow">◀</button>
	    	<div class="event-container">
		        <a href="https://feverup.com/m/140432?srsltid=AfmBOorCBtnFKMmGaPGgeOAyTEbs9t1JSHS2gz5efT9Fl7oEBNt51vA7">
		        	<div class="event-card">
						<div class="event-image" style="background-image: url('https://applications-media.feverup.com/image/upload/f_auto,w_720,h_720/fever2/plan/photo/fd19336a-5b6e-11ee-acdb-52daca66eded.png"></div>
						<div class="event-info"> 
							<h5>취중 드로잉 바, 싶 디 (Sip D)</h5>
							<p>일시: 화요일 ~ 일요일 19:00 ~ 4:00(라스트 오더 3:30)</p>
                			<p>장소: 서울 중구 충무로 40 3층</p></div>		        	
		        	</div>
		        </a>
		        
		        <a href="https://feverup.com/m/136579?srsltid=AfmBOorCBtnFKMmGaPGgeOAyTEbs9t1JSHS2gz5efT9Fl7oEBNt51vA7">
		        	<div class="event-card">
						<div class="event-image" style="background-image: url('https://applications-media.feverup.com/image/upload/fever2/plan/photo/e63d5b16-2d25-11ee-8540-f235ab335555.jpg')"></div>
						<div class="event-info"> 
							<h5>티하우스 절기</h5>
							<p>날짜: 화요일 ~ 일요일</p>
                			<p>시간:19:00 ~ 4:00(라스트 오더 3:30)</p>
                			<p>위치: 서울 강남구 봉은사로 306 1층</p>
                		</div>		        	
		        	</div>
		        </a>
		        
		        <a href="https://feverup.com/m/143133?srsltid=AfmBOorCBtnFKMmGaPGgeOAyTEbs9t1JSHS2gz5efT9Fl7oEBNt51vA7">
		        	<div class="event-card">
						<div class="event-image" style="background-image: url('https://applications-media.feverup.com/image/upload/fever2/plan/photo/4e9abe1c-3458-11ef-97d1-569c383ac591.jpg')"></div>
						<div class="event-info"> 
							<h5>예술을 마시는 밤</h5>
							<p>월 ~ 목: 19:00 ~ 02:00</p>
							<p>금 ~ 토: 19:00 ~ 03:00</p>
							<p>일: 19:00 ~ 24:00</p>
							<p>위치: 피그먼트 바 (서울 중구 퇴계로6가길 12-2)</p>
                		</div>		        	
		        	</div>
		        </a>
		        
		        <a href="https://feverup.com/m/134910?srsltid=AfmBOorCBtnFKMmGaPGgeOAyTEbs9t1JSHS2gz5efT9Fl7oEBNt51vA7">
		        	<div class="event-card">
						<div class="event-image" style="background-image: url('https://applications-media.feverup.com/image/upload/fever2/plan/photo/1ee8eff0-1a3b-11ee-aade-8ee65e6ed624.jpg')"></div>
						<div class="event-info"> 
							<h5>맥파이타이거 성수티룸</h5>
							<p>날짜: 화요일 ~ 일요일</p>
							<p>시간:12:00~21:30</p>
							<p>위치: 서울 성동구 성수이로 97, 5층</p>
                		</div>		        	
		        	</div>
		        </a>
		        
		        <a href="https://www.beveragemaster.kr/board_notice/31742">
		        	<div class="event-card">
						<div class="event-image" style="background-image: url('https://www.beveragemaster.kr/files/attach/images/15637/742/031/206042c604b403561a291779f5fa02b0.jpg')"></div>
						<div class="event-info"> 
							<h5>1박 2일 양조장 투어</h5>
							<p>2024년 10월 25일 (금) 오전 8시 30분</p>
							<p>~ 2024년 10월 26일 (토) 저녁 7시 사당역</p>
							<p>위치: 사당역 1번 출구 관광버스 공영주차장</p>
                		</div>		        	
		        	</div>
		        </a>
		        
		        <a href="https://www.beveragemaster.kr/board_notice/31737">
		        	<div class="event-card">
						<div class="event-image" style="background-image: url('https://www.beveragemaster.kr/files/attach/images/15637/737/031/3535c40423e5fa67a98e5972a07f8354.jpg')"></div>
						<div class="event-info"> 
							<h5>제4회 조주기능사 실기 대비반 모집</h5>
							<p>월요반(오후반) 10월 7일 개강 14기 ~ 17시</p>
							<p>수요반(저녁반) 10월 16일 개강 19시 ~ 22시</p>
							<p>금요반(저녁반) 10월 11일 개강 19시 ~ 22시</p>
                		</div>		        	
		        	</div>
		        </a>
		        
		        <a href="https://www.beveragemaster.kr/index.php?mid=board_notice&page=2&document_srl=31570">
		        	<div class="event-card">
						<div class="event-image" style="background-image: url('https://www.beveragemaster.kr/files/attach/images/15637/570/031/6d734ea2242670e6dea7c405573100f4.jpg')"></div>
						<div class="event-info"> 
							<h5>제17회 코리안컵칵테일대회</h5>
							<p>원서접수 2024년 5월 20일 09:00</p>
							<p> ~ 6월 8일 18:00</p>
							<p>예선전 2024년 6월 22일(대학리그)</p>
							<p>예선전 2024년 6월 23일(프로리그)</p>
                		</div>		        	
		        	</div>
		        </a>
		    </div>
		    <button class="arrow right-arrow">▶</button> 
    	</div>
    </div>
    <jsp:include page="${contextPath }/footer/footer.jsp" />
    
    <script>
    window.addEventListener('scroll', function() {
        const recommendationSection = document.getElementById('weekly-recommendation');
        const descriptionSection = document.getElementById('cocktail-description');
        const rankingContainer = document.querySelector('.ranking-container');
        const rank = document.querySelector('.rank'); // 오른쪽 요소

        const boundingRecommendation = recommendationSection.getBoundingClientRect();
        const boundingDescription = descriptionSection.getBoundingClientRect();
        const boundingRankingContainer = rankingContainer.getBoundingClientRect();
        const boundingRank = rank.getBoundingClientRect(); // 오른쪽 요소

        // 추천 섹션 애니메이션
        if (boundingRecommendation.top < window.innerHeight && boundingRecommendation.bottom >= 0) {
            recommendationSection.classList.add('visible'); // 이미지 애니메이션
        } else {
            recommendationSection.classList.remove('visible'); // 이미지 사라짐
        }

        // 설명 섹션 애니메이션
        if (boundingDescription.top < window.innerHeight && boundingDescription.bottom >= 0) {
            descriptionSection.classList.add('visible'); // 설명 애니메이션
        } else {
            descriptionSection.classList.remove('visible'); // 설명 사라짐
        }

        // 월드컵 부분 애니메이션
        if (boundingRankingContainer.top < window.innerHeight && boundingRankingContainer.bottom >= 0) {
            rankingContainer.classList.add('visible-ranking'); // 왼쪽에서 들어옴
        } else {
            rankingContainer.classList.remove('visible-ranking'); // 사라짐
        }

        if (boundingRank.top < window.innerHeight && boundingRank.bottom >= 0) {
            rank.classList.add('visible-rank'); // 오른쪽에서 들어옴
        } else {
            rank.classList.remove('visible-rank'); // 사라짐
        }
    });

	// 행사
	
	const eventContainer = document.querySelector('.event-container');
	const cards = document.querySelectorAll('.event-card');
	const leftArrow = document.querySelector('.left-arrow');
	const rightArrow = document.querySelector('.right-arrow');
	let scrollIndex = 0; // 현재 스크롤 인덱스
	let autoScrollInterval; // 자동 스크롤 간격 변수
	
	// 초기 상태에서 1번 카드가 중앙에 위치하도록 설정
	function setInitialScrollPosition() {
	    const cardWidth = 200; // 카드 너비
	    const initialScroll = cardWidth * 0; // 1번 카드가 중앙에 오도록 스크롤 위치 설정
	    eventContainer.scrollLeft = initialScroll;
	    
	    // 3번 카드에 active 클래스 추가 (확대 효과)
	    cards[2].classList.add('active'); // 3번 카드 (인덱스 0)
	}
	
	function updateActiveCard() {
	    cards.forEach(card => card.classList.remove('active')); // 모든 카드에서 active 클래스 제거

	    // 현재 스크롤 인덱스 기준으로 카드 활성화
	    const activeCardIndex = scrollIndex; // 현재 인덱스
	    cards[activeCardIndex].classList.add('active'); // 현재 카드에 active 클래스 추가
	}
	
	function scrollCards(direction) {
	    const cardWidth = 200; // 카드 너비

	    // 스크롤할 인덱스 계산
	    if (direction === 'right') {
	        scrollIndex++;
	        if (scrollIndex >= cards.length) {
	            scrollIndex = 0; // 처음으로 리셋
	        }
	    } else if (direction === 'left') {
	        scrollIndex--;
	        if (scrollIndex < 0) {
	            scrollIndex = cards.length - 1; // 마지막으로 리셋
	        }
	    }

	    // 카드 컨테이너의 스크롤 위치 조정
	    eventContainer.scrollTo({
	        left: scrollIndex * cardWidth,
	        behavior: 'smooth' // 부드러운 스크롤
	    });

	    updateActiveCard(); // 현재 카드 업데이트
	}
	
	// 화살표 클릭 이벤트 리스너
	leftArrow.addEventListener('click', () => {
	    scrollCards('left');
	    resetAutoScroll(); // 자동 스크롤 리셋
	});
	rightArrow.addEventListener('click', () => {
	    scrollCards('right');
	    resetAutoScroll(); // 자동 스크롤 리셋
	});
	
	// 자동 스크롤 함수
	function autoScroll() {
	    scrollCards('right');
	}
	
	// 자동 스크롤을 시작하는 함수
	function startAutoScroll() {
	    autoScrollInterval = setInterval(autoScroll, 3000); // 3초마다 자동 스크롤
	}
	
	// 자동 스크롤 리셋 함수
	function resetAutoScroll() {
	    clearInterval(autoScrollInterval);
	    startAutoScroll();
	}
	
	// 초기 상태 설정
	setInitialScrollPosition();
	startAutoScroll(); // 자동 스크롤 시작

	
    </script>
</body>
</html>