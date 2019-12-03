package com.postoffice.web.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.postoffice.web.dao.DroneManagementDAO;
import com.postoffice.web.dto.DeliveryDTO;
import com.postoffice.web.dto.DroneDTO;
import com.postoffice.web.dto.PackageDTO;
import com.postoffice.web.dto.VillageDTO;

@Service
public class DroneManagementService {

	@Autowired
	private DroneManagementDAO droneManagementDAO;
	
	public List<DroneDTO> selectDroneList(){
		return droneManagementDAO.selectDroneList();
	}
	public List<PackageDTO> packageList(){
		return droneManagementDAO.packageList();
	}
	public DroneDTO selectDroneInfo(DroneDTO dto){
		return droneManagementDAO.selectDroneInfo(dto);
	}
	
	public List<DeliveryDTO> selectDroneLog(DroneDTO dto){
		return droneManagementDAO.selectDroneLog(dto);
	}
	
	public VillageDTO selectDroneDeliveryState(DroneDTO dto) {
		return droneManagementDAO.selectDroneDeliveryState(dto);
	}
	public List<DeliveryDTO> selectDeliveryDrone(){
		return droneManagementDAO.selectDeliveryDrone();
	}
	public void updateDeliveryClear(DeliveryDTO dto) {
		droneManagementDAO.updatePackageClearState(dto);
		droneManagementDAO.updateDroneDeliveryClear(dto);
		droneManagementDAO.updateDeliveryClear(dto);
	}

}
