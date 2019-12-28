/**
 * 
 */
package com.qyhl.tpsb.mapper;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.qyhl.tpsb.entity.SysAdminEntity;

/**     
 * method：SysAdminMapper  
 * author：Qiu
 * time：2019-4-5 
 * @version 1.0.0
 */

public interface SysAdminMapper extends BaseMapper<SysAdminEntity>{

	/** 
	 * Anthor:Qiu
	 * method：login       
	 * @version 1.0.0
	 * time:2019-4-5下午8:53:38  
	 */
	
	@Select("select * from tb_admin where phone=#{phone} and password=#{apassword}")
	SysAdminEntity login(@Param("phone")String phone, @Param("apassword")String apassword);

}
