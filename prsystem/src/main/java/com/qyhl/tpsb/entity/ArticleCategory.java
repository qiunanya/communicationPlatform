package com.qyhl.tpsb.entity;

import java.io.Serializable;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

/**
 * 文章分类
 * method：ArticleCategory  
 * author：Qiu
 * time：2019-10-18 
 * @version 1.0.0
 */
@TableName("tb_article_category")
public class ArticleCategory extends BaseInfo implements Serializable{

	private static final long serialVersionUID = 1L;

	/**
	 * `category_id` bigint(20) NOT NULL COMMENT '分类ID',
	  `category_name` varchar(50) NOT NULL COMMENT '分类名称',
	  `category_alias` varchar(15) NOT NULL COMMENT '分类别名',
	  `category_description` text NOT NULL COMMENT '分类描述',
	  `parent_category_id` bigint(20) NOT NULL COMMENT '父分类ID',
	 */
	@TableId
	private Long categoryId;
	private String categoryName;
	private String categoryAlias;
	private String categoryDescription;
	private Long parentCategoryId;
	private Integer status;
	public Long getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(Long categoryId) {
		this.categoryId = categoryId;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getCategoryAlias() {
		return categoryAlias;
	}
	public void setCategoryAlias(String categoryAlias) {
		this.categoryAlias = categoryAlias;
	}
	public String getCategoryDescription() {
		return categoryDescription;
	}
	public void setCategoryDescription(String categoryDescription) {
		this.categoryDescription = categoryDescription;
	}
	public Long getParentCategoryId() {
		return parentCategoryId;
	}
	public void setParentCategoryId(Long parentCategoryId) {
		this.parentCategoryId = parentCategoryId;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	
	
	
}
