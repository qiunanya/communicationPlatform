package com.qyhl.tpsb.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.qyhl.tpsb.entity.SysUserEntity;

/**     
 * method：SysUserMapper  
 * author：Qiu
 * time：2019-4-2 
 * @version 1.0.0
 */
@Repository
public interface SysUserMapper extends BaseMapper<SysUserEntity>{
	
	@Select("select tu.userid,tu.create_time as createTime from tb_user as tu")
	List<SysUserEntity> getUsers();

	/** 
	 * Anthor:Qiu
	 * method：loginValidate       
	 * @version 1.0.0
	 * password=#{password} and
	 * time:2019-4-5下午12:46:31  
	 */
	
	@Select("select * from tb_user where phone=#{phone}")
	SysUserEntity loginValidate(@Param("password")String password,@Param("phone")String phone);

	
	@Select("select phone from tb_user where phone=#{uphone}")
	SysUserEntity selectByPhone(String uphone);

	/** 
	 * Anthor:Qiu
	 * method：getPage       
	 * @version 1.0.0
	 * time:2019-4-5下午10:22:20  
	 */
	
	
	List<SysUserEntity> getPage(Map<String, Object> map);

	/** 
	 * Anthor:Qiu
	 * method：updateById       
	 * @version 1.0.0
	 * time:2019-4-5下午11:29:53  
	 */
	
	@Update("delete from tb_user where userid=#{id}")
	void updateUserById(Integer id);

	/** 
	 * Anthor:Qiu
	 * method：activeUser       
	 * @version 1.0.0
	 * time:2019-4-6上午8:38:09  
	 */
	
	@Update("update tb_user set status=#{status} where userid=#{id}")
	void activeUser(@Param("id")String id, @Param("status")Integer status);

	/** 
	 * Anthor:Qiu
	 * method：forbiddenUser       
	 * @version 1.0.0
	 * time:2019-4-6上午8:49:47  
	 */
	
	@Update("update tb_user set status=#{status} where userid=#{id}")
	void forbiddenUser(@Param("id")String id, @Param("status")Integer status);

	/** 
	 * Anthor:Qiu
	 * method：selectUserCount       
	 * @version 1.0.0
	 * time:2019-4-7下午5:31:36  
	 */
	
	
	int selectUserCount(Map<String, Object> map);

	/** 
	 * Anthor:Qiu
	 * method：updatePassWord       
	 * @version 1.0.0
	 * time:2019-4-8上午11:49:48  
	 */
	
	@Select("select * FROM tb_user WHERE userid=#{userid}")
	SysUserEntity updatePassWord(String userid);

	/** 
	 * Anthor:Qiu
	 * method：userUpdateNewPassWord       
	 * @version 1.0.0
	 * time:2019-4-8上午11:58:58  
	 */
	
	@Select("update tb_user set password=#{password} where userid=#{userid}")
	void userUpdateNewPassWord(SysUserEntity userEntity);

	/** 
	 * Anthor:Qiu
	 * method：initUserPasswordByAdmin       
	 * @version 1.0.0
	 * time:2019-4-8下午12:23:30  
	 */
	
	@Select("update tb_user set password=#{password} where userid=#{userid}")
	void initUserPasswordByAdmin(SysUserEntity userEntity);

	/** 
	 * 给用户分配角色
	 * Anthor:Qiu
	 * method：addUserRoles       
	 * @version 1.0.0
	 * time:2019-9-13下午11:36:46  
	 */	
	Integer addUserRoles(Map<String, Object> map);

	/** 
	 * 删除用户角色
	 * Anthor:Qiu
	 * method：doCancelRoleToUser       
	 * @version 1.0.0
	 * time:2019-9-14上午10:05:07  
	 */
	Integer doCancelRoleToUser(Map<String, Object> map);

	/** 
	 * 查询关系表已分配角色
	 * method：findAssignRolesByUserId       
	 * @version 1.0.0
	 * time:2019-9-14上午10:57:59  
	 */
	@Select("select role_id as roleid from tb_user_role where user_id = #{uid}")
	List<String> findAssignRolesByUserId(String uid);
    

}
