package com.smhrd.conrtroller;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.smhrd.model.Winner;
import com.smhrd.model.WinnerDAO;

@WebServlet("/worldcup/saveWinner.do")
public class SaveWinnerServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");
    
   
        
    // JSON 데이터를 읽어오기 위해 버퍼 사용
    StringBuilder jsonBuffer = new StringBuilder();
    String line;
    try (BufferedReader reader = request.getReader()) {
        while ((line = reader.readLine()) != null) {
            jsonBuffer.append(line);
        }
    }

    try {
        // JSON 데이터 파싱
        JSONObject jsonObj = new JSONObject(jsonBuffer.toString());
        String winnerName = jsonObj.getString("winnerName");
        String winnerImage = winnerName+".png";
        System.out.println(winnerName+"-"+winnerImage);
        Winner win = new Winner(winnerName,winnerImage);
        
        // 데이터베이스에 저장 (DAO를 사용)
        WinnerDAO dao = new WinnerDAO();
        
        int result = dao.insertWinner(win);
        
        if(result>0) {
        	System.out.println(result);
		}else {
			System.out.println(result);
		}

        
    } catch (Exception e) {
        // 예외 처리
        response.setContentType("application/json");
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        PrintWriter out = response.getWriter();
        out.print("{\"error\":\"Internal Server Error\"}");
        out.flush();
        e.printStackTrace();
    }
}
}