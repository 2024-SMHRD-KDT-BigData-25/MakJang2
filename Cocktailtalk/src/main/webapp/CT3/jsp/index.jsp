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
    <div class="wrap">
		<%@include file="/Board/header.jsp" %>
        <!-- intro 끝 -->
        <div>
            <div class=main_bg>
            </div>
            <div class="main_text">
                <h1>칵테일 톡에 오신걸 환영합니다!</h1>
                <h2> 홈페이지 소개 </h2>
            </div>
        </div>

        <div class="main_text1">
            <h1>이번주 추천 칵테일</h1>
            <div class="px24">매주 새로운 칵테일을 추천해 드립니다</div>
            <div class="service">
                <div class="cock_photo">
                    <img src="../image/cock.jpg">
                </div>
                <div class="px18">
                    <h2>마티니</h2>
                    <h1>설명</h1>    
                </div>
            </div>
        </div>
    </div>
    
    <div class="main_text2">
        <h1>월드컵</h1>
        <div class="px24">이번주 웝드컵에 참여하세요!</div>
        <div class="ranking">
            <div class="px18">
                <h2>몇주차 월드컵</h2>
                <h1>설명</h1>    
            </div>
            <div class="rank">
                <img src="../image/worldcup.jpg">
            </div>
        </div>
    </div>
</body>
</html>