package com.smhrd.model;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class TB_SHOW_LIKES {

	private int SH_NO;
	private String US_EMAIL;
	
	
	public TB_SHOW_LIKES(int sH_NO) {
		super();
		SH_NO = sH_NO;
	}


	public TB_SHOW_LIKES(String uS_EMAIL) {
		super();
		US_EMAIL = uS_EMAIL;
	}

	
	
}
