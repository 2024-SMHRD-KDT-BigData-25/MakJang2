package com.smhrd.conrtroller;

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

/**
 * Servlet implementation class BoardWhite
 */
@WebServlet("/write")
public class BoardWhite extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// MultipartRequest => COS
		
		// 파일저장경로
		ServletContext context =  request.getServletContext();
		String uploadpath = context.getRealPath("upload");
		
		int maxsize = 500*1024*1024; // 5MB
		//(request, 파일저장경로, 최대파일크기, 인코딩타입, 파일이름생성규칙)
		MultipartRequest multi = new MultipartRequest(request,uploadpath,maxsize,"UTF-8",new DefaultFileRenamePolicy());
		
		String title = multi.getParameter("title");
		String content = multi.getParameter("content");
		String writer = multi.getParameter("writer");
		String img = multi.getFilesystemName("img");
		
		MyBoard uploadBoard = new MyBoard(title,content,writer,img);
		
		BoardDAO dao = new BoardDAO();
		int res = dao.writeimgBoard(uploadBoard);
		
		if(res>0) {
			response.sendRedirect("boardlist.jsp");
		}else {
			response.sendRedirect("boardform.jsp");
		}
		
	}

}
