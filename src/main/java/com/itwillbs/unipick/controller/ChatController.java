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
import com.itwillbs.unipick.service.BuyerService;

@Controller
@RequestMapping("/chat")
public class ChatController {
    
    @Autowired
    private ChatService chatService;
    
    @Autowired
    private BuyerService buyerService;
    
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
        
        // 마지막 확인 시간 업데이트
        chatService.updateLastCheckedTime(buy_em);
        
        return "chat/buyerChat";
    }
    
    // 판매자 채팅 목록 페이지
    @GetMapping("/seller/list")
    public String sellerChatList(HttpSession session, Model model) {
        // 세션에서 판매자 ID 가져오기
        String sel_id = (String) session.getAttribute("sel_id");
        
        // 다른 세션 키도 확인
        if (sel_id == null) {
            sel_id = (String) session.getAttribute("sellerId");
        }
        if (sel_id == null) {
            sel_id = (String) session.getAttribute("seller_id");
        }
        if (sel_id == null) {
            sel_id = (String) session.getAttribute("selId");
        }
        
        System.out.println("판매자 세션 ID: " + sel_id);
        
        if (sel_id == null) {
            // 로그인되지 않은 경우
            return "redirect:/sellerlogin";
        }
        
        // 채팅방 목록 조회
        List<Map<String, Object>> chatList = chatService.getSellerChatList(sel_id);
        model.addAttribute("chatList", chatList);
        
        // 마지막 확인 시간 업데이트
        chatService.updateSellerLastCheckedTime(sel_id);
        
        return "chat/sellerChat";
    }
    
    // 채팅방 페이지
    @GetMapping("/room/{cht_id}")
    public String chatRoom(@PathVariable("cht_id") String cht_id, HttpSession session, Model model) {
        // 세션에서 사용자 정보 가져오기
        String buy_em = (String) session.getAttribute("buyEm");
        String buy_nm = (String) session.getAttribute("buyNm"); // 이름 가져오기
        String sel_id = (String) session.getAttribute("sel_id");
        
        // 다른 판매자 세션 키 시도
        if (sel_id == null) {
            sel_id = (String) session.getAttribute("sellerId");
        }
        if (sel_id == null) {
            sel_id = (String) session.getAttribute("seller_id");
        }
        if (sel_id == null) {
            sel_id = (String) session.getAttribute("selId");
        }
        
        String sel_nm = (String) session.getAttribute("sel_nm"); // 판매자 이름 가져오기
        
        // 디버깅용 출력
        System.out.println("채팅방 판매자 세션 ID: " + sel_id);
        System.out.println("채팅방 구매자 세션 이메일: " + buy_em);
        
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
            
            // 사용자 ID 설정 (이메일 또는 ID)
            String userId = (buy_em != null) ? buy_em : sel_id;
            model.addAttribute("userId", userId);
            
            // 사용자 아이디를 세션에 저장 (웹소켓 핸들러에서 사용)
            // 이메일 대신 이름을 사용 (이름이 없는 경우 이메일 사용)
            String displayName = (buy_em != null) ? 
                (buy_nm != null ? buy_nm : buy_em) : 
                (sel_nm != null ? sel_nm : sel_id);
            session.setAttribute("sId", displayName);
            
            // 디버깅용 출력
            System.out.println("사용자 유형: " + userType);
            System.out.println("사용자 ID: " + userId);
            System.out.println("표시 이름: " + displayName);
            
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
        String buy_nm = (String) session.getAttribute("buyNm"); // 이름 가져오기
        String sel_id = (String) session.getAttribute("sel_id");
        
        // 다른 판매자 세션 키 시도
        if (sel_id == null) {
            sel_id = (String) session.getAttribute("sellerId");
        }
        if (sel_id == null) {
            sel_id = (String) session.getAttribute("seller_id");
        }
        if (sel_id == null) {
            sel_id = (String) session.getAttribute("selId");
        }
        
        String sel_nm = (String) session.getAttribute("sel_nm"); // 판매자 이름 가져오기
        
        // 디버깅용 출력
        System.out.println("채팅방 판매자 세션 ID: " + sel_id);
        System.out.println("채팅방 구매자 세션 이메일: " + buy_em);
        
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
            
            // 사용자 ID 설정 (이메일 또는 ID)
            String userId = (buy_em != null) ? buy_em : sel_id;
            model.addAttribute("userId", userId);
            
            // 사용자 아이디를 세션에 저장 (웹소켓 핸들러에서 사용)
            // 이메일 대신 이름을 사용 (이름이 없는 경우 이메일 사용)
            String displayName = (buy_em != null) ? 
                (buy_nm != null ? buy_nm : buy_em) : 
                (sel_nm != null ? sel_nm : sel_id);
            session.setAttribute("sId", displayName);
            
            // 디버깅용 출력
            System.out.println("사용자 유형: " + userType);
            System.out.println("사용자 ID: " + userId);
            System.out.println("표시 이름: " + displayName);
            
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
        
        // 다른 판매자 세션 키 시도
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
        System.out.println("메시지 조회 - 판매자 세션 ID: " + sel_id);
        System.out.println("메시지 조회 - 구매자 세션 이메일: " + buy_em);
        
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
        
        // 다른 판매자 세션 키 시도
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
        System.out.println("메시지 전송 - 판매자 세션 ID: " + sel_id);
        System.out.println("메시지 전송 - 구매자 세션 이메일: " + buy_em);
        
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
    
    // 웹소켓 채팅 페이지
    @GetMapping("/websocket")
    public String websocketChat(HttpSession session) {
        // 세션에서 사용자 정보 가져오기
        String buy_em = (String) session.getAttribute("buyEm");
        String buy_nm = (String) session.getAttribute("buyNm"); // 이름 가져오기
        String sel_id = (String) session.getAttribute("sel_id");
        
        // 다른 판매자 세션 키 시도
        if (sel_id == null) {
            sel_id = (String) session.getAttribute("sellerId");
        }
        if (sel_id == null) {
            sel_id = (String) session.getAttribute("seller_id");
        }
        if (sel_id == null) {
            sel_id = (String) session.getAttribute("selId");
        }
        
        String sel_nm = (String) session.getAttribute("sel_nm"); // 판매자 이름 가져오기
        
        // 디버깅용 출력
        System.out.println("웹소켓 판매자 세션 ID: " + sel_id);
        System.out.println("웹소켓 구매자 세션 이메일: " + buy_em);
        
        if (buy_em == null && sel_id == null) {
            // 로그인되지 않은 경우
            return "redirect:/buyerlogin";
        }
        
        // 사용자 아이디를 세션에 저장 (웹소켓 핸들러에서 사용)
        // 이메일 대신 이름을 사용 (이름이 없는 경우 이메일 사용)
        String displayName = (buy_em != null) ? 
            (buy_nm != null ? buy_nm : buy_em) : 
            (sel_nm != null ? sel_nm : sel_id);
        session.setAttribute("sId", displayName);
        
        return "chat/WebSocketChat";
    }
    
    // 채팅방 판매자 신고 (AJAX)
    @PostMapping("/report")
    @ResponseBody
    public Map<String, Object> reportSeller(
            @RequestParam("cht_id") int cht_id,
            @RequestParam("rpt_rs") String reportReason,
            @RequestParam(value = "rpt_tg", required = false) String reportTarget,
            HttpSession session) {
        
        Map<String, Object> result = new HashMap<>();
        
        // 세션에서 구매자 이메일 가져오기
        String buy_em = (String) session.getAttribute("buyEm");
        
        // 다른 세션 키 시도
        if (buy_em == null) {
            buy_em = (String) session.getAttribute("buyerEm");
        }
        
        // 로그인 상태 확인
        if (buy_em == null) {
            result.put("success", false);
            result.put("message", "구매자 로그인이 필요합니다.");
            return result;
        }
        
        try {
            // 채팅방 정보 조회
            Map<String, Object> chatRoom = chatService.getChatRoom(cht_id);
            
            if (chatRoom == null) {
                result.put("success", false);
                result.put("message", "채팅방을 찾을 수 없습니다.");
                return result;
            }
            
            // 해당 채팅방의 구매자인지 확인
            if (!buy_em.equals(chatRoom.get("buy_em"))) {
                result.put("success", false);
                result.put("message", "해당 채팅방의 구매자만 신고할 수 있습니다.");
                return result;
            }
            
            // 신고 데이터 구성
            Map<String, Object> reportData = new HashMap<>();
            reportData.put("buy_em", buy_em);
            reportData.put("sel_id", chatRoom.get("sel_id"));
            reportData.put("rpt_rs", reportReason);
            
            // 신고 대상이 지정되지 않은 경우 기본값 설정 (판매자 자체를 신고)
            if (reportTarget == null || reportTarget.isEmpty()) {
                reportData.put("rpt_tg", "판매자");
            } else {
                reportData.put("rpt_tg", reportTarget);
            }
            
            // 신고 등록 처리
            chatService.reportSeller(reportData);
            
            result.put("success", true);
            result.put("message", "신고가 접수되었습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "신고 처리 중 오류가 발생했습니다: " + e.getMessage());
            e.printStackTrace();
        }
        
        return result;
    }
    
    // 채팅방 구매자 신고 (AJAX)
    @PostMapping("/report-buyer")
    @ResponseBody
    public Map<String, Object> reportBuyer(
            @RequestParam("cht_id") int cht_id,
            @RequestParam("rpt_rs") String reportReason,
            @RequestParam(value = "rpt_tg", required = false) String reportTarget,
            HttpSession session) {
        
        Map<String, Object> result = new HashMap<>();
        
        // 세션에서 판매자 ID 가져오기
        String sel_id = (String) session.getAttribute("sel_id");
        
        // 다른 판매자 세션 키 시도
        if (sel_id == null) {
            sel_id = (String) session.getAttribute("sellerId");
        }
        if (sel_id == null) {
            sel_id = (String) session.getAttribute("seller_id");
        }
        if (sel_id == null) {
            sel_id = (String) session.getAttribute("selId");
        }
        
        // 로그인 상태 확인
        if (sel_id == null) {
            result.put("success", false);
            result.put("message", "판매자 로그인이 필요합니다.");
            return result;
        }
        
        try {
            // 채팅방 정보 조회
            Map<String, Object> chatRoom = chatService.getChatRoom(cht_id);
            
            if (chatRoom == null) {
                result.put("success", false);
                result.put("message", "채팅방을 찾을 수 없습니다.");
                return result;
            }
            
            // 해당 채팅방의 판매자인지 확인
            if (!sel_id.equals(chatRoom.get("sel_id"))) {
                result.put("success", false);
                result.put("message", "해당 채팅방의 판매자만 신고할 수 있습니다.");
                return result;
            }
            
            // 신고 데이터 구성
            Map<String, Object> reportData = new HashMap<>();
            reportData.put("buy_em", chatRoom.get("buy_em"));
            reportData.put("sel_id", sel_id);
            reportData.put("rpt_rs", reportReason);
            
            // 신고 대상이 지정되지 않은 경우 기본값 설정 (구매자 자체를 신고)
            if (reportTarget == null || reportTarget.isEmpty()) {
                reportData.put("rpt_tg", "구매자");
            } else {
                reportData.put("rpt_tg", reportTarget);
            }
            
            // 신고 등록 처리
            chatService.reportBuyer(reportData);
            
            result.put("success", true);
            result.put("message", "신고가 접수되었습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "신고 처리 중 오류가 발생했습니다: " + e.getMessage());
            e.printStackTrace();
        }
        
        return result;
    }
    
    // 채팅방 신고 내역 조회 (AJAX)
    @GetMapping("/reports/{cht_id}")
    @ResponseBody
    public Map<String, Object> getChatReports(@PathVariable("cht_id") int cht_id, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        // 세션에서 사용자 정보 가져오기
        String buy_em = (String) session.getAttribute("buyEm");
        String sel_id = (String) session.getAttribute("sel_id");
        
        // 다른 판매자 세션 키 시도
        if (sel_id == null) {
            sel_id = (String) session.getAttribute("sellerId");
        }
        if (sel_id == null) {
            sel_id = (String) session.getAttribute("seller_id");
        }
        if (sel_id == null) {
            sel_id = (String) session.getAttribute("selId");
        }
        
        if (buy_em == null && sel_id == null) {
            // 로그인되지 않은 경우
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return result;
        }
        
        try {
            // 채팅방 정보 조회
            Map<String, Object> chatRoom = chatService.getChatRoom(cht_id);
            
            if (chatRoom == null) {
                result.put("success", false);
                result.put("message", "채팅방을 찾을 수 없습니다.");
                return result;
            }
            
            // 채팅방 참여자인지 확인
            boolean isParticipant = (buy_em != null && buy_em.equals(chatRoom.get("buy_em"))) || 
                                  (sel_id != null && sel_id.equals(chatRoom.get("sel_id")));
            
            if (!isParticipant) {
                result.put("success", false);
                result.put("message", "해당 채팅방의 참여자만 신고 내역을 조회할 수 있습니다.");
                return result;
            }
            
            // 신고 내역 조회
            List<Map<String, Object>> reports = chatService.getChatReports(cht_id);
            
            result.put("success", true);
            result.put("reports", reports);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "신고 내역 조회 중 오류가 발생했습니다: " + e.getMessage());
            e.printStackTrace();
        }
        
        return result;
    }
    
    // 새 메시지 개수 확인 (구매자용) (AJAX)
    @GetMapping("/new-messages/count")
    @ResponseBody
    public Map<String, Object> getNewMessageCount(HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        // 세션에서 구매자 이메일 가져오기
        String buy_em = (String) session.getAttribute("buyEm");
        
        // 다른 세션 키 시도
        if (buy_em == null) {
            buy_em = (String) session.getAttribute("buyerEm");
        }
        
        if (buy_em == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            result.put("count", 0);
            return result;
        }
        
        try {
            int newMessageCount = chatService.getNewMessageCountForBuyer(buy_em);
            
            result.put("success", true);
            result.put("count", newMessageCount);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "메시지 개수 조회 중 오류가 발생했습니다.");
            result.put("count", 0);
            e.printStackTrace();
        }
        
        return result;
    }
    
    // 마지막 확인 시간 업데이트 (구매자용) (AJAX)
    @PostMapping("/update-last-checked")
    @ResponseBody
    public Map<String, Object> updateLastCheckedTime(HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        // 세션에서 구매자 이메일 가져오기
        String buy_em = (String) session.getAttribute("buyEm");
        
        // 다른 세션 키 시도
        if (buy_em == null) {
            buy_em = (String) session.getAttribute("buyerEm");
        }
        
        if (buy_em == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return result;
        }
        
        try {
            chatService.updateLastCheckedTime(buy_em);
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "마지막 확인 시간 업데이트 중 오류가 발생했습니다.");
            e.printStackTrace();
        }
        
        return result;
    }
    
    // 새 메시지 개수 확인 (판매자용) (AJAX)
    @GetMapping("/seller/new-messages/count")
    @ResponseBody
    public Map<String, Object> getNewMessageCountForSeller(HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        // 세션에서 판매자 ID 가져오기
        String sel_id = (String) session.getAttribute("sel_id");
        
        // 다른 세션 키도 확인
        if (sel_id == null) {
            sel_id = (String) session.getAttribute("sellerId");
        }
        if (sel_id == null) {
            sel_id = (String) session.getAttribute("seller_id");
        }
        if (sel_id == null) {
            sel_id = (String) session.getAttribute("selId");
        }
        
        if (sel_id == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            result.put("count", 0);
            return result;
        }
        
        try {
            int newMessageCount = chatService.getNewMessageCountForSeller(sel_id);
            
            result.put("success", true);
            result.put("count", newMessageCount);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "메시지 개수 조회 중 오류가 발생했습니다.");
            result.put("count", 0);
            e.printStackTrace();
        }
        
        return result;
    }
    
    // 마지막 확인 시간 업데이트 (판매자용) (AJAX)
    @PostMapping("/seller/update-last-checked")
    @ResponseBody
    public Map<String, Object> updateSellerLastCheckedTime(HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        // 세션에서 판매자 ID 가져오기
        String sel_id = (String) session.getAttribute("sel_id");
        
        // 다른 세션 키도 확인
        if (sel_id == null) {
            sel_id = (String) session.getAttribute("sellerId");
        }
        if (sel_id == null) {
            sel_id = (String) session.getAttribute("seller_id");
        }
        if (sel_id == null) {
            sel_id = (String) session.getAttribute("selId");
        }
        
        if (sel_id == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return result;
        }
        
        try {
            chatService.updateSellerLastCheckedTime(sel_id);
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "마지막 확인 시간 업데이트 중 오류가 발생했습니다.");
            e.printStackTrace();
        }
        
        return result;
    }
    
    // 상품 문의 채팅 시작 (팝업 창)
    @GetMapping("/product-inquiry")
    public String startProductInquiry(
            @RequestParam(value = "sel_id", required = false) String sel_id,
            @RequestParam("prd_cd") String prd_cd,
            @RequestParam("prd_nm") String prd_nm,
            HttpSession session, Model model) {
        
        // 세션에서 구매자 이메일 가져오기
        String buy_em = (String) session.getAttribute("buyEm");
        
        if (buy_em == null) {
            // 다른 세션 키 시도
            buy_em = (String) session.getAttribute("buyerEm");
        }
        
        if (buy_em == null) {
            // 로그인되지 않은 경우
            return "redirect:/buyerlogin";
        }
        
        // 판매자 ID가 전달되지 않은 경우 상품 코드로 조회
        if (sel_id == null || sel_id.isEmpty()) {
            try {
                // BuyerService를 통해 판매자 ID 조회
                sel_id = buyerService.getSellerIdByProductId(prd_cd);
                
                if (sel_id == null || sel_id.isEmpty()) {
                    // 판매자 ID를 찾을 수 없음
                    return "redirect:/";
                }
            } catch (Exception e) {
                System.err.println("판매자 ID 조회 중 오류: " + e.getMessage());
                return "redirect:/";
            }
        }
        
        // 채팅방 가져오기 (없으면 생성)
        int cht_id = chatService.getOrCreateChatRoom(buy_em, sel_id);
        
        // 첫 메시지로 상품 문의 내용 전송
        Map<String, Object> chatDetail = new HashMap<>();
        chatDetail.put("cht_id", cht_id);
        chatDetail.put("chd_ms", "[상품문의] 상품코드: " + prd_cd + ", 상품명: " + prd_nm);
        chatDetail.put("sender", buy_em);
        
        try {
            chatService.sendMessage(chatDetail);
        } catch (Exception e) {
            System.err.println("상품 문의 메시지 전송 중 오류: " + e.getMessage());
        }
        
        return "redirect:/chat/popup/" + cht_id;
    }
}
