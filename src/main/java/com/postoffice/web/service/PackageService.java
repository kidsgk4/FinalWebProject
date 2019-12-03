package com.postoffice.web.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.postoffice.web.dao.PackageDAO;
import com.postoffice.web.dto.DeliveryDTO;
import com.postoffice.web.dto.MailDTO;
import com.postoffice.web.dto.PackageDTO;
import com.postoffice.web.dto.VillageDTO;

@Service
public class PackageService {

	@Autowired
	PackageDAO packageDAO;

	public List<MailDTO> mailList() {

		return packageDAO.mailList();
	}
	
	public List<MailDTO> village_mailList(String village_name){
		
		return packageDAO.village_mailList(village_name);
	}

	public List<VillageDTO> villageList(){
		return packageDAO.villageList();
	}
	
	public List<PackageDTO> packageList() {
		return packageDAO.packageList();
	}

	public List<PackageDTO> mailPackaging(String totalWeight, List<String> mailIdList, String vid) {
		// 총 무게 g 자르고 int 변환
		String rep = totalWeight.replace("g", "");
		int total = Integer.parseInt(rep);
		System.out.println("-------------------------------");
		System.out.println(total);
		PackageDTO packageDTO = new PackageDTO();
		packageDTO.setPackage_weight(total);
		packageDTO.setVid(vid);
		// 패키지 insert
		packageDAO.mailPackaging(packageDTO);

		MailDTO mailDTO = new MailDTO();
		
		// 우편 update
		for (int i = 0; i < mailIdList.size(); i++) {
			mailDTO.setMail_id(Integer.parseInt(mailIdList.get(i)));
			packageDAO.mailUpdate(mailDTO, packageDTO);
		}

		// 패키지 목록 select
		return packageDAO.packageList();
	}

	public List<MailDTO> pack_mailList(PackageDTO dto) {

		return packageDAO.pack_mailList(dto);
	}

	public int clientInfo(String to_name, String from_name, String to_address, String from_address, String vid,
			int mail_weight) {
		return packageDAO.clientInfo(to_name, from_name, to_address, from_address, vid, mail_weight);
	}
	
	public List<DeliveryDTO> deliveryList(){
		return packageDAO.deliveryList();
	}

}

