package com.qyhl.tpsb.entity;

import java.io.Serializable;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

/**
 * 角色实体
 * method：SysRoleEntity  
 * author：Qiu
 * time：2019-9-1 
 * @version 1.0.0
 */
@TableName("tb_role")
public class SysRoleEntity extends BaseInfo implements Serializable{
	
	private static final long serialVersionUID = 1L;
	/**
	 * 角色ID
	 * */
	@TableId
	private String id;
	/**
	 * 角色名称
	 * */
	private String name;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	@Override
	public String toString() {
		return "SysRoleEntity [id=" + id + ", name=" + name + "]";
	}
	
	
	

}
