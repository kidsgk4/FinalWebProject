package com.postoffice.web.dto;

public class VillageDTO {
	private String vid;
	private String vname;
	private String send_path;
	private String return_path;
	
	public String getVid() {
		return vid;
	}
	public void setVid(String vid) {
		this.vid = vid;
	}
	public String getVname() {
		return vname;
	}
	public void setVname(String vname) {
		this.vname = vname;
	}
	public String getSend_path() {
		return send_path;
	}
	public void setSend_path(String send_path) {
		this.send_path = send_path;
	}
	public String getReturn_path() {
		return return_path;
	}
	public void setReturn_path(String return_path) {
		this.return_path = return_path;
	}
	
}
