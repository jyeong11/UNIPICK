package com.itwillbs.unipick.handler;

import java.util.Properties;

import javax.mail.Address;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

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
            // 공백 제거
            receiver = receiver.trim();

            Properties props = System.getProperties();
            props.put("mail.smtp.host", HOST);
            props.put("mail.smtp.port", PORT);
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.ssl.protocols", "TLSv1.2");
            props.put("mail.smtp.ssl.trust", HOST);

            Session mailSession = Session.getDefaultInstance(props, mailAuth);
            Message message = new MimeMessage(mailSession);

            // 보내는 사람 주소 설정 (이름 값에 큰따옴표 추가)
            Address senderAddr = new InternetAddress(SENDER_ADDRESS, "\"유니픽\"");
            message.setFrom(senderAddr);

            // 수신자 이메일 검증
            try {
                InternetAddress emailAddr = new InternetAddress(receiver);
                emailAddr.validate();
                Address receiverAddr = emailAddr;
                message.setRecipient(Message.RecipientType.TO, receiverAddr);
            } catch (AddressException e) {
                System.out.println("잘못된 이메일 형식: " + receiver);
                e.printStackTrace();
                return; // 잘못된 이메일이면 메일 발송 중단
            }

            message.setHeader("content-type", "text/html; charset=UTF-8");
            message.setSubject(subject);
            message.setContent("<h3>" + content + "</h3>", "text/html; charset=UTF-8");

            Transport.send(message);
            System.out.println("메일 발송 성공!");

        } catch (Exception e) {
            System.out.println("메일 발송 실패!");
            e.printStackTrace();
        }
    }
}
