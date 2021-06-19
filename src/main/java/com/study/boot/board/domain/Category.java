package com.study.boot.board.domain;

import com.fasterxml.jackson.annotation.JsonBackReference;
import lombok.*;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class Category {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long categoryNo;

    @Column(length = 50, nullable = false)
    private String categoryName;

    @JsonBackReference
    @OneToMany(mappedBy = "category", cascade = CascadeType.ALL)
    private List<Board> boards = new ArrayList<>();

    public void updateCategory(String categoryName) {
        this.categoryName = categoryName;
    }
}

