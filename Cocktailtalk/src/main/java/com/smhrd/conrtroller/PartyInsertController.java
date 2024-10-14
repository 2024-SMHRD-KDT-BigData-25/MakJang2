package com.smhrd.conrtroller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.model.BoardDAO;
import com.smhrd.model.MemberPartyDAO;
import com.smhrd.model.MyBoard;
import com.smhrd.model.TB_SHOW_LIKES;


@WebServlet("/PartyInsertController")
public class PartyInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		int idx = Integer.parseInt(request.getParameter("ME_NO"));
		BoardDAO dao = new BoardDAO();
		MyBoard board = dao.getmeBoard(idx);
		int ME_NO = board.getME_NO();
		TB_SHOW_LIKES insertparty = new TB_SHOW_LIKES(ME_NO,email);
		MemberPartyDAO daoo = new MemberPartyDAO();
		int res = daoo.insertparty(insertparty);
	
		
		
		if(res>0) {
			System.out.println("성공!");
			RequestDispatcher rd = request.getRequestDispatcher("Board/meeting_BBS/meetingview.jsp");
			rd.forward(request, response);

		} else {
			System.out.println("실패!");
			RequestDispatcher rd = request.getRequestDispatcher("Board/meeting_BBS/meetingview.jsp");
			rd.forward(request, response);
		}
		
	}


}
