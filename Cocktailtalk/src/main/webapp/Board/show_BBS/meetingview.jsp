<%@page import="com.smhrd.model.TB_SHOW_LIKES"%>
<%@page import="com.smhrd.model.MemberLikeDAO"%>
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
    <title>인증 게시글</title>
    <link rel="stylesheet" href="../css/css.css"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    
    <style>
    
    .comment-wrap{
    	margin-top: 20px;
    	border: 1px solid black;
    	padding: 20px;
    	border-radius: 5px;
    }
    }

    /* 대댓글 스타일 - 들여쓰기와 약간 어두운 배경 */
    .reply {
        margin-left: 20px;
        background-color: #f0f0f0;
    }
    
    /* 댓글 목록 스타일 */
.list-group {
    margin: 20px 0;
    padding: 0;
    list-style-type: none;
}

h3{
	margin: 20px;
}

textarea{
	width: 100%;
}

.comment {
    border: 1px solid #ddd;
    border-radius: 5px;
    margin-bottom: 10px;
    padding: 10px;
    background-color: #f9f9f9;
    transition: background-color 0.3s;
}

.comment:hover {
    background-color: #f1f1f1;
}

.comment.reply {
    margin-left: 20px; /* 답글을 들여쓰기 */
    border-left: 3px solid #007bff; /* 답글 강조 */
}

.content{

}

.btn {
    margin-top: 5px;
    float: right; /* 버튼을 오른쪽으로 이동 */
}

.form-group {
    margin-bottom: 15px;
}

/* 댓글 삭제 버튼 스타일 */
.btn-danger {
    float: right;
    margin-top: -10px;
}

/* 텍스트 영역 스타일 */
textarea.form-control {
    width: 100%;
    height: 70px; /* 텍스트 영역 높이 조절 */
}

/* 댓글 작성 폼 숨김 처리 */
form[style*="display:none;"] {
    margin-top: 10px;
}

/* 사용자 아이디 및 작성일 스타일 */
strong {
    color: #333;
}

/* 댓글 내용 스타일 */
.comment-content {
    white-space: pre-wrap; /* 줄바꿈 및 공백 처리 */
    color: #555;
}

.nickname{
	border: 1px solid black;
	padding: 7px;
	border-radius: 5px;
	padding-bottom: 5px;
	font-weight: bold;
}



/* 버튼 기본 스타일 */
.delete, .modify {
    background-color: white;   /* 배경 색상 */
    border: 1px solid #007bff; /* 테두리 색상 */
    border-radius: 5px;        /* 모서리 둥글게 */
    padding: 10px 15px;        /* 내부 여백 */
    cursor: pointer;            /* 커서 변경 */
    font-weight: bold;          /* 글자 두께 */
    color: #007bff;             /* 글자 색상 */
    transition: background-color 0.3s; /* 배경색 변화 애니메이션 */
    height: 20px;              /* 버튼 높이 통일 */
}

/* 삭제, 수정 버튼 호버 시 효과 */
.delete:hover, .modify:hover {
    background-color: #f1f1f1; /* 호버 시 배경색 변화 */
}

