package com.study.boot.board.service;

import com.querydsl.core.Tuple;
import com.study.boot.board.domain.Category;
import com.study.boot.board.repository.CategoryRepository;
import com.study.boot.payload.response.CategoryListDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class CategoryService {

    private final CategoryRepository categoryRepository;

    @Transactional
    public List<CategoryListDto> findCategoryCntAll() {
        return categoryRepository.findCategoryAndCntAll();
    }

    @Transactional
    public Category findByCategoryNo(Long categoryNo) {
        return categoryRepository.getOne(categoryNo);
    }

    @Transactional
    public void addCategory(String categoryName) {
        Category newCategory = new Category();
        newCategory.setCategoryName(categoryName);
        categoryRepository.save(newCategory);
    }

    @Transactional
    public void deleteCategory(long categoryNo) {
        categoryRepository.delete(categoryRepository.getOne(categoryNo));
    }

    @Transactional
    public void editCategoryName(long categoryNo, String categoryName) {
        Category category = categoryRepository.getOne(categoryNo);
        category.updateCategory(categoryName);
    }

}
