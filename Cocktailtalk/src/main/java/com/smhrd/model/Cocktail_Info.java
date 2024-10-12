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
	
	private int cocktail_no;
	private String cocktail_name;
	private String cocktail_recipe;
	private String cocktail_img;
	private String cocktail_his;
	private String cocktail_making;
	private String cocktail_base;
	private String cocktail_point;
	private String cocktail_tag_1;
	private String cocktail_tag_2;
	
	public Cocktail_Info(int cocktail_no, String cocktail_name) {
		this.cocktail_no = cocktail_no;
		this.cocktail_name = cocktail_name;
	}
}
