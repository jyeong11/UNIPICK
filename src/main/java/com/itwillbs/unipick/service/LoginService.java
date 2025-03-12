package com.itwillbs.unipick.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.unipick.mapper.LoginMapper;

@Service
public class LoginService {

	@Autowired
	LoginMapper mapper;
}
