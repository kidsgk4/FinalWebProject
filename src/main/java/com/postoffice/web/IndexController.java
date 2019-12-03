package com.postoffice.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.postoffice.web.dto.NoticeDTO;
import com.postoffice.web.service.ClientCheckService;
import com.postoffice.web.service.NoticeService;
import com.postoffice.web.service.PackageService;

@Controller
public class IndexController {
	@Autowired
	private PackageService packageService;
	
	@Autowired
	private NoticeService noticeService;
	
	@Autowired
	private ClientCheckService checkService;
	
	
	@RequestMapping("/index")
	public String index(Model model) {
		model.addAttribute("mailList",packageService.mailList());	
		model.addAttribute("noticeList",noticeService.getNoticeListdiv());
		model.addAttribute("packageList",checkService.packageCheckdiv());
		model.addAttribute("deliveryList",packageService.deliveryList());
	
		return "index";
	}
	
	
	
	
	
	
}
