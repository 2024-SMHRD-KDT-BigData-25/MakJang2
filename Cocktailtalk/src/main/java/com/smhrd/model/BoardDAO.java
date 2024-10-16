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
    
    // 검색 기능을 포함한 페이징 처리된 모임 게시글 목록 조회 메서드
    public List<MyBoard> searchMeBoardListPaging(String searchType, String searchKeyword, int startRow, int endRow) {
        SqlSession session = sqlSessionFactory.openSession();
        List<MyBoard> boardList = null;
        try {
            // 검색 조건을 Map에 담아 MyBatis에 전달
            Map<String, Object> params = new HashMap<>();
            params.put("searchType", searchType);
            params.put("searchKeyword", "%" + searchKeyword + "%");  // LIKE 연산자를 위한 포맷
            params.put("startRow", startRow);
            params.put("endRow", endRow);
            
            boardList = session.selectList("BoardMapper.searchMeBoardListPaging", params);
        } finally {
            session.close();
        }
        return boardList;
    }

    // 검색된 게시글의 총 개수를 조회하는 메서드
    public int getSearchMeBoardCount(String searchType, String searchKeyword) {
        SqlSession session = sqlSessionFactory.openSession();
        int totalCount = 0;
        try {
            // 검색 조건을 Map에 담아 MyBatis에 전달
            Map<String, Object> params = new HashMap<>();
            params.put("searchType", searchType);
            params.put("searchKeyword", "%" + searchKeyword + "%");  // LIKE 연산자를 위한 포맷
            
            totalCount = session.selectOne("BoardMapper.getSearchMeBoardCount", params);
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
    
//창작
      
   //창작게시글가져오기
   public List<MyBoard> getCrList() {
      SqlSession sqlSession = sqlSessionFactory.openSession(true);
      List<MyBoard> res = sqlSession.selectList("BoardMapper.crSelect");
      sqlSession.close();
      return res;
   }
   
   //창작글작성 완료뷰
   public MyBoard getcrBoard(int idx) {
      SqlSession sqlSession = sqlSessionFactory.openSession(true);
      MyBoard res = sqlSession.selectOne("BoardMapper.getcreate", idx);
      sqlSession.close();
      return res;
   }      
   
   //창작게시판 글작성
   public int writecrBoard(MyBoard b) {
      SqlSession sqlSession = sqlSessionFactory.openSession(true);
      int res = sqlSession.insert("BoardMapper.crWrite", b);
      sqlSession.close();
      return res;
   }
   
    // 특정 게시글 조회 (수정할 글 불러오기)
    public MyBoard geteditcrBoard(int meNo) {
        SqlSession session = sqlSessionFactory.openSession(true);
        MyBoard board = null;
        try {
            board = session.selectOne("BoardMapper.selectCrBoard", meNo);
        } finally {
            session.close();
        }
        return board;
    }
    
    // 창작게시글 삭제 
   public int deletecrBoard(int meNo) {
      SqlSession sqlSession = sqlSessionFactory.openSession(true);
      int res = sqlSession.delete("BoardMapper.crdelete",meNo);
      sqlSession.close();
      return res;
   }

    // 창작게시글 수정 메서드
    public int updatecrBoard(MyBoard board) {
        SqlSession sqlSession = sqlSessionFactory.openSession(true);
        int result = sqlSession.update("BoardMapper.updateCrBoard", board);
        sqlSession.close();
        return result;
    }
    
 // 페이징을 위한 창작게시글 목록 조회
    public List<MyBoard> getcrBoardListPaging(int startRow, int endRow) {
        SqlSession session = sqlSessionFactory.openSession();
        List<MyBoard> boardList = null;
        try {
            Map<String, Integer> params = new HashMap<>();
            params.put("startRow", startRow);
            params.put("endRow", endRow);
            boardList = session.selectList("BoardMapper.getCrBoardListPaging", params);
        } finally {
            session.close();
        }
        return boardList;
    }

    // 전체 창작게시글 수 카운트
    public int getcrBoardCount() {
        SqlSession session = sqlSessionFactory.openSession();
        int totalCount = 0;
        try {
            totalCount = session.selectOne("BoardMapper.getCrBoardCount");
        } finally {
            session.close();
        }
        return totalCount;
    }

    // 검색 기능을 포함한 페이징 처리된 창작 게시글 목록 조회 메서드
    public List<MyBoard> searchCrBoardListPaging(String searchType, String searchKeyword, int startRow, int endRow) {
        SqlSession session = sqlSessionFactory.openSession();
        List<MyBoard> boardList = null;
        try {
            // 검색 조건을 Map에 담아 MyBatis에 전달
            Map<String, Object> params = new HashMap<>();
            params.put("searchType", searchType);
            params.put("searchKeyword", "%" + searchKeyword + "%");  // LIKE 연산자를 위한 포맷
            params.put("startRow", startRow);
            params.put("endRow", endRow);
            
            boardList = session.selectList("BoardMapper.searchCrBoardListPaging", params);
        } finally {
            session.close();
        }
        return boardList;
    }

    // 검색된 게시글의 총 개수를 조회하는 메서드
    public int getSearchCrBoardCount(String searchType, String searchKeyword) {
        SqlSession session = sqlSessionFactory.openSession();
        int totalCount = 0;
        try {
            // 검색 조건을 Map에 담아 MyBatis에 전달
            Map<String, Object> params = new HashMap<>();
            params.put("searchType", searchType);
            params.put("searchKeyword", "%" + searchKeyword + "%");  // LIKE 연산자를 위한 포맷
            
            totalCount = session.selectOne("BoardMapper.getSearchCrBoardCount", params);
        } finally {
            session.close();
        }
        return totalCount;
    }

    
    // 창작게시물 조회수 증가 메서드
    public void increasecrHitCount(int boardId) {
        SqlSession session = sqlSessionFactory.openSession();
        try {
            session.update("BoardMapper.increaseCrHitCount", boardId);
            session.commit();
        } finally {
            session.close();
        }
    }
    
  //창작끝    
 
   //자유
      
   //자유게시글가져오기
   public List<MyBoard> getFrList() {
      SqlSession sqlSession = sqlSessionFactory.openSession(true);
      List<MyBoard> res = sqlSession.selectList("BoardMapper.frSelect");
      sqlSession.close();
      return res;
   }
   
   //자유글작성 완료뷰
   public MyBoard getfrBoard(int idx) {
      SqlSession sqlSession = sqlSessionFactory.openSession(true);
      MyBoard res = sqlSession.selectOne("BoardMapper.getfree", idx);
      sqlSession.close();
      return res;
   }      
   
   //자유게시판 글작성
   public int writefrBoard(MyBoard b) {
      SqlSession sqlSession = sqlSessionFactory.openSession(true);
      int res = sqlSession.insert("BoardMapper.frWrite", b);
      sqlSession.close();
      return res;
   }
   
    // 특정 게시글 조회 (수정할 글 불러오기)
    public MyBoard geteditfrBoard(int meNo) {
        SqlSession session = sqlSessionFactory.openSession(true);
        MyBoard board = null;
        try {
            board = session.selectOne("BoardMapper.selectFrBoard", meNo);
        } finally {
            session.close();
        }
        return board;
    }
    
    // 자유게시글 삭제 
   public int deletefrBoard(int meNo) {
      SqlSession sqlSession = sqlSessionFactory.openSession(true);
      int res = sqlSession.delete("BoardMapper.deleteFr",meNo);
      sqlSession.close();
      return res;
   }

    // 자유게시글 수정 메서드
    public int updatefrBoard(MyBoard board) {
        SqlSession sqlSession = sqlSessionFactory.openSession(true);
        int result = sqlSession.update("BoardMapper.updateFrBoard", board);
        sqlSession.close();
        return result;
    }
 
    // 페이징을 위한 자유게시글 목록 조회
    public List<MyBoard> getfrBoardListPaging(int startRow, int endRow) {
        SqlSession session = sqlSessionFactory.openSession();
        List<MyBoard> boardList = null;
        try {
            Map<String, Integer> params = new HashMap<>();
            params.put("startRow", startRow);
            params.put("endRow", endRow);
            boardList = session.selectList("BoardMapper.getFrBoardListPaging", params);
        } finally {
            session.close();
        }
        return boardList;
    }
    
    // 전체 자유게시글 수 카운트
    public int getfrBoardCount() {
        SqlSession session = sqlSessionFactory.openSession();
        int totalCount = 0;
        try {
            totalCount = session.selectOne("BoardMapper.getFrBoardCount");
        } finally {
            session.close();
        }
        return totalCount;
    }   
    
    // 검색 기능을 포함한 페이징 처리된 자유 게시글 목록 조회 메서드
    public List<MyBoard> searchFrBoardListPaging(String searchType, String searchKeyword, int startRow, int endRow) {
        SqlSession session = sqlSessionFactory.openSession();
        List<MyBoard> boardList = null;
        try {
            // 검색 조건을 Map에 담아 MyBatis에 전달
            Map<String, Object> params = new HashMap<>();
            params.put("searchType", searchType);
            params.put("searchKeyword", "%" + searchKeyword + "%");  // LIKE 연산자를 위한 포맷
            params.put("startRow", startRow);
            params.put("endRow", endRow);
            
            boardList = session.selectList("BoardMapper.searchFrBoardListPaging", params);
        } finally {
            session.close();
        }
        return boardList;
    }

    // 검색된 게시글의 총 개수를 조회하는 메서드
    public int getSearchFrBoardCount(String searchType, String searchKeyword) {
        SqlSession session = sqlSessionFactory.openSession();
        int totalCount = 0;
        try {
            // 검색 조건을 Map에 담아 MyBatis에 전달
            Map<String, Object> params = new HashMap<>();
            params.put("searchType", searchType);
            params.put("searchKeyword", "%" + searchKeyword + "%");  // LIKE 연산자를 위한 포맷
            
            totalCount = session.selectOne("BoardMapper.getSearchFrBoardCount", params);
        } finally {
            session.close();
        }
        return totalCount;
    }

    
    // 자유게시물 조회수 증가 메서드
    public void increasefrHitCount(int boardId) {
        SqlSession session = sqlSessionFactory.openSession();
        try {
            session.update("BoardMapper.increaseFrHitCount", boardId);
            session.commit();
        } finally {
            session.close();
        }
    }
    
  //자유끝
    
  //인증
      
   //인증게시글가져오기
   public List<MyBoard> getShList() {
      SqlSession sqlSession = sqlSessionFactory.openSession(true);
      List<MyBoard> res = sqlSession.selectList("BoardMapper.shSelect");
      sqlSession.close();
      return res;
   }
   
   //인증글작성 완료뷰
   public MyBoard getshBoard(int idx) {
      SqlSession sqlSession = sqlSessionFactory.openSession(true);
      MyBoard res = sqlSession.selectOne("BoardMapper.getshow", idx);
      sqlSession.close();
      return res;
   }      
   
   //인증게시판 글작성
   public int writeshBoard(MyBoard b) {
      SqlSession sqlSession = sqlSessionFactory.openSession(true);
      int res = sqlSession.insert("BoardMapper.shWrite", b);
      sqlSession.close();
      return res;
   }
   
    // 특정 게시글 조회 (수정할 글 불러오기)
    public MyBoard geteditshBoard(int meNo) {
        SqlSession session = sqlSessionFactory.openSession(true);
        MyBoard board = null;
        try {
            board = session.selectOne("BoardMapper.selectShBoard", meNo);
        } finally {
            session.close();
        }
        return board;
    }
    
    // 인증게시글 삭제 
   public int deleteshBoard(int meNo) {
      SqlSession sqlSession = sqlSessionFactory.openSession(true);
      int res = sqlSession.delete("BoardMapper.deleteSh",meNo);
      sqlSession.close();
      return res;
   }

    // 인증게시글 수정 메서드
    public int updateshBoard(MyBoard board) {
        SqlSession sqlSession = sqlSessionFactory.openSession(true);
        int result = sqlSession.update("BoardMapper.updateShBoard", board);
        sqlSession.close();
        return result;
    }
    
 // 페이징을 위한 인증게시글 목록 조회
    public List<MyBoard> getshBoardListPaging(int startRow, int endRow) {
        SqlSession session = sqlSessionFactory.openSession();
        List<MyBoard> boardList = null;
        try {
            Map<String, Integer> params = new HashMap<>();
            params.put("startRow", startRow);
            params.put("endRow", endRow);
            boardList = session.selectList("BoardMapper.getShBoardListPaging", params);
        } finally {
            session.close();
        }
        return boardList;
    }

    // 전체 인증게시글 수 카운트
    public int getshBoardCount() {
        SqlSession session = sqlSessionFactory.openSession();
        int totalCount = 0;
        try {
            totalCount = session.selectOne("BoardMapper.getShBoardCount");
        } finally {
            session.close();
        }
        return totalCount;
    }
    
    // 검색 기능을 포함한 페이징 처리된 자유 게시글 목록 조회 메서드
    public List<MyBoard> searchShBoardListPaging(String searchType, String searchKeyword, int startRow, int endRow) {
        SqlSession session = sqlSessionFactory.openSession();
        List<MyBoard> boardList = null;
        try {
            // 검색 조건을 Map에 담아 MyBatis에 전달
            Map<String, Object> params = new HashMap<>();
            params.put("searchType", searchType);
            params.put("searchKeyword", "%" + searchKeyword + "%");  // LIKE 연산자를 위한 포맷
            params.put("startRow", startRow);
            params.put("endRow", endRow);
            
            boardList = session.selectList("BoardMapper.searchShBoardListPaging", params);
        } finally {
            session.close();
        }
        return boardList;
    }

    // 검색된 게시글의 총 개수를 조회하는 메서드
    public int getSearchShBoardCount(String searchType, String searchKeyword) {
        SqlSession session = sqlSessionFactory.openSession();
        int totalCount = 0;
        try {
            // 검색 조건을 Map에 담아 MyBatis에 전달
            Map<String, Object> params = new HashMap<>();
            params.put("searchType", searchType);
            params.put("searchKeyword", "%" + searchKeyword + "%");  // LIKE 연산자를 위한 포맷
            
            totalCount = session.selectOne("BoardMapper.getSearchShBoardCount", params);
        } finally {
            session.close();
        }
        return totalCount;
    }
    
    // 인증게시물 조회수 증가 메서드
    public void increaseshHitCount(int boardId) {
        SqlSession session = sqlSessionFactory.openSession();
        try {
            session.update("BoardMapper.increaseShHitCount", boardId);
            session.commit();
        } finally {
            session.close();
        }
    }
    
    //인증게시글 작성 이미지 업로드 테스트
   public int writeshimgBoard(MyBoard b) {
      SqlSession sqlSession = sqlSessionFactory.openSession(true);
      int res = sqlSession.insert("BoardMapper.shimgwrite",b);
      sqlSession.close();
      return res;
   }  
  //인증끝  
    
    
}