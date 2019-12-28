package com.qyhl.tpsb.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.fasterxml.jackson.annotation.JsonFormat.Value;
import com.qyhl.tpsb.commonutils.Constant;
import com.qyhl.tpsb.commonutils.IDUtils;
import com.qyhl.tpsb.dto.role.FindRoleDTO;
import com.qyhl.tpsb.entity.SysRoleEntity;
import com.qyhl.tpsb.entity.SysUserEntity;
import com.qyhl.tpsb.mapper.SysRoleMapper;
import com.qyhl.tpsb.service.RolePermissionService;
import com.qyhl.tpsb.service.SysRoleService;

@Service
public class SysRoleServiceImpl extends ServiceImpl<SysRoleMapper, SysRoleEntity> implements SysRoleService {
	
	@Autowired
	private SysRoleMapper sysRoleMapper;
	
	@Autowired
	private RolePermissionService rolePermissionService;

	
	@Override
	public void add(SysRoleEntity sysRoleEntity,SysUserEntity user) {
		     if (!StringUtils.isEmpty(user)) {
				  sysRoleEntity.setCreateId(user.getUserid());
				  sysRoleEntity.setCreatePerson(user.getUsername());
			   }else{
				  sysRoleEntity.setCreateId(String.valueOf(Constant.ZERO));
				  sysRoleEntity.setCreatePerson("admin");
			   }
			try {
				sysRoleEntity.setCreateTime(new Date());
				sysRoleEntity.setStatus(Constant.ONE);
				sysRoleEntity.setId(IDUtils.getId());
				this.insert(sysRoleEntity);
				
			} catch (Exception e) {
				new RuntimeException("添加失败"+e);
			}
	}


	@Override
	public Page<SysRoleEntity> getData(FindRoleDTO findRoleDTO) {
		EntityWrapper<SysRoleEntity> wrapper = new EntityWrapper<>();
		if (!StringUtils.isEmpty(findRoleDTO.getSearch())) {
			wrapper.like("id", findRoleDTO.getSearch()).or()
			       .like("name", findRoleDTO.getSearch()).andNew();
		}
		wrapper.eq("status", Constant.ONE)
		       .orderBy("create_time", false);
		Page<SysRoleEntity> page ;
		try {
			 page = this.selectPage(new Page<SysRoleEntity>(findRoleDTO.getPage(),findRoleDTO.getLimit()),wrapper);
		} catch (Exception e) {
			throw new RuntimeException("查询失败");
		}
		
		return page;
	}

   
	@Override
	public Integer removeById(String id, SysUserEntity user) {
		 Integer state = 0;
				if (!StringUtils.isEmpty(id)) {
					if (id.equals(Constant.ADMIN_ROLE_ID)) {
						state = 5;
					}else{
					
					SysRoleEntity role = this.selectOne(new EntityWrapper<SysRoleEntity>().eq("id", id).eq("status", Constant.ONE));
					if (!StringUtils.isEmpty(role)) {
						role.setUpdateId(user.getUserid());
						role.setUpdatePerson(user.getUsername());
						role.setUpdateTime(new Date());
						role.setStatus(Constant.ZERO);
						try {
							this.updateById(role);
							state =1;
						} catch (Exception e) {
							state = 3;
							e.printStackTrace();
						}
					}else {
						state = 2;
					}
					}
					
				}else {
					state = 4;
				}
		return state;
	}

	@Override
	public Integer updateByRoleId(SysRoleEntity sysRoleEntity, SysUserEntity user) {
		Integer state = 0;
		SysRoleEntity role = this.selectOne(new EntityWrapper<SysRoleEntity>().eq("id", sysRoleEntity.getId()).eq("status", Constant.ONE));
		if (!StringUtils.isEmpty(role)) {
		    try {
		    	role.setUpdateId(user.getUserid());
		    	role.setUpdatePerson(user.getUsername());
		    	role.setUpdateTime(new Date());
		    	role.setName(sysRoleEntity.getName());
		    	// BeanUtils.copyProperties(sysRoleEntity, role);
		    	this.updateById(role);
		    	state = 1;
			} catch (Exception e) {
				state = 3;
				throw new RuntimeException("更新失败"+e);
			}
		}else {
			state = 2;
		}
		return state;
		
	}


	@Override
	public Integer batchRemoveRoles(List<SysRoleEntity> roleList) {
		Integer state;
		for (SysRoleEntity role : roleList) {
			role.setStatus(Constant.ZERO);
		}
		try {
			this.updateBatchById(roleList);
			state = 1;
		} catch (Exception e) {
			state = 0;
			e.printStackTrace();
		}
		return state;
	}

	@Override
	public List<SysRoleEntity> getList() {
		List<SysRoleEntity> selectList = this.selectList(new EntityWrapper<SysRoleEntity>().eq("status", Constant.ONE));
		return selectList;
	}

	@Override
	public void doAssignPermission(Map<String, Object> map) {
		
		rolePermissionService.doAssignPermission(map);
		
		
	}

}
