package com.smhrd.conrtroller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smhrd.model.BoardDAO;
import com.smhrd.model.MyBoard;

@WebServlet("/Board/meeting_BBS/viewBoard.do")
public class MeViewBoardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int boardId = Integer.parseInt(request.getParameter("ME_NO"));

            // pageNum이 없으면 기본값 1 설정
            String pageNumStr = request.getParameter("pageNum");
            int pageNum = (pageNumStr == null) ? 1 : Integer.parseInt(pageNumStr);

            BoardDAO dao = new BoardDAO();
            MyBoard board = dao.getmeBoard(boardId);

            if (board == null) {  // 게시글이 존재하지 않는 경우
                // 세션에 에러 메시지 저장
                request.getSession().setAttribute("errorMessage", "존재하지 않는 게시글입니다.");
                // 리스트 페이지로 리다이렉트
                response.sendRedirect("meList.jsp");  // 절대 경로로 수정
            } else {
                request.setAttribute("board", board);
                request.getRequestDispatcher("meetingview.jsp?ME_NO=" + boardId + "&pageNum=" + pageNum)
                        .forward(request, response);
            }
        } catch (NumberFormatException e) {
            // 파라미터가 없거나 형식이 잘못되었을 때 예외 처리
            request.getSession().setAttribute("errorMessage", "잘못된 요청입니다.");
            response.sendRedirect("meList.jsp");
        }
    }
}
