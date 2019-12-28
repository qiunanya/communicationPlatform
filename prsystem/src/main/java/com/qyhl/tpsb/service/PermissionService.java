package com.qyhl.tpsb.service;

import java.util.List;

import com.baomidou.mybatisplus.service.IService;
import com.qyhl.tpsb.entity.PermissionEntity;
import com.qyhl.tpsb.entity.SysUserEntity;

public interface PermissionService{

	/** 
	 * 查询所有菜单数据1
	 * method：findAllPermissions       
	 * @version 1.0.0
	 * time:2019-9-14下午4:56:09  
	 */
	List<PermissionEntity> findAllPermissions();

	/** 
	 * 添加菜单
	 * method：add       
	 * @version 1.0.0
	 * time:2019-9-17下午10:28:59  
	 */
	Integer add(PermissionEntity permission, SysUserEntity user);

	/** 
	 * 删除菜单
	 * method：deletePermissionById       
	 * @version 1.0.0
	 * time:2019-9-18下午7:29:08  
	 */
	Integer deletePermissionById(Integer id);

	/** 
	 * 根据Id更新菜单
	 * method：update       
	 * @version 1.0.0
	 * time:2019-9-18下午7:52:32  
	 */
	Integer update(PermissionEntity permission, SysUserEntity user);

	/** 
	 * 查询菜单供给ztree树调用
	 * method：findAllPermissionsByZtree       
	 * @version 1.0.0
	 * time:2019-9-23下午10:13:26  
	 */
	List<PermissionEntity> findAllPermissionsByZtree();

	/** 
	 * 获取当前角色已经分配权限信息
	 * method：queryPermissiondisByRoid       
	 * @version 1.0.0
	 * time:2019-9-24下午10:12:01  
	 */
	List<Integer> queryPermissiondisByRoid(String roleid);

	/** 
	 * 通过用户获取用户的权限信息
	 * method：getAllUserPermissionByUserId       
	 * @version 1.0.0
	 * time:2019-9-25下午10:51:25  
	 */
	List<PermissionEntity> getAllUserPermissionByUserId(SysUserEntity user);
	
	

}
