package com.itwillbs.unipick.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;

import com.itwillbs.unipick.service.ChatService;

@Controller
@RequestMapping("/chat")
public class ChatController {
    
    @Autowired
    private ChatService chatService;
    
    // 타입변환 예외 처리
    @ExceptionHandler(MethodArgumentTypeMismatchException.class)
    public String handleTypeMismatch(MethodArgumentTypeMismatchException ex) {
        if (ex.getName().equals("cht_id")) {
            // 채팅방 ID 변환 오류일 경우 채팅 목록으로 리다이렉트
            return "redirect:/chat/buyer/list";
        }
        return "redirect:/";
    }
    
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
        
        return "chat/sellerChat";
    }
    
    // 채팅방 페이지
    @GetMapping("/room/{cht_id}")
    public String chatRoom(@PathVariable("cht_id") String cht_id, HttpSession session, Model model) {
        // 세션에서 사용자 정보 가져오기 (다양한 키 확인)
        String buy_em = (String) session.getAttribute("buyEm");
        String sel_id = (String) session.getAttribute("sel_id");
        
        
        if (buy_em == null && sel_id == null) {
            // 로그인되지 않은 경우
            return "redirect:/buyerlogin";  // 경로 수정
        }
        
        try {
            // 채팅방 ID를 정수로 변환
            int chatRoomId = Integer.parseInt(cht_id);
            
            // 채팅방 정보 조회
            Map<String, Object> chatRoom = chatService.getChatRoom(chatRoomId);
            
            if (chatRoom == null) {
                // 채팅방을 찾을 수 없는 경우
                return "redirect:/chat/buyer/list";
            }
            
            model.addAttribute("chatRoom", chatRoom);
            
            // 현재 사용자가 구매자인지 판매자인지 확인
            String userType = (buy_em != null) ? "buyer" : "seller";
            model.addAttribute("userType", userType);
            model.addAttribute("userId", (buy_em != null) ? buy_em : sel_id);
            
            return "chat/ChatRoom";
        } catch (NumberFormatException e) {
            // 채팅방 ID가 유효한 정수가 아닌 경우
            return "redirect:/chat/buyer/list";
        }
    }
    
    // 팝업 채팅방 페이지
    @GetMapping("/popup/{cht_id}")
    public String chatPopup(@PathVariable("cht_id") String cht_id, HttpSession session, Model model) {
        // 세션에서 사용자 정보 가져오기
        String buy_em = (String) session.getAttribute("buyEm");
        String sel_id = (String) session.getAttribute("sel_id");
        
        if (buy_em == null && sel_id == null) {
            // 로그인되지 않은 경우
            return "redirect:/buyerlogin";
        }
        
        try {
            // 채팅방 ID를 정수로 변환
            int chatRoomId = Integer.parseInt(cht_id);
            
            // 채팅방 정보 조회
            Map<String, Object> chatRoom = chatService.getChatRoom(chatRoomId);
            
            if (chatRoom == null) {
                // 채팅방을 찾을 수 없는 경우
                return "redirect:/chat/buyer/list";
            }
            
            model.addAttribute("chatRoom", chatRoom);
            
            // 현재 사용자가 구매자인지 판매자인지 확인
            String userType = (buy_em != null) ? "buyer" : "seller";
            model.addAttribute("userType", userType);
            model.addAttribute("userId", (buy_em != null) ? buy_em : sel_id);
            
            return "chat/popUp";
        } catch (NumberFormatException e) {
            // 채팅방 ID가 유효한 정수가 아닌 경우
            return "redirect:/chat/buyer/list";
        }
    }
    
    // 판매자와 채팅 시작 (구매자용) - 일반 페이지
    @GetMapping("/start")
    public String startChat(@RequestParam("sel_id") String sel_id, HttpSession session) {
        // 세션에서 구매자 이메일 가져오기
        String buy_em = (String) session.getAttribute("buyEm");
        
        if (buy_em == null) {
            // 다른 세션 키 시도
            buy_em = (String) session.getAttribute("buyerEm");
        }
        
        if (buy_em == null || sel_id == null || sel_id.isEmpty()) {
            // 로그인되지 않았거나 판매자 ID가 유효하지 않은 경우
            return "redirect:/buyerlogin";
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
            // 다른 세션 키 시도
            buy_em = (String) session.getAttribute("buyerEm");
        }
        
        if (buy_em == null || sel_id == null || sel_id.isEmpty()) {
            // 로그인되지 않았거나 판매자 ID가 유효하지 않은 경우
            return "redirect:/buyerlogin";
        }
        
        // 채팅방 가져오기 (없으면 생성)
        int cht_id = chatService.getOrCreateChatRoom(buy_em, sel_id);
        
        return "redirect:/chat/popup/" + cht_id;
    }
    
    // 판매자 검색 API
    @GetMapping("/search/sellers")
    @ResponseBody
    public Map<String, Object> searchSellers(@RequestParam("term") String term) {
        Map<String, Object> result = new HashMap<>();
        
        List<Map<String, Object>> sellers = chatService.searchSellers(term);
        
        result.put("success", true);
        result.put("sellers", sellers);
        
        return result;
    }
    
    // 채팅 메시지 목록 조회 (AJAX)
    @GetMapping("/messages/{cht_id}")
    @ResponseBody
    public Map<String, Object> getMessages(@PathVariable("cht_id") String cht_id, HttpSession session) {
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
        
        try {
            // cht_id 문자열을 정수로 변환
            int chatRoomId = Integer.parseInt(cht_id);
            
            // 채팅방 정보 조회
            Map<String, Object> chatRoom = chatService.getChatRoom(chatRoomId);
            
            if (chatRoom == null) {
                result.put("success", false);
                result.put("message", "채팅방을 찾을 수 없습니다.");
                return result;
            }
            
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
            List<Map<String, Object>> messages = chatService.getChatMessages(chatRoomId);
            
            result.put("success", true);
            result.put("messages", messages);
        } catch (NumberFormatException e) {
            result.put("success", false);
            result.put("message", "유효하지 않은 채팅방 ID입니다.");
        }
        
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
        
        // 메시지 전송 처리
        Map<String, Object> chatDetail = new HashMap<>();
        chatDetail.put("cht_id", cht_id);
        chatDetail.put("chd_ms", message);
        chatDetail.put("sender", (buy_em != null) ? buy_em : sel_id);
        
        try {
            chatService.sendMessage(chatDetail);
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "메시지 전송에 실패했습니다.");
            e.printStackTrace();
        }
        
        return result;
    }
}
