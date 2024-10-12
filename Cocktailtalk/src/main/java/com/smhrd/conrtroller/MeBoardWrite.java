package com.smhrd.conrtroller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smhrd.model.BoardDAO;
import com.smhrd.model.MyBoard;

@WebServlet("/meeting_BBS/meWrite")
public class MeBoardWrite extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String meTitle = request.getParameter("meTitle");
		String meContent =request.getParameter("meContent");
		String usEmail = request.getParameter("usEmail");	
		int mePeople = Integer.parseInt(request.getParameter("mePeople"));	

		MyBoard meBoard = new MyBoard(meTitle,meContent,usEmail,mePeople);
		
		BoardDAO dao = new BoardDAO();
		int res = dao.writeBoard(meBoard);
	
		if(res>0) {
			response.sendRedirect("meList.jsp");
		}else {
			response.sendRedirect("write.jsp");
		}
		
	}


}
