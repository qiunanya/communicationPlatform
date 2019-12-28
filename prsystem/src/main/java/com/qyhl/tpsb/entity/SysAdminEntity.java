package com.qyhl.tpsb.entity;

import java.io.Serializable;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

/**     
 * method：SysAdminEntity  
 * author：Qiu
 * time：2019-4-5 
 * @version 1.0.0
 */
@TableName("tb_admin")
public class SysAdminEntity extends BaseInfo implements Serializable{
	
	private static final long serialVersionUID = 1L;
	@TableId
	private Long id;
	private String name;
	private String phone;
	private String password;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	

}
