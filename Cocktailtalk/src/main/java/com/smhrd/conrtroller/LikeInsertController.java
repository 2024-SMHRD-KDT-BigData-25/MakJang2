package com.smhrd.conrtroller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.model.MemberLikeDAO;
import com.smhrd.model.TB_SHOW_LIKES;


@WebServlet("/LikeInsertController")
public class LikeInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// int SH_NO = Integer.parseInt(request.getParameter("SH_NO"));
		String email = request.getParameter("email");
		int num = 1;
		TB_SHOW_LIKES insertlike = new TB_SHOW_LIKES(num,email);
		MemberLikeDAO dao = new MemberLikeDAO();
		int res = dao.insertlike(insertlike);
	
		
		
		if(res>0) {
			System.out.println("성공!");
			RequestDispatcher rd = request.getRequestDispatcher("main.jsp");
			rd.forward(request, response);

		} else {
			System.out.println("실패!");
			RequestDispatcher rd = request.getRequestDispatcher("main.jsp");
			rd.forward(request, response);
		}
		
	}


}
