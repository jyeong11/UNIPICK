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
        
        // 채팅방 존재 여부 확인
        int count = chatMapper.checkChatRoom(params);
        
        // 없으면 생성
        if (count == 0) {
            chatMapper.createChatRoom(params);
        }
        
        // 채팅방 ID 반환
        return chatMapper.getChatRoomId(params);
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
} 