package com.smhrd.conrtroller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smhrd.model.CommentDAO;

@WebServlet("/Board/create_BBS/deleteComment.do")
public class CrDeleteCommentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int commentId = Integer.parseInt(request.getParameter("commentId"));
        int boardId = Integer.parseInt(request.getParameter("boardId"));
        
        CommentDAO dao = new CommentDAO();
        
        int result = dao.deletecrComment(commentId);
        
        if (result > 0) {
            // 댓글이 삭제되면 해당 게시물로 리다이렉트
            response.sendRedirect("meetingview.jsp?NO=" + boardId);
        } else {
            // 오류가 발생하면 에러 페이지로 리다이렉트
            response.sendRedirect("error.jsp");
        }
    }
}