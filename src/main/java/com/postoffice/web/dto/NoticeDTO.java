package com.postoffice.web.dto;

import java.util.Date;
import java.util.List;

public class NoticeDTO {
	
	private int notice_id;
	private String notice_title;
	private String notice_content;
	private MemberDTO memberDTO;
	private String notice_attach_file;
	private Date notice_date;
	private String mid;
	private MemberDTO dto;
	private List<MemberDTO> memberList;
	private List<DeptDTO> deptList;
	
	
	
	public List<DeptDTO> getDeptList() {
		return deptList;
	}
	public void setDeptList(List<DeptDTO> deptList) {
		this.deptList = deptList;
	}
	
	
	public List<MemberDTO> getMemberList() {
		return memberList;
	}
	public void setMemberList(List<MemberDTO> memberList) {
		this.memberList = memberList;
	}
	public int getNotice_id() {
		return notice_id;
	}
	public void setNotice_id(int notice_id) {
		this.notice_id = notice_id;
	}
	public String getNotice_title() {
		return notice_title;
	}
	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}
	public String getNotice_content() {
		return notice_content;
	}
	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}
	public String getNotice_attach_file() {
		return notice_attach_file;
	}
	public void setNotice_attach_file(String notice_attach_file) {
		this.notice_attach_file = notice_attach_file;
	}
	
	
	public MemberDTO getMemberDTO() {
		return memberDTO;
	}
	public void setMemberDTO(MemberDTO memberDTO) {
		this.memberDTO = memberDTO;
	}
	public Date getNotice_date() {
		return notice_date;
	}
	public void setNotice_date(Date notice_date) {
		this.notice_date = notice_date;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}

	
	
	
}
