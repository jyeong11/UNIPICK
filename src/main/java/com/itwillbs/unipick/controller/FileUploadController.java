package com.itwillbs.unipick.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class FileUploadController {
	@PostMapping("/upload")
    public ResponseEntity<Map<String, String>> handleFileUpload(@RequestParam("image") MultipartFile file) {
		System.out.println("!~@#$%^&*"+file);
        try {
            String uploadDirectory = "D:/UNIPICK/src/main/webapp/resources/upload/";

            // 파일 저장 처리
            Path path = Paths.get(uploadDirectory + file.getOriginalFilename());
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
