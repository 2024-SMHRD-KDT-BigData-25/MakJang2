package com.smhrd.conrtroller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.smhrd.model.BoardDAO;
import com.smhrd.model.MyBoard;

/**
 * Servlet implementation class BoardList
 */
@WebServlet("/board")
public class BoardList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		BoardDAO dao = new BoardDAO();
		List<MyBoard> list = dao.getimgList();
		// JavaObject => JSONObject(json 형식의 객체구조) => GSON
		Gson gson = new Gson();
		String json = gson.toJson(list);
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		// 텍스트 출력(out / Server -> Client) 스트림 => PrintWriter
		PrintWriter out = response.getWriter();
		out.print(json);
	}

}
