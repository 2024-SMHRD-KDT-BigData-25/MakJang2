<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <title>칵테일톡</title>
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <script type="text/javascript">
        Kakao.init('a670a16eed4a7510584df4c98f1e3baa');

        function kakaoLogin() {
            Kakao.Auth.login({
                success: function (response) {
                    let ACCESS_TOKEN = response.access_token; // access_token을 가져옵니다.
                    Kakao.API.request({
                        url: '/v2/user/me',
                        success: function (res) {
                            let EMAIL = res.kakao_account.email;
                            let NAME = res.id;
                            let NICK = res.properties.nickname;

                            // AJAX로 POST 요청 보내기
                            fetch('logincheck.jsp', {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/x-www-form-urlencoded',
                                },
                                body: 'EMAIL=' + encodeURIComponent(EMAIL) + 
                                      '&NAME=' + encodeURIComponent(NAME) + 
                                      '&NICK=' + encodeURIComponent(NICK) +
                                      '&ACCESS_TOKEN=' + encodeURIComponent(ACCESS_TOKEN)
                            })
                            .then(response => response.text())
                            .then(data => {
                                document.open();
                                document.write(data);
                                document.close();
                            })
                            .catch(error => console.error('Error:', error));
                        },
                        fail: function (error) {
                            alert(JSON.stringify(error));
                        },
                    });
                },
                fail: function (error) {
                    alert(JSON.stringify(error));
                },
            });
        }
    </script>
</head>
<body>
    <fieldset>
        <table align="center">
            <tr><td><h1>로그인 화면</h1></td></tr>
            <tr><td>
                <div>
                    <a href="javascript:kakaoLogin()">
                        <img src="images/kakao_login_medium_narrow.png" alt="Kakao Login">
                    </a>
                </div>
            </td></tr>
        </table>
    </fieldset>
</body>
</html>
