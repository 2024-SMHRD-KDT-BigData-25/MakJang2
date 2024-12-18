<%@page import="com.smhrd.model.MemberLikeDAO"%>
<%@page import="com.smhrd.model.MyMember"%>
<%@page import="com.smhrd.model.MemberDAO"%>
<%@page import="com.smhrd.model.CommentDAO"%>
<%@page import="com.smhrd.model.MyBoard"%>
<%@page import="java.util.List"%>
<%@page import="com.smhrd.model.BoardDAO"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>인증 게시판</title>
    <link rel="stylesheet" href="../css/css.css">
</head>
<body>

    <%
		BoardDAO dao = new BoardDAO();
    	CommentDAO commentDao = new CommentDAO();
		int pageSize = 10; // 한 페이지에 보여줄 게시글 수
		int pageBlock = 5; // 하단에 표시할 페이지 블록 수
		
		// 현재 페이지 번호
		String pageNumStr = request.getParameter("pageNum");
		int pageNum = (pageNumStr == null) ? 1 : Integer.parseInt(pageNumStr);
	
		// 검색 조건 처리
		String searchType = request.getParameter("searchType");
		String searchKeyword = request.getParameter("searchKeyword");
		
		// 검색어가 없을 경우 기본 값 설정
		boolean isSearch = (searchKeyword != null && !searchKeyword.trim().isEmpty());
		
		// 전체 게시글 수
		int totalCount;
		if (isSearch) {
		    totalCount = dao.getSearchShBoardCount(searchType, searchKeyword); // 검색어에 맞는 게시글 수 조회
		} else {
		    totalCount = dao.getshBoardCount(); // 전체 게시글 수 조회
		}
		
		// 전체 페이지 수 계산
		int pageCount = (totalCount / pageSize) + ((totalCount % pageSize == 0) ? 0 : 1);
		
		// 페이지 블록 계산
		int startPage = ((pageNum - 1) / pageBlock) * pageBlock + 1;
		int endPage = Math.min(startPage + pageBlock - 1, pageCount);
		
		// 데이터 조회를 위한 startRow와 endRow 계산
		int startRow = (pageNum - 1) * pageSize + 1;
		int endRow = pageNum * pageSize;
		
		// 해당 페이지의 데이터 가져오기
		List<MyBoard> list;
		if (isSearch) {
		    list = dao.searchShBoardListPaging(searchType, searchKeyword, startRow, endRow); // 검색된 게시글 가져오기
		} else {
		    list = dao.getshBoardListPaging(startRow, endRow); // 전체 게시글 가져오기
		}
		
	    // 게시물 번호 계산 (페이지 내에서 역순으로 번호를 표시)
	    int listNo = totalCount - (pageNum - 1) * pageSize;
		
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
%>

<%
    // 세션에 저장된 에러 메시지를 확인
    String errorMessage = (String) session.getAttribute("errorMessage");
    if (errorMessage != null) {
%>
    <!-- 에러 메시지 출력 -->
    <script>
        alert("<%= errorMessage %>");
    </script>

<%
        // 메시지를 한 번 출력한 후 세션에서 제거
        session.removeAttribute("errorMessage");
    }
%>	

 	<jsp:include page="${contextPath }/header/header.jsp" />
        <div class="board_wrap">
            <div class="board_title">
                <Strong><a href="crList.jsp">인증 게시판</a></Strong>
                <p>취향이 맞는 다른 사람들과 함께 마시기 원한다면 방을 만들어보세요!</p>
                <!-- 검색 폼 추가 -->
                <div class="search-bar">
                    <form action="crList.jsp" method="get">
                        <select name="searchType" class="custom-select">
                            <option value="title" <%= "title".equals(searchType) ? "selected" : "" %>>제목</option>
                            <option value="writer" <%= "writer".equals(searchType) ? "selected" : "" %>>작성자</option>
                        </select>
                        <input type="text" name="searchKeyword" id="searchInput" value="<%= (searchKeyword != null) ? searchKeyword : "" %>" placeholder="검색어를 입력하세요">
                        <button type="submit" id="searchButton">검색</button>
                    </form>
                </div>
            </div>

            <div class="board_list_wrap">
                <div class="board_list">
                    <div class="top">
                        <div class="num">번호</div>
                        <div class="title">제목</div>
                        <div class="writer">글쓴이</div>
                        <div class="date">작성일</div>
                        <div class="count">조회</div>
                        <div class="like">좋아요</div>
                    </div>
                    
                    <!-- DB에서 게시글 목록 출력 -->
                    
                    <%for(MyBoard b:list){ 
                    	 int commentCount = commentDao.getshCommentCountByBoardId(b.getSH_NO());  // 댓글 개수 조회
                     	// 참여인원 확인
                    	 MemberLikeDAO daoo = new MemberLikeDAO();
                    	 int totallike = daoo.totallike(b.getSH_NO());	
                    %>
                   
                    <div>
                        <div class="num"><%=listNo--%></div>
                        <div class="title"><a href="viewBoard.do?No=<%=b.getSH_NO()%>&pageNum=<%=pageNum%>"><%= b.getSH_TITLE().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %>
                        <%if(commentCount!=0){ %><span style="color:gray;">[<%= commentCount %>]</span> <!-- 댓글 개수 표시 --><%} %></a> </div>
                        <div class="writer"><%= b.getUS_NICK()%></div>
                        <div class="date"><%= b.getSH_WRITEDATE().substring(0,11) %></div>
                        <div class="count"><%= b.getSH_HIT() %></div>
                        <div class="like"><%= totallike %></div>
                    </div>
                    <% } %>
                    
                </div>

                <!-- 페이지 번호 표시 -->
				<div class="board_page">
					<% if (startPage > 1) { %>
					<a href="crList.jsp?pageNum=<%= startPage - 1 %>&searchType=<%= searchType %>&searchKeyword=<%= searchKeyword %>" class="bt pre" ><<</a>
					<% } %>
						
					<% for (int i = startPage; i <= endPage; i++) { %>
					<a href="crList.jsp?pageNum=<%= i %>&searchType=<%= searchType %>&searchKeyword=<%= searchKeyword %>" <%= (i == pageNum) ? "class='num on'" : "class='num'" %> ><%= i %></a>
					<% } %>
						
					<% if (endPage < pageCount) { %>
					<a href="crList.jsp?pageNum=<%= endPage + 1 %>&searchType=<%= searchType %>&searchKeyword=<%= searchKeyword %>" class="bt last">>></a>
					<% } %>
				</div>     
                    <div class="bt_wrap">
                        <a href="write.jsp" class="on">등록</a>
                    </div>
                </div>
            </div>
        </div>
        
       <jsp:include page="${contextPath }/footer/footer.jsp" />        
     
    
    
</body>
</html>
