package com.itwillbs.unipick.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ChatMapper {
    
    // 채팅방 목록 조회 (구매자용)
    public List<Map<String, Object>> getBuyerChatList(String buy_em);
    
    // 채팅방 목록 조회 (판매자용)
    public List<Map<String, Object>> getSellerChatList(String sel_id);
    
    // 채팅방 상세 정보 조회
    public Map<String, Object> getChatRoom(int cht_id);
    
    // 채팅방 존재 여부 확인
    public int checkChatRoom(Map<String, Object> params);
    
    // 채팅방 생성
    public void createChatRoom(Map<String, Object> params);
    
    // 채팅방 ID 조회
    public int getChatRoomId(Map<String, Object> params);
    
    // 메시지 목록 조회
    public List<Map<String, Object>> getChatMessages(int cht_id);
    
    // 메시지 전송
    public void sendMessage(Map<String, Object> chatDetail);
    
    // 판매자 검색
    public List<Map<String, Object>> searchSellers(String searchTerm);
    
    // 채팅방 판매자 신고
    public void reportSeller(Map<String, Object> reportData);
    
    // 채팅방 구매자 신고
    public void reportBuyer(Map<String, Object> reportData);
    
    // 채팅방 신고 내역 조회
    public List<Map<String, Object>> getChatReports(int cht_id);
    
    // 새 메시지 개수 확인 (구매자용)
    public int getNewMessageCountForBuyer(String buy_em);
    
    // 마지막 확인 시간 업데이트 (구매자용)
    public void updateLastCheckedTime(String buy_em);
    
    // 새 메시지 개수 확인 (판매자용)
    public int getNewMessageCountForSeller(String sel_id);
    
    // 마지막 확인 시간 업데이트 (판매자용)
    public void updateSellerLastCheckedTime(String sel_id);
} 