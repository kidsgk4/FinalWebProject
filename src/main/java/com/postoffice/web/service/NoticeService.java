package com.postoffice.web.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.postoffice.web.dao.NoticeDAO;
import com.postoffice.web.dto.DeptDTO;
import com.postoffice.web.dto.MemberDTO;
import com.postoffice.web.dto.NoticeDTO;

@Service
public class NoticeService {

	@Autowired
	private NoticeDAO noticeDAO;
	//noticeList에 대한 페이징 처리
	public int getTotalRowNum() {
		int totalRowNum = noticeDAO.selectTotalRowNum();
		return totalRowNum;
	}
	//TitleSearch에 대한 페이징 처리
	public int SearchTitleTotalRowNum(String searchNotice,String searchWord) {
		int totalRowNum = noticeDAO.SearchTitleTotalRowNum(searchNotice,searchWord);
		return totalRowNum;
	}
	
	//MidSearch에 대한 페이징 처리 
	public int MnameSearchTotalRowNum(String searchNotice,String searchWord) { 
		return noticeDAO.MnameSearchTotalRowNum(searchNotice,searchWord); 
	}
	 
	

	public List<NoticeDTO> getNoticeList(int startRowNum, int endRowNum) {
		List <NoticeDTO> noticeList = noticeDAO.selectList(startRowNum, endRowNum);
		
		return noticeList;
	}

	SimpleDateFormat format = new SimpleDateFormat ("yyyy-MM-dd");

	public void noticeDelete(NoticeDTO noticeDTO) {
		noticeDAO.deleteDelete(noticeDTO);
		
	}
	//noticeList검색부분 리스트 select
	public List<NoticeDTO> noticeSearch(String searchNotice, String searchWord, int startRowNum, int endRowNum) {
		List<NoticeDTO> noticeSearch=noticeDAO.noticeSearch(searchNotice, searchWord, startRowNum, endRowNum);
		
		return noticeSearch;
	}
	
	//noticeDetail(수정테스트)
	public NoticeDTO noticeDetail(NoticeDTO noticeDTO){
		NoticeDTO noticeList = noticeDAO.selectDetail(noticeDTO);
		return noticeList;
	}
	
	
	public void noticeWrite(NoticeDTO noticeDTO) {	
		noticeDAO.noticeinsert(noticeDTO);
			
	}
	
	//공지사항 세부정보 가져오기
	public NoticeDTO getnotice(int notice_id) {
		NoticeDTO noticeDTO = noticeDAO.selectNotice(notice_id);
		return noticeDTO;
	}
	
	public MemberDTO selectMember(NoticeDTO dto) {
		MemberDTO memberDTO = noticeDAO.selectmember(dto);
		return memberDTO;
	}
	
	public DeptDTO selectDept(MemberDTO Mdto) {
		DeptDTO deptDto = noticeDAO.selectdept(Mdto);
		return deptDto;
	}

	
	public MemberDTO showMember(MemberDTO dto) {
		return noticeDAO.showMember(dto);
	}
	
	//공지사항 수정
	public void noticeupdate(NoticeDTO noticeDTO) {
		noticeDAO.noticeupdate(noticeDTO);
	}
	
	
	
	//테스트 코드
	public List<MemberDTO> testMember(){
		List<MemberDTO> list = noticeDAO.testMember();
		List<NoticeDTO> list2 = noticeDAO.testNotice();
		
		System.out.println("--------------------------------------------");
		for(int i = 0; i < list.size(); i++) {
			MemberDTO dto = list.get(i);
			System.out.println("dept id : " + dto.getDept_id());
			System.out.println("id : " + dto.getMid());
			System.out.println("name : " + dto.getMname());
		}
		System.out.println("--------------------------------------------");

		System.out.println("--------------------------------------------");
		for(int i = 0; i < list2.size(); i++) {
			NoticeDTO dto = list2.get(i);
			System.out.println("1 :" + dto.getNotice_id());
			System.out.println("2 :" +dto.getNotice_title());
			System.out.println("3 :" +dto.getNotice_date());
			System.out.println("4 :" +dto.getMid());
			
			
	
		}
		System.out.println("--------------------------------------------");
		
		return list;
	}
	public List<NoticeDTO> getNoticeListdiv() {
		List<NoticeDTO> noticeList = noticeDAO.getNoticeListdiv();
		return noticeList;
	}

	
	
	
}
