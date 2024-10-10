<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <link rel="stylesheet" type="text/css" href="../css/table_insert.css">
</head>
<body>
    <div class="wrap">
 		<%@include file="/Board/header.jsp" %>
        <div>
            <h1>게시판 글쓰기</h1>
            <form action="#" method="post" name="form"">
                <table border="1">
                    <tr>
                        <td>이름</td> <!-- 작성자 이름 자동 입력-->
                        <td><input type="text" name="writer">
                        </td>
                    </tr>
                    <tr>
                        <td>제목</td>
                        <td>
                            <input type="text" name="subject">
                    </td>
                    </tr>
                    <tr>
                        <td>내용</td>
                        <td>
                            <textarea name="content" rows="13" cols="40"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <input type="submit" value="글쓰기">
                            <input type="reset" value="다시작성">
                            <input type="button" value="목록" onclick="location.href='list.jsp'">
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    
    </div>
    
</body>
</html>