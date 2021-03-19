package com.study.boot.payload.response;

import lombok.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ApiResponse {

    private boolean success;
    private String dateTime;
    private String errorCode;
    private String detail;
    private Map<String, Object> data = new HashMap<>();

   public ApiResponse(boolean success) {
        this.dateTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        this.success = success;
    }

    public ApiResponse(boolean success, String detail) {
        this.dateTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        this.success = success;
        this.detail = detail;
    }

    public ApiResponse(boolean success, String errorCode, String detail) {
        this.dateTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        this.success = success;
        this.errorCode = errorCode;
        this.detail = detail;
    }

    public void putData(String key, Object value) {
        this.data.put(key, value);
    }

}
