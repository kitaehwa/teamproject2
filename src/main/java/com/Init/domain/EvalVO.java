package com.Init.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class EvalVO {
	private String eval_id;
	private String eval_name;
    private String score1;
    private String score2;
    private String score3;
    private String total;
    private String feadback;
    private String valuator;
    private Date eval_date;
}
