package com.postoffice.web.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.postoffice.web.dto.DeptDTO;
import com.postoffice.web.dto.StateDTO;
import com.postoffice.web.dto.VillageDTO;

@Component
public class SystemManagementDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	//상태, 부서, 마을 정보 리스트
	public List<StateDTO> sysGetState(StateDTO stateDTO) {
		return sqlSessionTemplate.selectList("sysManage.sysGetState",stateDTO);
	}
	
	public List<DeptDTO> sysGetDept(DeptDTO deptDTO) {
		return sqlSessionTemplate.selectList("sysManage.sysGetDept", deptDTO);
	}
	
	public List<VillageDTO> sysGetVillage(VillageDTO villageDTO) {
		return sqlSessionTemplate.selectList("sysManage.sysGetVillage", villageDTO);
	}
	
	//상태, 부서, 마을 정보 삭제
	public StateDTO sysStateDel(StateDTO stateDTO) {
		return sqlSessionTemplate.selectOne("sysManage.sysStateDel", stateDTO);
	}
	
	public DeptDTO sysDeptDel(DeptDTO deptDTO) {
		return sqlSessionTemplate.selectOne("sysManage.sysDeptDel", deptDTO);
	}

	public VillageDTO sysVillageDel(VillageDTO villageDTO) {
		return sqlSessionTemplate.selectOne("sysManage.sysVillageDel", villageDTO);
	}
	
	//상태, 부서, 마을 정보 추가
	public void sysInsertState(StateDTO stateDTO) {
		sqlSessionTemplate.insert("sysManage.sysInsertState", stateDTO);
	}
	public void sysInsertDept(DeptDTO deptDTO) {
		sqlSessionTemplate.insert("sysManage.sysInsertDept", deptDTO);
	}
	public void sysInsertVillage(VillageDTO villageDTO) {
		sqlSessionTemplate.insert("sysManage.sysInsertVillage", villageDTO);
	}

	public void sysUpdateState(StateDTO stateDTO) {
		sqlSessionTemplate.update("sysManage.sysUpdateState", stateDTO);
	}
	
	public void sysUpdateDept(DeptDTO deptDTO) {
		sqlSessionTemplate.update("sysManage.sysUpdateDept", deptDTO);
	}
	
	public void sysUpdateVillage(VillageDTO villageDTO) {
		sqlSessionTemplate.update("sysManage.sysUpdateVillage", villageDTO);
	}
	
	
	
	public int idCheck(String state_id) {
		return sqlSessionTemplate.selectOne("sysManage.stateIdCheck",state_id);
	}
	
	public int didCheck(String dept_id) {
		return sqlSessionTemplate.selectOne("sysManage.deptIdCheck", dept_id);
	}
	public int vidCheck(String vid) {
		return sqlSessionTemplate.selectOne("sysManage.villageIdCheck", vid);
	}
}
