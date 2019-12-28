package com.qyhl.tpsb.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.qyhl.tpsb.commonutils.JsonLongSerializer;

/**
 * 文章类
 * method：Article  
 * author：Qiu
 * time：2019-10-18 
 * @version 1.0.0
 */
@TableName("tb_user_articles")
public class Article extends BaseInfo implements Serializable{
	private static final long serialVersionUID = 1L;
	/**
	 * `article_id` bigint(255) NOT NULL AUTO_INCREMENT COMMENT '博文ID',
  `user_id` bigint(20) DEFAULT NULL COMMENT '发表用户ID',
  `article_title` text COLLATE utf8_unicode_ci COMMENT '博文标题',
  `article_content` longtext COLLATE utf8_unicode_ci COMMENT '博文内容',
  `article_views` bigint(20) DEFAULT NULL COMMENT '浏览量',
  `article_comment_count` bigint(20) DEFAULT NULL COMMENT '评论总数',
  `article_date` datetime DEFAULT NULL COMMENT '发表时间',
  `article_like_count` bigint(20) DEFAULT NULL COMMENT '喜欢总量',
	 */
	@TableId
	@JsonSerialize(using = JsonLongSerializer.class )
	private Long articleId;
	private String userId;
	private String articleTitle;
	private String articleContent;
	private BigDecimal articleViews;
	private BigDecimal articleCommentCount;
	private Date articleDate;
	private Long article_like_count;
	private Long categoryId;
	@TableField(exist=false)
	private List<Article> article;
	public Long getArticleId() {
		return articleId;
	}
	public void setArticleId(Long articleId) {
		this.articleId = articleId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getArticleTitle() {
		return articleTitle;
	}
	public void setArticleTitle(String articleTitle) {
		this.articleTitle = articleTitle;
	}
	public String getArticleContent() {
		return articleContent;
	}
	public void setArticleContent(String articleContent) {
		this.articleContent = articleContent;
	}
	public BigDecimal getArticleViews() {
		return articleViews;
	}
	public void setArticleViews(BigDecimal articleViews) {
		this.articleViews = articleViews;
	}
	public BigDecimal getArticleCommentCount() {
		return articleCommentCount;
	}
	public void setArticleCommentCount(BigDecimal articleCommentCount) {
		this.articleCommentCount = articleCommentCount;
	}
	public Date getArticleDate() {
		return articleDate;
	}
	public void setArticleDate(Date articleDate) {
		this.articleDate = articleDate;
	}
	public Long getArticle_like_count() {
		return article_like_count;
	}
	public void setArticle_like_count(Long article_like_count) {
		this.article_like_count = article_like_count;
	}
	public List<Article> getArticle() {
		return article;
	}
	public void setArticle(List<Article> article) {
		this.article = article;
	}
	public Long getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(Long categoryId) {
		this.categoryId = categoryId;
	}
	
	
	
}
