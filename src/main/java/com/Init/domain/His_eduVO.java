package com.Init.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class His_eduVO {
	private String emp_id;
	private String edu_name;  
	private String edu_teacher;  
    private Date edu_complete_date;
    private String edu_status;
    
}
