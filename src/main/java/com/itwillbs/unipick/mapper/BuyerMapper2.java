package com.itwillbs.unipick.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface BuyerMapper2 {
	
	Map<String, Object> BuyerLogin(Map<String, Object> logindata); 

	public int BuyEmail(@Param("buy_em") String buyEm);
	
	void insertBuyer(@Param("buyer_em") String email, @Param("buyer_pw") String password, @Param("phone") String phone);

}
