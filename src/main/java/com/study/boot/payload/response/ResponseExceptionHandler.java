package com.study.boot.payload.response;

import com.study.boot.payload.exception.ResourceNotFoundException;
import com.study.boot.payload.exception.ResponseError;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

@ControllerAdvice
public class ResponseExceptionHandler {

    @ExceptionHandler(value = {ResourceNotFoundException.class})
    @ResponseStatus(value = HttpStatus.NOT_FOUND)
    @ResponseBody
    public ResponseError handlerResourceNotFound(ResourceNotFoundException e) {
        ResponseError responseError = new ResponseError(404, "resource가 존재하지 않습ㄴ디ㅏ.");
        return responseError;
    }

}
