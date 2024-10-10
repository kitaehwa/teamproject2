package com.Init.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class EvalVO {
	private String eval_id;
    private String score1;
    private String score2;
    private String score3;
    private String att;
    private String feadback;
    private String valuator;
    private Date eval_date;
}
