package com.postoffice.web.dto;

import java.sql.Date;
import java.util.List;

public class MailDTO {
	private int mail_id;
	private String from_name;
	private String from_address;
	private String to_name;
	private String to_address;
	private int mail_weight;
	private String state_id;
	private String state_name;

	private List<StateDTO> stateList;

	private int package_num;
	private Date mail_date;

	private String vid;
	private String village_name;

	private List<VillageDTO> villageList;

	
	
	public String getState_name() {
		return state_name;
	}
	public void setState_name(String state_name) {
		this.state_name = state_name;
	}
	public String getVillage_name() {
		return village_name;
	}
	public void setVillage_name(String village_name) {
		this.village_name = village_name;
	}
	public int getMail_id() {
		return mail_id;
	}
	public void setMail_id(int mail_id) {
		this.mail_id = mail_id;
	}
	public String getFrom_name() {
		return from_name;
	}
	public void setFrom_name(String from_name) {
		this.from_name = from_name;
	}
	public String getFrom_address() {
		return from_address;
	}
	public void setFrom_address(String from_address) {
		this.from_address = from_address;
	}
	public String getTo_name() {
		return to_name;
	}
	public void setTo_name(String to_name) {
		this.to_name = to_name;
	}
	public String getState_id() {
		return state_id;
	}
	public void setState_id(String state_id) {
		this.state_id = state_id;
	}
	public String getVid() {
		return vid;
	}
	public void setVid(String vid) {
		this.vid = vid;
	}
	public String getTo_address() {
		return to_address;
	}
	public void setTo_address(String to_address) {
		this.to_address = to_address;
	}
	public int getMail_weight() {
		return mail_weight;
	}
	public void setMail_weight(int mail_weight) {
		this.mail_weight = mail_weight;
	}
	
	
	public List<StateDTO> getStateList() {
		return stateList;
	}
	public void setStateList(List<StateDTO> stateList) {
		this.stateList = stateList;
	}
	public List<VillageDTO> getVillageList() {
		return villageList;
	}
	public void setVillageList(List<VillageDTO> villageList) {
		this.villageList = villageList;
	}
	public int getPackage_num() {
		return package_num;
	}
	public void setPackage_num(int package_num) {
		this.package_num = package_num;
	}
	public Date getMail_date() {
		return mail_date;
	}
	public void setMail_date(Date mail_date) {
		this.mail_date = mail_date;
	}
	
	
	
	
}
