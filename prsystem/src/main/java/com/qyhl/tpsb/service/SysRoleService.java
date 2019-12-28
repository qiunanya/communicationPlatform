package com.qyhl.tpsb.service;

import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.IService;
import com.qyhl.tpsb.dto.role.FindRoleDTO;
import com.qyhl.tpsb.entity.SysRoleEntity;
import com.qyhl.tpsb.entity.SysUserEntity;

/**
 * 角色服务
 * method：SysRoleService  
 * author：Qiu
 * time：2019-9-1 
 * @version 1.0.0
 */
public interface SysRoleService extends IService<SysRoleEntity>{
	
   /**
    * 添加角色
    * */
	void add(SysRoleEntity sysRoleEntity,SysUserEntity user);
    /**
     * 分页获取角色信息
     * Anthor:Qiu
     * method：getData       
     * @version 1.0.0
     * time:2019-9-3下午10:00:27
     */
    Page<SysRoleEntity> getData(FindRoleDTO findRoleDTO);
	/** 
	 * 根据ID删除角色
	 * Anthor:Qiu
	 * method：removeById       
	 * @version 1.0.0
	 * time:2019-9-7上午8:08:23  
	 */
	
	Integer removeById(String id, SysUserEntity user);
	/** 
	 * 修改角色
	 * Anthor:Qiu
	 * method：updateByRoleId       
	 * @version 1.0.0
	 * time:2019-9-9下午11:21:02  
	 */
	Integer updateByRoleId(SysRoleEntity sysRoleEntity, SysUserEntity user);
	/** 
	 * 批量删除角色信息
	 * Anthor:Qiu
	 * method：batchRemoveRoles       
	 * @version 1.0.0
	 * time:2019-9-12下午10:28:05  
	 */
	Integer batchRemoveRoles(List<SysRoleEntity> roleList);
	/** 
	 * 获取角色列表
	 * Anthor:Qiu
	 * method：getList       
	 * @version 1.0.0
	 * time:2019-9-13下午12:32:38  
	 */
	List<SysRoleEntity> getList();
	/** 
	 * 给角色分配权限
	 * method：doAssignPermission       
	 * @version 1.0.0
	 * time:2019-9-23下午11:21:35  
	 */
	void doAssignPermission(Map<String, Object> map);
    
}
