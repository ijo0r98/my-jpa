package com.study.boot.image.domain;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.study.boot.board.domain.Board;
import com.study.boot.common.DateEntity;
import com.study.boot.member.domain.Member;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@NoArgsConstructor
@Entity
@Getter
@Setter
public class Images extends DateEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long imageNo;

    @JsonManagedReference
    @ManyToOne
    @JoinColumn(name = "member_no")
    private Member member;

    @JsonManagedReference
    @ManyToOne
    @JoinColumn(name = "board_no")
    private Board board;

    @Column(length = 500, nullable = false)
    private String originImageName;

    @Column(length = 500, nullable = false)
    private String imageName;

    @Column(length = 1000, nullable = false)
    private String imagePath;
}
