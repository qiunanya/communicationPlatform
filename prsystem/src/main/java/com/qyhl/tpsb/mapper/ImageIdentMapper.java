package com.qyhl.tpsb.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.qyhl.tpsb.entity.IdentPicEntity;

public interface ImageIdentMapper extends BaseMapper<IdentPicEntity>{

	/** 
	 * Anthor:Qiu
	 * method：getIdentImgPages       
	 * @version 1.0.0
	 * time:2019-4-6下午10:27:21  
	 */
	
	
	List<IdentPicEntity> getIdentImgPages(Map<String, Object> map);

	/** 
	 * Anthor:Qiu
	 * method：getImageDataPage       
	 * @version 1.0.0
	 * time:2019-4-7上午11:56:58  
	 */
	
	
	List<IdentPicEntity> getImageDataPage(Map<String, Object> map);

	/** 
	 * Anthor:Qiu
	 * method：selectUserImageCount       
	 * @version 1.0.0
	 * time:2019-4-7下午1:05:25  
	 */
	
	
	Integer selectUserImageCount(Map<String, Object> map);

	/** 
	 * Anthor:Qiu
	 * method：selectImageCounts       
	 * @version 1.0.0
	 * time:2019-4-7下午1:08:39  
	 */
	
	@Select("select count(*) from tb_identpic")
	int selectImageCounts();

	/** 
	 * Anthor:Qiu
	 * method：selectImageCounts       
	 * @version 1.0.0
	 * time:2019-4-7下午6:08:44  
	 */
	
	
	int selectImageCounts(Map<String, Object> map);

	/** 
	 * Anthor:Qiu
	 * method：saveImageIdentResult       
	 * @version 1.0.0
	 * time:2019-4-7下午9:59:52  
	 */
	
	
	int saveImageIdentResult(IdentPicEntity ident);

}
