package com.qyhl.tpsb.entity;

import java.io.Serializable;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

/**
 * 角色权限
 * method：SysRoleEntity  
 * author：Qiu
 * time：2019-9-1 
 * @version 1.0.0
 */
@TableName("tb_role_permission")
public class RolePermissionEntity implements Serializable{
	
	private static final long serialVersionUID = 1L;
	/**
	 * 角色ID
	 * */
	@TableId
	private Integer id;
	
	private String roleId;
	private Integer permissionId;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getRoleId() {
		return roleId;
	}
	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}
	public Integer getPermissionId() {
		return permissionId;
	}
	public void setPermissionId(Integer permissionId) {
		this.permissionId = permissionId;
	}
	
}
