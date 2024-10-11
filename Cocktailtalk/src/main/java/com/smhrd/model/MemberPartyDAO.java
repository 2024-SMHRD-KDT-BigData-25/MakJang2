package com.smhrd.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.mysql.cj.Session;
import com.smhrd.database.SqlSessionManager;

public class MemberPartyDAO {

	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSessionFactory();	
	
	public int insertlike(TB_SHOW_LIKES t) {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		int res = sqlSession.insert("partyMapper.insertlike", t);
		sqlSession.close();
		return res;
	}
	
	public TB_SHOW_LIKES totallike(int sh_no) {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		TB_SHOW_LIKES res = sqlSession.selectOne("partyMapper.totallike", sh_no);
		sqlSession.close();
		return res;
	}
	
	public int deletelike(TB_SHOW_LIKES t) {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		int res = sqlSession.delete("partyMapper.deletelike", t);
		sqlSession.close();
		return res;
	}
	
	public int checklike(TB_SHOW_LIKES t) {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		int res = sqlSession.selectOne("partyMapper.checklike",t);
		sqlSession.close();
		return res;
	}

	
}
