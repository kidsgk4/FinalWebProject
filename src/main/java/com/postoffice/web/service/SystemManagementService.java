package com.postoffice.web.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.postoffice.web.dao.SystemManagementDAO;
import com.postoffice.web.dto.DeptDTO;
import com.postoffice.web.dto.StateDTO;
import com.postoffice.web.dto.VillageDTO;

@Service
public class SystemManagementService {
	
	@Autowired
	private SystemManagementDAO systemManagementDAO;
	
	//상태 부서 마을 정보 불러오기
	public List<StateDTO> sysGetState(StateDTO stateDTO) {
		return systemManagementDAO.sysGetState(stateDTO);
	}
	
	public List<DeptDTO> sysGetDept(DeptDTO deptDTO) {
		return systemManagementDAO.sysGetDept(deptDTO);
	}
	
	public List<VillageDTO> sysGetVillage(VillageDTO villageDTO) {
		return systemManagementDAO.sysGetVillage(villageDTO);
	}
	
	//상태 부서 마을 정보 삭제
	public StateDTO sysStateDel(StateDTO stateDTO) {
		return systemManagementDAO.sysStateDel(stateDTO);
	}
	
	public DeptDTO sysDeptDel(DeptDTO deptDTO) {
		return systemManagementDAO.sysDeptDel(deptDTO);
	}

	public VillageDTO sysVillageDel(VillageDTO villageDTO) {
		return systemManagementDAO.sysVillageDel(villageDTO);
		
	}
	
	//상태 부서 마을 정보 추가
	public void sysInsertState(StateDTO stateDTO) {
		systemManagementDAO.sysInsertState(stateDTO);
	}
	
	public void sysInsertDept(DeptDTO deptDTO) {
		systemManagementDAO.sysInsertDept(deptDTO);
	}
	
	public void sysInsertVillage(VillageDTO villageDTO) {
		systemManagementDAO.sysInsertVillage(villageDTO);
	}

	public void sysUpdateState(StateDTO stateDTO) {
		systemManagementDAO.sysUpdateState(stateDTO);
	}
	
	public void sysUpdateDept(DeptDTO deptDTO) {
		systemManagementDAO.sysUpdateDept(deptDTO);
	}
	
	public void sysUpdateVillage(VillageDTO villageDTO) {
		systemManagementDAO.sysUpdateVillage(villageDTO);
	}
	
	
	public int idCheck(String state_id) {
		return systemManagementDAO.idCheck(state_id);
	}
	
	public int didCheck(String dept_id) {
		return systemManagementDAO.didCheck(dept_id);
	}
	public int vidCheck(String vid) {
		return systemManagementDAO.vidCheck(vid);
	}
}
