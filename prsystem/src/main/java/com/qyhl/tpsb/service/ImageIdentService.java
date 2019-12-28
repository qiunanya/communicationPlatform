package com.qyhl.tpsb.service;

import java.util.List;
import java.util.Map;

import com.qyhl.tpsb.entity.IdentPicEntity;

/**     
 * method：ImageIdentService  
 * author：Qiu
 * time：2019-4-6 
 * @version 1.0.0
 */

public interface ImageIdentService {

	/** 
	 * Anthor:Qiu
	 * method：saveIdentEntity       
	 * @version 1.0.0
	 * time:2019-4-6下午5:12:54  
	 */
	
	
	Integer saveIdentEntity(IdentPicEntity ident);

	/** 
	 * Anthor:Qiu
	 * method：getTotalCount       
	 * @version 1.0.0
	 * time:2019-4-6下午10:20:13  
	 */
	
	
	int userGetTotalCount(Map<String, Object> map);

	/** 
	 * Anthor:Qiu
	 * method：getPages       
	 * @version 1.0.0
	 * time:2019-4-6下午10:24:59  
	 */
	
	
	List<IdentPicEntity> getPages(Map<String, Object> map);

	/** 
	 * Anthor:Qiu
	 * method：deleteById       
	 * @version 1.0.0
	 * time:2019-4-6下午11:04:01  
	 * @return 
	 */
	
	
	int deleteById(Long id);

	/** 
	 * Anthor:Qiu
	 * method：getImageDataPage       
	 * @version 1.0.0
	 * time:2019-4-7上午11:56:15  
	 */
	
	
	List<IdentPicEntity> getImageDataPage(Map<String, Object> map);

	/** 
	 * Anthor:Qiu
	 * method：getTotalCount       
	 * @version 1.0.0
	 * time:2019-4-7下午1:07:34  
	 */
	
	
	int adminGetCount(Map<String, Object> map);

	/** 
	 * Anthor:Qiu
	 * method：saveImageIdentResult       
	 * @version 1.0.0
	 * time:2019-4-7下午9:58:56  
	 */
	
	
	int saveImageIdentResult(IdentPicEntity ident);

	
	

	
}
