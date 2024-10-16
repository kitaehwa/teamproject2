package com.Init.domain;

import java.sql.Date;
import java.sql.Timestamp;
import lombok.Data;

@Data
public class LicenseVO {  
	private String emp_id;
    private String li_id;
    private Date li_date;
    private String li_issu;
    private String li_name;
    
}
