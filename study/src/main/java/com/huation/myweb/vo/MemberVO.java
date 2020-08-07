package com.huation.myweb.vo;

import java.util.Date;
import lombok.Data;

@Data
public class MemberVO {

	private String memberId;
	private String passwd;
	private String email;
	private Date regDate;
	private Boolean active;
	private String userType;
	
}
