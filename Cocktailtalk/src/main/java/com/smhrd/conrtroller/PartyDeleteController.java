package com.smhrd.conrtroller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smhrd.model.BoardDAO;
import com.smhrd.model.MemberPartyDAO;
import com.smhrd.model.MyBoard;
import com.smhrd.model.TB_SHOW_LIKES;


@WebServlet("/PartyDeleteController")
public class PartyDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		int idx = Integer.parseInt(request.getParameter("ME_NO"));
		BoardDAO dao = new BoardDAO();
		MyBoard board = dao.getmeBoard(idx);
		int ME_NO = board.getME_NO();
		MemberPartyDAO daoo = new MemberPartyDAO();
		TB_SHOW_LIKES deleteparty = new TB_SHOW_LIKES(ME_NO,email);
		int res = daoo.deleteparty(deleteparty);
		response.sendRedirect("Board/moim/jsp/view2.jsp");
	}

}
