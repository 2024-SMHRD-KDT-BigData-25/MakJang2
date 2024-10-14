<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.smhrd.model.MemberPartyDAO"%>
<%@page import="com.smhrd.model.TB_SHOW_LIKES"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>모임 게시글</title>
    <link rel="stylesheet" href="../../css/css.css">
</head>
<body>

<%
    MemberPartyDAO daoo = new MemberPartyDAO();
    int sh_no = 1;
    String email = "beerliker";
    int totalparty = daoo.totalparty(sh_no);
    TB_SHOW_LIKES ress = new TB_SHOW_LIKES(sh_no, email);
    int check = daoo.checkparty(ress);
%>

	<jsp:include page="${contextPath }/header/header.jsp" />
    <div class="board_wrap">
        <div class="board_title">
            <Strong>모임 게시글</Strong>
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
                    <dl>
                        <dt>참여인원</dt>
                        <dd><span id="partyCount"><%= totalparty %></span></dd>
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
                <a href="list.jsp" class="on">목록</a>
                <span class="party-button <%= check > 0 ? "active" : "" %>">
                	<a id="partyText"><%= check > 0 ? "참여취소" : "참여" %></a>

            </div>
        </div>
    </div>
        <jsp:include page="${contextPath }/footer/footer.jsp" />
        
<script>
    const partyButton = document.querySelector('.party-button');
    const partyCountDisplay = document.getElementById('partyCount');
    const partyTextDisplay = document.getElementById('partyText');

    partyButton.addEventListener('click', function() {
        const isActive = this.classList.toggle('active'); // 버튼의 상태 토글
        const xhr = new XMLHttpRequest();
        const url = isActive ? "../../../PartyInsertController" : "../../../PartyDeleteController";

        xhr.open("POST", url, true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.onload = function() {
            if (xhr.status === 200) {
                // 성공 시 총 좋아요 수 업데이트
                const currentparty = parseInt(partyCountDisplay.textContent);
                partyCountDisplay.textContent = isActive ? currentparty + 1 : currentparty - 1; // 화면에 참여인원 수 업데이트

                // 버튼 텍스트 변경
                if (isActive) {
                    partyTextDisplay.textContent = "참여취소"; 
                } else {
                    partyTextDisplay.textContent = "참여";
                } 
            } else {
                console.error("요청에 실패했습니다.");
            }
        };

        // 서버로 보낼 데이터 설정
        xhr.send("email=" + encodeURIComponent("<%=email%>") + "&sh_no=" + encodeURIComponent("<%=sh_no%>"));
    });
</script>
        
</body>
</html>