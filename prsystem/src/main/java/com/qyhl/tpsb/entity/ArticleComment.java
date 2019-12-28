package com.qyhl.tpsb.entity;

import java.io.Serializable;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

/**
 * 文章评论
 * method：ArticleComment  
 * author：Qiu
 * time：2019-10-18 
 * @version 1.0.0
 */
@TableName("tb_article_comments")
public class ArticleComment extends BaseInfo implements Serializable{
	private static final long serialVersionUID = 1L;

	/**
	 * `comment_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '评论ID',
	  `user_id` bigint(20) DEFAULT NULL COMMENT '发表用户ID',
	  `article_id` bigint(20) DEFAULT NULL COMMENT '评论博文ID',
	  `comment_like_count` bigint(20) DEFAULT NULL COMMENT '点赞数',
	  `comment_content` text COMMENT '评论内容',
	  `parent_comment_id` bigint(20) DEFAULT NULL COMMENT '父评论ID',
	 */
	@TableId
	private Long commentId;
	private Long userId;
	private Long articleId;
	private Long commentLikeCount;
	private String commentContent;
	private Long parentCommentId;
	public Long getCommentId() {
		return commentId;
	}
	public void setCommentId(Long commentId) {
		this.commentId = commentId;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public Long getArticleId() {
		return articleId;
	}
	public void setArticleId(Long articleId) {
		this.articleId = articleId;
	}
	public Long getCommentLikeCount() {
		return commentLikeCount;
	}
	public void setCommentLikeCount(Long commentLikeCount) {
		this.commentLikeCount = commentLikeCount;
	}
	public String getCommentContent() {
		return commentContent;
	}
	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}
	public Long getParentCommentId() {
		return parentCommentId;
	}
	public void setParentCommentId(Long parentCommentId) {
		this.parentCommentId = parentCommentId;
	}
	
	
}
