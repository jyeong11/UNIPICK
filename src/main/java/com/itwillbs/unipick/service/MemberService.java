package com.itwillbs.unipick.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.unipick.mapper.MemberMapper;

@Service
public class MemberService {

	@Autowired
	MemberMapper mapper;
	
//	 // 이메일 중복 체크: 중복이면 true, 아니면 false
//    public boolean checkEmail(String email) {
//        return mapper.checkEmail(email) > 0;
//    }
//
//    // 회원가입 처리: 중복되지 않은 경우 회원 정보 등록
//    public boolean registerMember(Member member) {
//        if (checkEmail(member.getEmail())) {
//            return false; // 중복된 이메일 존재 시 등록 불가
//        }
//        // 실제 서비스에서는 비밀번호 암호화 적용 권장
//        return mapper.insertMember(member) > 0;
//    }
}
