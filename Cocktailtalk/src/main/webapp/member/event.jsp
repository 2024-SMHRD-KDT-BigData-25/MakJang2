<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    // 현재 세션을 가져옴
    HttpSession userSession = request.getSession();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>칵테일 행사 알림 페이지</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #ffffff; /* 바탕 흰색 */
        margin: 0;
        padding: 20px;
        text-align: center;
    }
    h1 {
        margin-top: 100px;
        color: #333333; /* 부드러운 검정색 */
    }
    .event-container {
        margin: 20px auto 100px auto;
    }
    .event {
        display: flex;
        align-items: center; /* 세로 정렬 */
        margin: 30px auto; /* 가운데 정렬을 위해 auto 사용 */
        background-color: #f9f9f9; /* 카드 배경을 연한 회색 */
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); /* 그림자 더 부드럽게 */
        width: 70%; /* 카드의 폭을 유지 */
        transition: transform 0.3s ease; /* hover 효과 추가 */
    }
    .event:hover {
        transform: scale(1.02); /* 살짝 확대 효과 */
    }
    .event-image {
        width: 40%; /* 이미지 너비 조정 */
        height: 200px; /* 이미지 높이를 넓게 */
        background-size: cover;
        background-position: center;
        border-radius: 10px;
        margin-right: 20px;
    }
    .event-details {
        text-align: left;
        width: 50%; /* 내용 영역의 너비 */
        color: #555555; /* 부드러운 텍스트 색상 */
    }
    .event-details h2 {
        color: #333333; /* 제목 색상 */
        font-size: 24px;
        margin-bottom: 10px;
    }
    .event-details p {
        margin: 5px 0; /* 문단 간격 조정 */
        white-space: normal; /* 자동 줄바꿈 활성화 */
    }
    .button-container {
        display: flex;
        justify-content: flex-end;
        margin-top: 10px;
    }
    button {
        background-color: #1abc9c; /* 민트색 */
        color: white;
        border: none;
        border-radius: 5px;
        padding: 8px 15px; /* 버튼 크기 */
        cursor: pointer;
        font-size: 14px;
        transition: background-color 0.3s ease, transform 0.3s ease;
    }
    button:hover {
        background-color: #16a085; /* 더 진한 민트 */
        transform: scale(1.05); /* hover 시 확대 효과 */
    }
