package com.postoffice.web.dto;

import java.sql.Date;
import java.util.List;

public class DroneDTO {
	private String drone_id;
	private String state_id;
	private Date add_date;
	private List<StateDTO> stateList;
	private List<VillageDTO> villageList;
	
	public String getDrone_id() {
		return drone_id;
	}
	public void setDrone_id(String drone_id) {
		this.drone_id = drone_id;
	}
	public String getState_id() {
		return state_id;
	}
	public void setState_id(String state_id) {
		this.state_id = state_id;
	}
	public Date getAdd_date() {
		return add_date;
	}
	public void setAdd_date(Date add_date) {
		this.add_date = add_date;
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
	
	
}
