package com.study.boot.board.service;

import com.study.boot.board.domain.Category;
import com.study.boot.board.repository.CategoryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class CategoryService {

    private final CategoryRepository categoryRepository;

    @Transactional
    public List<Category> findAllCategory() {
        return categoryRepository.findAll();
    }

    @Transactional
    public Optional<Category> findByCategoryNo(Long categoryNo) {
        return categoryRepository.findById(categoryNo);
    }
}
