package com.itwillbs.unipick.handler;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class MailAuth extends Authenticator {

    private PasswordAuthentication passwordAuth;

    public MailAuth(@Value("${mail.smtp.username}") String username, 
                    @Value("${mail.smtp.password}") String password) {
        this.passwordAuth = new PasswordAuthentication(username, password);
    }
	
	@Override
	  protected PasswordAuthentication getPasswordAuthentication() {
		passwordAuth = new PasswordAuthentication("junesse89@gmail.com", "kzzbvbajafejxmfg");
		
        return passwordAuth;
    }
}
