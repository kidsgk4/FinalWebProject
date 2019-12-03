package com.postoffice.web.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.postoffice.web.dto.MailDTO;
import com.postoffice.web.dto.StateDTO;
import com.postoffice.web.service.ClientRequestService;
import com.postoffice.web.service.GcsService;
import com.postoffice.web.service.LoginService;

@Controller
public class ClientRequestController {
	private static final Logger logger = LoggerFactory.getLogger(ClientRequestController.class);

	@Autowired
	private ClientRequestService requestService;
	@Autowired
	private LoginService loginService;
	@Autowired 
	private GcsService gcsService;
	

	
	@RequestMapping("/client_index")
	public String client_index(HttpSession session, Model model){
		String lid = (String)session.getAttribute("lid");
		String vlist = loginService.vmphotofind(lid);
		model.addAttribute("vlist",vlist);
		model.addAttribute("lid",lid);

		return "client/index";
	}
	
	@RequestMapping("/mailpackaging")
	public String mailpackaging(Model model,
			@RequestParam(value="mailIdList[]")List<String>mailIdList,
			@RequestParam(value="totalWeight") String totalWeight,HttpSession session)throws Exception{
			String vid = (String)session.getAttribute("vid");
			System.out.println("totalWeight:"+totalWeight);
			System.out.println("mailIdList:"+mailIdList);
			System.out.println("vid:"+vid);
			requestService.mailPackaging(mailIdList,totalWeight,vid);
			gcsService.sendMessageToGcs("requestDrone");
			
		return "redirect:/requestBoarderList";
	}

	@RequestMapping("/requestBoarderList")
	public String requestBoarderList(Model model,HttpSession session,
					@RequestParam(defaultValue = "1") int pageNo, 
					@RequestParam(defaultValue = "0") String totalWeight,
					@RequestParam(defaultValue = "garbage") String totalMailId){
		
		session.setAttribute("pageNo", pageNo);

		String sessioninfo = (String)session.getAttribute("lid");
		System.out.println("sessioninfo:"+sessioninfo);
		int rowsPerPage = 10;
		int pagesPerGroup = 5;

		String vid = (String)session.getAttribute("vid");
		int totalRowNum = requestService.getTotalRowNo(vid);
	
		int totalPageNum = totalRowNum / rowsPerPage;
		if (totalRowNum % rowsPerPage != 0)
			totalPageNum++;
		// 전체 그룹 수
		int totalGroupNum = totalPageNum / pagesPerGroup;
		if (totalPageNum % pagesPerGroup != 0)
			totalGroupNum++;

		// 현재 페이지의 그룹번호
		int groupNo = (pageNo - 1) / pagesPerGroup + 1;
		// 현재 그룹의 시작 페이지 번호
		int startPageNo = (groupNo - 1) * pagesPerGroup + 1;
		// 현재 그룹의 마지막 페이지 번호
		int endPageNo = startPageNo + pagesPerGroup - 1;
		if (groupNo == totalGroupNum)
			endPageNo = totalPageNum;

		// 현재 페이지의 시작 행번호
		int startRowNo = (pageNo - 1) * rowsPerPage + 1;
		// 현재 페이지의 끝 행번호
		int endRowNo = pageNo * rowsPerPage;
		if (pageNo == totalPageNum)
			endRowNo = totalRowNum;
		
		String sessionvid = (String)session.getAttribute("vid");
		List<MailDTO> MailList = requestService.selectMailList(startRowNo, endRowNo ,vid);
		// JSP로 페이지 정보 넘기기
		
		model.addAttribute("pagesPerGroup", pagesPerGroup);// model의 경우 jsp페이지로 넘길때 해당 페이지가, PL표현식으로 넘겨질수 있기 떄문에 이 표현식을
															// 씀
		model.addAttribute("totalPageNum", totalPageNum);
		model.addAttribute("totalRowNum",totalRowNum);
		model.addAttribute("totalGroupNum", totalGroupNum);
		model.addAttribute("groupNo", groupNo);
		model.addAttribute("startPageNo", startPageNo);
		model.addAttribute("endPageNo", endPageNo);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("MailList", MailList);
		model.addAttribute("totalWeight", totalWeight);
		model.addAttribute("totalMailId", totalMailId);
		return "client/requestBoarderList";
	}

