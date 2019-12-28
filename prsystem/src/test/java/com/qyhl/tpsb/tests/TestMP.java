package com.qyhl.tpsb.tests;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import javax.sql.DataSource;

import lombok.val;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.baomidou.mybatisplus.plugins.Page;
import com.qyhl.tpsb.commonutils.Constant;
import com.qyhl.tpsb.commonutils.IDUtils;
import com.qyhl.tpsb.commonutils.MD5Utils;
import com.qyhl.tpsb.dto.user.FindUserDTO;
import com.qyhl.tpsb.entity.PermissionEntity;
import com.qyhl.tpsb.entity.SysAdminEntity;
import com.qyhl.tpsb.entity.SysRoleEntity;
import com.qyhl.tpsb.entity.SysUserEntity;
import com.qyhl.tpsb.mapper.PermissionMapper;
import com.qyhl.tpsb.mapper.SysAdminMapper;
import com.qyhl.tpsb.mapper.SysRoleMapper;
import com.qyhl.tpsb.mapper.SysUserMapper;
import com.qyhl.tpsb.service.SysRoleService;
import com.qyhl.tpsb.service.SysUserService;
import com.qyhl.tpsb.service.impl.SysRoleServiceImpl;
public class TestMP {
	private static Logger logger = LoggerFactory.getLogger(TestMP.class);
	private ApplicationContext ioc=new ClassPathXmlApplicationContext("applicationContext.xml");

	private SysUserMapper sysUserMapper=ioc.getBean("sysUserMapper",SysUserMapper.class);
	
	private SysAdminMapper sysAdminMapper=ioc.getBean("sysAdminMapper",SysAdminMapper.class);
	
	private PermissionMapper permissionMapper=ioc.getBean("PermissionMapper",PermissionMapper.class);
	
	@Autowired
	private SysRoleMapper sysRoleMapper;

	@Autowired
	private SysUserService sysUserService;
	
	@Autowired
	private SysRoleService sysRoleService;
	
	/***
	 * 分页获取用户信息
	 */
	@Test
	public void getUsers(){
		FindUserDTO findUserDTO = new FindUserDTO();
		findUserDTO.setPage(1);
		findUserDTO.setLimit(12);
		Page<SysUserEntity> page = sysUserService.getUsers(findUserDTO);
		System.out.println("分页用户信息是"+page);
	}
	
	@Test
	public void test() throws SQLException{
		DataSource ds=ioc.getBean("dataSource",DataSource.class);
		System.out.println("获取数据源："+ds);
		
		Connection connection = ds.getConnection();
		System.out.println("获取的连接"+connection);
		
	}
	
	@Test
	public void addPermission(){
		
	}
	
	@Test
	public void insertUser(){
		SysUserEntity sysUserEntity = new SysUserEntity();
		sysUserEntity.setUserid(IDUtils.getId());
		sysUserEntity.setUsername("测试9");
		sysUserEntity.setPassword(MD5Utils.md5("12345678"));
		sysUserEntity.setCreateTime(new Date());
		sysUserEntity.setPhone("18786014643");
		sysUserEntity.setStatus(0);
		sysUserEntity.setDeleted(Constant.ONE);
		Integer insert = sysUserMapper.insert(sysUserEntity);
		System.out.println("插入数据成功————"+insert);
	}
	
	// 测试添加角色
	@Test
	public void addRole(){
		SysRoleEntity entity = new SysRoleEntity();
		entity.setCreateId("1160090992418795522");
		entity.setCreatePerson("测试人员");
		entity.setCreateTime(new Date());
		String id = IDUtils.getId();
		//entity.setId(id);
		entity.setName("管理员");
		entity.setStatus(Constant.ONE);
		System.out.println("实体信息=="+entity+id);
		  //sysRoleService.add(entity);
			logger.warn("添加成功");
		
	   
	}
	
	// 添加管理员
	@Test
	public void addAdmin(){
		SysAdminEntity sysAdminEntity=new SysAdminEntity();
		sysAdminEntity.setName("nanzhou");
		sysAdminEntity.setPhone("13158050103");
		sysAdminEntity.setPassword(MD5Utils.md5("12345678"));
		sysAdminEntity.setCreateTime(new Date());
		
		sysAdminMapper.insert(sysAdminEntity);
	}
	
	@Test
	public void getUser(){
		
		List<SysUserEntity> insert = sysUserMapper.selectList(null);
		System.out.println("查询数据成功————"+insert);
	}
	
	// 自定义查询
   @Test
   public void getAllUser(){
	   List<SysUserEntity> users = sysUserMapper.getUsers();
	   System.out.println("自定义查询结果：--"+users);
   }
   
   
	
}
