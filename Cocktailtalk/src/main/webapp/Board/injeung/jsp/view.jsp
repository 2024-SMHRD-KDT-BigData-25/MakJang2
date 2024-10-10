<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang=kr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>인증 게시글</title>
    <link rel="stylesheet" href="../../css/css.css">
</head>
<body>
	<%@include file="/Board/header.jsp" %>
    <div class="board_wrap">
        <div class="board_title">
            <Strong>작성자 입장 인증 게시글</Strong>
            <p>취향이 맞는 다른 사람들과 함께 마시기 원한다면 방을 만들어보세요!</p>
        </div>
        <div class="board_view_wrap">
            <div class="board_view">
                <div class="title">
                    글 제목이 들어갑니다 <!-- input-->
                </div>
                <div class="info">
                    <dl>
                        <dt>번호</dt>
                        <dd>1</dd>
                    </dl>
                    <dl>
                        <dt>글쓴이</dt>
                        <dd>방승완</dd>
                    </dl>
                    <dl>
                        <dt>작성일</dt>
                        <dd>2024.10.04</dd>
                    </dl>
                    <dl>
                        <dt>조회</dt>
                        <dd>33</dd>
                    </dl>
                </div>
                <div class="cont">
                    글 내용이 들어갑니다<br> <!-- input-->
                    글 내용이 들어갑니다<br>
                    글 내용이 들어갑니다<br>
                    글 내용이 들어갑니다
                </div>
            </div>
            
            <div class="bt_wrap">
                <a href="list.html" class="on">목록</a>
                <a href="edit.html">수정</a>
            </div>
        </div>
    </div>
    
    <%@include file="/Board/footer.jsp" %>
    
</body>
</html>