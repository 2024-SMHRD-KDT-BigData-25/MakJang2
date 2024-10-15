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
	<jsp:include page="${contextPath }/header/header.jsp" />
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
                        <dt>작성자</dt>
                        <dd><%= nick %></dd>
                        <dd>
                            <input type="hidden" name="usEmail" value="<%=email%>">
                        </dd>
                    </dl>
                    <dl>
                        <dt>이미지</dt>
                        <dd>
                            <form action="#" method="post" enctype="multipart/form-data"> <!-- 이미지 파일 데이터를 받아야 하기 때문에 enctype을 "multipart/form-data"로 설정 -->
                                <input type="file" name="image" accept="image/*" multiple required> <!-- accept 속성을 "image/*" 로 설정하면 이미지 파일만 선택, 여러개 파일 업로드 가능-->
                            </form>
                        </dd>
                    </dl>
                </div>
                <div class="cont">
                    <textarea placeholder="내용 입력">

                    </textarea>
                </div>
            </div>
            
            <div class="bt_wrap">
                <a href="view.jsp" class="on">등록</a>
                <a href="list.jsp">취소</a>
            </div>
        </div>
    </div>
    
</form>
    <jsp:include page="${contextPath }/footer/footer.jsp" />
    
<script>


    // 폼 제출 시 Quill 에디터에서 작성된 데이터를 hidden input에 저장
    function submitForm() {
        var content = document.querySelector('input[name=meContent]');
        content.value = quill.root.innerHTML;  // Quill 에디터의 HTML 내용을 hidden input에 저장

        // 폼 유효성 검사
        var title = document.getElementById("me_title").value;
        var email = document.getElementsByName("usEmail")[0].value;

        console.log("Title: ", title);
        console.log("Email: ", email);
        console.log("Content: ", quill.getText());

        // 제목 입력 여부 확인
        if (title.trim() === "") {  // trim()으로 공백을 제거하고 검사
            alert("제목을 입력해 주세요.");
            return false;
        }

        // 이메일 입력 여부 확인
        if (email.trim() === "") {  // 이메일이 공백인지 확인
            alert("글쓴이 이메일을 입력해 주세요.");
            return false;
        }


        // Quill 에디터의 내용 확인
        if (quill.getText().trim().length === 0) {  // Quill의 텍스트가 비어 있는지 확인
            alert("내용을 입력해 주세요.");
            return false;
        }

        return true;  // 유효성 검사를 모두 통과했으면 true 반환
    }

</script>

</body>
</html>