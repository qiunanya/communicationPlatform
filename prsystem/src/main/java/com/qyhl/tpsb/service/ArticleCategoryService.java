package com.qyhl.tpsb.service;

import java.util.List;

import com.baomidou.mybatisplus.service.IService;
import com.qyhl.tpsb.entity.ArticleCategory;

public interface ArticleCategoryService extends IService<ArticleCategory>{
	
	/**
	 * 获取分类列表
	 */
	List<ArticleCategory> getList();

}
