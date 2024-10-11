package com.smhrd.model;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import com.smhrd.database.SqlSessionManager;

public class MemberDAO {
    
    SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSessionFactory();
    
    // 중복체크
    public boolean isDuplicateEmail(String email) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        int count = sqlSession.selectOne("MemberMapper.countByEmail", email);
        sqlSession.close();
        return count > 0;
    }

    // 회원가입
    public int join(MyMember m) {
        SqlSession sqlSession = sqlSessionFactory.openSession(true);
        int res = sqlSession.insert("MemberMapper.join", m);
        sqlSession.close();
        return res;
    }

    // 닉네임 중복체크
    public boolean isNickDuplicate(String us_nick) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        int count = sqlSession.selectOne("MemberMapper.countByNick", us_nick);
        sqlSession.close();
        return count > 0;
    }

    // 회원정보수정
    public int update(MyMember m) {
        SqlSession sqlSession = sqlSessionFactory.openSession(true);
        int res = sqlSession.update("MemberMapper.update", m);
        sqlSession.close();
        return res;
    }

    // 이메일로 회원정보 조회
    public MyMember getMemberByEmail(String email) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        MyMember member = sqlSession.selectOne("MemberMapper.getMemberByEmail", email);
        sqlSession.close();
        return member;
    }

    // 회원탈퇴
    public int delete(String email) {
        SqlSession sqlSession = sqlSessionFactory.openSession(true);
        // 북마크 삭제
        sqlSession.delete("MemberMapper.deleteBookmarkByEmail", email);
        // 회원 삭제
        int res = sqlSession.delete("MemberMapper.delete", email);
        sqlSession.close();
        return res;
    }

    // 찜하기
    public int insertBookmark(Bookmark b) {
        SqlSession sqlSession = sqlSessionFactory.openSession(true);
        int res = sqlSession.insert("MemberMapper.insertBookmark", b);
        sqlSession.close();
        return res;
    }
    
    // 찜확인
    public List<Cocktail_Info> selectBookmarkByEmail(String email) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        List<Cocktail_Info> bookmarkList = sqlSession.selectList("MemberMapper.selectBookmark", email);
        sqlSession.close();
        return bookmarkList;
    }
    
    // 찜삭제
    public int deleteBookmark(int email) {
        SqlSession sqlSession = sqlSessionFactory.openSession(true);
        int res = sqlSession.delete("MemberMapper.deleteBookmark", email);
        sqlSession.close();
        return res;
    }
}
