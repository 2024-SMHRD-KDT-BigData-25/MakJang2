package com.smhrd.model;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import com.smhrd.database.SqlSessionManager;

public class CommentDAO {

    SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSessionFactory();

  //모임 
    
    // 모임 댓글 또는 답글 추가
    public int insertComment(Comment comment) {
        SqlSession sqlSession = sqlSessionFactory.openSession(true);
        int res = sqlSession.insert("BoardMapper.insertComment", comment);
        sqlSession.close();
        return res;
    }

    // 모임 특정 게시글의 댓글 목록 가져오기 (답글 포함)
    public List<Comment> getCommentsByBoardId(int boardId) {
        SqlSession sqlSession = sqlSessionFactory.openSession(true);
        List<Comment> res = sqlSession.selectList("BoardMapper.getCommentsByBoardId", boardId);
        sqlSession.close();
        return res;
    }
    
        // 모임 댓글 삭제 메서드
        public int deleteComment(int commentId) {
            SqlSession sqlSession = sqlSessionFactory.openSession(true);
            int result = sqlSession.delete("BoardMapper.deleteComment", commentId);
            sqlSession.close();
            return result;
    }

        // 모임 게시글별 댓글 개수 조회
        public int getCommentCountByBoardId(int boardId) {
            SqlSession sqlSession = sqlSessionFactory.openSession(true);
            int commentCount = sqlSession.selectOne("BoardMapper.getCommentCountByBoardId", boardId);
            sqlSession.close();
            return commentCount;
        }
        
      //모임
        
      //창작
 
        // 창작 댓글 또는 답글 추가
        public int insertcrComment(Comment comment) {
            SqlSession sqlSession = sqlSessionFactory.openSession(true);
            int res = sqlSession.insert("BoardMapper.insertCrComment", comment);
            sqlSession.close();
            return res;
        }

        // 창작 특정 게시글의 댓글 목록 가져오기 (답글 포함)
        public List<Comment> getcrCommentsByBoardId(int boardId) {
            SqlSession sqlSession = sqlSessionFactory.openSession(true);
            List<Comment> res = sqlSession.selectList("BoardMapper.getCrCommentsByBoardId", boardId);
            sqlSession.close();
            return res;
        }
        
            // 창작 댓글 삭제 메서드
            public int deletecrComment(int commentId) {
                SqlSession sqlSession = sqlSessionFactory.openSession(true);
                int result = sqlSession.delete("BoardMapper.deleteCrComment", commentId);
                sqlSession.close();
                return result;
        }

            // 창작 게시글별 댓글 개수 조회
            public int getcrCommentCountByBoardId(int boardId) {
                SqlSession sqlSession = sqlSessionFactory.openSession(true);
                int commentCount = sqlSession.selectOne("BoardMapper.getCrCommentCountByBoardId", boardId);
                sqlSession.close();
                return commentCount;
            }
            
         //창작
            
         //자유
            // 자유 댓글 또는 답글 추가
            public int insertfrComment(Comment comment) {
                SqlSession sqlSession = sqlSessionFactory.openSession(true);
                int res = sqlSession.insert("BoardMapper.insertFrComment", comment);
                sqlSession.close();
                return res;
            }

            // 자유 특정 게시글의 댓글 목록 가져오기 (답글 포함)
            public List<Comment> getfrCommentsByBoardId(int boardId) {
                SqlSession sqlSession = sqlSessionFactory.openSession(true);
                List<Comment> res = sqlSession.selectList("BoardMapper.getFrCommentsByBoardId", boardId);
                sqlSession.close();
                return res;
            }
            
                // 자유 댓글 삭제 메서드
                public int deletefrComment(int commentId) {
                    SqlSession sqlSession = sqlSessionFactory.openSession(true);
                    int result = sqlSession.delete("BoardMapper.deleteFrComment", commentId);
                    sqlSession.close();
                    return result;
            }

                // 자유 게시글별 댓글 개수 조회
                public int getfrCommentCountByBoardId(int boardId) {
                    SqlSession sqlSession = sqlSessionFactory.openSession(true);
                    int commentCount = sqlSession.selectOne("BoardMapper.getFrCommentCountByBoardId", boardId);
                    sqlSession.close();
                    return commentCount;
                }
                           
         //자유
                
         //인증
                // 인증 댓글 또는 답글 추가
                public int insertshComment(Comment comment) {
                    SqlSession sqlSession = sqlSessionFactory.openSession(true);
                    int res = sqlSession.insert("BoardMapper.insertShComment", comment);
                    sqlSession.close();
                    return res;
                }

                // 인증 특정 게시글의 댓글 목록 가져오기 (답글 포함)
                public List<Comment> getshCommentsByBoardId(int boardId) {
                    SqlSession sqlSession = sqlSessionFactory.openSession(true);
                    List<Comment> res = sqlSession.selectList("BoardMapper.getShCommentsByBoardId", boardId);
                    sqlSession.close();
                    return res;
                }
                
                    // 인증 댓글 삭제 메서드
                    public int deleteshComment(int commentId) {
                        SqlSession sqlSession = sqlSessionFactory.openSession(true);
                        int result = sqlSession.delete("BoardMapper.deleteShComment", commentId);
                        sqlSession.close();
                        return result;
                }

                    // 인증 게시글별 댓글 개수 조회
                    public int getshCommentCountByBoardId(int boardId) {
                        SqlSession sqlSession = sqlSessionFactory.openSession(true);
                        int commentCount = sqlSession.selectOne("BoardMapper.getShCommentCountByBoardId", boardId);
                        sqlSession.close();
                        return commentCount;
                    }
                    
         //인증
                
}


