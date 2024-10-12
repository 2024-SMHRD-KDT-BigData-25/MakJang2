package com.smhrd.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter // set 메서드
@NoArgsConstructor // 기본생성자
@AllArgsConstructor // 전체 필드 초기화 생성자
@Getter // get 메서드
public class MyBoard {

	private int idx;
	private String title;
	private String content;
	private String writer;
	private String img;
	private String indate;

	// 모임게시판
	private int ME_NO;
	private String ME_TITLE;
	private String ME_CONTENT;
	private String ME_WRITEDATE;
	private int ME_HIT;
	private String US_EMAIL;
	private int ME_LIKE;
	private int ME_PEOPLE;
	private int ME_CLICK;
	private String US_NICK;
	
	private String meTitle;
	private String meContent;
	private int mePeople;
	private int meclick;
	
	private String usEmail;
	private String usNick;
	
	// 창작게시판
	private int CR_NO;
	private String CR_TITLE;
	private String CR_CONTENT;
	private String CR_WRITEDATE;
	private int CR_HIT;
	private int CR_LIKE;
	
	//자유
	private int FR_NO;
	private String FR_TITLE;
	private String FR_CONTENT;
	private String FR_WRITEDATE;
	private int FR_HIT;
	private int FR_LIKE;
	
	private int No;
	private String Title;
	private String Content;
	
	public MyBoard(int idx, String title, String writer, String indate) {
		super();
		this.idx = idx;
		this.title = title;
		this.writer = writer;
		this.indate = indate;
	}
	
	public MyBoard(String title, String content, String writer, String img) {
		super();
		this.title = title;
		this.content = content;
		this.writer = writer;
		this.img = img;
	}
	
	public MyBoard(String meTitle, String meContent, String usEmail, int mePeople) {
		super();
		this.meTitle = meTitle;
		this.meContent = meContent;
		this.usEmail = usEmail;
		this.mePeople = mePeople;
	}
	
	public MyBoard(int ME_NO, String meTitle, String meContent, int mePeople) {
		super();
		this.ME_NO = ME_NO;
		this.meTitle = meTitle;
		this.meContent = meContent;
		this.mePeople = mePeople;
	}	
//    							   모임  											//
	
	public MyBoard(String Title, String Content, String usEmail) {
		super();
		this.Title = Title;
		this.Content = Content;
		this.usEmail = usEmail;
	}
	
	public MyBoard(String Title, String Content, int No) {
		super();
		this.Title = Title;
		this.Content = Content;
		this.No = No;
	}
	
}
