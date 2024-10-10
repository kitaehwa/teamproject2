package com.Init.domain;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.Data;

@Data
public class AccountVO {
	private String emp_account_name;
    private String emp_account_num;
    private String emp_bank_name;
}
