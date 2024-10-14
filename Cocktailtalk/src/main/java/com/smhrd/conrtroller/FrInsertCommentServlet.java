package com.smhrd.conrtroller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.smhrd.model.Comment;
import com.smhrd.model.CommentDAO;

@WebServlet("/Board/free_BBS/insertComment.do")
public class FrInsertCommentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        int boardId = Integer.parseInt(request.getParameter("boardId"));
        String writer = request.getParameter("writer");
        String content = request.getParameter("content");
        String parentCommentIdStr = request.getParameter("parentCommentId");
        String us_email = request.getParameter("us_email");

        Integer parentCommentId = null;
        if (parentCommentIdStr != null && !parentCommentIdStr.isEmpty()) {
            parentCommentId = Integer.parseInt(parentCommentIdStr);
        }
        Comment comment = new Comment(boardId, parentCommentId, writer, content, us_email);
        CommentDAO commentDAO = new CommentDAO();

        commentDAO.insertfrComment(comment);

        // 댓글 또는 답글 작성 후 해당 게시글 상세 페이지로 리다이렉트
        response.sendRedirect("meetingview.jsp?No=" + boardId);
    }
}

