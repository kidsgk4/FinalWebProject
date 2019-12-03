package com.postoffice.web.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.postoffice.web.dto.DeliveryDTO;
import com.postoffice.web.dto.MailDTO;
import com.postoffice.web.dto.PackageDTO;
import com.postoffice.web.dto.VillageDTO;

@Repository
public class PackageDAO {

   @Autowired
   private SqlSessionTemplate sqlSessionTemplate;
   
	// 우편 목록
	public List<MailDTO> mailList() {
		return sqlSessionTemplate.selectList("packaging.selectMailList");
	}

	public List<MailDTO> village_mailList(String village_name){
		return sqlSessionTemplate.selectList("packaging.selectMailListVillage", village_name);
	}
	
	public List<VillageDTO> villageList() {
		return sqlSessionTemplate.selectList("packaging.selectVillage");
	}
   
	//우편 패키징
	public int mailPackaging(PackageDTO dto) {
		int pack_num = sqlSessionTemplate.insert("packaging.insertMailPackaging",dto);
		return pack_num;
	}
	
	//패키징된 우편 업데이트(상태,패키징 번호)
	public int mailUpdate(MailDTO mailDTO, PackageDTO packageDTO) {
		
		Map<String, Integer> map = new HashMap<>();
		map.put("mail_id", mailDTO.getMail_id());
		map.put("package_id", packageDTO.getPackage_id());
		System.out.println("--------------------------------------");
		System.out.println(mailDTO.getMail_id());
		System.out.println(packageDTO.getPackage_id());
		return sqlSessionTemplate.update("packaging.updateMail", map);
	}
	
	//패키지 목록
	public List<PackageDTO> packageList(){
		
		return sqlSessionTemplate.selectList("packaging.selectPackageList");
	}
	
	//패키징된 우편 목록
	public List<MailDTO> pack_mailList(PackageDTO dto){
		
		return sqlSessionTemplate.selectList("packaging.selectPackageMailList", dto);
	}

   public int clientInfo(String to_name, String from_name, String to_address, String from_address,String vid,int mail_weight) {
      Map<String,Object>map = new HashMap<String, Object>();
      map.put("to_name", to_name);
      map.put("from_name",from_name);
      map.put("to_address", to_address);
      map.put("from_address", from_address);
      map.put("vid",vid);
      map.put("mail_weight", mail_weight);
      return sqlSessionTemplate.insert("packaging.clientInfo",map);
   }
   
   public List<DeliveryDTO> deliveryList(){
	   return sqlSessionTemplate.selectList("board.deliveryList");
   }
}

