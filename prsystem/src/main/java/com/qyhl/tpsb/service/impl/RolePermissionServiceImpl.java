package com.qyhl.tpsb.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.qyhl.tpsb.entity.RolePermissionEntity;
import com.qyhl.tpsb.mapper.RolePermissionMapper;
import com.qyhl.tpsb.service.RolePermissionService;
@Service
@Transactional
public class RolePermissionServiceImpl extends ServiceImpl<RolePermissionMapper, RolePermissionEntity> implements RolePermissionService {

	@Autowired
	private RolePermissionMapper rolePermissionMapper;
	
	@Override
	public void doAssignPermission(Map<String, Object> map) {
		
		 try {
			 String id = (String) map.get("roleid");
			// 根据角色ID删除之前的分配信息
			 this.delete(new EntityWrapper<RolePermissionEntity>().eq("role_id", id));
			 rolePermissionMapper.doAssignPermission(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
	}

}
