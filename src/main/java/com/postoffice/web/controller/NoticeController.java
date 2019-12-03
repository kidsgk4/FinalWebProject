
package com.postoffice.web.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import com.postoffice.web.dto.NoticeDTO;
import com.postoffice.web.service.NoticeService;



@Controller
public class NoticeController {
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	@Autowired
	private NoticeService noticeService;

	@RequestMapping("/noticeList")
	public String noticeList(Model model, @RequestParam(defaultValue = "1") int pageNum, HttpSession session, NoticeDTO noticeDTO) {	

		
		session.setAttribute("pageNum", pageNum);
		
		//String lid = (String)session.getAttribute("lid");
		//session.setAttribute("mid", lid);
		//페이지당 행 수
		int rowsPerPage = 10;
		//이전, 다음을 클릭했을 때 나오는 페이지 수
		int pagesPerGroup = 5;
		//전체 게시물 수
		int totalRowNum = noticeService.getTotalRowNum();
		//전체 페이지 수
		int totalPageNum=totalRowNum / rowsPerPage;
		if(totalRowNum % rowsPerPage !=0) totalPageNum++;
		//전체 그룹 수
		int totalGroupNum = totalPageNum/pagesPerGroup;
		if(totalPageNum % pagesPerGroup != 0) totalGroupNum++;
		//현재 페이지의 그룹번호
		int groupNum = (pageNum-1)/pagesPerGroup +1;
		//현재 그룹의 시작 페이지 번호
		int startPageNum = (groupNum-1)*pagesPerGroup+1;
		//현재 그룹의 마지막 페이지 번호
		int endPageNum =startPageNum + pagesPerGroup -1;
		if(groupNum == totalGroupNum) endPageNum = totalPageNum;
		//현재 페이지의 시작 행번호
		int startRowNum = (pageNum-1)*rowsPerPage +1; 
		//현재 페이지의 끝 행번호
		int endRowNum = pageNum * rowsPerPage;
		if(pageNum == totalPageNum) endRowNum = totalRowNum;

		
		
		List<NoticeDTO>noticeList =noticeService.getNoticeList(startRowNum,endRowNum);
		
		model.addAttribute("pagesPerGroup", pagesPerGroup);
		model.addAttribute("totalPageNum", totalPageNum);
		model.addAttribute("totalGroupNum", totalGroupNum);
		model.addAttribute("groupNum", groupNum); 
		model.addAttribute("startPageNum",startPageNum);
		model.addAttribute("endPageNum", endPageNum);
		model.addAttribute("pageNum", pageNum); 
		
		model.addAttribute("noticeList",noticeList);		 

		
		
		
	return "manager/noticeList";
	}
	
	
	//noticeList(공지사항 목록) 검색기능
	@RequestMapping("/noticeSearch")
	public String noticeSearch(String searchNotice, String searchWord, Model model, @RequestParam(defaultValue = "1") int pageNum, HttpSession session) {
		if (searchNotice != null) {
			System.out.println("첫번쨰");
			
		} else {
			System.out.println("두번쨰");
			
		}
		session.setAttribute("pageNum", pageNum);
		System.out.println(session.getAttribute("searchNoticeGet")+"//0000000//////////////////////");
		System.out.println(session.getAttribute("searchWordGet")+"///00000000000////////////////////");

		
		//페이징 클릭해서 들어왔을때
		String searchNotice_get = null;
		
		if(searchNotice == null) {
			searchNotice_get = (String)session.getAttribute("searchNoticeGet");
		}
		else {
			session.setAttribute("searchNoticeGet", searchNotice);
		}
		
		String searchWord_get = null;
		
		if(searchWord == null) {
			searchWord_get = (String)session.getAttribute("searchWordGet");
		}
		else {
			session.setAttribute("searchWordGet", searchWord);
		}
		
		int totalRowNum=0;

		//페이지당 행 수
		int rowsPerPage = 10;
		//이전, 다음을 클릭했을 때 나오는 페이지 수
		int pagesPerGroup = 5;
		//전체 게시물 수	
		//페이징이동
		if(searchWord_get != null) {
			if(searchNotice_get.equals("notice_title")) {
				totalRowNum = noticeService.SearchTitleTotalRowNum(searchNotice_get,searchWord_get);
			}
			else if(searchNotice_get.equals("mname")) {
				totalRowNum = noticeService.MnameSearchTotalRowNum(searchNotice_get,searchWord_get);
				System.out.println(totalRowNum +"이름+++++++++++++++++++++++++++++++++++22222");
			}
		}
		//처음 검색시
		else {
			if(searchNotice.equals("notice_title")) {
				totalRowNum = noticeService.SearchTitleTotalRowNum(searchNotice,searchWord);

				
			}
			else if(searchNotice.equals("mname")) {
				totalRowNum = noticeService.MnameSearchTotalRowNum(searchNotice,searchWord);

				
			}
		}
		//전체 페이지 수
		int totalPageNum=totalRowNum / rowsPerPage;
		if(totalRowNum % rowsPerPage !=0) totalPageNum++;
		//전체 그룹 수
		int totalGroupNum = totalPageNum/pagesPerGroup;
		if(totalPageNum % pagesPerGroup != 0) totalGroupNum++;
		//현재 페이지의 그룹번호
		int groupNum = (pageNum-1)/pagesPerGroup +1;
		//현재 그룹의 시작 페이지 번호
		int startPageNum = (groupNum-1)*pagesPerGroup+1;
		//현재 그룹의 마지막 페이지 번호
		int endPageNum =startPageNum + pagesPerGroup -1;
		if(groupNum == totalGroupNum) endPageNum = totalPageNum;
		//현재 페이지의 시작 행번호
		int startRowNum = (pageNum-1)*rowsPerPage +1;			
		//현재 페이지의 끝 행번호
		int endRowNum = pageNum * rowsPerPage;
		if(pageNum == totalPageNum) endRowNum = totalRowNum;
		
		List<NoticeDTO> noticeSearch = null;
		if(searchWord !=null && searchNotice !=null) {
			noticeSearch = noticeService.noticeSearch(searchNotice, searchWord, startRowNum, endRowNum);
		}
		else {
			noticeSearch = noticeService.noticeSearch(searchNotice_get,searchWord_get,startRowNum,endRowNum);
		}
		
		model.addAttribute("pagesPerGroup", pagesPerGroup);
		model.addAttribute("totalPageNum", totalPageNum);
		model.addAttribute("totalGroupNum", totalGroupNum);
		model.addAttribute("groupNum", groupNum); 
		model.addAttribute("startPageNum",startPageNum);
		//title검색
		model.addAttribute("endPageNum", endPageNum);
		model.addAttribute("pageNum", pageNum); 
		model.addAttribute("noticeList",noticeSearch);		

		return"manager/noticeSearch";
	}

