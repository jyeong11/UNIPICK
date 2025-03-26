package com.itwillbs.unipick.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface BuyerMapper2 {
    
    Map<String, Object> BuyerLogin(Map<String, Object> logindata); 

    int BuyEmail(@Param("buy_em") String buyEm);
    
    void insertBuyer(@Param("buyerData") Map<String, Object> buyerData);
    
    int saveBuyerAgreement(@Param("acc_ta") boolean acc_ta,
                           @Param("acc_pa") boolean acc_pa,
                           @Param("acc_ma") boolean acc_ma);
}
