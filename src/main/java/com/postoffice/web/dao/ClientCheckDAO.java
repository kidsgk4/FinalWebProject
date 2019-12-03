package com.postoffice.web.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.postoffice.web.dto.MailDTO;
import com.postoffice.web.dto.PackageDTO;
import com.postoffice.web.service.LoginService;

@Repository
public class ClientCheckDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public List selectAll( ) {
		return sqlSessionTemplate.selectList("board.selectAll");
	}
	
	public int updateStateProc(MailDTO mailDTO) {
		return sqlSessionTemplate.update("board.updateStateProc", mailDTO);
	}
	
	public List beforeSelectAll() {
		return sqlSessionTemplate.selectList("board.beforeSelectAll");
	}

	public List<PackageDTO> packageSelect() {
		return sqlSessionTemplate.selectList("board.packageCheck");
		
	}
	public List<PackageDTO> packageCheckdiv() {
		return sqlSessionTemplate.selectList("board.packageCheckdiv");
	}

	public int cancel(int package_id) {
		return sqlSessionTemplate.delete("board.cancel",package_id);
	}

	public PackageDTO packageDetail(int package_id) {
		return sqlSessionTemplate.selectOne("board.packageDetail",package_id);
	}

	public int registRequest(int package_id) {
		return sqlSessionTemplate.update("board.registRequest",package_id);
	}

	public int villageArrive(int package_id) {

		return sqlSessionTemplate.update("board.villageArrive",package_id);
	}
}

