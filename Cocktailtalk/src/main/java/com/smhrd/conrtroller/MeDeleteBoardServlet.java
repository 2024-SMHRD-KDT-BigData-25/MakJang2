package com.smhrd.conrtroller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smhrd.model.BoardDAO;

@WebServlet("/meeting_BBS/deleteBoard.do")
public class MeDeleteBoardServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int meNo = Integer.parseInt(request.getParameter("meNo"));
        BoardDAO dao = new BoardDAO();
        
        int result = dao.deleteBoard(meNo);
        
        if (result > 0) {
            // 게시물이 삭제되면 목록으로 리다이렉트
            response.sendRedirect("meList.jsp");
        } else {
            // 오류가 발생하면 에러 페이지로 리다이렉트
            response.sendRedirect("error.jsp");
        }
    }
}
