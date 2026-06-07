package com.civic.dao;

import java.util.List;

import com.civic.dto.Category;

public interface CategoryDAO {
	List<Category> getAllCategories();
    Category getCategoryById(int id);
    Category getCategoryByName(String name);
    void addCategory(Category category);
    void updateCategory(Category category);
    void deleteCategory(int id);
    boolean isCategoryExists(String name);
}
