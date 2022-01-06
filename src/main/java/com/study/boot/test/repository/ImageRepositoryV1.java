package com.study.boot.test.repository;

import com.study.boot.test.domain.ImageTest;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ImageRepositoryV1 extends JpaRepository<ImageTest, Long> {

}
