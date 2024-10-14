package com.smhrd.conrtroller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.smhrd.model.Bookmark;
import com.smhrd.model.Cocktail_Info;
import com.smhrd.model.MemberDAO;

@WebServlet("/BM_ToggleController")
public class BM_ToggleController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	request.setCharacterEncoding("UTF-8"); // 요청 인코딩 설정
        response.setContentType("application/json; charset=UTF-8"); // 응답 인코딩 설정
        PrintWriter out = response.getWriter();
        
        String US_EMAIL = request.getParameter("US_EMAIL");
        int COCKTAIL_NO = Integer.parseInt(request.getParameter("COCKTAIL_NO"));

        MemberDAO dao = new MemberDAO();

        // 찜 목록에서 존재 여부를 확인
        List<Cocktail_Info> bookmarkList = dao.selectBookmarkByEmail(US_EMAIL);
        boolean isBookmarked = bookmarkList.stream()
            .anyMatch(cocktail -> cocktail.getCOCKTAIL_NO() == COCKTAIL_NO);

        // 응답을 위한 JSON 객체 생성
        response.setContentType("application/json");
        JSONObject jsonResponse = new JSONObject();

        if (isBookmarked) {
            // 찜 취소
            dao.deleteBookmark(COCKTAIL_NO);
            jsonResponse.put("success", true);
            jsonResponse.put("newStatus", "♡ 찜"); // 새로운 상태
        } else {
            // 찜하기
            Bookmark bookmark = new Bookmark(US_EMAIL, COCKTAIL_NO);
            dao.insertBookmark(bookmark);
            jsonResponse.put("success", true);
            jsonResponse.put("newStatus", "✔ 찜됨"); // 새로운 상태
        }

        out.print(jsonResponse);
        out.flush();
    }
}
