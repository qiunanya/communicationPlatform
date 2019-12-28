package com.qyhl.tpsb.service;

import java.util.Map;

import com.baomidou.mybatisplus.service.IService;
import com.qyhl.tpsb.entity.RolePermissionEntity;

public interface RolePermissionService extends IService<RolePermissionEntity>{

	/** 
	 * 给角色分配权限
	 * method：doAssignPermission       
	 * @version 1.0.0
	 * time:2019-9-23下午11:53:33  
	 */
	void doAssignPermission(Map<String, Object> map);

}
