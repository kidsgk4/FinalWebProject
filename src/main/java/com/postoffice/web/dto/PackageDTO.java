package com.postoffice.web.dto;

import java.sql.Date;
import java.util.List;

public class PackageDTO {
	private int package_id;
	private String village;
	private int package_weight;
	private String state_id;
	private Date arrival_date;
	private String vid;
	
	private List<PackageDTO> packageList;
	private List<StateDTO> stateList;
	private List<VillageDTO> villageList;
	private List<MailDTO> mailList;

	
	public int getPackage_id() {
		return package_id;
	}
	public void setPackage_id(int package_id) {
		this.package_id = package_id;
	}
	public String getVillage() {
		return village;
	}
	public void setVillage(String village) {
		this.village = village;
	}
	
	public int getPackage_weight() {
		return package_weight;
	}
	public void setPackage_weight(int package_weight) {
		this.package_weight = package_weight;
	}
	public String getState_id() {
		return state_id;
	}
	public void setState_id(String state_id) {
		this.state_id = state_id;
	}
	public Date getArrival_date() {
		return arrival_date;
	}
	public void setArrival_date(Date arrival_date) {
		this.arrival_date = arrival_date;
	}
	public String getVid() {
		return vid;

	}
	public void setVid(String vid) {
		this.vid = vid;
	}
	
	public List<PackageDTO> getPackageList() {
		return packageList;
	}
	public void setPackageList(List<PackageDTO> packageList) {
		this.packageList = packageList;
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
	public List<MailDTO> getMailList() {
		return mailList;
	}
	public void setMailList(List<MailDTO> mailList) {
		this.mailList = mailList;
	}
}