package com.smhrd.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@NoArgsConstructor
@Getter
@AllArgsConstructor
public class MyMember {
	
	private String US_EMAIL;
	private String US_NAME;
	private String US_NICK;
	
	public MyMember(String US_EMAIL, String US_NICK) {
		this.US_EMAIL = US_EMAIL;
		this.US_NICK = US_NICK;
	}
}