	// 공지사항 작성 폼
	@GetMapping("/noticeWrite")
	public String noticeWriteForm(Model model, HttpSession session) {
		//session에서 mname(직원이름), dept_name(부서명)가져오기
		String mname = (String)session.getAttribute("mname");
		String dept_name = (String)session.getAttribute("dept_name");
		
		if(mname == null) {
			return "redirect:/";
		}
		return "manager/noticeWrite";
	}

	
	// 공지사항 작성 처리
	@PostMapping("/noticeWrite")
	public String noticeWrite(NoticeDTO noticeDTO, HttpSession session,HttpServletRequest request,@RequestParam("attachFile")MultipartFile attachFile, Model model) throws Exception{
		noticeDTO.setMid((String) session.getAttribute("lid"));

		//첨부파일 업로드
		String savePath = request.getServletContext().getRealPath("/resources/");
		
		if(!attachFile.isEmpty()) {
			String saveFileName = new Date().getTime() +"-"+ attachFile.getOriginalFilename();
			
			attachFile.transferTo(new File(savePath + saveFileName));
			
			noticeDTO.setNotice_attach_file(saveFileName);
			
		}
		noticeService.noticeWrite(noticeDTO);
		
		return "redirect:/noticeList";
	}
	//세부정보 확인
	@RequestMapping("/noticeDetail")
	public String noticeDetailForm(Model model, HttpSession session, NoticeDTO noticeDTO) {
		NoticeDTO noticedetail = noticeService.noticeDetail(noticeDTO);
		model.addAttribute("noticedetail", noticedetail);
		
		
		return "manager/noticeDetail";
	}
	
