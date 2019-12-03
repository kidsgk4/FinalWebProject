package com.postoffice.web.dto;

import java.sql.Date;
import java.util.List;

public class DeliveryDTO {

	private String drone_id;
	private int package_id;
	private Date delivery_date;
	private List<DroneDTO> droneList;
	private List<PackageDTO> packageList;
	private List<VillageDTO> villageList;
	
	public String getDrone_id() {
		return drone_id;
	}
	public void setDrone_id(String drone_id) {
		this.drone_id = drone_id;
	}
	public int getPackage_id() {
		return package_id;
	}
	public void setPackage_id(int package_id) {
		this.package_id = package_id;
	}
	public Date getDelivery_date() {
		return delivery_date;
	}
	public void setDelivery_date(Date delivery_date) {
		this.delivery_date = delivery_date;
	}
	public List<DroneDTO> getDroneList() {
		return droneList;
	}
	public void setDroneList(List<DroneDTO> droneList) {
		this.droneList = droneList;
	}
	public List<PackageDTO> getPackageList() {
		return packageList;
	}
	public void setPackageList(List<PackageDTO> packageList) {
		this.packageList = packageList;
	}
	public List<VillageDTO> getVillageList() {
		return villageList;
	}
	public void setVillageList(List<VillageDTO> villageList) {
		this.villageList = villageList;
	}
	
	
}
