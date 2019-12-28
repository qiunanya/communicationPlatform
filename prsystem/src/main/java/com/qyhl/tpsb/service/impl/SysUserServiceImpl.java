package com.qyhl.tpsb.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.qyhl.tpsb.commonutils.Constant;
import com.qyhl.tpsb.dto.user.FindUserDTO;
import com.qyhl.tpsb.entity.SysUserEntity;
import com.qyhl.tpsb.mapper.SysUserMapper;
import com.qyhl.tpsb.service.SysUserService;
/**
 * method：SysUserServiceImpl  
 * author：Qiu
 * time：2019-4-4 
 * @version 1.0.0
 */
@Service
@Transactional
public class SysUserServiceImpl extends ServiceImpl<SysUserMapper, SysUserEntity> implements SysUserService {
	
	
	@Autowired
	private SysUserMapper sysUserMapper;


	@Override
	public Integer saveEntity(SysUserEntity entity) {
		Integer state = 5;
		if (StringUtils.isEmpty(entity)) {
			// 用户参数不能为空
			state = 0;
		}else {
			SysUserEntity selectOne = this.selectOne(new EntityWrapper<SysUserEntity>().eq("phone", entity.getPhone()).eq("deleted", Constant.ONE));
			if (!StringUtils.isEmpty(selectOne)) {
				// 手机号已存在
				state = 2;
			}else {
				SysUserEntity user = this.selectOne(new EntityWrapper<SysUserEntity>().eq("username", entity.getUsername()).eq("deleted", Constant.ONE));
				if (!StringUtils.isEmpty(user)) {
					// 用户名已存在
					state = 3;
				}else {
					// 可用用户信息
					try {
						this.insert(entity);
						// 添加成功
						state = 1;
					} catch (Exception e) {
						// 添加失败
						state = 4;
						e.printStackTrace();
					}
				}
			}
		}
		
		return state;
	}

	@Override
	public SysUserEntity loginValidate(String password,String phone) {
		SysUserEntity users=sysUserMapper.loginValidate(password,phone);
		return  users;
	}
	
	@Override
	public SysUserEntity validateUserNameExit(String uphone) {
		
		SysUserEntity users=sysUserMapper.selectByPhone(uphone);
		return users;
	}

	@Override
	public int selectCount(Map<String, Object> map) {
		
		return sysUserMapper.selectUserCount(map);
	}


	/* 
	 * 分页获取系统用户数据
	 */
	@Override
	public List<SysUserEntity> getPage(Map<String, Object> map) {
	    
	    return sysUserMapper.getPage(map);
	}


	@Override
	public Integer removeById(String id,String userId) {
		 Integer state = 0;
		if (!StringUtils.isEmpty(id)) {
			if (id.equals(Constant.ADMIN_ID)) {
				// 不能删除系统管理员
				state = 6;
			}else {
				SysUserEntity userEntity = this.selectOne(new EntityWrapper<SysUserEntity>().eq("userid", id).eq("deleted", Constant.ONE));
				if (!StringUtils.isEmpty(userEntity)) {
					if (userId.equals(userEntity.getUserid())) {
						state = 1;
					}else {
						try {
							userEntity.setDeleted(Constant.ZERO);
							this.updateById(userEntity);
							state = 2;
						} catch (Exception e) {
						   state = 3;
						   e.printStackTrace();
						}
					}
					
				}else {
					// 用户不存在
					state = 4;
				}
			}
			
		}else {
			// id为空
			state = 5;
		}
		
		
		return state;
	}


	/* (non-Javadoc)
	 * 激活用户
	 * 
	 */
	@Override
	public void activeUser(String id) {
		Integer status=0;
		sysUserMapper.activeUser(id,status);
		
	}


	@Override
	public void forbiddenUser(String id) {
		Integer status=1;
		sysUserMapper.forbiddenUser(id,status);
		
	}


	/* 
	 * 找回密码
	 */
	@Override
	public SysUserEntity updatePassWord(String userid) {
		
		return sysUserMapper.updatePassWord(userid);
	}

	@Override
	public void userUpdateNewPassWord(SysUserEntity userEntity) {
		
		sysUserMapper.userUpdateNewPassWord(userEntity);
	}

	@Override
	public void initUserPasswordByAdmin(SysUserEntity userEntity) {
		sysUserMapper.initUserPasswordByAdmin(userEntity);
		
	}

	@Override
	public Page<SysUserEntity> getUsers(FindUserDTO findUserDTO) {
		EntityWrapper<SysUserEntity> wrapper = new EntityWrapper<>();
		wrapper.eq("deleted", Constant.ONE)
		       .orderBy("createtime",false);
		Page<SysUserEntity> selectPage = this.selectPage(new Page<SysUserEntity>(findUserDTO.getPage(),findUserDTO.getLimit()), wrapper);
	
		return selectPage;
	}


	@Override
	public Page<SysUserEntity> getList(FindUserDTO findUserDTO) {
		EntityWrapper<SysUserEntity> wrapper = new EntityWrapper<>();
		if (!StringUtils.isEmpty(findUserDTO.getSearch())) {
			wrapper.like("userid", findUserDTO.getSearch()).or()
			       .like("username", findUserDTO.getSearch()).or()
			       .like("phone", findUserDTO.getSearch()).andNew();
		} 
		
		wrapper.eq("deleted", Constant.ONE)
		       .orderBy("create_time",false);
		try {
			Page<SysUserEntity> selectPage = this.selectPage(new Page<SysUserEntity>(findUserDTO.getPage(),findUserDTO.getLimit()),wrapper);
			return selectPage;
		} catch (Exception e) {
			throw new RuntimeException("查询失败");
		}
		
	}

	@Override
	public Integer updateUserById(SysUserEntity entity) {
		Integer state;
		SysUserEntity user = this.selectOne(new EntityWrapper<SysUserEntity>().eq("userid", entity.getUserid()).eq("deleted", Constant.ONE));
		 if (!StringUtils.isEmpty(user)) {
			entity.setUpdateTime(new Date());
			try {
				this.updateById(entity);
				state = 1;
			} catch (Exception e) {
				state = 0;
				e.printStackTrace();
			}
			
		 }else {
			state = 2;
		}
		return state;
	}

	
	@Override
	public Integer batchRemoveUsers(List<SysUserEntity> entityList) {
	   Integer state;
	   for (SysUserEntity user : entityList) {
		    user.setDeleted(Constant.ZERO);
	     }
	   try {
		   this.updateBatchById(entityList);
		   state = 1;
		} catch (Exception e) {
			state = 0;
			e.printStackTrace();
		}
	    
		return state;
	}

	
	@Override
	public SysUserEntity findUserById(String userid) {
		SysUserEntity selectOne = this.selectOne(new EntityWrapper<SysUserEntity>().eq("userid", userid).eq("deleted", Constant.ONE));
		return selectOne;
	}

	
	@Override
	public Integer doAssignRoleToUser(Map<String, Object> map) {
		Integer state = sysUserMapper.addUserRoles(map);
		return state;
	}


	@Override
	public Integer doCancelRoleToUser(Map<String, Object> map) {
		Integer state = sysUserMapper.doCancelRoleToUser(map);
		return state;
		
	}

	
	@Override
	public List<String> findAssignRolesByUserId(String uid) {
		
		return sysUserMapper.findAssignRolesByUserId(uid);
	}


	
	
}