	@RequestMapping("/filedownload")
	public void noticeFiledownload(@RequestParam("notice_id") String notice_id,
							@RequestParam("NFileName") String NFileName,
							Model model, HttpServletRequest request, HttpServletResponse response) throws Exception{
		//파일 다운받기
		NoticeDTO notice = noticeService.getnotice(Integer.parseInt(notice_id));
		
		NFileName = notice.getNotice_attach_file();

		String mimeType = request.getServletContext().getMimeType(NFileName);
		response.setHeader("Content-Type", mimeType);
				
		String userAgent = request.getHeader("User-Agent");
		String downloadName;
				
		if(userAgent.contains("Trident7.0") || userAgent.contains("MSIE")) {
			downloadName = URLEncoder.encode(NFileName,"UTF-8");
		}else {
			downloadName = new String(NFileName.getBytes("UTF-8"), "ISO-8859-1");
		}
		response.setHeader("Content-Disposition", "attachment; fileName=\"" + downloadName + "\"");
				
		String realPath = request.getServletContext().getRealPath("/resources/" + NFileName);
		File file = new File(realPath);
		response.setHeader("Content-Length", String.valueOf(file.length()));
				
		OutputStream os = response.getOutputStream();
		InputStream is = new FileInputStream(realPath);
				
		byte[] buffer = new byte[1024];
		while(true) {
			int readByte = is.read(buffer);
			if(readByte == -1) break;
			os.write(buffer,0, readByte);
		}
		os.flush();
		os.close();
		is.close();
		
	}
	
	
	@GetMapping("/noticeUpdate")
	public String noticeUpdateForm(NoticeDTO noticeDTO, Model model, HttpSession session) {
		NoticeDTO notice = noticeService.getnotice(noticeDTO.getNotice_id());

		model.addAttribute("notice", notice);
		return "manager/noticeUpdate";
	}
	
	@PostMapping("/noticeUpdate")
	public String noticeUpdate(NoticeDTO noticeDTO, HttpSession session,HttpServletRequest request, @RequestParam("attachFile")MultipartFile attachFile)throws Exception {
		
		MemberDTO dto = new MemberDTO();
		dto.setMid((String)session.getId());
		
		//첨부파일 업로드
		//기존 파일 명 불러오기
		String oldFileName = attachFile.getOriginalFilename();
		//새로 저장될 파일 명
		String saveFileName = null;
		//저장 경로
		String savePath =request.getServletContext().getRealPath("/resources/");
		 
		if(oldFileName == null || oldFileName.equals("")) {
			saveFileName = noticeDTO.getNotice_attach_file();
		}
		
		else if(!attachFile.isEmpty()) { 
			saveFileName = new Date().getTime() +"-"+ oldFileName;
		
			attachFile.transferTo(new File(savePath + saveFileName));
		  
			noticeDTO.setNotice_attach_file(saveFileName);
		 
		}
		
		noticeService.noticeupdate(noticeDTO);
		return "redirect:/noticeDetail?notice_id=" +noticeDTO.getNotice_id();
	}
	
	@RequestMapping("/noticeDelete")
	public String noticeDelete(NoticeDTO noticeDTO, HttpSession session) {
		noticeService.noticeDelete(noticeDTO);
		int test = noticeDTO.getNotice_id();
		logger.debug(""+test);
		return "redirect:/noticeList";
	}
	
	

}
