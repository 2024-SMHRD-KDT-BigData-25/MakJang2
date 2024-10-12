package com.smhrd.conrtroller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.model.MemberDAO;

@WebServlet("/DeleteController")
public class MEM_DeleteController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String US_EMAIL = request.getParameter("US_EMAIL");

        MemberDAO dao = new MemberDAO();
        int res = dao.delete(US_EMAIL);
        
        if (res > 0) {
            // 삭제 성공 시 로그인 페이지로 리다이렉트
            response.sendRedirect("member/login.jsp");
        } else {
            // 실패 시 에러 페이지로 리다이렉트
            response.sendRedirect("member/fail.jsp");
        }
    }
}
