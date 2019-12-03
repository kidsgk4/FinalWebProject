package com.postoffice.web.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.postoffice.web.dto.StateDTO;

@Repository
public class StateDAO {
	@Autowired
	private SqlSessionTemplate sqlsessionTemplate;
	
	public StateDTO stateCheck(String state_id) {
		StateDTO stateDTO=sqlsessionTemplate.selectOne("state.stateCheck",state_id);
		return stateDTO;
	}

	public List selectList() {
		List stateList = sqlsessionTemplate.selectList("state.selectList");
		return stateList;
	}

}
