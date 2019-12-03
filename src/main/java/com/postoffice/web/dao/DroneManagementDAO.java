package com.postoffice.web.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.postoffice.web.dto.DeliveryDTO;
import com.postoffice.web.dto.DroneDTO;
import com.postoffice.web.dto.PackageDTO;
import com.postoffice.web.dto.VillageDTO;

@Repository
public class DroneManagementDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public List<DroneDTO> selectDroneList(){
		return sqlSessionTemplate.selectList("drone.selectDroneList");
	}
	public List<PackageDTO> packageList(){
		return sqlSessionTemplate.selectList("drone.selectPackageList");
	}
	public DroneDTO selectDroneInfo(DroneDTO dto){
		return sqlSessionTemplate.selectOne("drone.selectDroneInfo",dto);
	}
	public List<DeliveryDTO> selectDroneLog(DroneDTO dto){
		return sqlSessionTemplate.selectList("drone.selectDroneLog", dto);
	}
	
	public VillageDTO selectDroneDeliveryState(DroneDTO dto) {
		return sqlSessionTemplate.selectOne("drone.selectDroneDeliveryState", dto);
	}
	public void insertDroneDelivery(DeliveryDTO dto) {
		sqlSessionTemplate.insert("drone.insertDroneDelivery",dto);
	}
	public void updateDroneDelivery(DeliveryDTO dto) {
		sqlSessionTemplate.update("drone.updateDroneDelivery", dto);
	}
	public void updateDroneState(DeliveryDTO dto, String state_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("drone_id",dto.getDrone_id());
		map.put("state_id",state_id);
		sqlSessionTemplate.update("drone.updateDroneStateDelivery",map);
	}
	public void updatePackageState(DeliveryDTO dto, String state_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("package_id",dto.getPackage_id());
		map.put("state_id",state_id);
		System.out.println("test : " + state_id);
		sqlSessionTemplate.update("drone.updatePackageState",map);
	}
	public void updatePackageClearState(DeliveryDTO dto) {	
		sqlSessionTemplate.update("drone.updatePackageClearState", dto);
	}
	public List<DeliveryDTO> selectDeliveryDrone(){
		return sqlSessionTemplate.selectList("drone.selectDeliveryDrone");
	}
	public void updateDeliveryClear(DeliveryDTO dto){
		sqlSessionTemplate.update("drone.updateDeliveryClear",dto);
	}
	
	public void updateDroneDeliveryClear(DeliveryDTO dto){
		sqlSessionTemplate.update("drone.updateDroneDeliveryClear",dto);
	}
}
