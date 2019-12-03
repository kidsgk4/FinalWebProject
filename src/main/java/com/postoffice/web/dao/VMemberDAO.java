package com.postoffice.web.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.omg.CORBA.Object;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.postoffice.web.dto.DeptDTO;
import com.postoffice.web.dto.VMemberDTO;
import com.postoffice.web.dto.VillageDTO;

@Component
public class VMemberDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public VMemberDTO selectMember(String lid) {
		VMemberDTO vmember = sqlSessionTemplate.selectOne("vmember.selectUserInfo", lid);
		return vmember;
	}

	public VMemberDTO selectVmemberByLpw(String lid) {
		VMemberDTO vmember = sqlSessionTemplate.selectOne("vmember.selectVmemberByLpw", lid);
		return vmember;
	}
	public int insert(VMemberDTO vmember) {
		int rows = sqlSessionTemplate.insert("vmember.insert", vmember);
		return rows;
	}

	public String selectVname(String lid) {
		String vname = sqlSessionTemplate.selectOne("vmember.selectVname", lid);
		return vname;
	}

	public String selectvmnSelect(String lid) {
		String vmname = sqlSessionTemplate.selectOne("vmember.selectvmname",lid);
		return vmname;
	}

	public List<VMemberDTO> selectvmemberList(String lid) {
		List<VMemberDTO> selectListvmem = sqlSessionTemplate.selectList("vmember.selectvmemeberList",lid);
		return selectListvmem;
	}

	public int selectvmList(VMemberDTO vmdto) {
		int selectvmem = sqlSessionTemplate.update("vmember.updateList",vmdto);
		return selectvmem;
	}

	public String selectvmlid(String lid) {
		String selectvmlid = sqlSessionTemplate.selectOne("vmember.selectvlid",lid);
		return selectvmlid;
	}

	public void updateFile(VMemberDTO vmdto,String saveFileName) {
		System.out.println("dao))))))))))))))))))))))))))))");
		Map<String, String> map = new HashMap<String, String>();
		map.put("vmid", vmdto.getVmid());
		map.put("vmphoto", saveFileName);
		sqlSessionTemplate.update("vmember.updateFile",map);
	}

	public String selectphoto(String lid) {
		String vmphoto = sqlSessionTemplate.selectOne("vmember.selectvphoto",lid);
		System.out.println(vmphoto);
		return vmphoto;
	}
	
	//마을 정보가져오기
	public List<VillageDTO> selectvlist() {
		List<VillageDTO> vlist = sqlSessionTemplate.selectList("vmember.selectvlist");
		return vlist;
	}
	public List<DeptDTO> getdlist(){
		List<DeptDTO>dlist = sqlSessionTemplate.selectList("vmember.selectdlist");
		return dlist;
	}	
}
