<%@page import="com.smhrd.model.MyBoard"%>
<%@page import="com.smhrd.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    int No = Integer.parseInt(request.getParameter("No"));
    BoardDAO dao = new BoardDAO();
    MyBoard board = dao.getshBoard(No);
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
	<title>게시글 수정</title>
	<link rel="stylesheet" href="../css/css.css">
<head>
<body>

<form action="updateBoard.do" method="post" enctype="multipart/form-data" onsubmit="return submitForm();">  
    
    <input type="hidden" name="No" value="<%= board.getSH_NO() %>">
    <div class="board_wrap">
        <div class="board_title">
            <strong>게시글 수정</strong>
            <p>작성했던 글을 수정할 수 있습니다.</p>
        </div>
    <div class="board_write_wrap">
        <div class="board_write">
            <div class="title">
                <dl>
                    <dt>제목</dt>
                    <dd>
                        <input type="text" name="meTitle" value="<%= board.getSH_TITLE() %>" required>
                    </dd>
                </dl>
            </div>
            <div class="info">
                <dl>
                	<dt>이미지 변경</dt>
                     <dd>
                        <input type="file" name="image" accept="image/*">
                     </dd>
                </dl>            
            </div>
                    <div class="cont">
                        <dl>
                            <dt>내용</dt>
                            <dd>
                                <textarea name="meContent" required><%= board.getSH_CONTENT() %></textarea>
                            </dd>
                        </dl>
                   </div>
                </div>
				
                <div class="bt_wrap">
                    <button type="submit" class="btn btn-primary">수정 완료</button>
                    <a href="meetingview.jsp?No=<%= board.getSH_NO() %>" class="btn btn-secondary">취소</a>
                </div>
            </div>
        </div>
    </form>
    
<script>
    // 폼 제출 전 검증 작업 (제목과 내용)
    function submitForm() {
        var title = document.getElementById('me_title').value.trim();
        var content = document.getElementById('meContent').value.trim();

        // 제목이 비어 있을 때
        if (title === '') {
            alert("제목을 입력해 주세요.");
            return false;
        }

        // 내용이 비어 있을 때
        if (content === '') {
            alert("내용을 입력해 주세요.");
            return false;
        }

        return true;  // 검증 통과 시 폼 제출
    }
</script>


</body>
</html>

