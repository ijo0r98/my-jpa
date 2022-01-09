package com.study.boot.payload.request;

import com.sun.istack.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;


@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class BoardRequest {


    private String boardTitle;
    private String boardContent;
    private Long categoryNo;
    private MultipartFile image;

}
