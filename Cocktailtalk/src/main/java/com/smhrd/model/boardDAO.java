package com.smhrd.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.smhrd.database.SqlSessionManager;

public class boardDAO {
	
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSessionFactory();
	
	public List<myboard> getList() {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		List<myboard> res = sqlSession.selectList("BoardMapper.getList");
		sqlSession.close();
		return res;
	}
	
	public int writeBoard(myboard b) {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		int res = sqlSession.insert("BoardMapper.write",b);
		sqlSession.close();
		return res;
	}
	
	public myboard getBoard(int idx) {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		myboard res = sqlSession.selectOne("BoardMapper.getBoard",idx);
		sqlSession.close();
		return res;
	}
	
	public int deleteBoard(int idx) {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		int res = sqlSession.delete("BoardMapper.delete",idx);
		sqlSession.close();
		return res;
		
	}

}
