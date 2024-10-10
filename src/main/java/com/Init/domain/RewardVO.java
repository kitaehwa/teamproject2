package com.Init.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class RewardVO {
	private String rid;
    private String division;
    private String rname;
    private String reason;
    private Date rdate;
}
