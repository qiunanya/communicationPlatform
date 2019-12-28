package com.qyhl.tpsb.entity;

import java.util.Date;

/**
 * 基础类
 * method：BaseInfo  
 * author：Qiu
 * time：2019-9-1 
 * @version 1.0.0
 */
public class BaseInfo {
	/**
	 * 创建人ID
	 */
	private String createId;
	/**
	 * 创建人姓名
	 */
    private String createPerson;
    /**
	 * 创建时间
	 */
	private Date createTime;
	/**
	 * 更新人ID
	 */
	private String updateId;
	/**
	 * 更新人姓名
	 */
	private String updatePerson;
	/**
	 * 更新时间
	 */
	private Date updateTime;
	/**
	 * 是否删除
	 */
	private Integer status;
	
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getCreateId() {
		return createId;
	}
	public void setCreateId(String createId) {
		this.createId = createId;
	}
	public String getCreatePerson() {
		return createPerson;
	}
	public void setCreatePerson(String createPerson) {
		this.createPerson = createPerson;
	}
	public String getUpdateId() {
		return updateId;
	}
	public void setUpdateId(String updateId) {
		this.updateId = updateId;
	}
	public String getUpdatePerson() {
		return updatePerson;
	}
	public void setUpdatePerson(String updatePerson) {
		this.updatePerson = updatePerson;
	}
	
	

}
