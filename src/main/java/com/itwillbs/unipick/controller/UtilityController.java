package com.itwillbs.unipick.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;


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

}
