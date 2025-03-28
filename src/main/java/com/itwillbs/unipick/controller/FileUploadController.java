package com.itwillbs.unipick.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class FileUploadController {
	
	 @PostMapping("/upload")
	    public ResponseEntity<Map<String, String>> handleFileUpload(
	    		HttpServletRequest req,
	    		@RequestParam("file") MultipartFile file) {
		 ServletContext servletContext = req.getServletContext();
	        System.out.println("🚀 파일 업로드 시도: " + file.getOriginalFilename());
	        try {
	            // 실제 배포 경로 가져오기
	            String uploadDirectory = servletContext.getRealPath("/resources/upload/");
	            System.out.println("📁 저장 경로: " + uploadDirectory);
	            
	            // 폴더가 없으면 생성
	            File uploadDir = new File(uploadDirectory);
	            if (!uploadDir.exists()) {
	                uploadDir.mkdirs();
	            }

	            // 파일 저장 처리
	            Path path = Paths.get(uploadDirectory, file.getOriginalFilename());
	            Files.write(path, file.getBytes());

	            // 업로드된 파일의 URL 반환
	            Map<String, String> response = new HashMap<>();
	            response.put("url", "/resources/upload/" + file.getOriginalFilename());
	            
	            return ResponseEntity.ok(response);
	        } catch (IOException e) {
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	                    .body(Collections.singletonMap("error", "파일 업로드에 실패했습니다."));
	        }
	    }
}
