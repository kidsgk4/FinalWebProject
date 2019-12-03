package com.postoffice.web.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.postoffice.web.dto.VillageDTO;



@Component
public class VillageDAO {
	private static final Logger logger = LoggerFactory.getLogger(VillageDAO.class);
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public int updateSendPath(VillageDTO villageDto) {
		logger.debug("실행");
		int rows = sqlSessionTemplate.update("village.updateSendPath", villageDto);
		logger.debug(""+rows);
		return rows;
	}
	
	public int updateReturnPath(VillageDTO villageDto) {
		logger.debug("실행");
		int rows = sqlSessionTemplate.update("village.updateReturnPath", villageDto);
		logger.debug(""+rows);
		return rows;
	}
	
	public String selectSendPath(String vid) {
		return sqlSessionTemplate.selectOne("village.selectSendPath", vid);
	}
}
