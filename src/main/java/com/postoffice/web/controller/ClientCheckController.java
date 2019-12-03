package com.postoffice.web.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.postoffice.web.dto.MailDTO;
import com.postoffice.web.dto.PackageDTO;
import com.postoffice.web.dto.VillageDTO;
import com.postoffice.web.service.ClientCheckService;
import com.postoffice.web.service.ClientStateCheckService;
import com.postoffice.web.service.GcsService;
import com.postoffice.web.service.LoginService;
import com.postoffice.web.service.PackageService;

@Controller
public class ClientCheckController {
	
	@Autowired
	private ClientCheckService checkService;
	@Autowired
	private ClientStateCheckService clientStateCheckService;
	@Autowired
	private LoginService loginService;
	@Autowired
	private PackageService packageService;
	@Autowired 
	private GcsService gcsService;
	 
	
	
	@RequestMapping("/check")
	public ModelAndView selectAll(Model model,HttpSession session) {
		String vid=(String)session.getAttribute("vid");
		
		System.out.println(vid);
		List checkList = checkService.selectAll();
		List stateList = clientStateCheckService.selectList();
		ModelAndView mav=new ModelAndView("client/requestCheck");
		
		
		model.addAttribute("CheckList",checkList);
		model.addAttribute("stateList", stateList);

		return mav;
	}
	@RequestMapping("/packageCheck")
	public String packageSelect(Model model,HttpSession session) {
		String vid=(String)session.getAttribute("vid");
		PackageDTO p=new PackageDTO();
		System.out.println(vid);
		List packageList=checkService.packageSelect();
		
		
		for(int i =0; i < packageList.size();i++) {
			System.out.println(packageList.get(i));
		}
		model.addAttribute("packageList",packageList);
		return "client/packageCheck";
	
	}
	
	  @RequestMapping("/stateCheck")
	  public String stateCheck(Model model,HttpServletRequest request) {
	  MailDTO mailDTO=new MailDTO();
	  mailDTO.setMail_id(Integer.parseInt(request.getParameter("mail_id")));
	  mailDTO.setState_id(request.getParameter("state_id"));
	  
	  int result = checkService.updateStateProc(mailDTO);
	  System.out.println(mailDTO.getState_id());
	  
	 
	  return "redirect:/check";
	  
	  }
	 
	//접수요청임 ㅇㅋ?
	@RequestMapping("/registRequest")
	public String registRequest(int package_id,HttpServletRequest request) {
		/*
		 * PackageDTO pack=new PackageDTO();
		 * pack.setState_id(request.getParameter("state_id"));
		 */
		gcsService.sendMessageToGcs("attachFinish");
		System.out.println(package_id);
		checkService.registRequest(package_id);
		return "redirect:/packageCheck";
	}
	
	@RequestMapping("/beforeCheckList")
	public String beforeCheckList(Model model) {
		
		List beforeList=checkService.beforeSelectAll();
		model.addAttribute("beforeList",beforeList);
		return "client/beforeCheckList";
	}
	
	@RequestMapping("/cancel")
	public String cancel(int package_id) {
		checkService.cancel(package_id);
		gcsService.sendMessageToGcs("requestCancel");
		return "redirect:/packageCheck";
	}
	@RequestMapping("packageDetail")
	public String packageDetail(int package_id,Model model) {
		PackageDTO detailList=checkService.packageDetail(package_id);
		/*
		 * for(int i=0; i<detailList.getMailList().size(); i++) {
		 * System.out.println(detailList.getMailList().get(i).getFrom_name() + "/" +
		 * detailList.getMailList().get(i).getMail_id()); }
		 */
		model.addAttribute("detail",detailList);
		return "client/packageDetail";
	}
	@RequestMapping("/registList")
	public String registList(Model model) {
		List packageList=checkService.packageSelect();
		model.addAttribute("packageList",packageList);
		return "client/beforePackagingList";
	}
	@RequestMapping("/villageArrive")
	public String villageArrive(int package_id) {
		gcsService.sendMessageToGcs("attachFinish");
		checkService.villageArrive(package_id);
		return "redirect:/packageCheck";
	}
	//현황 페이지 팝업 메서드
	@RequestMapping("/deliveryMap")
	public String current() {
		
		return "client/deliveryMap";
	}
	@RequestMapping("villageSendPath")
	public void villageSendPath(HttpSession session, HttpServletResponse response, Model model) throws IOException{
		String vid = (String)session.getAttribute("vid");
		System.out.println(vid);
		String path = checkService.selectSendPath(vid);
		
		System.out.println(path);
		response.setContentType("application/json; charset=UTF-8");
		
		JSONArray jsonArray = new JSONArray(path);
		JSONObject jsonObject = new JSONObject();
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
		
		PrintWriter pw = response.getWriter();
		pw.write(json);
		pw.flush();
		pw.close();
		

	}
	
}


