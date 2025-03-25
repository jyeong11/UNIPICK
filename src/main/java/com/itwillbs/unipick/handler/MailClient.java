package com.itwillbs.unipick.handler;

import java.util.Properties;

import javax.mail.Address;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

// 메일 관련 작업을 처리하는 클래스
@Component
public class MailClient {

	@Autowired
	private MailAuth mailAuth;

	private final String HOST = "smtp.gmail.com";
	private final String PORT = "587";
	private final String SENDER_ADDRESS = "junesse89@gmail.com";
	
	@Async
	public void sendMail(String receiver, String subject, String content) {
		
		try {
			
			Properties props = System.getProperties();
			
			
			props.put("mail.smtp.host", HOST); // SMTP 서버 주소
			props.put("mail.smtp.port", PORT); // SMTP 포트 번호
			props.put("mail.smtp.auth", "true"); // SMTP 이용과정에서 인증 여부 설정
			props.put("mail.smtp.starttls.enable", "true"); // 인증 프로토콜로 TLS 프로토콜 지정
			props.put("mail.smtp.ssl.protocols", "TLSv1.2"); // TLS 프로토콜 버전 설정
			props.put("mail.smtp.ssl.trust", HOST); // SSL 인증에 사용할 신뢰 가능한 서버 주소 등록
			
			Session mailSession = Session.getDefaultInstance(props, mailAuth);
			
			Message message = new MimeMessage(mailSession);
			
			Address senderAddr = new InternetAddress(SENDER_ADDRESS, "아이티윌");

			Address receiverAddr = new InternetAddress(receiver);

			message.setHeader("content-type", "text/html; charset=UTF-8");
			
			message.setFrom(senderAddr);
			
			
			message.setRecipient(RecipientType.TO, receiverAddr);

			message.setSubject(subject);

			message.setContent("<h3>"+content+"</h3>", "text/html; charset=UTF-8");
			
			Transport.send(message);
			
			System.out.println("메일 발송 성공!");
		} catch (Exception e) {
			System.out.println("메일 발송 실패!");
			e.printStackTrace();
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
	
}
