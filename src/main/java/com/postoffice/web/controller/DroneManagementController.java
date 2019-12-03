package com.postoffice.web.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.postoffice.web.dto.DroneDTO;
import com.postoffice.web.dto.VillageDTO;
import com.postoffice.web.service.DroneManagementService;

@Controller
public class DroneManagementController {

	@Autowired
	DroneManagementService droneManagementService;
	
	@RequestMapping("/droneManagement")
	public String droneManagement(Model model) {
		
		model.addAttribute("droneList", droneManagementService.selectDroneList());
		
		return "manager/droneManagement";
	}
	@RequestMapping("/droneLog")
	public String droneLog(DroneDTO dto, Model model) {
		model.addAttribute("droneLog", droneManagementService.selectDroneLog(dto));
		return "manager/droneManagement_Suv/droneLog_Ajax";
	}
	@RequestMapping("/droneState")
	public String droneState(DroneDTO dto, Model model) {
		if(dto.getState_id().equals("sd001")) {
			model.addAttribute("droneInfo",droneManagementService.selectDroneInfo(dto));
			return "manager/droneManagement_Suv/state_Wait_Ajax";
		}else if(dto.getState_id().equals("sd002")) {
			model.addAttribute("droneInfo",droneManagementService.selectDroneInfo(dto));
			return "manager/droneManagement_Suv/state_Delivery_Ajax";
		}else if(dto.getState_id().equals("sd003")) {
			model.addAttribute("droneInfo",droneManagementService.selectDroneInfo(dto));
			return "manager/droneManagement_Suv/state_Repair_Ajax";
		}else if(dto.getState_id().equals("sd004")) {
			model.addAttribute("droneInfo",droneManagementService.selectDroneInfo(dto));
			return "manager/droneManagement_Suv/state_Broken_Ajax";
		}else if(dto.getState_id().equals("sd005")) {
			model.addAttribute("droneInfo",droneManagementService.selectDroneInfo(dto));
			return "manager/droneManagement_Suv/state_Return_Ajax";
		}
		return null;
	}
	
	@RequestMapping("/selectDroneDeliveryState")
	public void selectDroneDeliveryState(DroneDTO dto, HttpServletResponse response) throws IOException {
		
		JSONObject jsonObject = new JSONObject();
		VillageDTO villageDTO = droneManagementService.selectDroneDeliveryState(dto);
		
		System.out.println(villageDTO.getSend_path());
		System.out.println("teeeeee : " + villageDTO.getReturn_path());
		System.out.println("teaeq : "+dto.getState_id());
		String send_path = villageDTO.getSend_path();
		String return_path = villageDTO.getReturn_path();
		
		if(dto.getState_id().equals("sd002")) {
			JSONArray jsonArray = new JSONArray(send_path);
			
			List<String> x = new ArrayList<String>();
			List<String> y = new ArrayList<String>();
			
			for(int i = 0; i < jsonArray.length(); i++) {
				JSONObject jsonPath = (JSONObject) jsonArray.get(i);
				x.add(jsonPath.get("x").toString());
				y.add(jsonPath.get("y").toString());
			}
			jsonObject.put("x", x);
			jsonObject.put("y", y);
			
			String json = jsonObject.toString();
			response.setContentType("application/json; charset=UTF-8");
			
			PrintWriter pw = response.getWriter();
			pw.write(json);
			pw.flush();
			pw.close();
		}else if(dto.getState_id().equals("sd005")) {
			JSONArray jsonArray = new JSONArray(return_path);
			
			List<String> x = new ArrayList<String>();
			List<String> y = new ArrayList<String>();
			
			for(int i = 0; i < jsonArray.length(); i++) {
				JSONObject jsonPath = (JSONObject) jsonArray.get(i);
				x.add(jsonPath.get("x").toString());
				y.add(jsonPath.get("y").toString());
			}
			jsonObject.put("x", x);
			jsonObject.put("y", y);
			
			String json = jsonObject.toString();
			response.setContentType("application/json; charset=UTF-8");
			
			PrintWriter pw = response.getWriter();
			pw.write(json);
			pw.flush();
			pw.close();
		}else {
			
		}
		
	}
	
}
