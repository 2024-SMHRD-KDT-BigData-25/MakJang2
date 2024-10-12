package com.smhrd.conrtroller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.model.MemberDAO;
import com.smhrd.model.MyMember;

@WebServlet("/UpdateController")
public class MEM_UpdateController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    	request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");
        
        String US_EMAIL = request.getParameter("US_EMAIL");
        String US_NICK = request.getParameter("US_NICK");

        MemberDAO dao = new MemberDAO();

        // 중복 체크
        if (dao.isNickDuplicate(US_NICK)) {
            // JSON 형식으로 에러 메시지 반환
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"errorMessage\": \"이미 사용 중인 닉네임입니다.\"}");
            return;
        }

        MyMember updateMember = new MyMember(US_EMAIL, US_NICK);
        int res = dao.update(updateMember);

        if (res > 0) {
            // 성공 시 세션에 닉네임 업데이트
            HttpSession userSession = request.getSession();
            userSession.setAttribute("NICK", US_NICK);
            // JSON 응답
            response.getWriter().write("{\"success\": true}");
        } else {
            // 실패 시
            response.getWriter().write("{\"success\": false, \"errorMessage\": \"수정 실패\"}");
        }
    }
}