package com.smhrd.conrtroller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smhrd.model.boardDAO;

/**
 * Servlet implementation class BoardDelete
 */
@WebServlet("/board/delete")
public class BoardDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		boardDAO dao = new boardDAO();
		int res = dao.deleteBoard(idx);
		
		PrintWriter out = response.getWriter();
		out.print(res);
	}

}
