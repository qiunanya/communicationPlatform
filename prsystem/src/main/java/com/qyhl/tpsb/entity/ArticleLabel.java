package com.qyhl.tpsb.entity;

import java.io.Serializable;

/***
 * 文章标签
 * method：ArticleLabel  
 * author：Qiu
 * time：2019-10-18 
 * @version 1.0.0
 */
public class ArticleLabel extends BaseInfo implements Serializable{

	private static final long serialVersionUID = 1L;
	/**
	 * `label_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '标签ID',
  `label_name` varchar(20) NOT NULL COMMENT '标签名称',
  `label_alias` varchar(15) NOT NULL COMMENT '标签别名',
  `label_description` text NOT NULL COMMENT '标签描述',
	 */
	private Long labelId;
	private String labelName;
	private String labelAlias;
	private String labelDescription;
	public Long getLabelId() {
		return labelId;
	}
	public void setLabelId(Long labelId) {
		this.labelId = labelId;
	}
	public String getLabelName() {
		return labelName;
	}
	public void setLabelName(String labelName) {
		this.labelName = labelName;
	}
	public String getLabelAlias() {
		return labelAlias;
	}
	public void setLabelAlias(String labelAlias) {
		this.labelAlias = labelAlias;
	}
	public String getLabelDescription() {
		return labelDescription;
	}
	public void setLabelDescription(String labelDescription) {
		this.labelDescription = labelDescription;
	}
	
	
	
}
