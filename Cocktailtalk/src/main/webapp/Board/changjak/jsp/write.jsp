<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>창작 게시글 작성</title>
    <link rel="stylesheet" href="../../css/css.css">
</head>
<body>
	<jsp:include page="${contextPath }/header/header.jsp" />
    <div class="board_wrap">
        <div class="board_title">
            <Strong>창작 게시글 작성</Strong>
            <p>취향이 맞는 다른 사람들과 함께 마시기 원한다면 방을 만들어보세요!</p>
        </div>
        <div class="board_write_wrap">
            <div class="board_write">
                <div class="title">
                    <dl>
                        <dt>제목</dt>
                        <dd>
                            <input type="text" placeholder="제목 입력">
                        </dd>
                    </dl>
                </div>
                <div class="info">
                    <dl>
                        <dt>글쓴이</dt>
                        <dd>
                            <input type="text" placeholder="글쓴이 입력">
                        </dd>
                    </dl>
                    <dl>
                        <dt>이미지</dt>
                        <dd>
                            <form action="#" method="post" enctype="multipart/form-data">
                                <input type="file" name="image" accept="image/*" multiple required> <!-- 여러개 파일 업로드 가능-->
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
    <jsp:include page="${contextPath }/footer/footer.jsp" />
</body>
</html>