<%@page import="com.smhrd.model.MyMember"%>
<%@page import="com.smhrd.model.MemberDAO"%>
<%@page import="com.smhrd.model.Comment"%>
<%@page import="java.util.List"%>
<%@page import="com.smhrd.model.CommentDAO"%>
<%@page import="com.smhrd.model.MyBoard"%>
<%@page import="com.smhrd.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang=kr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>자유 게시글</title>
    <link rel="stylesheet" href="../css/css.css"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    
    <style>
    /* 기본 댓글 스타일 */
    .comment {
        margin-bottom: 10px;
        padding: 10px;
        background-color: #f9f9f9;
        border: 1px solid #ddd;
        border-radius: 4px;
    }

    /* 대댓글 스타일 - 들여쓰기와 약간 어두운 배경 */
    .reply {
        margin-left: 20px;
        background-color: #f0f0f0;
    }
  </style>
</head>
<body>
<%
	int idx = Integer.parseInt(request.getParameter("No"));  // 게시글 ID 가져오기
	String pageNumStr = request.getParameter("pageNum");
	int pageNum = (pageNumStr == null) ? 1 : Integer.parseInt(pageNumStr);
	BoardDAO dao = new BoardDAO();
	
	// 조회수 증가
    dao.increasefrHitCount(idx);
	
	MyBoard board = dao.getfrBoard(idx);  // 게시글 정보 가져오기
	
	// 댓글 리스트 가져오기
	CommentDAO commentDAO = new CommentDAO();
	List<Comment> commentList = commentDAO.getfrCommentsByBoardId(idx);  // 게시글 ID로 댓글 목록 가져오기  
	
	%>
<%
    response.setContentType("text/html; charset=UTF-8");
    response.setCharacterEncoding("UTF-8");

    // 현재 세션을 가져옴
    HttpSession userSession = request.getSession();
    String email = (String) userSession.getAttribute("EMAIL"); // 이메일을 email 변수에 저장

    // 로그인 정보가 없는 경우 오류 페이지로 리다이렉트
    if (email == null) {
        response.sendRedirect("/testcocktail/fail.jsp");
        return;
    }

    // MemberDAO를 사용하여 DB에서 사용자 정보를 가져옴
    MemberDAO userdao = new MemberDAO();
    MyMember member = userdao.getMemberByEmail(email); // DB에서 닉네임 조회

    String nick = null; // 닉네임을 저장할 변수
    if (member != null) {
        nick = member.getUS_NICK(); // DB에서 닉네임을 가져옴
    }

    // 닉네임이 없으면 오류 페이지로 리다이렉트
    if (nick == null) {
        response.sendRedirect("/testcocktail/fail.jsp");
        return;
    }
    //System.out.print(pnum);
%>		

	
	
    <div class="board_wrap">
        <div class="board_title">
            <Strong>자유 게시글</Strong>
            <p>취향이 맞는 다른 사람들과 함께 마시기 원한다면 방을 만들어보세요!</p>
        </div>
        <div class="board_view_wrap">
            <div class="board_view">
                <div class="title">
                    <%=board.getFR_TITLE().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %> <!-- input-->
                </div>
                <div class="info">
                    <dl>
                        <dt>번호</dt>
                        <dd><%=board.getFR_NO() %></dd>
                    </dl>
                    <dl>
                        <dt>글쓴이</dt>
                        <dd><%=board.getUS_NICK() %></dd>
                    </dl>
                    <dl>
                        <dt>작성일</dt>
                        <dd><%=board.getFR_WRITEDATE() %></dd>
                    </dl>
                    <dl>
                        <dt>조회</dt>
                        <dd><%=board.getFR_HIT() %></dd>
                    </dl>


                  <% if (board.getUS_EMAIL().equals(email)){ %>
				    <dl>
				        <!-- 게시물 삭제 버튼 -->
				        <form action="deleteBoard.do" method="post" onsubmit="return confirmDelete();">
				            <input type="hidden" name="No" value="<%= board.getFR_NO() %>">
				            <dt><button type="submit">삭제</button></dt>
				        </form>
				    </dl>
				    <dl>
				    <dt><a href="updateBoardForm.jsp?No=<%= board.getFR_NO() %>" class="btn btn-warning">게시글 수정</a></dt>
				    </dl>
				<% } %>

				    

                </div>
                <div class="cont">
                    <%=board.getFR_CONTENT() %>
                </div>
            </div>
            
            <div class="bt_wrap">
                <a href="crList.jsp?pageNum=<%=pageNum%>" class="on">목록</a>
             
            </div>
   
   		<h3>댓글 작성</h3>
	<form action="insertComment.do" method="post">
	    <input type="hidden" name="boardId" value="<%= board.getFR_NO()%>">
	    <input type="hidden" name="parentCommentId" value="">
	    <div class="form-group">
	        <label for="writer"><%= nick %></label> <!-- 사용자 아이디 받기 -->
	        <input type="hidden" class="form-control" id="writer" name="writer" value="<%= nick %>" required>
	        <input type="hidden" class="form-control" id="us_email" name="us_email" value="<%= email %>" required>
	    </div>
	    <div class="form-group">
	        <label for="content">내용:</label>
	        <textarea class="form-control" id="content" name="content" required></textarea>
	    </div>
	    <button type="submit" class="btn btn-primary">댓글 작성</button>
	</form>         
     
     
     <h3>댓글 목록</h3>
