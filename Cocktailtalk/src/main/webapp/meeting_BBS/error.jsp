<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>에러 페이지</title>
    <script>
        // 일정 시간 후 자동으로 리스트 페이지로 리다이렉트
        setTimeout(function() {
            window.location.href = "meList.jsp";  // 리스트 페이지로 리다이렉트
        }, 3000);  // 3초 후 이동
    </script>
</head>
<body>
    <h2><%= request.getAttribute("errorMessage") %></h2>
    <p>3초 후 리스트 페이지로 이동합니다...</p>
    <p>지금 이동하려면 <a href="meList.jsp">여기</a>를 클릭하세요.</p>
</body>
</html>
