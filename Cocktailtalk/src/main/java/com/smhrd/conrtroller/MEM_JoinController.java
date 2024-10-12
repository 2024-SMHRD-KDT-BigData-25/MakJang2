package com.smhrd.conrtroller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smhrd.model.MyMember;
import com.smhrd.model.MemberDAO;

@WebServlet("/member/JoinController")
public class MEM_JoinController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    try {
	        request.setCharacterEncoding("UTF-8");

	        String US_EMAIL = request.getParameter("US_EMAIL");
	        String US_NAME = request.getParameter("US_NAME");
	        String US_NICK = request.getParameter("US_NICK");

	        MemberDAO dao = new MemberDAO();

	        // 중복 체크
	        if (dao.isDuplicateEmail(US_EMAIL)) {
	            // 데이터가 이미 존재하는 경우 메인 페이지로 리다이렉트
	            response.sendRedirect("main.jsp");
	            return;
	        }

	        MyMember joinMember = new MyMember(US_EMAIL, US_NAME, US_NICK);
	        int res = dao.join(joinMember);
	        
	        if (res > 0) {
	            response.sendRedirect("/member/main.jsp");
	        } else {
	            response.sendRedirect("/member/logincheck.jsp");
	        }
	    } catch (Exception e) {
	        e.printStackTrace(); // 에러 로그 기록
	        response.sendRedirect("fail.jsp"); // 에러 페이지로 리다이렉트
	    }
	}

}