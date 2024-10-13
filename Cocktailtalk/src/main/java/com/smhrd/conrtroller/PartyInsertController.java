package com.smhrd.conrtroller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.model.MemberPartyDAO;
import com.smhrd.model.TB_SHOW_LIKES;


@WebServlet("/PartyInsertController")
public class PartyInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// int SH_NO = Integer.parseInt(request.getParameter("SH_NO"));
		String email = request.getParameter("email");
		int num = 1;
		TB_SHOW_LIKES insertparty = new TB_SHOW_LIKES(num,email);
		MemberPartyDAO dao = new MemberPartyDAO();
		int res = dao.insertparty(insertparty);
	
		
		
		if(res>0) {
			System.out.println("성공!");
			RequestDispatcher rd = request.getRequestDispatcher("Board/moim/jsp/view2.jsp");
			rd.forward(request, response);

		} else {
			System.out.println("실패!");
			RequestDispatcher rd = request.getRequestDispatcher("Board/moim/jsp/view2.jsp");
			rd.forward(request, response);
		}
		
	}


}
