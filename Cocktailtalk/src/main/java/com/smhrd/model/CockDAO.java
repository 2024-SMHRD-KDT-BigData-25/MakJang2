package com.smhrd.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import com.smhrd.database.SqlSessionManager;

public class CockDAO {
	
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSessionFactory();
	
	//Cocktail_Info SELECT 		
	//Cocktail_Info, CockDAO, reccommend.jsp,
	//CockinfoMapper, MemberMapper, CockTail_Controller

	public List<Cocktail_Info> Cockinfo() {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		List<Cocktail_Info> res = sqlSession.selectList("CockinfoMapper.info_List");
		sqlSession.close();
		return res;
	}
	
	
		
}