<ul class="list-group">
    <% for (Comment comment : commentList) { 
        String cssClass = comment.getParentCommentId() == null ? "comment" : "comment reply";
    %>
    <li class="<%= cssClass %>" onclick="toggleReplyForm(<%= comment.getCommentId() %>, event)">
        <strong><%= comment.getWriter() %></strong> (작성일: <%= comment.getIndate() %>) 
        <% if (comment.getUs_email().equals(email)){ %>
        <!-- 댓글 삭제 버튼 -->
        <form action="deleteComment.do" method="post" onsubmit="return confirmDeletereply();">
            <input type="hidden" name="commentId" value="<%= comment.getCommentId() %>">
            <input type="hidden" name="boardId" value="<%= board.getFR_NO() %>">
            <button type="submit" class="btn btn-sm btn-danger">댓글 삭제</button>
        </form>
        <% } %>
        <br>
        <%= comment.getContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %>
    
        <!-- 답글 작성 폼 (기본적으로 숨김) -->
         <% if (comment.getParentCommentId() == null) { %>
         <form action="insertComment.do" method="post" style="display:none;" id="replyForm<%= comment.getCommentId() %>">
            <input type="hidden" name="boardId" value="<%= board.getFR_NO() %>">
            <input type="hidden" name="parentCommentId" value="<%= comment.getCommentId() %>">
            <div class="form-group">
                <label for="writer"><%= nick %></label>
                <input type="hidden" class="form-control" name="writer" value="<%= nick %>" required>
                <input type="hidden" class="form-control" id="us_email" name="us_email" value="<%= email %>" required>
            </div>
            <div class="form-group">
                <label for="content">답글:</label>
                <textarea class="form-control" name="content" required></textarea>
            </div>
            <button type="submit" class="btn btn-primary">답글 작성</button>
        </form>
        <% } %>
    </li>
    <% } %>
</ul>

            
        </div>
    </div>
    
<script>
    // 답글 폼을 토글하는 함수
    function toggleReplyForm(commentId, event) {
        var clickedElement = event.target;

        // 만약 클릭된 요소가 textarea 또는 button일 경우 클릭 이벤트 무시
        if (clickedElement.tagName.toLowerCase() === 'textarea' || clickedElement.tagName.toLowerCase() === 'button') {
            return;
        }

        var replyForm = document.getElementById('replyForm' + commentId);
        if (replyForm.style.display === 'none' || replyForm.style.display === '') {
            replyForm.style.display = 'block';  // 폼이 숨겨져 있으면 보이게
        } else {
            replyForm.style.display = 'none';   // 폼이 보이면 숨기기
        }
    }
    
    function confirmDelete() {
        return confirm("정말로 이 게시물을 삭제하시겠습니까?");
    }
    
    function confirmDeletereply() {
        return confirm("정말로 이 댓글을 삭제하시겠습니까?");
    }
</script>

</body>
</html>