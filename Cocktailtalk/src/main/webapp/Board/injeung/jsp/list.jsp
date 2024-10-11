<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>인증 게시판</title>
    <link rel="stylesheet" href="../../css/css.css">
</head>
<body>
	<jsp:include page="../../header.jsp" />
    <div class="board_wrap">
        <div class="board_title">
            <Strong>인증 게시판</Strong>
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
                <a href="write.html" class="on">등록</a>
                <!-- <a href="#">수정</a> -->
            </div>
        </div>
    </div>
    <%@include file="../../../footer/footer.jsp" %>

    <script>
        // DOM 요소 가져오기
        const searchInput = document.getElementById('searchInput');
        const searchButton = document.getElementById('searchButton');
        const postItems = document.querySelectorAll('.post-item');

        // 검색 버튼 클릭 시 게시물 필터링
        searchButton.addEventListener('click', function() {
            const searchValue = searchInput.value.toLowerCase();

            postItems.forEach(item => {
                const title = item.getAttribute('data-title').toLowerCase();
                const writer = item.getAttribute('data-writer').toLowerCase();

                if (title.includes(searchValue) || writer.includes(searchValue)) {
                    item.style.display = 'flex'; // 검색 결과 일치 시 표시
                } else {
                    item.style.display = 'none'; // 일치하지 않으면 숨김
                }
            });
        });
    </script>
    
</body>