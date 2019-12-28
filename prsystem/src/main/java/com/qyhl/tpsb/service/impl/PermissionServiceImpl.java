package com.qyhl.tpsb.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.qyhl.tpsb.commonutils.Constant;
import com.qyhl.tpsb.commonutils.IDUtils;
import com.qyhl.tpsb.entity.PermissionEntity;
import com.qyhl.tpsb.entity.SysUserEntity;
import com.qyhl.tpsb.mapper.PermissionMapper;
import com.qyhl.tpsb.service.PermissionService;
@Service
@Transactional
public class PermissionServiceImpl implements PermissionService {

	@Autowired
	private PermissionMapper permissionMapper;

	@Override
	public List<PermissionEntity> findAllPermissions() {
		return permissionMapper.findAllPermissions();
	}
   
	@Override
	public List<PermissionEntity> findAllPermissionsByZtree() {
		
		return permissionMapper.findAllPermissionsByZtree();
	}
	
	@Override
	public Integer add(PermissionEntity permission, SysUserEntity user) {
		Integer state;
		if (StringUtils.isEmpty(permission)) {
			// 参数不能为空
			state = 5;
		}else {
			PermissionEntity permissionEntity= permissionMapper.findParentByPid(permission.getPid());
			if (StringUtils.isEmpty(permissionEntity)) {
				state = 0;
			}else {
				PermissionEntity entity = permissionMapper.findUrl(permission.getUrl());
				if (!StringUtils.isEmpty(entity)) {
					state = 2;
				}else {
					PermissionEntity entity2 = permissionMapper.findName(permission.getTitle());
					if (!StringUtils.isEmpty(entity2)) {
						state = 3;
					}else {
						permission.setCreate_id(user.getUserid());
						permission.setCreate_person(user.getUsername());
						permission.setCreate_time(new Date());
						permission.setStatus(Constant.ONE);
						try {
							permissionMapper.addPermission(permission);
							state = 1;
						} catch (Exception e) {
							state = 4;
							e.printStackTrace();
						}
					}
				}
			}
		}
	    
		return state;
	}

     
	@Override
	public Integer deletePermissionById(Integer id) {
		Integer state ;
		if (StringUtils.isEmpty(id)) {
			// id不能为空
			state = 3;
		}else {
			PermissionEntity permissionById = permissionMapper.findPermissionById(id);
			if (StringUtils.isEmpty(permissionById)) {
				state = 2;
			}else {
				if (permissionById.getPid().equals(Constant.ROOT)) {
					// 不能删除系统菜单，既是根目录
					state = 4;
				}else {
					//  查看是否有子集
					 List<PermissionEntity> pid = permissionMapper.findAllChildrenByPid(permissionById.getId());
					 if (!StringUtils.isEmpty(pid) && pid.size() > 0) {
						 try {
							 permissionMapper.removeList(pid.get(Constant.ZERO).getPid());
							 permissionMapper.removeById(id);
							 state = 1;
						} catch (Exception e) {
							 state = 0;
						     e.printStackTrace();
						}
						
					 }else {
						 try {
								Integer i = permissionMapper.removeById(id);
								state = 1;
							} catch (Exception e) {
								state = 0;
								e.printStackTrace();
							}
					}
					
				}
			}
		}
		return state;
	}

	@Override
	public Integer update(PermissionEntity permission, SysUserEntity user) {
		Integer state = 0;
		if (StringUtils.isEmpty(permission)) {
			state = 2;
		}else {
			
		PermissionEntity entity = permissionMapper.findPermissionById(permission.getId());
		if (StringUtils.isEmpty(entity)) {
			// 不存在
			state = 5;
		}else {
			
				PermissionEntity findName = permissionMapper.findName(permission.getTitle());
				if (!StringUtils.isEmpty(findName)) {
					state = 4;
				}else {
					// 更新
					permission.setUpdateId(user.getUserid());
					permission.setUpdatePerson(user.getUsername());
					permission.setUpdateTime(new Date());
					try {
						permissionMapper.updatePermission(permission);
						state = 1;
					} catch (Exception e) {
						state = 0;
						e.printStackTrace();
					}
					
				}
		}
	}
		return state;
	}

	
	@Override
	public List<Integer> queryPermissiondisByRoid(String roleid) {
		List<Integer> permissionIds = permissionMapper.queryPermissiondisByRoid(roleid);
		return permissionIds;
	}

	/* 
	 * 通过用户获取用户的权限信息
	 */
	@Override
	public List<PermissionEntity> getAllUserPermissionByUserId(SysUserEntity user) {
		
		
		return permissionMapper.getAllUserPermissionByUserId(user);
	}

	

}