	//req_next값 가져오기
	 @RequestMapping("/requestWrite")
	 	public String mailadd1(Model model,HttpSession session) { 
		 //ystem.out.println("vmlid:"+vmlid);
		 //String vname = requestService.getvname(vmid);
		 
		 String sessionvid = (String)session.getAttribute("vid");
		 int num = requestService.getTotalRowNo(sessionvid)+1;
		 model.addAttribute("vmlid",session.getAttribute("lid"));
		 model.addAttribute("vname", session.getAttribute("vname"));
		 model.addAttribute("vid", session.getAttribute("vid"));
		 model.addAttribute("num",num);
		 return "client/requestWrite"; 
	}
	 @RequestMapping("/requestanswer")
	 public String answer(MailDTO maildto,Model model) {
		 requestService.getanswer(maildto);
		 return "redirect:/requestBoarderList";
	 }
	 
	
	//요청 삭제
	@RequestMapping("/requestRemove")
	public String requestRemove(String mail_id) {
		requestService.requestRemove(mail_id);
		return "redirect:/requestBoarderList";
	}
	@RequestMapping("/mailAdd")
		public String mailadd() {
			return "client/mailAdd";
		}
	
	
	//내가 썻던 게시물 정보부터 가져오기
	@RequestMapping("/boardDetail")
	public String boardDetail(int mail_id, Model model) {
		MailDTO board = requestService.getBoard(mail_id);
		model.addAttribute("board",board);
		return "client/boardDetail";
	}
	
	//게시물 수정한것 저장하기
	@RequestMapping("/updateBoard")
	public String updateBoard(MailDTO board, HttpSession session) {
		requestService.update(board);
		
		int pageNo = (Integer)session.getAttribute("pageNo");
		return "redirect:/requestBoarderList";
	}
	
	//search기능
	@RequestMapping("/searchBoard")
	public String searchBoard(
						//@RequestParam(value="mailIdList[]")List<String>mailIdList,
						//@RequestParam(value="totalWeight") String totalWeight,
						String searchType,String keyword,
						Model model,@RequestParam(defaultValue = "1") int pageNo,
						HttpSession session) {
		int totalRowNums = 0;
		session.setAttribute("keyword", keyword);
		String vid = String.valueOf(session.getAttribute("vid"));
		session.setAttribute("pageNo", pageNo);
		int rowsPerPage = 10;
		int pagesPerGroup = 5;
		System.out.println(searchType+"adhlsadlkasdlkdjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj");
		if(searchType.equals("keyword")) {
			totalRowNums = requestService.SearchTotalRowNum(searchType);
		}
		
		String sessionvid = (String)session.getAttribute("vid");
		int totalRowNum = requestService.getTotalRowNo(sessionvid);
		int totalPageNum = totalRowNum / rowsPerPage;
		if (totalRowNum % rowsPerPage != 0)
			totalPageNum++;
		int totalGroupNum = totalPageNum / pagesPerGroup;
		if (totalPageNum % pagesPerGroup != 0)
			totalGroupNum++;

		// 현재 페이지의 그룹번호
		int groupNo = (pageNo - 1) / pagesPerGroup + 1;
		// 현재 그룹의 시작 페이지 번호
		int startPageNo = (groupNo - 1) * pagesPerGroup + 1;
		// 현재 그룹의 마지막 페이지 번호
		int endPageNo = startPageNo + pagesPerGroup - 1;
		if (groupNo == totalGroupNum)
			endPageNo = totalPageNum;

		// 현재 페이지의 시작 행번호
		int startRowNo = (pageNo - 1) * rowsPerPage + 1;
		// 현재 페이지의 끝 행번호
		int endRowNo = pageNo * rowsPerPage;
		if (pageNo == totalPageNum)
			endRowNo = totalRowNum;

		List<MailDTO> MailList = requestService.fromsearch(searchType,keyword,startRowNo, endRowNo,vid);
		
		StateDTO dto = new StateDTO();
		
		model.addAttribute("totalPageNum", totalPageNum);
		model.addAttribute("totalRowNum",totalRowNum);
		model.addAttribute("totalGroupNum", totalGroupNum);
		model.addAttribute("groupNo", groupNo);
		model.addAttribute("startPageNo", startPageNo);
		model.addAttribute("endPageNo", endPageNo);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("MailList", MailList);
		model.addAttribute("stateName", dto.getState_name());
		System.out.println(" : " + dto.getState_name());
		
		return "client/requestBoarderList";
	}
}