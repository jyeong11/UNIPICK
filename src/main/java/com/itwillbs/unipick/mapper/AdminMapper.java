package com.itwillbs.unipick.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

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
}
