package com.postoffice.web.dto;

import java.util.Date;

public class RequestDTO {
	private String request_id;
	private Date request_date;
	private String vid;
	private String package_id;
	private boolean request_result;
	private boolean request_kind;
	private String drone_id;
	public String getRequest_id() {
		return request_id;
	}
	public void setRequest_id(String request_id) {
		this.request_id = request_id;
	}
	public Date getRequest_date() {
		return request_date;
	}
	public void setRequest_date(Date request_date) {
		this.request_date = request_date;
	}
	public String getVid() {
		return vid;
	}
	public void setVid(String vid) {
		this.vid = vid;
	}
	public String getPackage_id() {
		return package_id;
	}
	public void setPackage_id(String package_id) {
		this.package_id = package_id;
	}
	public boolean isRequest_result() {
		return request_result;
	}
	public void setRequest_result(boolean request_result) {
		this.request_result = request_result;
	}
	public boolean isRequest_kind() {
		return request_kind;
	}
	public void setRequest_kind(boolean request_kind) {
		this.request_kind = request_kind;
	}
	public String getDrone_id() {
		return drone_id;
	}
	public void setDrone_id(String drone_id) {
		this.drone_id = drone_id;
	}
	
	
}
