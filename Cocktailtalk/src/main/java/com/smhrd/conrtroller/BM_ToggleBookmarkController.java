package com.smhrd.conrtroller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smhrd.model.Bookmark;
import com.smhrd.model.Cocktail_Info;
import com.smhrd.model.MemberDAO;

@WebServlet("/BM_ToggleBookmarkController")
public class BM_ToggleBookmarkController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String US_EMAIL = request.getParameter("US_EMAIL");
        int COCKTAIL_NO = Integer.parseInt(request.getParameter("COCKTAIL_NO"));

        MemberDAO dao = new MemberDAO();
        
        // 찜 목록에서 존재 여부를 확인
        List<Cocktail_Info> bookmarkList = dao.selectBookmarkByEmail(US_EMAIL);
        boolean isBookmarked = bookmarkList.stream()
            .anyMatch(cocktail -> cocktail.getCOCKTAIL_NO() == COCKTAIL_NO);

        if (isBookmarked) {
            // 찜 취소
            dao.deleteBookmark(COCKTAIL_NO); // 이 메서드가 이미 구현되어 있어야 함
        } else {
            // 찜하기
            Bookmark bookmark = new Bookmark(US_EMAIL, COCKTAIL_NO);
            dao.insertBookmark(bookmark);
        }

        response.sendRedirect("member/mypage.jsp"); // 다시 마이페이지로 리다이렉트
    }
}
