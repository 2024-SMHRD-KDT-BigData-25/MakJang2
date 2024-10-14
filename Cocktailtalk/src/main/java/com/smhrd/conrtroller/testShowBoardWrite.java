package com.smhrd.conrtroller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.smhrd.model.BoardDAO;
import com.smhrd.model.MyBoard;

@WebServlet("/Board/show_BBS/Write")
public class testShowBoardWrite extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		int maxSize = 5 * 1024 * 1024; //5MB
		
		//파일저장경로(절대경로)
		//ServletContext context = request.getServletContext();
		String uploadPath = "//C:/Users/smart/git/MakJang2/Cocktailtalk/src/main/webapp/upload";
		System.out.println("uploadPath는? "+ uploadPath);
		// 디렉토리가 존재하지 않으면 생성
		//		File uploadDir = new File(uploadPath);
		//		if (!uploadDir.exists()) {
		//		    uploadDir.mkdir();
		//		}
		
		MultipartRequest multi = new MultipartRequest(request,uploadPath,maxSize,
				"UTF-8", new DefaultFileRenamePolicy());		
		


		String Title = multi.getParameter("meTitle");
		String Content =multi.getParameter("meContent");
		String usEmail = multi.getParameter("usEmail");	
		// 이미지
		String img = multi.getFilesystemName("image");


		// DB에 저장할 파일 경로 (서버의 상대 경로)
        System.out.println("img는? "+ img); 
		MyBoard crBoard = new MyBoard(Title,Content,img,usEmail);
		
		BoardDAO dao = new BoardDAO();
		int res = dao.writeshimgBoard(crBoard);
		
		if(res>0) {
			response.sendRedirect("crList.jsp");
		}else {
			response.sendRedirect("write.jsp");
		}
		
	}


}
