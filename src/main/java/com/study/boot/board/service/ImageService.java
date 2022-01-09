package com.study.boot.board.service;

import com.study.boot.board.domain.Images;
import com.study.boot.board.repository.ImageRepository;
import com.study.boot.member.domain.Member;
import com.study.boot.test.domain.ImageTest;
import com.study.boot.test.dto.ImageDtoV1;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.awt.*;
import java.io.File;
import java.time.LocalDateTime;
import java.time.temporal.ChronoField;

@Service
@RequiredArgsConstructor
public class ImageService {

    private final ImageRepository imageRepository;

    @Transactional
    public void saveImage(MultipartFile mtf) {
//        String origName = new String(mtf.getOriginalFilename().getBytes("8859_1"), "UTF-8"); //한글꺠짐 방지

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
        String fileExtension = '.' + mtf.getOriginalFilename().replaceAll("^.*\\.(.*)$", "$1"); // 정규식 이용하여 확장자만 추출
        String path = "images/local/" + year + "/" + month + "/" + day;

        try {
            File file = new File(absolutePath + path);
            if(!file.exists()) {
                file.mkdirs(); // mkdir()과 다르게 상위 폴더가 없을 때 상위폴더까지 생성
            }

            file = new File(absolutePath + path + "/" + newFileName + fileExtension);
            mtf.transferTo(file);

            Images images = Images.builder()
                    .originImageName(mtf.getOriginalFilename())
                    .imageName(newFileName + fileExtension)
                    .imagePath(path)
                    .build();

            imageRepository.save(images);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
