package com.study.boot.board.repository;

import com.study.boot.board.domain.Images;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ImageRepository extends JpaRepository<Images, Long> {
}
