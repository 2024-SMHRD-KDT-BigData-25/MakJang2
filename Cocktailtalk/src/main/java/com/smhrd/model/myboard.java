package com.smhrd.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter // set 메서드
@NoArgsConstructor // 기본생성자
@AllArgsConstructor // 전체 필드 초기화 생성자
@Getter // get 메서드
public class myboard {

	private int idx;
	private String title;
	private String content;
	private String writer;
	private String img;
	private String indate;
	
	public myboard(int idx, String title, String writer, String indate) {
		super();
		this.idx = idx;
		this.title = title;
		this.writer = writer;
		this.indate = indate;
	}
	
	public myboard(String title, String content, String writer, String img) {
		super();
		this.title = title;
		this.content = content;
		this.writer = writer;
		this.img = img;
	}
}
