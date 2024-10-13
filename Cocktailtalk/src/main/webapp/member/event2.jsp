<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    // 현재 세션을 가져옴
    HttpSession userSession = request.getSession();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 알림 페이지</title>
<script>
function sendKakaoMessage() {
    // 세션에서 access token을 가져옴
    const accessToken = '<%= userSession.getAttribute("ACCESS_TOKEN") %>';
    
    const templateObject = {
        object_type: 'feed',
        content: {
            title: '칵테일톡',
            description: '메시지 보내기 테스트(링크는 구글로 설정)',
            link: {
                web_url: 'https://www.google.com', // 웹에서 열리는 링크
                mobile_web_url: 'https://www.google.com' // 모바일에서 열리는 링크
            }
        },
        buttons: [
            {
                title: '이벤트 보기',
                link: {
                    web_url: 'https://www.google.com', // 버튼 클릭 시 이동할 URL
                    mobile_web_url: 'https://www.google.com' // 모바일에서 열리는 링크
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
            alert('메시지를 성공적으로 보냈습니다!');
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


    <h1>이벤트 알림 페이지</h1>
    <button onclick="sendKakaoMessage()">알림 보내기</button>
    
    <jsp:include page="${contextPath }/footer/footer.jsp" />
</body>
</html>
