package com.Init.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Init.domain.QuitVO;
import com.Init.persistence.QuitDAO;

@Service
public class QuitServiceImpl implements QuitService {

	@Autowired
    private QuitDAO quitDAO;

	 @Override
	    public void submitQuit(QuitVO quitVO) {
	        quitDAO.insertQuit(quitVO);
	    }
}