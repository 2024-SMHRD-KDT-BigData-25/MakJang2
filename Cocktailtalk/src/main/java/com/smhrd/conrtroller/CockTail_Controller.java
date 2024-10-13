package com.smhrd.conrtroller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.smhrd.model.CockDAO;
import com.smhrd.model.Cocktail_Info;


@WebServlet("/Cockform")
public class CockTail_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		//Cocktail_Info, CockDAO, reccommend.jsp, CockinfoMapper,
		//MemberMapper, CockTail_Controller
		CockDAO dao = new CockDAO();
		List<Cocktail_Info> join = dao.Cockinfo();
		request.setCharacterEncoding("UTF-8");
		
		
		PrintWriter out = response.getWriter();
		out.print(join);
		
		
		
		
	}

}
