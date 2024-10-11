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
   <style>
 		
 		
 		
	   .main_wrap{
	   		background-color:#f1f1f1;
	   		}
	   		
   		.main_container{
   			background-color:white;
   			border: 1px solid black;
   			width: 350px;
   			height: 600px;
   			text-align: center;
   			margin: 50px auto;
   		}
   		
   		.main_container .main_img{
   		
			width: 200px; 
			margin-top: 70px;
			margin-bottom: -80px; 
			margin: 70px auto -80px auto; 		
   		}
   		
   		.kakao{
   			margin: 50px 0;
   		}
   		
   		.other_id{
   			color: gray;
   		}
   </style>
    
</head>
<body>
   	<div class=main_wrap>
        <div class=main_container>
        	<table align="center" class=main_table>
	            <tr>
	            	<td>
	            		<img src="../images/logo7.png" class=main_img>
	            	</td>
	            </tr>
	            <tr>
	            	<td>
	            		<h3>간편하게 로그인하고 </h3>
	            		<h3>다양한 서비스를 이용해보세요</h3>
	            	</td>
	            </tr>
	            
	            
	            <tr>
	            	<td>
		                <div class="kakao">
		                    <a href="javascript:kakaoLogin()">
		                        <img src="../images/kakao_login_medium_narrow.png" alt="Kakao Login">
		                    </a>
		                </div>
	            	</td>
	            </tr>   
	            <tr>
	            	<td>
	            		<a href="https://smhrd.or.kr/" class="other_id">스마트인재개발원</a>
	            	</td>
	            </tr>
	        </table>
        </div>
	</div>
</body>
</html>
