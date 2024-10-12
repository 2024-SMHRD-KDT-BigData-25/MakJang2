package com.smhrd.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@NoArgsConstructor
@Getter
@AllArgsConstructor
public class Cocktail_Info {
	
	private int COCKTAILI_NO;
	private String COCKTAILI_NAME;
	private String COCKTAILI_RECOPE;
	private String COCKTAILI_IMG;
	private String COCKTAILI_HIS;
	private String COCKTAILI_MAKING;
	private String COCKTAILI_BASE;
	private String COCKTAILI_POINT;
	private String COCKTAILI_TAG_1;
	private String COCKTAILI_TAG_2;
	
	public Cocktail_Info(int COCKTAILI_NO, String COCKTAILI_NAME, String COCKTAILI_IMG) {
		this.COCKTAILI_NO = COCKTAILI_NO;
		this.COCKTAILI_NAME = COCKTAILI_NAME;
		this.COCKTAILI_IMG = COCKTAILI_IMG;
	}
}
