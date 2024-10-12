<%@page contentType="application/json; charset=UTF-8" %>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.smhrd.model.BoardDAO"%>
<%@page import="com.smhrd.model.MyBoard"%>
<%@page import="java.util.*"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.IOException"%>
<%@page import="java.util.stream.Collectors"%>

<%
// 요청 본문에서 JSON 데이터 읽기
    String jsonData = request.getReader().lines().collect(Collectors.joining());
    Map<String, Object> data = new Gson().fromJson(jsonData, Map.class);
    List<String> selectedImages = (List<String>) data.get("selectedImages");

    // 다음 라운드 이미지를 결정하는 로직
    List<MyBoard> allImages = new ArrayList<>();
    BoardDAO dao = new BoardDAO();
    allImages = dao.getimgList(); // 모든 이미지를 가져옴

    List<Map<String, String>> newImages = new ArrayList<>();
    // 선택된 이미지를 제외한 나머지 이미지로 새 리스트 만들기
    for (MyBoard board : allImages) {
        String imgName = board.getImg();
        if (!selectedImages.contains(imgName)) {
            Map<String, String> imgMap = new HashMap<>();
            imgMap.put("src", "worldcup_image/" + imgName);
            imgMap.put("name", imgName);
            newImages.add(imgMap);
        }
    }

    // 다음 라운드에 사용할 이미지를 JSON으로 반환
    String jsonResponse = new Gson().toJson(Collections.singletonMap("images", newImages));
    out.print(jsonResponse);
%>
