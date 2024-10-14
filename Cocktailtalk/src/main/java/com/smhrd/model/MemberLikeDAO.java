package com.smhrd.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.mysql.cj.Session;
import com.smhrd.database.SqlSessionManager;

public class MemberLikeDAO {

	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSessionFactory();	
	
	public int insertlike(TB_SHOW_LIKES t) {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		int res = sqlSession.insert("likeMapper.insertlike", t);
		sqlSession.close();
		return res;
	}
	
	public int totallike(int sh_no) {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		Integer res = sqlSession.selectOne("likeMapper.totallike", sh_no);
		sqlSession.close();
		return (res != null) ? res : 0;
	}
	
	public int deletelike(TB_SHOW_LIKES t) {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		int res = sqlSession.delete("likeMapper.deletelike", t);
		sqlSession.close();
		return res;
	}
	
	public int checklike(TB_SHOW_LIKES t) {
	    try (SqlSession sqlSession = sqlSessionFactory.openSession(true)) {
	        Integer res = sqlSession.selectOne("likeMapper.checklike", t); // Integer로 받기
	        return (res != null) ? res : 0; // null 체크 후 반환
	    } // try 블록이 끝나면 자동으로 sqlSession이 닫힘
	}


	
}
