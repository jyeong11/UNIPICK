package com.itwillbs.unipick.mapper;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface OtpMapper {

    // OTP 데이터 저장
    void insertVerification(Map<String, Object> verification);
    
    // 전화번호에 해당하는 OTP 데이터 조회
    Map<String, Object> selectByPhoneNumber(String phone);
    
    // 전화번호에 해당하는 OTP 데이터 삭제
    void deleteByPhoneNumber(String phone);

    void updateVerification(@Param("pho_nm") String phone, @Param("pho_otp") String otp, @Param("pho_at") Date expiration);


	
    
}
