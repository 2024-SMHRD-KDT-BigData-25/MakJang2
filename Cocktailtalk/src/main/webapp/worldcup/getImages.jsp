<%@page import="com.smhrd.model.MyBoard"%>
<%@page import="com.smhrd.model.BoardDAO"%>
<%@ page contentType="application/json; charset=UTF-8" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.google.gson.Gson"%>

<%

	BoardDAO dao = new BoardDAO();
	List<MyBoard> allImages = dao.getimgList();
    try {
        File uploadDir = new File("C:\\Users\\smart\\git\\MakJang2\\Cocktailtalk\\src\\main\\webapp\\upload");
        File[] files = uploadDir.listFiles();
        List<Map<String, String>> images = new ArrayList<>();
        
        if (files != null) {
            for (MyBoard m : allImages) {

                	Map<String, String> imgMap = new HashMap<>();
                    String imgName = m.getSH_FILENAME();
                    imgMap.put("src", request.getContextPath() + "/upload/" + imgName); // 이미지
                    
                    imgMap.put("name", imgName.substring(0, imgName.lastIndexOf("."))); // 확장자 제외한 이름
                    images.add(imgMap);
               if (images.size() == 8){
                   break;
                }
                   }
                }
            
        

        // 이미지 목록을 JSON 형식으로 변환
        String json = new Gson().toJson(Collections.singletonMap("images", images));
        out.print(json); // JSON 응답 출력
    } catch (Exception e) {
        out.print("{\"error\": \"" + e.getMessage() + "\"}"); // 오류 메시지 출력
        e.printStackTrace(); // 서버 로그에 오류 출력
    }
%>
