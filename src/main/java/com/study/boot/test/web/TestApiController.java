package com.study.boot.test.web;

import com.study.boot.payload.response.ApiResponse;
import com.study.boot.test.domain.ImageTest;
import com.study.boot.test.dto.ImageDtoV1;
import com.study.boot.test.service.TestService;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.http.ResponseEntity;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.temporal.ChronoField;
import java.util.Date;

@RestController
@RequestMapping("/test")
@RequiredArgsConstructor
public class TestApiController {

    private final TestService testService;

    @GetMapping("/image/V1/form")
    public ModelAndView imageFormV1() throws Exception{
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("/test/imageV1");

        return modelAndView;
    }

    @PostMapping("/image/V1/api")
    public String imageUploadV1(@RequestParam(name = "imageV1") MultipartFile imageV1) throws IOException {

        LocalDateTime now = LocalDateTime.now();
        int year = now.getYear();
        int month = now.getMonthValue();
        int day = now.getDayOfMonth();
        int hour = now.getHour();
        int minute = now.getMinute();
        int second = now.getSecond();
        int millis = now.get(ChronoField.MILLI_OF_SECOND);

        String absolutePath = new File("/Users/juran/Desktop").getAbsolutePath() + "/";
        String newFileName = "image" + hour + minute + second + millis;
        String fileExtension = '.' + imageV1.getOriginalFilename().replaceAll("^.*\\.(.*)$", "$1"); // 정규식 이용하여 확장자만 추출
        String path = "images/test/" + year + "/" + month + "/" + day;

        try {
            if(!imageV1.isEmpty()) {
                File file = new File(absolutePath + path);
                if(!file.exists()){
                    file.mkdirs(); // mkdir()과 다르게 상위 폴더가 없을 때 상위폴더까지 생성
                }

                file = new File(absolutePath + path + "/" + newFileName + fileExtension);
                imageV1.transferTo(file);

                ImageDtoV1 imgDto = ImageDtoV1.builder()
                        .originImageName(imageV1.getOriginalFilename())
                        .imagePath(path)
                        .imageName(newFileName + fileExtension)
                        .build();

                testService.saveImage(imgDto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "test/imageV1";
    }

    @GetMapping("/image/V2/form")
    public String imageFormV2() throws Exception{
        return "test/imageV2";
    }



}
