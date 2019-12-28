package com.qyhl.tpsb.dto;
/**
 * 分页过滤条件
 * @author:杨云
 * @date:2019-8-10上午11:34:01
 */
public class BaseSignPage {
	 /**
	  * 当前页
	  */
     private Integer page = 1;
     /**
	  * 每页显示条数
	  */
     private Integer limit = 10;
     /**
	  * 排序规则：true 升序  false 降序
	  */
     private Boolean asc = true;
	public Integer getPage() {
		return page;
	}
	public void setPage(Integer page) {
		this.page = page;
	}
	
	public Integer getLimit() {
		return limit;
	}
	public void setLimit(Integer limit) {
		this.limit = limit;
	}
	public Boolean getAsc() {
		return asc;
	}
	public void setAsc(Boolean asc) {
		this.asc = asc;
	}
     
     
}
