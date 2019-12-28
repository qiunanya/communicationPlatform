package com.qyhl.tpsb.dto.role;

import com.qyhl.tpsb.dto.BaseSignPage;

public class FindRoleDTO extends BaseSignPage{
   /**
    * 搜索参数
    */
	private String search;

public String getSearch() {
	return search;
}

public void setSearch(String search) {
	this.search = search;
}
	
}
