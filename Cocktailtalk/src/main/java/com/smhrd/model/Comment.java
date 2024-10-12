package com.smhrd.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@AllArgsConstructor
@Getter
@Setter
public class Comment {
    private int commentId;
    private int boardId;
    private Integer parentCommentId;  // 부모 댓글 ID (null일 수 있음)
    private String writer;
    private String us_email;
    private String content;
    private String indate;   
 
    
    // 댓글 및 답글 작성시 사용하는 생성자
    public Comment(int boardId, Integer parentCommentId, String writer, String content, String us_email) {
        this.boardId = boardId;
        this.parentCommentId = parentCommentId;
        this.writer = writer;
        this.content = content;
        this.us_email = us_email;
    }
}


