package com.smhrd.conrtroller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smhrd.model.Cocktail_Info;
import com.smhrd.model.MemberDAO;

@WebServlet("/BM_SelectController")
public class BM_SelectController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String US_EMAIL = request.getParameter("US_EMAIL");
        
        // MemberDAO를 사용하여 찜한 칵테일 목록을 가져옴
        MemberDAO dao = new MemberDAO();
        List<Cocktail_Info> bookmarkList = dao.selectBookmarkByEmail(US_EMAIL);
        
        response.setContentType("text/html; charset=UTF-8");
        response.getWriter().println("<html><body>");
        
        if (bookmarkList != null && !bookmarkList.isEmpty()) {
            response.getWriter().println("<h2>찜한 칵테일 목록</h2>");
            for (Cocktail_Info cocktail : bookmarkList) {
                response.getWriter().println("<div>");
                response.getWriter().println("<h3>" + cocktail.getCOCKTAIL_NAME() + "</h3>");
                response.getWriter().println("<img src='" + cocktail.getCOCKTAIL_IMG() + "' alt='" + cocktail.getCOCKTAIL_NAME() + "' />");
                response.getWriter().println("</div>");
            }
        } else {
            response.getWriter().println("<p>찜한 칵테일이 없습니다.</p>");
        }
        
        response.getWriter().println("</body></html>");
    }
}
