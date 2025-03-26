package com.itwillbs.unipick.handler;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;


//웹소켓 핸들링을 수행할 클래스 정의 - TextWebSocketHandler 클래스 상속
// 이 클래스는 컨트롤러처럼 개발자가 직접 객체 생성을 제어하지 ㅏㄶ음(자동으로 관리됨)
// 서버에서는 단 하나의 유일한 객체(싱글톤)로 관리됨
// 클래스 내에서 TextWebSocketHandler 클래스의 메서드를 오버라이딩 해서 각 요청에 대한 처리 구현

@Component
public class MyWebSocketHandler extends TextWebSocketHandler {

	//접속한 클라리언트(사용자)들에 대한 정보를 저장할 용도의 Map객체 생성
	//-> Key: 웹소켓 세션 아이디(문자열) Value: 웹소켓 세션 객체(WebSocketSession 타입)
	//-> Map 객체의 구현체 클래스로 HashMap 타입 대신 ConcurrentHashMap 타입 사용시
	//   멀티스레딩 환경에서 동시 접근시에도 락(LOCK)을 통해 안전 (Thread-safe)하게 구현 가능
	//   단 추가/수정 등의 작업에서는 HashMap 보다 성능 느림, 읽기는 동일함


	private Map<String, WebSocketSession> userSessionList = new ConcurrentHashMap<String, WebSocketSession>();

	
	
	//1. afterConnectionEstablished - 웹소켓 최초 연결 시 자동으로 호출되는 메서드
	// 이 과정에서 스프링에서도 WebSocket 관련 객체가 자동으로 생성됨
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("웹소켓 최초연결(afterConnectionEstablished)");
		System.out.println("웹소켓 세션 아이디" + session.getId());
		System.out.println("웹소켓 세션 IP주소"+ session.getRemoteAddress());
	}
	
	//2. handleTextMessage - 클라이언트로부터 메세지를 수신할 경우 자동으로 호출되는 메서드
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("메세지 수신됨(handleTextMessage)");
	}

	
	//3. afterConnectionClosed - 웹소캣 연결 해제 시 자동으로 호출되는 메서드
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("웹소켓 연결 해제됨(afterConnectionClosed)");
	}
	//4. handleTransportError - 웹소켓 통신 과정에서 오류 발생 시 자동으로 호출되는 메서드
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		System.out.println("웹소켓 오류 발생(handleTransportError)");
	}

	
	
}
