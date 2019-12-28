package com.qyhl.tpsb.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.qyhl.tpsb.entity.PermissionEntity;
import com.qyhl.tpsb.entity.SysUserEntity;

@Repository
public interface PermissionMapper{

	/** 
	 * Anthor:Qiu
	 * method：findAllPermissions       
	 * @version 1.0.0
	 * time:2019-9-20下午11:20:37  
	 */
	
	@Select("select * from tb_permission where status = 1")
	List<PermissionEntity> findAllPermissions();
	
	/** 
	 * 供给ztree调用
	 * method：findAllPermissionsByZtree       
	 * @version 1.0.0
	 * time:2019-9-23下午10:15:05  
	 */
	@Select("select *,title as name from tb_permission where status = 1")
	List<PermissionEntity> findAllPermissionsByZtree();

	/** 
	 * Anthor:Qiu
	 * method：findPermissionById       
	 * @version 1.0.0
	 * time:2019-9-20下午11:30:27  
	 */
	
	@Select("select * from tb_permission where id =#{id} and status = 1")
	PermissionEntity findPermissionById(Integer id);

	/** 
	 * Anthor:Qiu
	 * method：removeById       
	 * @version 1.0.0
	 * time:2019-9-20下午11:33:39  
	 */
	
	@Update("update tb_permission set status = 0 where id =#{id} ")
	Integer removeById(Integer id);

	/** 
	 * 根据pid查找父级
	 * Anthor:Qiu
	 * method：findParentByPid       
	 * @version 1.0.0
	 * time:2019-9-20下午11:44:40  
	 */
	@Select("select * from tb_permission where id = #{pid} and status = 1")
	PermissionEntity findParentByPid(Integer pid);

	/** 
	 * Anthor:Qiu
	 * method：findUrl       
	 * @version 1.0.0
	 * time:2019-9-20下午11:50:54  
	 */
	@Select("select * from tb_permission where url = #{url} and status = 1")
	PermissionEntity findUrl(String url);

	/** 
	 * Anthor:Qiu
	 * method：findName       
	 * @version 1.0.0
	 * time:2019-9-20下午11:53:45  
	 */
	@Select("select * from tb_permission where title = #{title} and status = 1")
	PermissionEntity findName(String title);

	/** 
	 * 添加菜单
	 * method：addPermission       
	 * @version 1.0.0
	 * time:2019-9-20下午11:58:21  
	 */
	void addPermission(PermissionEntity permission);

	/** 
	 * 批量删除
	 * method：removeList       
	 * @version 1.0.0
	 * time:2019-9-21上午8:04:33  
	 */
	@Update("update tb_permission set status =0 where pid = #{pid}")
	void removeList(Integer pid);

	/** 
	 * 根据父级查找所有子集
	 * method：findAllChildrenByPid       
	 * @version 1.0.0
	 * time:2019-9-21上午8:10:23  
	 */
	@Select("select * from tb_permission where pid = #{id} and status = 1")
	List<PermissionEntity> findAllChildrenByPid(Integer id);

	/** 
	 * 更新菜单
	 * method：update       
	 * @version 1.0.0
	 * time:2019-9-23下午10:21:55  
	 */
	void updatePermission(PermissionEntity permission);

	/** 
	 *获取当前角色已经分配权限信息
	 * method：queryPermissiondisByRoid       
	 * @version 1.0.0
	 * time:2019-9-24下午10:14:52  
	 */
	@Select("select permission_id from tb_role_permission where role_id = #{roleid}")
	List<Integer> queryPermissiondisByRoid(String roleid);

	/** 
	 * 通过用户获取用户的权限信息
	 * method：getAllUserPermissionByUserId       
	 * @version 1.0.0
	 * time:2019-9-25下午10:52:54  
	 */
	List<PermissionEntity> getAllUserPermissionByUserId(SysUserEntity user);
    
	

}
