<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
	
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="${contextPath }/footer/footer.css" rel="stylesheet" type="text/css">
</head>
<body>
	<footer>
		<div class=inner>
			<div class="logo">
				<a href="#">
					<img src="${contextPath}/images/logo7.png" alt="칵테일톡 로고" />
				</a>
			</div>
			<div class="list">
	            <div class ="people">
	            	<span>제작자 :</span>
	            	<span>권국성, 서지우, 안해민, 이동수, 박현우, 방승완</span><br>
	            	<span>전남 순천시 중앙로 260 (스마트 인재 개발원 순천점)</span><br>
	            	<span>Moblie : 010 - 1234 - 5678 (주)스마트인재개발원</span><br>
	            	<span>&copy;   Makjang Company. All Rights Reseved.</span>
	            </div>
	        </div>
		</div>
	</footer>
</body>
</html>