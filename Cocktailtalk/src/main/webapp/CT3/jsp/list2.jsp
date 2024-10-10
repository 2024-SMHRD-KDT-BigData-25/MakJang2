<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" type="text/css" href="../css/list.css">
</head>
<body>
    <div class="wrap">
		<%@include file="/Board/header.jsp" %>
    
    <div class="list">
        <h2>모임 게시판😎😎</h2>
        <div class="panel panel-default">
            <div class="panel-heading">목록</div>
           <!-- 비동기 통신 -->
            <div class="panel-body">
                <table class="table table-bordered" border="1">
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>제목</th>
                            <th>작성자</th>
                            <th>작성일</th>
                        </tr>
                    </thead>
                    <tbody id="list"> <!-- jquery -->
                        <tr>
                            <td colspan="4">
                            <!-- 클릭하면(onclick) 게시물 작성하는 페이지로 이동 -->
                            <button class="btn btn-sm btn-success" onclick="location.href='boardform.jsp'">글작성</button>
                            </td>
                        </tr>  
                    </tbody>
                </table>
          
            </div>
          
            <div class="panel-footer">footer</div>
        </div>
    </div>
    
</body>
</html>