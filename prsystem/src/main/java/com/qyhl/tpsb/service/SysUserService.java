package com.qyhl.tpsb.service;

import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.IService;
import com.qyhl.tpsb.commonutils.AjaxResult;
import com.qyhl.tpsb.dto.user.FindUserDTO;
import com.qyhl.tpsb.entity.SysRoleEntity;
import com.qyhl.tpsb.entity.SysUserEntity;

/**     
 * method：SysUserService  
 * author：Qiu
 * time：2019-4-4 
 * @version 1.0.0
 */

public interface SysUserService extends IService<SysUserEntity>{
	
	public Integer saveEntity(SysUserEntity entity);

	/** 
	 * Anthor:Qiu
	 * method：loginValidate       
	 * @version 1.0.0
	 * time:2019-4-5下午12:45:08  
	 */
	
	
	public SysUserEntity loginValidate(String password,String phone);

	/** 
	 * Anthor:Qiu
	 * method：validateUserNameExit       
	 * @version 1.0.0
	 * time:2019-4-5下午3:56:37  
	 */
	
	
	public SysUserEntity validateUserNameExit(String uphone);

	/** 
	 * Anthor:Qiu
	 * method：selectCount       
	 * @version 1.0.0
	 * time:2019-4-5下午10:16:00  
	 */
	
	
	public int selectCount(Map<String, Object> map);

	/** 
	 * Anthor:Qiu
	 * method：getPage       
	 * @version 1.0.0
	 * time:2019-4-5下午10:20:48  
	 */
	
	
	public List<SysUserEntity> getPage(Map<String, Object> map);

	/** 
	 * Anthor:Qiu
	 * method：deleteById       
	 * @version 1.0.0
	 * time:2019-4-5下午11:28:23  
	 */
	
	
	public Integer removeById(String id,String userId);

	/** 
	 * Anthor:Qiu
	 * method：activeUser       
	 * @version 1.0.0
	 * time:2019-4-6上午8:36:35  
	 */
	
	
	public void activeUser(String id);

	/** 
	 * Anthor:Qiu
	 * method：forbiddenUser       
	 * @version 1.0.0
	 * time:2019-4-6上午8:48:58  
	 */
	
	
	public void forbiddenUser(String id);

	/** 
	 * Anthor:Qiu
	 * method：updatePassWord       
	 * @version 1.0.0
	 * time:2019-4-8上午11:48:50  
	 */
	
	
	public SysUserEntity updatePassWord(String userid);

	/** 
	 * Anthor:Qiu
	 * method：userUpdateNewPassWord       
	 * @version 1.0.0
	 * time:2019-4-8上午11:57:57  
	 */
	
	
	public void userUpdateNewPassWord(SysUserEntity userEntity);

	/** 
	 * Anthor:Qiu
	 * method：initUserPasswordByAdmin       
	 * @version 1.0.0
	 * time:2019-4-8下午12:22:57  
	 */
	
	
	public void initUserPasswordByAdmin(SysUserEntity userEntity);
	
	/**
	 * 测试分页获取所有用户数据
	 * */
	public Page<SysUserEntity> getUsers(FindUserDTO findUserDTO);

	/** 
	 * 分页获取用户信息
	 * Anthor:Qiu
	 * method：getList       
	 * @version 1.0.0
	 * time:2019-9-6下午9:51:35  
	 */
	
	public Page<SysUserEntity> getList(FindUserDTO findUserDTO);

	/** 
	 * 修改用户信息
	 * Anthor:Qiu
	 * method：updateUserById       
	 * @version 1.0.0
	 * time:2019-9-11下午7:36:40  
	 */
	public Integer updateUserById(SysUserEntity entity);

	/** 
	 * 批量删除用户
	 * Anthor:Qiu
	 * method：batchRemoveUsers       
	 * @version 1.0.0
	 * time:2019-9-12下午9:55:02  
	 */
	public Integer batchRemoveUsers(List<SysUserEntity> entityList);

	/** 
	 * 根据ID获取用户信息
	 * Anthor:Qiu
	 * method：findUserById       
	 * @version 1.0.0
	 * time:2019-9-13下午1:01:27  
	 */	
	public SysUserEntity findUserById(String userid);

	/** 
	 * 给用户分配角色
	 * Anthor:Qiu
	 * method：doAssignRoleToUser       
	 * @version 1.0.0
	 * time:2019-9-13下午11:34:42  
	 */
	public Integer doAssignRoleToUser(Map<String, Object> map);

	/** 
	 * 删除用户角色
	 * Anthor:Qiu
	 * method：doCancelRoleToUser       
	 * @version 1.0.0
	 * time:2019-9-14上午10:03:52  
	 */
	public Integer doCancelRoleToUser(Map<String, Object> map);

	/** 
	 * 查询关系表已分配角色
	 * method：findAssignRolesByUserId       
	 * @version 1.0.0
	 * time:2019-9-14上午10:55:34  
	 */	
	public List<String> findAssignRolesByUserId(String uid);

	


}
