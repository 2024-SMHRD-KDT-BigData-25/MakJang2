package com.smhrd.conrtroller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smhrd.model.BoardDAO;
import com.smhrd.model.MyBoard;

@WebServlet("/Board/create_BBS/meWrite")
public class CrBoardWrite extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String Title = request.getParameter("meTitle");
		String Content =request.getParameter("meContent");
		String usEmail = request.getParameter("usEmail");	

		MyBoard crBoard = new MyBoard(Title,Content,usEmail);
		
		BoardDAO dao = new BoardDAO();
		int res = dao.writecrBoard(crBoard);
	
		if(res>0) {
			response.sendRedirect("crList.jsp");
		}else {
			response.sendRedirect("write.jsp");
		}
		
	}


}
