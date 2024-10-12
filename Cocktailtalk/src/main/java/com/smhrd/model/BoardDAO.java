package com.smhrd.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.smhrd.database.SqlSessionManager;

public class BoardDAO {
	
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSessionFactory();
	
	public List<MyBoard> getimgList() {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		List<MyBoard> res = sqlSession.selectList("BoardMapper.getimgList");
		sqlSession.close();
		return res;
	}
	
	public int writeimgBoard(MyBoard b) {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		int res = sqlSession.insert("BoardMapper.imgwrite",b);
		sqlSession.close();
		return res;
	}
	
	public MyBoard getimgBoard(int idx) {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		MyBoard res = sqlSession.selectOne("BoardMapper.getimgBoard",idx);
		sqlSession.close();
		return res;
	}
	
	public int deleteimgBoard(int idx) {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		int res = sqlSession.delete("BoardMapper.imgdelete",idx);
		sqlSession.close();
		return res;
		
	}
	
	// 모임게시판
	
	
	//모임게시글가져오기
	public List<MyBoard> getList() {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		List<MyBoard> res = sqlSession.selectList("BoardMapper.meSelect");
		sqlSession.close();
		return res;
	}
	
	//모임글작성 완료뷰
	public MyBoard getmeBoard(int idx) {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		MyBoard res = sqlSession.selectOne("BoardMapper.getmeet", idx);
		sqlSession.close();
		return res;
	}		
	
	//모임게시판 글작성
	public int writeBoard(MyBoard b) {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		int res = sqlSession.insert("BoardMapper.meWrite", b);
		sqlSession.close();
		return res;
	}
	
	 // 특정 게시글 조회 (수정할 글 불러오기)
    public MyBoard geteditBoard(int meNo) {
        SqlSession session = sqlSessionFactory.openSession(true);
        MyBoard board = null;
        try {
            board = session.selectOne("BoardMapper.selectBoard", meNo);
        } finally {
            session.close();
        }
        return board;
    }
    
    // 모임게시글 삭제 
	public int deleteBoard(int meNo) {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		int res = sqlSession.delete("BoardMapper.delete",meNo);
		sqlSession.close();
		return res;
	}

    // 모임게시글 수정 메서드
    public int updateBoard(MyBoard board) {
        SqlSession sqlSession = sqlSessionFactory.openSession(true);
        int result = sqlSession.update("BoardMapper.updateBoard", board);
        sqlSession.close();
        return result;
    }
    
 // 페이징을 위한 모임게시글 목록 조회
    public List<MyBoard> getBoardListPaging(int startRow, int endRow) {
        SqlSession session = sqlSessionFactory.openSession();
        List<MyBoard> boardList = null;
        try {
            Map<String, Integer> params = new HashMap<>();
            params.put("startRow", startRow);
            params.put("endRow", endRow);
            boardList = session.selectList("BoardMapper.getBoardListPaging", params);
        } finally {
            session.close();
        }
        return boardList;
    }

    // 전체 모임게시글 수 카운트
    public int getBoardCount() {
        SqlSession session = sqlSessionFactory.openSession();
        int totalCount = 0;
        try {
            totalCount = session.selectOne("BoardMapper.getBoardCount");
        } finally {
            session.close();
        }
        return totalCount;
    }
    
    // 모임게시물 조회수 증가 메서드
    public void increaseHitCount(int boardId) {
        SqlSession session = sqlSessionFactory.openSession();
        try {
            session.update("BoardMapper.increaseHitCount", boardId);
            session.commit();
        } finally {
            session.close();
        }
    }
    
//모임끝
    
 
}
