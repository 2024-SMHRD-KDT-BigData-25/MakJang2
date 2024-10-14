<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
	
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="${contextPath }/header/header.css" rel="stylesheet" type="text/css">
</head>
<body>
	<header>
	    <div class="intro_bg">
	        <div class="header">
	            <div class="logo">
	                <a href="${contextPath }/CT3/jsp/index.jsp"><img src="${contextPath }/header/logo8.png" alt="칵테일톡 로고" alt="Logo" class="logo-img"></a>
	            </div>
	            <ul class="nav">
	                <li><a href="${contextPath }/recommend/recommend.jsp">칵테일 검색</a></li>
	                <li class="dropdown-menu">
	                    <a href="#">커뮤니티</a>
	                    <ul class="dropdown">
	                        <li><a href="${contextPath }/Board/meeting_BBS/meList.jsp">모임 게시판</a></li>
	                        <li><a href="${contextPath }/Board/free_BBS/crList.jsp">자유 게시판</a></li>
	                        <li><a href="${contextPath }/Board/create_BBS/crList.jsp">창작 게시판</a></li>
	                        <li><a href="${contextPath }/Board/show_BBS/crList.jsp">인증 게시판</a></li>
	                    </ul>                    
	                </li>
	                <li class="dropdown-menu">
	                    <a href="#">즐길거리</a>
	                    <ul class="dropdown">
	                        <li><a href="${contextPath }/worldcup/worldcup.jsp">먹었어요 월드컵</a></li>
	                        <li><a href="#">먹고 싶어요 월드컵</a></li>
	                    </ul>
	                </li>
	                <li><a href="${contextPath }/member/event.jsp">행사</a></li>
	            </ul>
	            <div>
	                <ul class="my_page">
	                    <li><a href="${contextPath }/member/logout.jsp">로그아웃</a></li>
	                    <li><a href="${contextPath }/Mypage/mypage.jsp">마이페이지</a></li>
	                </ul>
	            </div>
	        </div>
	    </div>
    </header>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const dropdownMenus = document.querySelectorAll('.dropdown-menu');

            dropdownMenus.forEach(menu => {
                menu.addEventListener('mouseenter', function() {
                    const dropdown = menu.querySelector('.dropdown');
                    dropdown.style.display = 'block';
                });

                menu.addEventListener('mouseleave', function() {
                    const dropdown = menu.querySelector('.dropdown');
                    dropdown.style.display = 'none';
                });
            });
        });
    </script>
</body>
</html>
