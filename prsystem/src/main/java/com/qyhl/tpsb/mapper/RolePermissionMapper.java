package com.qyhl.tpsb.mapper;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.qyhl.tpsb.entity.RolePermissionEntity;

@Repository
public interface RolePermissionMapper extends BaseMapper<RolePermissionEntity>{

	/** 
	 * 给角色分配权限
	 * method：doAssignPermission       
	 * @version 1.0.0
	 * time:2019-9-23下午11:54:37  
	 */
	void doAssignPermission(Map<String, Object> map);

	
}
