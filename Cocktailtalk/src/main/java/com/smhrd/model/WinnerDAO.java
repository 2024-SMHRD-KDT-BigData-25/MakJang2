package com.smhrd.model;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.smhrd.database.SqlSessionManager;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class WinnerDAO {
    
    SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSessionFactory();

    public int insertWinner(Winner w) {
        SqlSession sqlSession = sqlSessionFactory.openSession(true);
        int res = sqlSession.insert("BoardMapper.insertWinner",w);
        sqlSession.close();
        return res;
     }
    
    // 전체 값 카운트
    public int CountWinnertb() {
    	SqlSession session = sqlSessionFactory.openSession();
    	int totalCount = session.selectOne("BoardMapper.CountWinnertb");
    	session.close();
    	return totalCount;
    }
    
    // 랭킹
    public List<Winner> CountWinner() {
        SqlSession sqlSession = sqlSessionFactory.openSession(true);
        List<Winner> res = sqlSession.selectList("BoardMapper.CountWinner");
        sqlSession.close();
        return res;
     }
    
    
}
