package com.itwillbs.unipick.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.unipick.service.ChatService;

@Controller
@RequestMapping("/chat")
public class ChatController {
    
    @Autowired
    private ChatService chatService;
    
    // 구매자 채팅 목록 페이지
    @GetMapping("/buyer/list")
    public String buyerChatList(HttpSession session, Model model) {
    	
        // 세션에서 구매자 이메일 가져오기 (다양한 키 확인)
        String buy_em = (String) session.getAttribute("buyEm");
        
        // 다른 세션 키 시도
        if (buy_em == null) {
            buy_em = (String) session.getAttribute("buyerEm");
        }
        // 디버깅용 출력
        System.out.println("구매자 세션 이메일: " + buy_em);
        
        if (buy_em == null) {
            // 로그인되지 않은 경우
            return "redirect:/buyerlogin";  // 경로 수정
        }
        
        // 채팅방 목록 조회
        List<Map<String, Object>> chatList = chatService.getBuyerChatList(buy_em);
        model.addAttribute("chatList", chatList);
        
        return "chat/buyerChat";
    }
    
    // 판매자 채팅 목록 페이지
    @GetMapping("/seller/list")
    public String sellerChatList(HttpSession session, Model model) {
        // 세션에서 판매자 ID 가져오기 (다양한 키 확인)
        String sel_id = (String) session.getAttribute("sel_id");
        
        // 다른 세션 키 시도
        if (sel_id == null) {
            sel_id = (String) session.getAttribute("sellerId");
        }
        if (sel_id == null) {
            sel_id = (String) session.getAttribute("seller_id");
        }
        if (sel_id == null) {
            sel_id = (String) session.getAttribute("selId");
        }
        
        // 디버깅용 출력
        System.out.println("판매자 세션 ID: " + sel_id);
        
        if (sel_id == null) {
            // 로그인되지 않은 경우
            return "redirect:/sellerlogin";  // 경로 수정
        }
        
        // 채팅방 목록 조회
        List<Map<String, Object>> chatList = chatService.getSellerChatList(sel_id);
        model.addAttribute("chatList", chatList);
        
        return "chat/ChatRoom";
    }
    
    // 채팅방 페이지
    @GetMapping("/room/{cht_id}")
    public String chatRoom(@PathVariable("cht_id") int cht_id, HttpSession session, Model model) {
        // 세션에서 사용자 정보 가져오기 (다양한 키 확인)
        String buy_em = (String) session.getAttribute("buyEm");
        String sel_id = (String) session.getAttribute("sel_id");
        
        // 다른 세션 키 시도
        if (buy_em == null) {
            buy_em = (String) session.getAttribute("buyerEm");
            buy_em = (String) session.getAttribute("buyer_em");
            buy_em = (String) session.getAttribute("buyerEmail");
        }
        
        if (sel_id == null) {
            sel_id = (String) session.getAttribute("sellerId");
            sel_id = (String) session.getAttribute("seller_id");
            sel_id = (String) session.getAttribute("selId");
        }
        
        if (buy_em == null && sel_id == null) {
            // 로그인되지 않은 경우
            return "redirect:/buyerlogin";  // 경로 수정
        }
        
        // 채팅방 정보 조회
        Map<String, Object> chatRoom = chatService.getChatRoom(cht_id);
        model.addAttribute("chatRoom", chatRoom);
        
        // 현재 사용자가 구매자인지 판매자인지 확인
        String userType = (buy_em != null) ? "buyer" : "seller";
        model.addAttribute("userType", userType);
        model.addAttribute("userId", (buy_em != null) ? buy_em : sel_id);
        
        return "chat/popUp";
    }
    
    // 팝업 채팅방 페이지
    @GetMapping("/popup/{cht_id}")
    public String chatPopup(@PathVariable("cht_id") int cht_id, HttpSession session, Model model) {
        // 세션에서 사용자 정보 가져오기
        String buy_em = (String) session.getAttribute("buyEm");
        String sel_id = (String) session.getAttribute("sel_id");
        
        if (buy_em == null && sel_id == null) {
            // 로그인되지 않은 경우
            return "redirect:/buyerlogin";
        }
        
        // 채팅방 정보 조회
        Map<String, Object> chatRoom = chatService.getChatRoom(cht_id);
        model.addAttribute("chatRoom", chatRoom);
        
        // 현재 사용자가 구매자인지 판매자인지 확인
        String userType = (buy_em != null) ? "buyer" : "seller";
        model.addAttribute("userType", userType);
        model.addAttribute("userId", (buy_em != null) ? buy_em : sel_id);
        
        return "chat/popup";
    }
    
