package com.postoffice.web.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.postoffice.web.dto.DeptDTO;
import com.postoffice.web.dto.MemberDTO;
import com.postoffice.web.dto.VMemberDTO;
import com.postoffice.web.dto.VillageDTO;
import com.postoffice.web.service.LoginResult;
import com.postoffice.web.service.LoginService;

@Controller
public class LoginController {
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	private LoginService loginService;
	
	
	@RequestMapping("/")
	public String login(Model model, HttpSession session) {
		String error = (String) session.getAttribute("error");
		String lauthority = (String) session.getAttribute("lauthority");
		
		//아이디 또는 비밀번호 틀렸을 때 실행 
		if(error != null) {
			if(error.equals("fail_lid")) {
				model.addAttribute("lidError", "*아이디가 존재하지 않습니다.");
			} else if(error.equals("fail_lpassword")) {
				model.addAttribute("lpasswordError", "*비밀번호가 틀렸습니다.");
			} else if(error.equals("lauthorityError")){
				model.addAttribute("lauthorityError", "*권한이 없습니다.");
			}
			session.removeAttribute("error");
		}
		
		//이미 로그인 상태일 때 로그인 페이지로 돌아갈 수 없도록 실행
		if(lauthority != null) {
			if(lauthority.equals("manager")) {
				return "redirect:/";
			} else if(lauthority.equals("admin")) {
				return "redirect:/";
			} else {
				return "redirect:/client_index";
			}
		}
		
		//error, mauthority 둘다 null이면 실행 
		return "login";
	}
	
	@RequestMapping("clientIndex")
	public String clientIndex() {
		return "client/index";
	}
	
