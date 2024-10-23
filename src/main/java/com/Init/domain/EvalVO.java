package com.Init.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class EvalVO {
	private String eval_id;
	private String eval_name;
    private String score_total;
    private String eval_grade;
    private String eval_comment;
    private String eval_his_status;
    private String evaluator;
    private Date eval_end_date;
    private String emp_name;
    
}