    // 판매자와 채팅 시작 (구매자용) - 일반 페이지
    @GetMapping("/start")
    public String startChat(@RequestParam("sel_id") String sel_id, HttpSession session) {
        // 세션에서 구매자 이메일 가져오기
        String buy_em = (String) session.getAttribute("buyEm");
        
        if (buy_em == null) {
            // 로그인되지 않은 경우
            return "redirect:/buyer_login";
        }
        
        // 채팅방 가져오기 (없으면 생성)
        int cht_id = chatService.getOrCreateChatRoom(buy_em, sel_id);
        
        return "redirect:/chat/room/" + cht_id;
    }
    
    // 판매자와 채팅 시작 (구매자용) - 팝업 창
    @GetMapping("/popup/start")
    public String startChatPopup(@RequestParam("sel_id") String sel_id, HttpSession session) {
        // 세션에서 구매자 이메일 가져오기
        String buy_em = (String) session.getAttribute("buyEm");
        
        if (buy_em == null) {
            // 로그인되지 않은 경우
            return "redirect:/seller_login";
        }
        
        // 채팅방 가져오기 (없으면 생성)
        int cht_id = chatService.getOrCreateChatRoom(buy_em, sel_id);
        
        return "redirect:/chat/popup/" + cht_id;
    }
    
    // 채팅 메시지 목록 조회 (AJAX)
    @GetMapping("/messages/{cht_id}")
    @ResponseBody
    public Map<String, Object> getMessages(@PathVariable("cht_id") int cht_id, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        // 세션에서 사용자 정보 가져오기
        String buy_em = (String) session.getAttribute("buyEm");
        String sel_id = (String) session.getAttribute("sel_id");
        
        if (buy_em == null && sel_id == null) {
            // 로그인되지 않은 경우
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return result;
        }
        
        // 채팅방 정보 조회
        Map<String, Object> chatRoom = chatService.getChatRoom(cht_id);
        
        // 현재 사용자가 해당 채팅방에 참여하고 있는지 확인
        boolean isParticipant = (buy_em != null && buy_em.equals(chatRoom.get("buy_em"))) || 
                              (sel_id != null && sel_id.equals(chatRoom.get("sel_id")));
        
        if (!isParticipant) {
            // 참여자가 아닌 경우
            result.put("success", false);
            result.put("message", "접근 권한이 없습니다.");
            return result;
        }
        
        // 메시지 목록 조회
        List<Map<String, Object>> messages = chatService.getChatMessages(cht_id);
        
        result.put("success", true);
        result.put("messages", messages);
        
        return result;
    }
    
    // 메시지 전송 (AJAX)
    @PostMapping("/send")
    @ResponseBody
    public Map<String, Object> sendMessage(
            @RequestParam("cht_id") int cht_id,
            @RequestParam("message") String message,
            HttpSession session) {
        
        Map<String, Object> result = new HashMap<>();
        
        // 세션에서 사용자 정보 가져오기
        String buy_em = (String) session.getAttribute("buyEm");
        String sel_id = (String) session.getAttribute("sel_id");
        
        if (buy_em == null && sel_id == null) {
            // 로그인되지 않은 경우
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return result;
        }
        
        // 채팅방 정보 조회
        Map<String, Object> chatRoom = chatService.getChatRoom(cht_id);
        
        // 현재 사용자가 해당 채팅방에 참여하고 있는지 확인
        boolean isParticipant = (buy_em != null && buy_em.equals(chatRoom.get("buy_em"))) || 
                              (sel_id != null && sel_id.equals(chatRoom.get("sel_id")));
        
        if (!isParticipant) {
            // 참여자가 아닌 경우
            result.put("success", false);
            result.put("message", "접근 권한이 없습니다.");
            return result;
        }
        
        // 메시지 저장
        Map<String, Object> chatDetail = new HashMap<>();
        chatDetail.put("cht_id", cht_id);
        chatDetail.put("chd_ms", message);
        
        // 발신자 정보 설정
        if (buy_em != null) {
            chatDetail.put("sender", buy_em);
            chatDetail.put("sender_type", "buyer");
        } else {
            chatDetail.put("sender", sel_id);
            chatDetail.put("sender_type", "seller");
        }
        
        chatService.sendMessage(chatDetail);
        
        result.put("success", true);
        
        return result;
    }
}
