<%@page import="com.smhrd.model.MyBoard"%>
<%@page import="com.smhrd.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    int No = Integer.parseInt(request.getParameter("No"));
    BoardDAO dao = new BoardDAO();
    MyBoard board = dao.getcrBoard(No);
%>

<!DOCTYPE html>
<html lang="en">
<head>
<!-- Quill CSS 및 JS CDN 추가 -->
<link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
<script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
    <meta charset="UTF-8">
    <title>게시글 수정</title>
    <link rel="stylesheet" href="../css/css.css">
</head>
<body>

	<jsp:include page="${contextPath }/header/header.jsp" />
<form action="updateBoard.do" method="post" onsubmit="return submitForm();">  <!-- onsubmit 추가 -->
    <input type="hidden" name="No" value="<%= board.getCR_NO() %>">
    
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
                        <input type="text" name="meTitle" value="<%= board.getCR_TITLE() %>" required>
                    </dd>
                </dl>
            </div>
            
            <div class="cont">
                <dl>
                    <dd>
                        <!-- Quill 에디터 영역 -->
                    <div id="editor-container" style="height: 300px;">
                        <%= board.getCR_CONTENT() %>  <!-- 기존 게시글 내용을 Quill에 표시 -->
                    </div>
                    </dd>
                </dl>
            </div>
        </div>

		 <!-- Quill 데이터가 저장될 히든 필드 -->
        <input type="hidden" name="meContent" id="meContent">

        <div class="bt_wrap">
            <button type="submit" class="btn btn-primary">수정 완료</button>
            <a href="meetingview.jsp?No=<%= board.getCR_NO() %>" class="btn btn-secondary">취소</a>
        </div>
   	 </div>
</form>
    </div>
        <jsp:include page="${contextPath }/footer/footer.jsp" />

<script>
    // Quill 에디터 초기화
    var quill = new Quill('#editor-container', {
        theme: 'snow',
        modules: {
            toolbar: [
                [{ 'header': [1, 2, false] }],
                ['bold', 'italic', 'underline'],
                [{ 'list': 'ordered'}, { 'list': 'bullet' }],
                ['image']  // 이미지 삽입 버튼 추가
            ]
        }
    });

    // 폼 제출 시 Quill 에디터에서 작성된 데이터를 hidden input에 저장
    function submitForm() {
        var content = document.querySelector('input[name=meContent]');
        content.value = quill.root.innerHTML;  // Quill 에디터의 HTML 내용을 hidden input에 저장

        // 제목 유효성 검사
        var title = document.querySelector("input[name='meTitle']").value;
        if (title.trim() === "") {
            alert("제목을 입력해 주세요.");
            return false;
        }

        // Quill 에디터의 내용 확인
        if (quill.getText().trim().length === 0) {
            alert("내용을 입력해 주세요.");
            return false;
        }

        return true;  // 유효성 검사를 통과하면 폼 제출
    }
</script>

</body>
</html>

