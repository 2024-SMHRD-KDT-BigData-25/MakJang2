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
	
	private int COCKTAIL_NO;
	private String COCKTAIL_NAME;
	private String COCKTAIL_RECIPE;
	private String COCKTAIL_IMG;
	private String COCKTAIL_HIS;
	private String COCKTAIL_MAKING;
	private String COCKTAIL_BASE;
	private String COCKTAIL_POINT;
	private String COCKTAIL_TAG_1;
	private String COCKTAIL_TAG_2;
	
	public Cocktail_Info(int COCKTAIL_NO, String COCKTAIL_NAME, String COCKTAIL_IMG) {
		this.COCKTAIL_NO = COCKTAIL_NO;
		this.COCKTAIL_NAME = COCKTAIL_NAME;
		this.COCKTAIL_IMG = COCKTAIL_IMG;
	}

	public Cocktail_Info(int cOCKTAIL_NO, String cOCKTAIL_NAME) {
		super();
		COCKTAIL_NO = cOCKTAIL_NO;
		COCKTAIL_NAME = cOCKTAIL_NAME;
	}
	
	
}
