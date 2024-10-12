package com.smhrd.conrtroller.PartyController;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smhrd.model.MemberPartyDAO;
import com.smhrd.model.TB_SHOW_LIKES;


@WebServlet("/PartyDeleteController")
public class PartyDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int SH_NO = 1 ;
		String US_EMAIL = request.getParameter("email");
		MemberPartyDAO dao = new MemberPartyDAO();
		TB_SHOW_LIKES deleteLikes = new TB_SHOW_LIKES(SH_NO,US_EMAIL);
		int res = dao.deletelike(deleteLikes);
		response.sendRedirect("main.jsp");
	}

}
