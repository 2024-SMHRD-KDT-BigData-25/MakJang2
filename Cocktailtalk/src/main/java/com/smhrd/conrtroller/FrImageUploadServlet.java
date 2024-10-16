package com.smhrd.conrtroller;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/Board/free_BBS/uploadImage")
@MultipartConfig
public class FrImageUploadServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");
        
        // 클라이언트에서 전송된 이미지 파일을 처리
        Part filePart = request.getPart("image"); // "image"는 클라이언트에서 보내온 필드명
        String fileName = getFileName(filePart);
        String uploadPath = "//C:/Users/smhrd/git/MakJang2/Cocktailtalk/src/main/webapp/upload";

        // 업로드 디렉토리가 없으면 생성
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        // 파일을 업로드 디렉토리에 저장
        filePart.write(uploadPath + File.separator + fileName);

        // 클라이언트에게 이미지 URL 반환
        String imageUrl = request.getContextPath() + "/upload/" + fileName;
        response.setContentType("application/json");
        response.getWriter().print("{\"url\": \"" + imageUrl + "\"}");
    }

    // 클라이언트에서 보낸 파일의 이름을 가져오는 메서드
    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        for (String cd : contentDisposition.split(";")) {
            if (cd.trim().startsWith("filename")) {
                return cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}

