package com.Init.domain;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.Data;


@Data
public class MemberVO {

	private String emp_id; 	
	private String emp_cid; 
	private String emp_pw; 
	private String emp_profile; 
	private String emp_name; 
	private Date emp_birth;
	private String emp_gender; 
	private String emp_tel; 
	private String emp_email; 
	private String emp_addr;  
	private String emp_dnum; 
	private String emp_position;  
	private String emp_job; 
	private Integer emp_status; 
	private Integer emp_bnum; 
	private Integer emp_work_type; 
	private Integer emp_salary; 
	private String emp_account_num; 
	private String emp_bank_name; 
	private String emp_account_name; 
	private Date emp_start_date; 
	private Date emp_break_date; 
	private Date emp_restart_date; 
	private Date emp_quit_date; 
	private String emp_power; 
	private Integer emp_level;
	private Timestamp update_date;	
	
}