/* 버튼의 텍스트 정렬 */
.delete, .modify {
    display: flex;              /* 플렉스 박스로 변환 */
    align-items: center;        /* 세로 정렬 */
    justify-content: center;    /* 가로 정렬 */
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
    dao.increaseshHitCount(idx);
	
	MyBoard board = dao.getshBoard(idx);  // 게시글 정보 가져오기
	
	// 댓글 리스트 가져오기
	CommentDAO commentDAO = new CommentDAO();
	List<Comment> commentList = commentDAO.getshCommentsByBoardId(idx);  // 게시글 ID로 댓글 목록 가져오기  
	
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

<%
	// 좋아요 수 카운트
    MemberLikeDAO daoo = new MemberLikeDAO();
    int totalLikes = daoo.totallike(board.getSH_NO());
    TB_SHOW_LIKES ress = new TB_SHOW_LIKES(board.getSH_NO(), email);
    int check = daoo.checklike(ress);
    TB_SHOW_LIKES inserttotallike  = new TB_SHOW_LIKES(totalLikes, board.getSH_NO());
    int chhhhh = daoo.inserttotallike(inserttotallike);
    System.out.println(chhhhh);
%>


	

	
	<jsp:include page="${contextPath }/header/header.jsp" />	
    <div class="board_wrap">
        <div class="board_title">
            <Strong>인증 게시글</Strong>
            <p>취향이 맞는 다른 사람들과 함께 마시기 원한다면 방을 만들어보세요!</p>
        </div>
        <div class="board_view_wrap">
            <div class="board_view">
                <div class="title">
                    <%=board.getSH_TITLE().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %> <!-- input-->
                </div>
                <div class="info">
                    <dl>
                        <dt>번호</dt>
                        <dd><%=board.getSH_NO() %></dd>
                    </dl>
                    <dl>
                        <dt>글쓴이</dt>
                        <dd><%=board.getUS_NICK() %></dd>
                    </dl>
                    <dl>
                        <dt>작성일</dt>
                        <dd><%=board.getSH_WRITEDATE() %></dd>
                    </dl>
                    <dl>
                        <dt>조회</dt>
                        <dd><%=board.getSH_HIT() %></dd>
                    </dl>
                   	<dl>
                    <dt>
                        <button class="like-button <%= check > 0 ? "active" : "" %>">
                            <span id="likeText"><%= check > 0 ? "좋아요 ♥" : "좋아요 ♡" %></span>
                            <span id="likeCount"><%= totalLikes %></span>
                        </button>
                    </dt>
                    </dl>

                  <% if (board.getUS_EMAIL().equals(email)){ %>
				    <dl>
				    	<dt>
					        <!-- 게시물 삭제 버튼 -->
					        <form action="deleteBoard.do" method="post" onsubmit="return confirmDelete();">
					            <input type="hidden" name="No" value="<%= board.getSH_NO() %>">
					            <dt><button type="submit" class="delete">삭제</button></dt>
					        </form>
				        </dt>
				    </dl>
				    <dl>
				    	<dt><button class="modify"><a href="updateBoardForm.jsp?No=<%= board.getSH_NO() %>">수정</a></button></dt>
				    </dl>
				<% } %>

				    

                </div>
                <div class="cont">
                	<% 
       				 String imgPath = board.getSH_FILENAME(); // DB에 저장된 이미지 경로
        			 if (imgPath != null && !imgPath.isEmpty()) { 
					%>
					<!-- 이미지 표시 -->
				        <img src="../../upload/<%= board.getSH_FILENAME() %>" alt="게시글 이미지" style="max-width:100%;">	<br>
				        <%=board.getSH_CONTENT() %>
				    <% } else { %>
                    	<%=board.getSH_CONTENT() %>
				    <% } %>
                </div>
            </div>
            
            <div class="bt_wrap">
                <a href="crList.jsp?pageNum=<%=pageNum%>" class="on">목록</a>
             
            </div>
   
<div class="comment-wrap">
   		<h3>댓글 작성</h3>
	
	<form action="insertComment.do" method="post">
	    <input type="hidden" name="boardId" value="<%= board.getSH_NO()%>">
	    <input type="hidden" name="parentCommentId" value="">
	    
	    <div class="form-group">
	        <label for="writer" class="nickname">닉네임: <%= nick %></label> <!-- 사용자 아이디 받기 -->
	        <input type="hidden" class="form-control" id="writer" name="writer" value="<%= nick %>" required>
	        <input type="hidden" class="form-control" id="us_email" name="us_email" value="<%= email %>" required>
	    </div>
	    
	    <div class="form-group">
	        <label for="content" class="content">내용:</label>
	        <br>
	        <br>
	        <textarea class="form-control" id="content" name="content" required></textarea>
	    </div>
	    <button type="submit" class="btn btn-primary com">댓글 작성</button>
	</form>         
     <br>
     <br>
     
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
            <input type="hidden" name="boardId" value="<%= board.getSH_NO() %>">
            <button type="submit" class="btn btn-sm btn-danger com">댓글 삭제</button>
        </form>
        <% } %>
        <br>
        <%= comment.getContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %>
    
        <!-- 답글 작성 폼 (기본적으로 숨김) -->
         <% if (comment.getParentCommentId() == null) { %>
         <form action="insertComment.do" method="post" style="display:none;" id="replyForm<%= comment.getCommentId() %>">
            <input type="hidden" name="boardId" value="<%= board.getSH_NO() %>">
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
    <jsp:include page="${contextPath }/footer/footer.jsp" />
        
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
 
    // 좋아요 추가, 카운트
    const likeButton = document.querySelector('.like-button');
    const likeCountDisplay = document.getElementById('likeCount');
    const likeTextDisplay = document.getElementById('likeText');

    likeButton.addEventListener('click', function() {
        const isActive = this.classList.toggle('active'); // 버튼의 상태 토글
        const xhr = new XMLHttpRequest();
        const url = isActive ? "../../LikeInsertController" : "../../LikeDeleteController";

        xhr.open("POST", url, true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.onload = function() {
            if (xhr.status === 200) {
                // 성공 시 총 좋아요 수 업데이트
                const currentLikes = parseInt(likeCountDisplay.textContent);
                likeCountDisplay.textContent = isActive ? currentLikes + 1 : currentLikes - 1; // 화면에 좋아요 수 업데이트

                // 버튼 텍스트 변경
                if (isActive) {
                    likeTextDisplay.textContent = "좋아요 ♥"; // 좋아요 추가
                } else {
                    likeTextDisplay.textContent = "좋아요 ♡"; // 좋아요 제거
                } 
            } else {
                console.log("요청에 실패했습니다.");
            }
        };

        // 서버로 보낼 데이터 설정
        xhr.send("email=" + encodeURIComponent("<%=email%>") + "&SH_NO=" + encodeURIComponent("<%=board.getSH_NO()%>") + "&No=" + encodeURIComponent("<%= idx %>") );
    });    
    
    
    
</script>

</body>
</html>