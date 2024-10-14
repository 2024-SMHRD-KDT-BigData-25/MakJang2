<%@page import="com.smhrd.model.MyMember"%>
<%@page import="com.smhrd.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>인증 게시글 작성</title>
<link rel="stylesheet" href="../css/css.css">
</head>
<body>
<%
    response.setContentType("text/html; charset=UTF-8");
    response.setCharacterEncoding("UTF-8");

    // 현재 세션을 가져옴
    HttpSession userSession = request.getSession();
    String email = (String) userSession.getAttribute("EMAIL"); // 이메일을 email 변수에 저장

    // 로그인 정보가 없는 경우 오류 페이지로 리다이렉트
    if (email == null) {
        response.sendRedirect("fail.jsp");
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
        response.sendRedirect("fail.jsp");
        return;
    }
%>
    <form class="board_write" action="Write" method="post" enctype="multipart/form-data" onsubmit="return submitForm();">
    <div class="board_wrap">
        <div class="board_title">
            <Strong>인증 게시글 작성</Strong>
            <p>취향이 맞는 다른 사람들과 함께 마시기 원한다면 방을 만들어보세요!</p>
        </div>
        <div class="board_write_wrap">
            <div class="board_write">
                <div class="title">
                    <dl>
                        <dt>제목</dt>
                        <dd>
                            <input type="text" name="meTitle" id="me_title" placeholder="제목 입력" required>
                        </dd>
                    </dl>
                </div>
                <div class="info">
                    <dl>
                        <dt><%= nick %></dt>
                        <dd>
                            <input type="hidden" name="usEmail" value="<%=email%>">
                        </dd>
                    </dl>
                    <dl>
                        <dt>이미지</dt>
                        <dd>
                            <input type="file" name="image" accept="image/*" multiple="multiple" required> <!-- 이미지 업로드 -->
                        </dd>                   
                    </dl>
                </div>
                <div class="cont">
                    <textarea name="meContent" id="meContent" placeholder="내용 입력"></textarea>
                </div>
            </div>
            <div class="bt_wrap">
                <button type="submit"><a class="on">등록</a></button>
                <a href="crList.jsp">취소</a>
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