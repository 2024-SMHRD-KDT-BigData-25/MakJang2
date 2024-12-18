<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>자유 게시판</title>
    <link rel="stylesheet" href="../../css/css.css">
</head>
<body>
	<jsp:include page="${contextPath }/header/header.jsp" />
        <div class="board_wrap">
            <div class="board_title">
                <Strong>자유 게시판</Strong>
                <p>취향이 맞는 다른 사람들과 함께 마시기 원한다면 방을 만들어보세요!</p>
            </div>
            <div class="board_list_wrap">
                <div class="board_list">
                    <div class="top">
                        <div class="num">번호</div>
                        <div class="title">제목</div>
                        <div class="writer">글쓴이</div>
                        <div class="date">작성일</div>
                        <div class="count">조회</div>
                    </div>
                    <div class="post-item" data-title="글제목이 들어갑니다" data-writer="방승완"><!-- DB에서 불러오기-->
                        <div class="num">5</div>
                        <div class="title"><a href="view2.html">글제목이 들어갑니다</a></div>
                        <div class="writer">방승완</div>
                        <div class="date">2024.10.04</div>
                        <div class="count">33</div>
                    </div>
                    <div class="post-item" data-title="글제목이 들어갑니다" data-writer="방완">
                        <div class="num">4</div>
                        <div class="title"><a href="view2.html">글제목이 들어갑니다</a></div>
                        <div class="writer">방완</div>
                        <div class="date">2024.10.04</div>
                        <div class="count">33</div>
                    </div>
                    <div class="post-item" data-title="글제목이 들어갑니다" data-writer="방완">
                        <div class="num">3</div>
                        <div class="title"><a href="view2.html">글제목이 들어갑니다</a></div>
                        <div class="writer">방완</div>
                        <div class="date">2024.10.04</div>
                        <div class="count">33</div>
                    </div>
                    <div class="post-item" data-title="글제목이 들어갑니다" data-writer="방완">
                        <div class="num">2</div>
                        <div class="title"><a href="view2.html">글제목이 들어갑니다</a></div>
                        <div class="writer">방완</div>
                        <div class="date">2024.10.04</div>
                        <div class="count">33</div>
                    </div>
                    <div class="post-item" data-title="글제목이 들어갑니다" data-writer="방승">
                        <div class="num">1</div>
                        <div class="title"><a href="view2.html">글제목이 들어갑니다</a></div>
                        <div class="writer">방승</div>
                        <div class="date">2024.10.04</div>
                        <div class="count">33</div>
                    </div>
                </div>
                <div class="search-bar">
                    <input type="text" id="searchInput" placeholder="제목 또는 작성자를 검색하세요">
                    <button id="searchButton">검색</button>
                </div>
                <div class="board_page">
                    <a href="#" class="bt first"><<</a>
                    <a href="#" class="bt pre"><</a>
                    <a href="#" class="num on">1</a> <!-- 페이지 이동-->
                    <a href="#" class="num">2</a>
                    <a href="#" class="num">3</a>
                    <a href="#" class="num">4</a>
                    <a href="#" class="num">5</a>
                    <a href="#" class="bt next">></a>
                    <a href="#" class="bt last">>></a>
                </div>
                <div class="bt_wrap">
                    <a href="write.jsp" class="on">등록</a>
                    <!-- <a href="#">수정</a> -->
                </div>
            </div>
        </div>
        <jsp:include page="${contextPath }/footer/footer.jsp" />
</body>
</html>