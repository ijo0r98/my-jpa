package com.study.boot.test.domain;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.study.boot.board.domain.Board;
import com.study.boot.member.domain.Member;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Getter
@Setter
@NoArgsConstructor
public class ImageTest {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long imageNo;

    @Column(length = 500, nullable = false)
    private String originImageName;

    @Column(length = 500, nullable = false)
    private String imageName;

    @Column(length = 1000, nullable = false)
    private String imagePath;

    @Builder
    public ImageTest(String originImageName, String imageName, String imagePath) {
        this.originImageName = originImageName;
        this.imageName = imageName;
        this.imagePath = imagePath;
    }
}
