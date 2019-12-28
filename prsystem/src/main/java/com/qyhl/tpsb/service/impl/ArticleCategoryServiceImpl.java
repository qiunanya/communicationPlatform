package com.qyhl.tpsb.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.qyhl.tpsb.commonutils.Constant;
import com.qyhl.tpsb.entity.ArticleCategory;
import com.qyhl.tpsb.mapper.ArticleCategoryMapper;
import com.qyhl.tpsb.service.ArticleCategoryService;
@Service
public class ArticleCategoryServiceImpl extends ServiceImpl<ArticleCategoryMapper, ArticleCategory> implements ArticleCategoryService {

	@Override
	public List<ArticleCategory> getList() {
		EntityWrapper<ArticleCategory> wrapper = new EntityWrapper<>();
		wrapper.eq("status", Constant.ONE);
		return this.selectList(wrapper);
	}

	
}
