package com.smhrd.model;

import lombok.Getter;

@Getter
public class TB_SHOW_LIKES {

	private int ME_NO;
	private String US_EMAIL;
	private int totallike;
	

	public TB_SHOW_LIKES(String uS_EMAIL) {
		super();
		US_EMAIL = uS_EMAIL;
	}
	
	public TB_SHOW_LIKES(int mE_NO) {
		super();
		ME_NO = mE_NO;
	}

	public TB_SHOW_LIKES(int mE_NO, String uS_EMAIL) {
		super();
		ME_NO = mE_NO;
		US_EMAIL = uS_EMAIL;
	}

	public TB_SHOW_LIKES(int totallike, int mE_NO) {
		super();
		this.totallike = totallike;
		ME_NO = mE_NO;
	}

	
	
}
