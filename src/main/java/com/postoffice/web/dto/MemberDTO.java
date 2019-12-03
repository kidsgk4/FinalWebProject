package com.postoffice.web.dto;

import java.util.List;

public class MemberDTO {
	
	private String mid;
	private String mname;
	private String mpassword;
	private String mtel;
	private String mphoto;
	private String dept_id;
	private String mauthority;
	private List<NoticeDTO> noticeList;
	private List<DeptDTO> deptList;
	
	
	
	public List<DeptDTO> getDeptList() {
		return deptList;
	}
	public void setDeptList(List<DeptDTO> deptList) {
		this.deptList = deptList;
	}
	public List<NoticeDTO> getNoticeList() {
		return noticeList;
	}
	public void setNoticeList(List<NoticeDTO> noticeList) {
		this.noticeList = noticeList;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getMname() {
		return mname;
	}
	public void setMname(String mname) {
		this.mname = mname;
	}
	public String getMpassword() {
		return mpassword;
	}
	public void setMpassword(String mpassword) {
		this.mpassword = mpassword;
	}
	public String getMtel() {
		return mtel;
	}
	public void setMtel(String mtel) {
		this.mtel = mtel;
	}
	public String getMphoto() {
		return mphoto;
	}
	public void setMphoto(String mphoto) {
		this.mphoto = mphoto;
	}
	public String getDept_id() {
		return dept_id;
	}
	public void setDept_id(String dept_id) {
		this.dept_id = dept_id;
	}
	public String getMauthority() {
		return mauthority;
	}
	public void setMauthority(String mauthority) {
		this.mauthority = mauthority;
	}
	
	
}
