package com.study.boot.board.domain;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.study.boot.common.DateEntity;
import com.study.boot.member.domain.Member;
import lombok.*;

import javax.persistence.*;

@Entity
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Comment extends DateEntity {

    @Id
    @GeneratedValue (strategy = GenerationType.IDENTITY)
    private Long commentNo;

    @JsonManagedReference
    @ManyToOne
    @JoinColumn(name = "member_no")
    private Member member;

    @JsonManagedReference
    @ManyToOne
    @JoinColumn(name = "board_no")
    private Board board;

    @Column(length = 500, nullable = false)
    private String commentContent;

}
