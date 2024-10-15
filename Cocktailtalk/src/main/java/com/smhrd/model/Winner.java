package com.smhrd.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Winner {

	private String winnerName;
	private String winnerImage;
	private String WINNER_NAME;
	private String WINNER_IMAGE;
	
	   public Winner(String winnerName, String winnerImage) {
		      super();
		      this.winnerName = winnerName;
		      this.winnerImage = winnerImage;
		   }

}