</style>
<script>
        function sendKakaoMessage(event) {
            const accessToken = '<%= userSession.getAttribute("ACCESS_TOKEN") %>';
            const eventType = event.target.getAttribute('data-event');
            const eventCard = event.target.closest('.event'); // 클릭된 버튼의 상위 이벤트 카드
            const eventTitle = eventCard.querySelector('.event-name').textContent; // 해당 카드 내의 h2 클래스 'event-name' 내용
            const eventImage = eventCard.querySelector('.event-image').style.backgroundImage; 
            
            let eventURL;

            // 각 행사에 맞는 URL 설정
            if (eventType === 'drawingBar') {
                eventURL = 'https://www.feverup.com/m/140432?srsltid=AfmBOorCBtnFKMmGaPGgeOAyTEbs9t1JSHS2gz5efT9Fl7oEBNt51vA7';
            } else if (eventType === 'teaCocktail') {
                eventURL = 'https://www.feverup.com/m/136579?srsltid=AfmBOorCBtnFKMmGaPGgeOAyTEbs9t1JSHS2gz5efT9Fl7oEBNt51vA7'; 
            } else if (eventType === 'artNight') {
                eventURL = 'https://www.feverup.com/m/143133?srsltid=AfmBOorCBtnFKMmGaPGgeOAyTEbs9t1JSHS2gz5efT9Fl7oEBNt51vA7'; 
            }

			
            const eventImageUrl = eventImage.replace('url("', '').replace('")', '');
            
            const templateObject = {
                object_type: 'feed',
                content: {
                    title: '행사 안내: ' + eventTitle,
                    image_url: eventImageUrl,
                    description: '자세한 내용은 아래 링크를 확인하세요.',
                    link: {
                        web_url: eventURL,
                        mobile_web_url: eventURL
                    }
                },
                buttons: [
                    {
                        title: '행사 상세 보기',
                        link: {
                            web_url: eventURL,
                            mobile_web_url: eventURL
                        }
                    }
                ]
            };

            fetch('https://kapi.kakao.com/v2/api/talk/memo/default/send', {
                method: 'POST',
                headers: {
                    'Authorization': 'Bearer ' + accessToken,
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: 'template_object=' + encodeURIComponent(JSON.stringify(templateObject))
            })
            .then(response => {
                if (response.ok) {
                    alert('카톡으로 전송되었습니다!');
                } else {
                    return response.json().then(errorInfo => {
                        console.error('Error:', errorInfo);
                        alert('메시지 전송 실패: ' + (errorInfo.message || '알 수 없는 오류입니다.'));
                    });
                }
            })
            .catch(error => console.error('Error:', error));
        }
    </script>
</head>
<body>
    <jsp:include page="${contextPath }/header/header.jsp" />

    <h1>칵테일 행사 알림</h1>
    <div class="event-container">
        <!-- 첫 번째 행사 -->
        <div class="event">
            <div class="event-image" style="background-image: url('https://applications-media.feverup.com/image/upload/f_auto,w_720,h_720/fever2/plan/photo/fd19336a-5b6e-11ee-acdb-52daca66eded.png');"></div>
            <div class="event-details">
                <h2 class="event-name">취중 드로잉 바, 싶 디 (Sip D)</h2>
                <p>일시: 화요일 ~ 일요일 19:00 ~ 4:00(라스트 오더 3:30)</p>
                <p>장소: 서울 중구 충무로 40 3층</p>
                <p>힙지로의 감성, 예술인들이 모이는 공간. 그림을 그리면서 술을 마신다고요? 우리나라 최초 취중 드로잉 바입니다.</p>
                <div class="button-container">
                    <button data-event="drawingBar" onclick="sendKakaoMessage(event)">알림 보내기</button>
                </div>
            </div>
        </div>

        <!-- 두 번째 행사 -->
        <div class="event">
            <div class="event-image" style="background-image: url('https://applications-media.feverup.com/image/upload/fever2/plan/photo/e63d5b16-2d25-11ee-8540-f235ab335555.jpg');"></div>
            <div class="event-details">
                <h2 class="event-name">티 하우스 절기</h2>
                <p>일시: 매주 화요일~수요일 19시 </p>
                <p>장소: 서울 강남구 봉은사로 306 1층 티하우스 절기</p>
                <p>티 칵테일 클래스에서는 좋아하는 티로 칵테일을 만들어보며, 집에서도 언제든 활용하실 수 있는 티 시럽과 칵테일 레시피를 알려드립니다. </p>
                <div class="button-container">
                    <button data-event="teaCocktail" onclick="sendKakaoMessage(event)">알림 보내기</button>
                </div>
            </div>
        </div>

        <!-- 세 번째 행사 -->
        <div class="event">
            <div class="event-image" style="background-image: url('https://applications-media.feverup.com/image/upload/fever2/plan/photo/4e9abe1c-3458-11ef-97d1-569c383ac591.jpg');"></div>
            <div class="event-details">
                <h2 class="event-name">예술을 마시는 밤</h2>
                <p>일시: 월 ~ 목: 19:00 ~ 02:00, 금 ~ 토: 19:00 ~ 03:00, 일: 19:00 ~ 24:00</p>
                <p>장소: 피그먼트 바 (서울 중구 퇴계로6가길 12-2)</p>
                <p>그림 그리고 술, 두 개의 예술작품을 만날 수 있는 회현동의 스피크 이지 갤러리 바, 갤러리 피그먼트입니다. 마치 갤러리로 들어가는 듯한 입구부터 시즌별로 변경되는 시그니처 칵테일까지 갤러리 피그먼트에서 전하는 신비롭고 독특한 경험을 놓치지 마세요!</p>
                <div class="button-container">
                    <button data-event="artNight" onclick="sendKakaoMessage(event)">알림 보내기</button>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="${contextPath }/footer/footer.jsp" />
</body>
</html>
