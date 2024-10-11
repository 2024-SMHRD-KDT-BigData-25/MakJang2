package com.smhrd.conrtroller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smhrd.model.MemberDAO;

@WebServlet("/BM_DeleteController")
public class BM_DeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		String US_EMAIL = request.getParameter("US_EMAIL");
		int COCKTAIL_NO = Integer.parseInt(request.getParameter("COCKTAIL_NO"));
		
		MemberDAO dao = new MemberDAO();
		int res = dao.deleteBookmark(COCKTAIL_NO);
		
		response.setContentType("text/html; charset=UTF-8");
        
        response.getWriter().println("<html><body>");
        if(res > 0) {
            response.getWriter().println("<script>alert('찜 목록에서 삭제되었습니다!');</script>");
        } else {
            response.getWriter().println("<script>alert('다시 시도해주세요!');</script>");
        }
        response.getWriter().println("<script>window.history.back();</script>"); // 이전 페이지로 돌아가기
        response.getWriter().println("</body></html>");
		
	}

}
