package com.Init.domain;

import java.sql.Date;
import java.sql.Timestamp;
import lombok.Data;

@Data
public class LicenseVO {
	private String li_id;
    private String li_name;
    private String li_issu;
    
    private String id;
    private Date li_date;
    
}
