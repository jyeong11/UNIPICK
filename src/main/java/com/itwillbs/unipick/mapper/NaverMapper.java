package com.itwillbs.unipick.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.http.ResponseEntity;

@Mapper
public interface NaverMapper {
    
    Map<String, Object> BuyerLogin(Map<String, Object> logindata); 

    int BuyEmail(@Param("buy_em") String buyEm);
    
    int insertBuyer(@Param("buyerData") Map<String, Object> buyerData);
    
    int saveBuyerAgreement(@Param("acc_ta") boolean acc_ta,
                           @Param("acc_pa") boolean acc_pa,
                           @Param("acc_ma") boolean acc_ma);
    
    Map<String, Object> selectEmployeeByNameAndPhone(
    		@Param("buy_nm") String buyNm,
    		@Param("buy_ph") String buyPh);

    Map<String, Object> findEmployeeByNoAndEmail(@Param("buyNm") String buyNm, @Param("buyEm") String buyEm);

    void updatePassword(@Param("buyEm") String buyEm, @Param("buyPw") String buyPw);
    
    // 네이버 로그인용 메서드 추가
    Map<String, Object> findByEmail(@Param("buy_em") String buyEm);
    
    int insertNaverUser(Map<String, Object> userData);
}
