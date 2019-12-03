package com.postoffice.web.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.postoffice.web.dto.DeptDTO;
import com.postoffice.web.dto.MemberDTO;
import com.postoffice.web.dto.NoticeDTO;

@Component
public class NoticeDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	//noticeList에 대한 페이징 처리
	public int selectTotalRowNum() {
		int totalRowNum = sqlSessionTemplate.selectOne("notice.selectTotalRowNum");
		
		return totalRowNum;
	}
	
	//noticeSearch에 대한 페이징 처리
	public int SearchTitleTotalRowNum(String searchNotice,String searchWord) { 
		Map<String,Object>map = new HashMap<String,Object>();
		map.put("searchNotice", searchNotice);
		map.put("searchWord", searchWord);
		int totalRowNum =  sqlSessionTemplate.selectOne("notice.SearchTitleTotalRowNum",map);
		return totalRowNum; 
	}
	
	
	 //noticeSearch(mid)에 대한 페이징 처리 
	public int MnameSearchTotalRowNum(String searchNotice,String searchWord) {
		Map<String,Object>map = new HashMap<String,Object>();
		map.put("searchNotice", searchNotice);
		map.put("searchWord", searchWord);
		return sqlSessionTemplate.selectOne("notice.MnameSearchTotalRowNum",map);
	}
	 
	//noticeList
	public List<NoticeDTO> selectList(int startRowNum, int endRowNum) {	
		Map<String, Integer> map = new HashMap<>();
		map.put("startRowNum", startRowNum);
		map.put("endRowNum", endRowNum);
		
		
		List<NoticeDTO> list = sqlSessionTemplate.selectList("notice.noticeList", map);
		
		return list;
	}
	
	//공지사항 목록 검색
	public List<NoticeDTO> noticeSearch(String searchNotice, String searchWord, int startRowNum,int endRowNum) {
		Map<String,Object>map = new HashMap<String,Object>();
		map.put("searchNotice", searchNotice);
		map.put("searchWord", searchWord);
		map.put("startRowNum", startRowNum);
		map.put("endRowNum", endRowNum);
		//map.put("endRowNum2", endRowNum2);
		
		if(searchNotice.equals("notice_title")) {
			List<NoticeDTO> noticeSearch = sqlSessionTemplate.selectList("notice.noticeTitleSearch",map);
			return noticeSearch;
		}
		List<NoticeDTO> noticeSearch = sqlSessionTemplate.selectList("notice.mnameSearch",map);
		return noticeSearch;
	}
	//공지사항 세부정보
	public NoticeDTO selectDetail(NoticeDTO noticeDTO){
		System.out.println(noticeDTO.getNotice_id());
		
		NoticeDTO list = sqlSessionTemplate.selectOne("notice.noticeDetail",noticeDTO);
		return list;
	}
	
	//공지사항 작성
	public int noticeinsert(NoticeDTO noticeDTO) {
		int rows = sqlSessionTemplate.insert("notice.noticeinsert", noticeDTO);
		
		return rows;
	}

	//공지사항 정보 가져오기
	public NoticeDTO selectNotice(int notice_id) {
		NoticeDTO noticeDTO = sqlSessionTemplate.selectOne("notice.selectnotice", notice_id);
		return noticeDTO;
	}
	
	public MemberDTO selectmember(NoticeDTO dto) {
		MemberDTO memberDTO = sqlSessionTemplate.selectOne("notice.selectMember",dto);
		return memberDTO;
	}
	
	public DeptDTO selectdept(MemberDTO Mdto) {
		DeptDTO deptDTO = sqlSessionTemplate.selectOne("notice.selectDept", Mdto);
		return deptDTO;
	}
	
	
	
	

	
	//test
	public MemberDTO showMember(MemberDTO dto) {
		return sqlSessionTemplate.selectOne("notice.memberInfo", dto);
	}
	
	//공지사항 수정
	public void noticeupdate(NoticeDTO noticeDTO) {
		sqlSessionTemplate.update("notice.noticeupdate", noticeDTO);
	}
	
	//테스트 코드/
	public List<MemberDTO> testMember() {
		return sqlSessionTemplate.selectList("notice.testMember");
	}
	public List<NoticeDTO> testNotice(){
		return sqlSessionTemplate.selectList("notice.testNotice");
	}

	public void deleteDelete(NoticeDTO noticeDTO) {
		sqlSessionTemplate.delete("notice.noticedelete", noticeDTO);
	}

	public List<NoticeDTO> getNoticeListdiv() {
		List<NoticeDTO> noticeList = sqlSessionTemplate.selectList("notice.getNoticeListdiv");
		return noticeList;
	}

	


	
}
