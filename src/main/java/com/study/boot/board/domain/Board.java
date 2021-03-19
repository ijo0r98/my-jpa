package com.study.boot.board.domain;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.study.boot.common.DateEntity;
import com.study.boot.member.domain.Member;
import lombok.*;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
public class Board extends DateEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long boardNo;

    @JsonManagedReference
    @ManyToOne
    @JoinColumn(name = "member_no")
    private Member member;

    @JsonManagedReference
    @ManyToOne
    @JoinColumn(name = "category_no")
    private Category category;

    @JsonBackReference
    @OneToMany(mappedBy = "board", cascade = CascadeType.ALL)
    private List<Comment> comments = new ArrayList<>();

    //제목
    @Column(length = 500, nullable = false)
    private String boardTitle;

    //내용
    @Column(length = 1000, nullable = false)
    private String boardContent;

    //추천수
    @Column(insertable = false, columnDefinition = "int default 0", nullable = false)
    private Integer boardRcmdCnt;

    //조회수
    @Column(insertable = false, columnDefinition = "int default 0", nullable = false)
    private Integer boardViewCnt;


    //--비지니스 로직--//
    public void updateBoard (String title, String content, Category category) {
        this.boardTitle = title;
        this.boardContent = content;
        this.category = category;
    }


}

