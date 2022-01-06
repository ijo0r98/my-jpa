package com.study.boot.test.service;

import com.study.boot.test.domain.ImageTest;
import com.study.boot.test.dto.ImageDtoV1;
import com.study.boot.test.repository.ImageRepositoryV1;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class TestService {

    private final ImageRepositoryV1 imageRepositoryV1;

    // Lombok 도움없이 직접 빈 주입
//    private ImageRepositoryV1 imageRepositoryV1;
//    public TestService(ImageRepositoryV1 imageRepositoryV1) {
//        this.imageRepositoryV1 = imageRepositoryV1;
//    }

    @Transactional
    public Long saveImage(ImageDtoV1 imageDtoV1) {
        return imageRepositoryV1.save(imageDtoV1.toEntity()).getImageNo();
    }

    @Transactional
    public ImageDtoV1 getImage(Long id) {
        ImageTest image = imageRepositoryV1.findById(id).get();

        ImageDtoV1 imageDto = ImageDtoV1.builder()
                .imageName(image.getImageName())
                .imagePath(image.getImagePath())
                .originImageName(image.getOriginImageName()).build();
        return imageDto;
    }
}
