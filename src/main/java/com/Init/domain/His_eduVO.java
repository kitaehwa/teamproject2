package com.Init.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class His_eduVO {
	private String emp_id;
	private String ename;  
	private String teacher;  
    private Date edate;
    private Date end_edate;
    private String estatus;
    private String approval;
}
