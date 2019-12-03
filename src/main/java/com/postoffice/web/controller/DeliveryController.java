package com.postoffice.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.postoffice.web.dto.DeliveryDTO;
import com.postoffice.web.dto.DroneDTO;
import com.postoffice.web.dto.PackageDTO;
import com.postoffice.web.service.DroneManagementService;
import com.postoffice.web.service.GcsService;

@Controller
public class DeliveryController {

	@Autowired
	private DroneManagementService droneManagementService;
	
	@Autowired 
	private GcsService gcsService;
	 
	
	@RequestMapping("/delivery")
	public String delibery(Model model) {

		
		model.addAttribute("droneDeliveryList", droneManagementService.selectDeliveryDrone());
		model.addAttribute("packageList",droneManagementService.packageList());
		return "manager/delivery";
	}
	
	
	@RequestMapping("/delivery_Ajax")
	public String delivery_Ajax(Model model, PackageDTO dto, @RequestParam String index) {
		
		model.addAttribute("package_id", dto.getPackage_id());
		model.addAttribute("index", index);
		model.addAttribute("droneInfo", droneManagementService.selectDroneList());
		return "manager/delivery_Ajax";
	}
	
	@RequestMapping("/delivery_Popup_Ajax")
	public String delivery_Popup_Ajax(Model model, DroneDTO dto) {
		
		model.addAttribute("droneLog", droneManagementService.selectDroneLog(dto));
		
		return "manager/delivery_Popup_Ajax";
	}
	
	@RequestMapping("/drone_delivery")
	public String drone_delivery(DeliveryDTO dto, @RequestParam String state_id, @RequestParam String path) {
		System.out.println(path);
		System.out.println(dto.getDrone_id());
		gcsService.sendMessage(dto,state_id,path);
		return "redirect:/delivery";
	}
	
	@RequestMapping("/drone_delivery_clear")
	public String droneDeliveryClear(DeliveryDTO dto) {
		System.out.println(dto.getPackage_id());
		droneManagementService.updateDeliveryClear(dto);
		
		return "redirect:/delivery";
	}
}
