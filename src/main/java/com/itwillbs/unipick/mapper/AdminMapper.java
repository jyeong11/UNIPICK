package com.itwillbs.unipick.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;


@Mapper
public interface AdminMapper {
	// 관리자 정보 조회
	public Map<String, Object> adminInfo(Map<String, Object> admin);
	// 관리자 정보 수정
	public int adminEdit(Map<String,Object> admin);
	// 코드 등록
	public int registerDB(Map<String, Object> code);
	// 코드 수정
	public int updateDB(Map<String, Object> code);
	// 코드 조회
	public List<Map<String, Object>> codeList(Map<String, Object> map);
	// 코드 삭제
	public int deleteDB(Map<String, Object> code);
	// 상세 코드 조회
	public List<Map<String, Object>> detailCodeList(Map<String, Object> map);
	// 상세 코드 등록
	public int detailcoderegister(Map<String, Object> map);
	// 상세 코드 수정
	public int 	updateDBcodeDetail(Map<String, Object> map);
	// 상세 코드 삭제
	public int 	updateDBcodeDelete(Map<String, Object> map);
	// 계층 코드 조회
	public List<Map<String, Object>> selectLvCode(Map<String, Object> map);
	// 계층 코드 등록
	public int insertLvCode(Map<String, Object> map);
	// 계층 코드 수정
	public int 	updateLvCode(Map<String, Object> map);
	// 계층 코드 삭제
	public int 	deleteLvCode(Map<String, Object> map);
	// 사이드 메인 메뉴
	public List<Map<String, Object>> sideMainMenuList(Map<String, Object> map);
	// 사이드 서브 메뉴
	public List<Map<String, Object>> sideSubMenuList(Map<String, Object> map);
	// 상품관리
	public List<Map<String, Object>> getPrdList(Map<String, Object> map);
	// 상품관리 페이징에 필요한 전체 횟수 조회
	public int getPrdTotalCount(Map<String, Object> map);
	// 상품 상세조회
	public List<Map<String, Object>> getprdListDetail(Map<String, Object> prdCd);
	// 상품 상태 상세코드
	public List<Map<String, Object>> getCommonStatus();
	// 방문자 수
	public Map<String, Object> visitCount();
	// 상품 접수 상태변경
	void updateStatus(@Param("status") String status, @Param("prdCd") String prdCd);
	// 가입 리스트
	public List<Map<String, Object>> joinList();
	// 신고내역 리스트
	public List<Map<String,Object>> reportList(Map<String, Object> report);
	// 판매자 회원 조회
	public List<Map<String, Object>> getSellerInfo(Map<String, Object> data);
	// 판매자 회원 상세 조회
	public List<Map<String, Object>> getSellerInfoDeatil(Map<String, Object> sel_nm);
	// 구매자 회원 조회
	public List<Map<String, Object>> getBuyerInfo(Map<String, Object> data);
	// 구매자 상태
	public List<Map<String, Object>> getStatus(String com_cd);
	// 신고 상태 업데이트
	public void updateReportStatus(Map<String, Object> report);
}