	@PostMapping("/login")
	public String loginConfirm(String lid, String lpassword, String lauthority, 
			HttpSession session,HttpServletRequest request,HttpServletResponse response,Model model) throws Exception{
		if(lauthority.equals("manager") || lauthority.equals("admin")) { //직원 또는 관리자가 로그인할 때 
			LoginResult result = loginService.mLogin(lid, lpassword);
			
			//로그인 실패했을 때 실행
			if(result == LoginResult.FAIL_LID) {
				session.setAttribute("error", "fail_lid");
				return "redirect:/";
			}else if(result == LoginResult.FAIL_LPASSWORD) {
				session.setAttribute("error", "fail_lpassword");
				return "redirect:/";
			}
			
			//로그인 성공했을 때 실행
			session.setAttribute("lid", lid); //세션에 로그인 정보 저장
			String dept_name = loginService.getDeptName(lid);
			String mname = loginService.getMname(lid);
			session.setAttribute("mname", mname);

			session.setAttribute("dept_name", dept_name);
			session.setAttribute("lauthority", lauthority);	//세션에 로그인 정보 저장
			if(lauthority.equals("manager")) {
				logger.debug("직원 로그인");
				return "redirect:/index"; //직원이 로그인했을 때 이동하는 페이지
			} else {
				logger.debug("관리자 로그인");
				return "redirect:/index"; //관리자가 로그인했을 때 이동하는 페이지
			}
			
		}else { //이장님이 로그인했을 때
			LoginResult result = loginService.cLogin(lid, lpassword);
			
			//로그인 실패했을 때 실행
			if(result == LoginResult.FAIL_LID) {
				session.setAttribute("error", "fail_lid");
				return "redirect:/";
			}else if(result == LoginResult.FAIL_LPASSWORD) {
				session.setAttribute("error", "fail_lpassword");
				return "redirect:/";
			}
			
			//로그인 성공했을 때 실행
			VMemberDTO userInfo = loginService.userInfo(lid);
			
			session.setAttribute("lid", userInfo.getVmid()); //세션에 로그인 정보 저장
			//String vname = loginService.getVname(lid);
			session.setAttribute("vname", userInfo.getVmname());
			session.setAttribute("lauthority", lauthority);	//세션에 로그인 정보 저장
			session.setAttribute("vname", userInfo.getVillageList().get(0).getVname());
			session.setAttribute("vid", userInfo.getVillageList().get(0).getVid());
			logger.debug("이장님 로그인");
			
			String vmname = loginService.vmnrequest(lid);
			session.setAttribute("vmname", vmname);
			VMemberDTO vmember=new VMemberDTO();
			String grade = vmember.getGrade();
			System.out.println(grade+"=+++++++++++++++++++++++++++++++++++@@@@@@@+!#!#");
			return "client/index"; //이장님이 로그인했을 때 이동하는 페이지
		} 
	}
	
	
	//로그인 했을때 사진 정보 주기
	@RequestMapping("/vmemeberphoto")
	public String vmphoto(HttpSession session,HttpServletRequest request,
			HttpServletResponse response,Model model) throws Exception{
		//session을 통해 사진 확인
		String sessioninfo = (String)session.getAttribute("lid");
		System.out.println("sessioninfo:"+sessioninfo);
		String vlist = loginService.vmphotofind(sessioninfo);
		
		ServletContext application = request.getServletContext();
		
		String userAgent = request.getHeader("User-Agent");
		
		String downloadName;
		if(userAgent.contains("Trident/7.0") || userAgent.contains("MSIE")) {
			//IE11 버전 또는 IE10 이하 버전에서 한글 파일을 복원하기 위해
			downloadName = URLEncoder.encode(vlist, "UTF-8");
		} else { 
			//WebKit 기반 브라우저(Chrome, Safari, FireFox, Opera, Edge)에서 한글 파일을 복원하기 위해
			downloadName = new String(vlist.getBytes("UTF-8"), "ISO-8859-1");
		}
		response.setHeader("Content-Disposition", "attachment; filename=\"" + downloadName + "\"");
		
		String realPath = application.getRealPath("/WEB-INF/views/images/"+vlist);
		
		File file = new File(realPath);
		
		response.setHeader("Content-Length", String.valueOf(file.length()));
		
		//응답 본문에 데이터 추가
		InputStream is = new FileInputStream(realPath);
		OutputStream os = response.getOutputStream();
		
		byte[] buffer = new byte[1024];
		while(true) {
			int readByte = is.read(buffer);
			
			if(readByte == -1) break;
			os.write(buffer, 0, readByte);
		}
		os.flush();
		os.close();
		is.close();
		
		return "client/index";
		}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("lid");
		session.removeAttribute("lauthority");
		return "redirect:/";
	}
	
	@GetMapping("/join")
	public String joinForm(Model model) {
		List<VillageDTO> vlist =  loginService.getVlist();
		List<DeptDTO> dlist = loginService.getdlist();
		model.addAttribute("vlist",vlist);
		model.addAttribute("dlist",dlist);
		return "joinForm";
	}
	
	@PostMapping("/join") 
	public String join(String lid, String lname, String lpassword, String ltel,
			MultipartFile lphoto, String lauthority, String vname, String deptName,
			HttpServletRequest request, Model model) throws Exception {
		
		
		logger.debug(lid);
		logger.debug(lname);
		logger.debug(lpassword);
		logger.debug(lphoto.getOriginalFilename());
		logger.debug(lphoto.getContentType());
		logger.debug(""+lphoto.getSize());
		logger.debug(lauthority);
		logger.debug(vname);
		logger.debug(deptName);
		MemberDTO member = new MemberDTO();
		
		VMemberDTO vmember = new VMemberDTO();
		
		ServletContext application = request.getServletContext();
		String savePath = application.getRealPath("/WEB-INF/views/images/");
		
		//사진이 첨부되어 있다면 DTO에 저장 
		if(!lphoto.isEmpty()) {
			logger.debug("실행");
			String saveFileName = new Date().getTime() + "-" + lphoto.getOriginalFilename();
			lphoto.transferTo(new File(savePath + saveFileName));
			if(lauthority.equals("manager") || lauthority.equals("admin")) {
				member.setMphoto(saveFileName);
				logger.debug("실행");
			} else {
				vmember.setVmphoto(saveFileName);
			}
		}
		
		//직원(관리자) 또는 이장님이 회원가입할 때 정보를 저장
		if(lauthority.equals("manager") || lauthority.equals("admin")) {
			member.setMid(lid);
			member.setMname(lname);
			member.setMpassword(lpassword);
			member.setMtel(ltel);
			member.setMauthority(lauthority);
			member.setDept_id(deptName);
			loginService.mJoin(member);
			return "redirect:/";
		} else {
			vmember.setVmid(lid);
			vmember.setVmname(lname);
			vmember.setVmpassword(lpassword);
			vmember.setVmtel(ltel);
			vmember.setVid(vname);
			
				//첫번째 문제점:우리는 회원가입할때 정보를 저장한다. 근데 ???? grade 는 매퍼에서 고정값으로 준거라 폼에서 넘겨지지가 않으니 여기서 매개변수로 저장을 받을수 없다
				//인풋타입을 써야함 인풋타입을쓰면? 흐름타고 가서 할거 ㅈㄴ많음
				
				//인풋타입을 안쓰면? 값을 넘겨서 지금 저장하는게 힘듬  명상이형은 뷰에 뿌려질정보가 없기때문이다~!~##~$#
				
			loginService.cJoin(vmember);
			
			return "redirect:/";
		}
		
	}
	
	@RequestMapping("/lidCheck")
	public void lidCheck(String lid, String lauthority, HttpServletResponse response) throws Exception{
		logger.debug(lid);
		logger.debug(lauthority);
		boolean result;
		if(lauthority.equals("manager") || lauthority.equals("admin")) {
			result = loginService.mLidCheck(lid);
		} else {
			result = loginService.cLidCheck(lid);
		}
		response.setContentType("application/json; charset=UTF-8"); 
		PrintWriter pw = response.getWriter(); 
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("result", result); 
		pw.print(jsonObject.toString());
		pw.flush(); 
		pw.close();
	}
	
	@RequestMapping("/clientTouch")
	public String vmberDTO(String lid,Model model,HttpSession session){
		session.setAttribute("lid",lid);
		
		List<VMemberDTO>vmemberList = loginService.vmemberList(lid);
		System.out.println(vmemberList.isEmpty());
		model.addAttribute("vmemberList",vmemberList);
		return "client/clientTouch";
	}
	
	@RequestMapping("/clientAfterWrite")
	public String clientAfterWrite(String vmphoto, VMemberDTO vmdto ,MultipartFile lphoto,Model model,HttpSession session) {
		System.out.println(vmdto.getVmid());
		loginService.vmemAfter(vmdto);
		String fileName = lphoto.getOriginalFilename();
		
		System.out.println(vmdto.getVmid());
		String saveFileName = null;
		//System.out.println("test : " + lphoto.getOriginalFilename());
		System.out.println("before : " + vmphoto);
		System.out.println("lphoto : "+ lphoto);
		if(fileName == null || fileName.equals("")) {
			System.out.println("if문 통과 :"+vmphoto);
			saveFileName = vmphoto;
		}else {
			saveFileName = new Date().getTime() + "-" +fileName;
		}
		
		System.out.println("after : " + saveFileName);
		
		loginService.chaneFile(vmdto,saveFileName);
		System.out.println(saveFileName+")))))))))))))))))))");
		System.out.println("성공성공성공성공성공성공성공성공성공성공성공");
		
		
		session.setAttribute("vmname", vmdto.getVmname());
		model.addAttribute(vmdto);
		model.addAttribute("vmname",session.getAttribute("vmname"));
		
		return "redirect:/client_index";
	}
}
