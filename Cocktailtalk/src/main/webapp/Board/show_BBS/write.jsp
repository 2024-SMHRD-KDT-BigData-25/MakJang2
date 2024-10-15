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

<!-- Quill CSS 및 JS CDN 추가 -->
<link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
<script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
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
    <form class="board_write" action="meWrite" method="post" onsubmit="return submitForm();">
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
               </div>
                <!-- Quill 에디터가 적용될 영역 -->
                <div class="cont">
                    <div id="editor-container" style="height: 200px;"></div>
                </div>
            </div>
            <div class="bt_wrap">
                <button type="submit"><a class="on">등록</a></button>
                <a href="crList.jsp">취소</a>
            </div>
        </div>
    </div>
    
    <!-- Quill 데이터가 저장될 히든 필드 -->
    <input type="hidden" name="meContent" id="meContent">
    
</form>
    <jsp:include page="${contextPath }/footer/footer.jsp" />
    
<script>
    // Quill 에디터 초기화
    var quill = new Quill('#editor-container', {
        theme: 'snow',
        modules: {
            toolbar: {
                container: [
                    [{ 'header': [1, 2, false] }],
                    ['bold', 'italic', 'underline'],
                    ['image']  // 이미지 버튼 추가
                ],
                handlers: {
                    'image': imageHandler
                }
            }
        }
    });

    // 이미지 삽입 핸들러 함수
    function imageHandler() {
        var input = document.createElement('input');
        input.setAttribute('type', 'file');
        input.setAttribute('accept', 'image/*');
        input.click();

        input.onchange = () => {
            var file = input.files[0];

            if (file) {
                var formData = new FormData();
                formData.append('image', file);

                // 서버에 이미지 업로드 요청
                fetch('uploadImage', {
                    method: 'POST',
                    body: formData
                })
                .then(response => response.json())
                .then(result => {
                    var range = quill.getSelection(); // 현재 커서 위치 가져오기
                    quill.insertEmbed(range.index, 'image', result.url); // 이미지 URL 삽입
                })
                .catch(error => {
                    console.error('Error:', error);
                });
            }
        };
    }

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