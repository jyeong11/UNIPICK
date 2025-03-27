package com.itwillbs.unipick.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller //없길래 걸어봄 0327
public class UtilityController {

    public static String createDirectories(String basePath) {
        String datePath = new SimpleDateFormat("yyyy/MM/dd").format(new Date());
        String fullPath = basePath + "/" + datePath;
        File dir = new File(fullPath);
        if (!dir.exists()) {
            dir.mkdirs();
        }
        return datePath;
    }
    
    @GetMapping("privacy")
    public String privacy() {
    	return "inc/privacy";
    }
    
    @GetMapping("policy")
    public String policy () {
    	return "inc/policy";
    }
 
    
}
