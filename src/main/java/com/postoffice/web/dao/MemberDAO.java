package com.postoffice.web.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.postoffice.web.dto.MemberDTO;

@Component
public class MemberDAO {
	private static final Logger logger = LoggerFactory.getLogger(MemberDAO.class);
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public MemberDTO selectMember(String lid) {
		MemberDTO member = sqlSessionTemplate.selectOne("member.selectMemberByLid", lid);
		return member;
	}
	

	public int insert(MemberDTO member) {
		logger.debug(member.getMphoto());
		logger.debug(member.getMid());
		logger.debug(member.getMname());
		logger.debug(member.getMpassword());
		logger.debug(member.getMtel());
		logger.debug(member.getDept_id());
		int rows = sqlSessionTemplate.insert("member.insert", member);
		return rows;
	}

	public String selectDeptName(String lid) {
		String dept_name = sqlSessionTemplate.selectOne("member.selectDeptName", lid);
		return dept_name;
	}
	
	public String selectMname(String lid) {
		String mname = sqlSessionTemplate.selectOne("member.selectMname", lid);
		return mname;
		
		
	}
	
	
}
