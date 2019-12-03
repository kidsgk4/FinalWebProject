package com.postoffice.web.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.postoffice.web.dto.PackageDTO;
import com.postoffice.web.service.GcsService;
import com.postoffice.web.service.PackageService;

@Controller
public class PackageController {


   @Autowired
   private PackageService packageService;
   @Autowired 
   private GcsService gcsService;
	
   
   @RequestMapping("/packagingList")
   public String packagingList(Model model) {
      
      model.addAttribute("mailList",packageService.mailList());
      model.addAttribute("packageList",packageService.packageList());
      model.addAttribute("villages",packageService.villageList());
      
      List<PackageDTO> list = packageService.packageList();

      return "manager/packaging";
   }
   
   @RequestMapping("/pack_search")
   public String pack_search(@RequestParam String village_name, Model model) {
		model.addAttribute("mailList",packageService.village_mailList(village_name));
		model.addAttribute("packageList",packageService.packageList());
		model.addAttribute("villages",packageService.villageList());
	   
		return "manager/packaging";
   }
   

   @RequestMapping("/packaging")
   public String packaging(Model model,
         @RequestParam(value="mailIdList[]") List<String> mailIdList,
         @RequestParam(value="totalWeight") String totalWeight,
         @RequestParam String vid) throws IOException {
         model.addAttribute("packagingList", packageService.mailPackaging(totalWeight, mailIdList, vid));
         
         gcsService.sendMessageToGcs("requestDelivery");
         
         return "redirect:/packagingList";
   }
   
   @RequestMapping("/pack_mailList")
   public String pack_mailList(Model model, PackageDTO dto) {
         
         model.addAttribute("pack_num",dto.getPackage_id());
         model.addAttribute("pack_mailList",packageService.pack_mailList(dto));
         return "manager/packageMailList_popup";
   }
   
   @RequestMapping("/clientInfo")
   public String clientInfo(String to_name,String from_name,String to_address,String from_address,String vid,String weight) {
	   int mail_weight = Integer.parseInt(weight);
	   System.out.println(mail_weight);
         packageService.clientInfo(to_name,from_name,to_address,from_address,vid,mail_weight);
         return "redirect:/packagingList";
   }
   
}
