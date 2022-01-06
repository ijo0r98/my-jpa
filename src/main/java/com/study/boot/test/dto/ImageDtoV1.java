package com.study.boot.test.dto;


import com.study.boot.test.domain.ImageTest;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ImageDtoV1 {

    private String originImageName;
    private String imageName;
    private String imagePath;

    public ImageTest toEntity() {
        ImageTest build = ImageTest.builder()
                .originImageName(originImageName)
                .imageName(imageName)
                .imagePath(imagePath)
                .build();
        return build;
    }

    @Builder
    public ImageDtoV1 (String originImageName, String imageName,String imagePath) {
        this.originImageName = originImageName;
        this.imageName = imageName;
        this.imagePath = imagePath;
    }

}
