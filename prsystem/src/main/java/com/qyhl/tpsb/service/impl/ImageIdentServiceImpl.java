package com.qyhl.tpsb.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qyhl.tpsb.entity.IdentPicEntity;
import com.qyhl.tpsb.mapper.ImageIdentMapper;
import com.qyhl.tpsb.service.ImageIdentService;

@Service
public class ImageIdentServiceImpl implements ImageIdentService {
	@Autowired
	private ImageIdentMapper imageIdentMapper;

	/* (non-Javadoc)
	 * @see com.qyhl.tpsb.service.ImageIdentService#saveIdentEntity(com.qyhl.tpsb.entity.IdentPicEntity)
	 */
	@Override
	public Integer saveIdentEntity(IdentPicEntity ident) {
		Integer insert = imageIdentMapper.insert(ident);
		return insert;
	}

	/* (non-Javadoc)
	 * @see com.qyhl.tpsb.service.ImageIdentService#getTotalCount()
	 */
	@Override
	public int userGetTotalCount(Map<String, Object> map) {
		Integer count = imageIdentMapper.selectUserImageCount(map);
		return count;
	}

	/* 分页获取用户识别图片信息
	 * @see com.qyhl.tpsb.service.ImageIdentService#getPages(java.util.Map)
	 */
	@Override
	public List<IdentPicEntity> getPages(Map<String, Object> map) {
		List<IdentPicEntity> identPic=imageIdentMapper.getIdentImgPages(map);
		return identPic;
	}

	
	@Override
	public int deleteById(Long id) {
		return imageIdentMapper.deleteById(id);
		
	}

	@Override
	public List<IdentPicEntity> getImageDataPage(Map<String, Object> map) {
		List<IdentPicEntity> identPic=imageIdentMapper.getImageDataPage(map);
		return identPic;
		
	}

	
	@Override
	public int adminGetCount(Map<String, Object> map) {
		int i=imageIdentMapper.selectImageCounts(map);
		return i;
	}

	/* (non-Javadoc)
	 * @see com.qyhl.tpsb.service.ImageIdentService#saveImageIdentResult(com.qyhl.tpsb.entity.IdentPicEntity)
	 */
	@Override
	public int saveImageIdentResult(IdentPicEntity ident) {
		int i=imageIdentMapper.saveImageIdentResult(ident);
		return i;
	}

}
