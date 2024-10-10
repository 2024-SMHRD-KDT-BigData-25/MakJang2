<%@page contentType="application/json; charset=UTF-8" %>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.smhrd.model.boardDAO"%>
<%@page import="com.smhrd.model.myboard"%>
<%@page import="java.util.*"%>
<%@page import="java.io.IOException"%>

<%
    boardDAO dao = new boardDAO();
    List<myboard> list = dao.getList(); // DB에서 이미지 목록 가져오기
    
    List<Map<String, String>> images = new ArrayList<>(); // 이미지를 담을 리스트
    for (myboard board : list) {
        String imgName = board.getImg(); // 전체 이미지 이름
        String nameWithoutExtension = imgName.substring(0, imgName.lastIndexOf(".")); // 확장자 제외한 이름
        
        Map<String, String> imgMap = new HashMap<>();
        imgMap.put("src", "worldcup_image/" + imgName); // 이미지 경로
        imgMap.put("name", nameWithoutExtension); // 확장자를 제외한 이미지 이름

        images.add(imgMap);
    }

    // 이미지 목록을 JSON 형식으로 변환
    String json = new Gson().toJson(Collections.singletonMap("images", images));
    out.print(json); // JSON 응답 출력
%>
