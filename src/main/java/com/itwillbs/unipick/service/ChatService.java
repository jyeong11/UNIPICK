package com.itwillbs.unipick.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.unipick.mapper.ChatMapper;

@Service
public class ChatService {
    
    @Autowired
    private ChatMapper chatMapper;
    
    // 채팅방 목록 조회 (구매자용)
    public List<Map<String, Object>> getBuyerChatList(String buy_em) {
        return chatMapper.getBuyerChatList(buy_em);
    }
    
    // 채팅방 목록 조회 (판매자용)
    public List<Map<String, Object>> getSellerChatList(String sel_id) {
        return chatMapper.getSellerChatList(sel_id);
    }
    
    // 채팅방 상세 정보 조회
    public Map<String, Object> getChatRoom(int cht_id) {
        return chatMapper.getChatRoom(cht_id);
    }
    
    // 채팅방 가져오기 (없으면 생성)
    public int getOrCreateChatRoom(String buy_em, String sel_id) {
        Map<String, Object> params = new HashMap<>();
        params.put("buy_em", buy_em);
        params.put("sel_id", sel_id);
        
        // 채팅방 ID를 저장할 변수
        int cht_id = 0;
        
        // 채팅방 존재 여부 확인
        int count = chatMapper.checkChatRoom(params);
        System.out.println("채팅방 존재 여부 확인 결과: " + count);
        
        if (count > 0) {
            // 이미 존재하는 채팅방인 경우 ID 조회
            cht_id = chatMapper.getChatRoomId(params);
            System.out.println("기존 채팅방 ID 조회: " + cht_id);
            
            // ID가 0이면 오류
            if (cht_id <= 0) {
                System.err.println("기존 채팅방 ID가 유효하지 않습니다. 새로 생성합니다.");
                // 기존 채팅방이 있다고 했지만 ID가 유효하지 않으면 새로 생성
                cht_id = createNewChatRoom(params);
            }
        } else {
            // 채팅방이 없으면 새로 생성
            cht_id = createNewChatRoom(params);
        }
        
        // 채팅방 ID가 여전히 0이면 마지막 시도로 다시 조회
        if (cht_id <= 0) {
            System.err.println("최종 확인: 채팅방 ID를 조회합니다.");
            cht_id = chatMapper.getChatRoomId(params);
            
            if (cht_id <= 0) {
                System.err.println("채팅방 ID 조회 실패. 심각한 오류가 있을 수 있습니다.");
            }
        }
        
        return cht_id;
    }
    
    // 새 채팅방 생성 (별도 메서드로 분리)
    private int createNewChatRoom(Map<String, Object> params) {
        int cht_id = 0;
        
        try {
            chatMapper.createChatRoom(params);
            System.out.println("새 채팅방 생성 - 파라미터: " + params);
            
            // selectKey로 생성된 ID 확인
            if (params.get("cht_id") != null) {
                cht_id = Integer.parseInt(params.get("cht_id").toString());
                System.out.println("자동 생성된 채팅방 ID: " + cht_id);
            } else {
                // 파라미터에서 ID를 가져올 수 없으면 조회
                System.out.println("자동 생성된 ID를 가져올 수 없어 직접 조회합니다.");
                cht_id = chatMapper.getChatRoomId(params);
                System.out.println("조회된 채팅방 ID: " + cht_id);
            }
        } catch (Exception e) {
            System.err.println("채팅방 생성 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
        }
        
        return cht_id;
    }
    
    // 메시지 목록 조회
    public List<Map<String, Object>> getChatMessages(int cht_id) {
        List<Map<String, Object>> messages = chatMapper.getChatMessages(cht_id);
        
        // 채팅방 정보 조회
        Map<String, Object> chatRoom = chatMapper.getChatRoom(cht_id);
        String buyerEmail = (String) chatRoom.get("buy_em");
        String sellerId = (String) chatRoom.get("sel_id");
        
        // 각 메시지의 발신자 타입 설정
        for (Map<String, Object> message : messages) {
            String sender = (String) message.get("sender");
            if (sender != null) {
                if (sender.equals(buyerEmail)) {
                    message.put("sender_type", "buyer");
                } else if (sender.equals(sellerId)) {
                    message.put("sender_type", "seller");
                } else {
                    message.put("sender_type", "unknown");
                }
            } else {
                message.put("sender_type", "unknown");
            }
        }
        
        return messages;
    }
    
    // 메시지 전송
    public void sendMessage(Map<String, Object> chatDetail) {
        chatMapper.sendMessage(chatDetail);
    }
    
    // 판매자 검색
    public List<Map<String, Object>> searchSellers(String searchTerm) {
        return chatMapper.searchSellers(searchTerm);
    }
    
    // 채팅방 판매자 신고
    public void reportSeller(Map<String, Object> reportData) {
        // 신고 상태가 없으면 기본값 설정
        if (reportData.get("rpt_st") == null || ((String) reportData.get("rpt_st")).isEmpty()) {
            reportData.put("rpt_st", "RS01"); // 기본값
        }
        
        // 신고 대상이 없으면 기본값 설정
        if (reportData.get("rpt_tg") == null || ((String) reportData.get("rpt_tg")).isEmpty()) {
            reportData.put("rpt_tg", "판매자");
        }
        
        chatMapper.reportSeller(reportData);
    }
    
    // 채팅방 구매자 신고
    public void reportBuyer(Map<String, Object> reportData) {
        // 신고 상태가 없으면 기본값 설정
        if (reportData.get("rpt_st") == null || ((String) reportData.get("rpt_st")).isEmpty()) {
            reportData.put("rpt_st", "RS01"); // 기본값
        }
        
        // 신고 대상이 없으면 기본값 설정
        if (reportData.get("rpt_tg") == null || ((String) reportData.get("rpt_tg")).isEmpty()) {
            reportData.put("rpt_tg", "구매자");
        }
        
        chatMapper.reportBuyer(reportData);
    }
    
    // 채팅방 신고 내역 조회
    public List<Map<String, Object>> getChatReports(int cht_id) {
        return chatMapper.getChatReports(cht_id);
    }
    
    // 새 메시지 개수 확인 (구매자용)
    public int getNewMessageCountForBuyer(String buy_em) {
        if (buy_em == null || buy_em.trim().isEmpty()) {
            return 0;
        }
        
        return chatMapper.getNewMessageCountForBuyer(buy_em);
    }
    
    // 마지막 확인 시간 업데이트 (구매자용)
    public void updateLastCheckedTime(String buy_em) {
        if (buy_em != null && !buy_em.trim().isEmpty()) {
            chatMapper.updateLastCheckedTime(buy_em);
        }
    }
    
    // 새 메시지 개수 확인 (판매자용)
    public int getNewMessageCountForSeller(String sel_id) {
        if (sel_id == null || sel_id.trim().isEmpty()) {
            return 0;
        }
        
        return chatMapper.getNewMessageCountForSeller(sel_id);
    }
    
    // 마지막 확인 시간 업데이트 (판매자용)
    public void updateSellerLastCheckedTime(String sel_id) {
        if (sel_id != null && !sel_id.trim().isEmpty()) {
            chatMapper.updateSellerLastCheckedTime(sel_id);
        }
    }
} 