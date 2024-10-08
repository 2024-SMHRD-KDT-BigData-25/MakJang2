package com.smhrd.database;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

// SqlSession 관리
public class SqlSessionManager {
	// SqlSession : DB연결, Sql 실행 등 DB관련 (한가지)작업을 수행해주는 객체
	// SqlSession을 생성해주는 문장
	public static SqlSessionFactory SqlSessionFactory;
	
	// mybatis-config.xml(설정)에 작성되어있는 값을 가지고 factory 생성
	// => 클래스 로딩되면 딱 한번만 실행하고 더이상 실행하지 않음
	
	static {
		String resource = "com/smhrd/database/mybatis-config.xml";
		// Reader를 사용해서 정보를 읽어와서 factory 생성
		try {
			Reader reader = Resources.getResourceAsReader(resource);
			SqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	// 생성된 SqlSessionFactory 반환 메서드
	public static SqlSessionFactory getSqlSessionFactory() {
		return SqlSessionFactory;
	}
}
