package com.qyhl.tpsb.service;

import com.qyhl.tpsb.entity.SysAdminEntity;

/**     
 * method：SysAdminService  
 * author：Qiu
 * time：2019-4-5 
 * @version 1.0.0
 */

public interface SysAdminService {

	/** 
	 * Anthor:Qiu
	 * method：login       
	 * @version 1.0.0
	 * time:2019-4-5下午8:52:46  
	 */
	
	
	SysAdminEntity login(String phone, String apassword);

}
