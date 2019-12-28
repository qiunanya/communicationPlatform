package com.qyhl.tpsb.dto.user;

import com.qyhl.tpsb.dto.BaseSignPage;

public class FindUserDTO extends BaseSignPage{
	
	/**
	 * 搜索参数
	 */
	private String search;
	
	/**
	 * 用户ID
	 */
	private String userId;

	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	

}
