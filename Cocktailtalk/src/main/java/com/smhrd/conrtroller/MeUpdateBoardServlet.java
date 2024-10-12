package com.smhrd.conrtroller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smhrd.model.BoardDAO;
import com.smhrd.model.MyBoard;

@WebServlet("/meeting_BBS/updateBoard.do")
public class MeUpdateBoardServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       
    	request.setCharacterEncoding("UTF-8");

        // 파라미터로 전달된 게시글 정보 가져오기
        int ME_NO = Integer.parseInt(request.getParameter("meNo"));
        String meTitle = request.getParameter("meTitle");
        String meContent = request.getParameter("meContent");
        int mePeople = Integer.parseInt(request.getParameter("mePeople"));


        
        // DAO 호출하여 게시글 수정
        BoardDAO dao = new BoardDAO();
        MyBoard board = new MyBoard(ME_NO, meTitle, meContent, mePeople);
        int result = dao.updateBoard(board);

        if (result > 0) {
            // 수정 성공 시 게시글 보기 페이지로 리다이렉트
            response.sendRedirect("meetingview.jsp?ME_NO=" + ME_NO);
        } else {
            // 수정 실패 시 오류 페이지로 리다이렉트
            response.sendRedirect("error.jsp");
        }
    }
}