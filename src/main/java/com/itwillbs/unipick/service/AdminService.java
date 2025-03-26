package com.itwillbs.unipick.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.unipick.mapper.AdminMapper;

@Service
public class AdminService {
	@Autowired
	AdminMapper mapper;
	
	// 관리자 정보 조회
	public Map<String, Object> adminInfo(Map<String, Object> admin) {
		return mapper.adminInfo(admin);
	}
	
	// 관리자 정보 수정
	public int adminEdit(Map<String, Object> admin) {
		return mapper.adminEdit(admin);
	}
	
	// 코드등록
	public int registerDB(Map<String, Object> code) {
		return mapper.registerDB(code);
	}
	// 코드 수정
	public int updateDB(Map<String, Object> code) {
		return mapper.updateDB(code);
	}
	// 코드 조회
	public List<Map<String, Object>> codeList(Map<String, Object> map) {	
		return mapper.codeList(map);
	}
	// 코드 삭제
	public int deleteDB(Map<String, Object> code) {	
		return mapper.deleteDB(code);
	}
	// 상세 코드 조회
	public List<Map<String, Object>> detailCodeList(Map<String, Object> map) {
		return mapper.detailCodeList(map);
	}
	// 상세 코드 등록
	public int detailcoderegister(Map<String, Object> map) {
		return mapper.detailcoderegister(map);
	}
	// 상세 코드 수정
	public int updateDBcodeDetail(Map<String, Object> map) {
		return mapper.updateDBcodeDetail(map);
	}
	// 상세 코드 삭제
	public int updateDBcodeDelete(Map<String, Object> map) {
		return mapper.updateDBcodeDelete(map);
	}
	// 계층 코드등록
	public int insertLvCode(Map<String, Object> code) {
		return mapper.insertLvCode(code);
	}
	// 계층 코드 수정
	public int updateLvCode(Map<String, Object> code) {
		return mapper.updateLvCode(code);
	}
	// 계층 코드 조회
	public List<Map<String, Object>> selectLvCode(Map<String, Object> map) {	
		return mapper.selectLvCode(map);
	}
	// 계층 코드 삭제
	public int deleteLvCode(Map<String, Object> code) {	
		return mapper.deleteLvCode(code);
	}
	// 사이드 메인 메뉴
	public List<Map<String, Object>> MenuList(Map<String, Object> map) {
		List<Map<String, Object>> mainMenus = mapper.sideMainMenuList(map);
        List<Map<String, Object>> subMenus = mapper.sideSubMenuList(map);
		
        Map<String, List<Map<String, Object>>> subMenuMap = new HashMap<>();
        for (Map<String, Object> sub : subMenus) {
            String parentCode = (String) sub.get("parent_code");
            subMenuMap.computeIfAbsent(parentCode, k -> new ArrayList<>()).add(sub);
        }

        // 상위 메뉴에 하위 메뉴 추가
        for (Map<String, Object> main : mainMenus) {
            String mainCode = (String) main.get("code");
            main.put("subCodes", subMenuMap.getOrDefault(mainCode, new ArrayList<>()));
        }
        
        return mainMenus;
		
	}
	// 상품관리
	public List<Map<String, Object>> getPrdList(Map<String, Object> map) {
		return mapper.getPrdList(map);
	}
	
	// 상품 상세조회
	public List<Map<String, Object>> getprdListDetail(Map<String, Object> prdCd) {
		return mapper.getprdListDetail(prdCd);
	}
	
	// 방문자 수
	public Map<String, Object> visitCount() {
		return mapper.visitCount();
	}
	// 상품 접수 상태변경
	public void updateStatus(@Param("status") String status, @Param("prdCd") String prdCd){
		mapper.updateStatus(status, prdCd);
	}
	
	// 메인 페이지 출력
	public Map<String, Object> mainPrint() {
		Map<String, Object> mainData = new HashMap<String, Object>();
		mainData.put("visCnt", mapper.visitCount());
		mainData.put("joinList", mapper.joinList());
		mainData.put("reportList", mapper.reportList());
		
		return mainData;
	}
		
}
