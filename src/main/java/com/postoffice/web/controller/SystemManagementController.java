package com.postoffice.web.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.postoffice.web.dto.DeptDTO;
import com.postoffice.web.dto.StateDTO;
import com.postoffice.web.dto.VillageDTO;
import com.postoffice.web.service.SystemManagementService;

@Controller
public class SystemManagementController {
	@Autowired
	private SystemManagementService systemManagementService;

	@RequestMapping("/systemManagement")
	public String systemManagement(Model model, HttpSession session, StateDTO stateDTO, DeptDTO deptDTO,
			VillageDTO villageDTO) {

		List<StateDTO> stateList = systemManagementService.sysGetState(stateDTO);
		List<DeptDTO> deptList = systemManagementService.sysGetDept(deptDTO);
		List<VillageDTO> villageList = systemManagementService.sysGetVillage(villageDTO);

		model.addAttribute("stateList", stateList);
		model.addAttribute("deptList", deptList);
		model.addAttribute("villageList", villageList);

		String sid = stateDTO.getState_id();
		String sname = stateDTO.getState_name();

		String did = deptDTO.getDept_id();
		String dname = deptDTO.getDept_name();

		String vid = villageDTO.getVid();
		String vname = villageDTO.getVname();
		//int lat = villageDTO.getVlat();
		//int lng = villageDTO.getVlng();

		System.out.println("=========================------------------\\\\\\\"");
		System.out.println(sid + sname + did + dname + vid + vname );

		return "manager/systemManagement";
	}

	@RequestMapping("/sysstateDelete")
	public String sysstateDelete(Model model, StateDTO stateDTO) {
		systemManagementService.sysStateDel(stateDTO);

		return "redirect:/systemManagement";
	}

	@RequestMapping("/sysdeptDelete")
	public String sysDeptDelete(Model model, DeptDTO deptDTO) {
		systemManagementService.sysDeptDel(deptDTO);
		return "redirect:/systemManagement";
	}

	@RequestMapping("/sysvillageDelete")
	public String sysVillageDelete(Model model, VillageDTO villageDTO) {
		systemManagementService.sysVillageDel(villageDTO);
		return "redirect:/systemManagement";
	}

	@RequestMapping("/stateinsert")
	public String sysInsertState(StateDTO stateDTO) {
		systemManagementService.sysInsertState(stateDTO);
		return "redirect:/systemManagement";
	}

	@RequestMapping("/deptinsert")
	public String sysInsertDept(DeptDTO deptDTO) {
		systemManagementService.sysInsertDept(deptDTO);
		return "redirect:/systemManagement";
	}

	@RequestMapping("/villageinsert")
	public String sysInsertVillage(VillageDTO villageDTO) {
		systemManagementService.sysInsertVillage(villageDTO);
		return "redirect:/systemManagement";
	}
	
	@RequestMapping("/stateupdate")
	public String sysUpdateState(StateDTO stateDTO) {
		systemManagementService.sysUpdateState(stateDTO);
		
		return "redirect:/systemManagement";
	}
	
	@RequestMapping("/deptupdate")
	public String sysUpdateDept(DeptDTO deptDTO) {
		systemManagementService.sysUpdateDept(deptDTO);
		
		return "redirect:/systemManagement";
	}
	
	@RequestMapping("/villageupdate")
	public String sysUpdateVillage(VillageDTO villageDTO) {
		systemManagementService.sysUpdateVillage(villageDTO);
		return "redirect:/systemManagement";
	}

	@RequestMapping("/stateIdCheck")
	public void idCheck(String state_id, HttpServletResponse response) throws IOException {
		int check = systemManagementService.idCheck(state_id);
		
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("stateCheck", check);
		String json = jsonObject.toString();
		
		pw.print(json);
		pw.flush();
		pw.close();
		
	}
	
	@RequestMapping("/deptIdCheck")
	public void didCheck(String dept_id, HttpServletResponse response) throws IOException {
		int dcheck = systemManagementService.didCheck(dept_id);
		
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("deptCheck", dcheck);
		String json = jsonObject.toString();
		
		pw.print(json);
		pw.flush();
		pw.close();
		
	}
	
	@RequestMapping("/villageIdCheck")
	public void vidCheck(String vid, HttpServletResponse response) throws IOException{
		int vcheck = systemManagementService.vidCheck(vid);
		
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("villageCheck", vcheck);
		String json = jsonObject.toString();
		
		pw.print(json);
		pw.flush();
		pw.close();
	}

}
