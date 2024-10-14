package com.smhrd.conrtroller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smhrd.model.BoardDAO;
import com.smhrd.model.MemberLikeDAO;
import com.smhrd.model.MyBoard;
import com.smhrd.model.TB_SHOW_LIKES;


@WebServlet("/LikeDeleteController")
public class LikeDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		int idx = Integer.parseInt(request.getParameter("No"));
		BoardDAO dao = new BoardDAO();
		MyBoard board = dao.getmeBoard(idx);
		MemberLikeDAO daoo = new MemberLikeDAO();
		TB_SHOW_LIKES deleteLikes = new TB_SHOW_LIKES(idx,email);
		int res = daoo.deletelike(deleteLikes);
		if(res>0) {
			System.out.println("좋아요 취소 성공!");
			RequestDispatcher rd = request.getRequestDispatcher("Board/show_BBS/meetingview.jsp");
			rd.forward(request, response);

		} else {
			System.out.println("좋아요 취소 실패!");
			RequestDispatcher rd = request.getRequestDispatcher("Board/show_BBS/meetingview.jsp");
			rd.forward(request, response);
		}
	}

}
