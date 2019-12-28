package com.qyhl.tpsb.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.qyhl.tpsb.commonutils.AjaxResult;
import com.qyhl.tpsb.commonutils.Constant;
import com.qyhl.tpsb.commonutils.IDUtils;
import com.qyhl.tpsb.commonutils.LayuiAPiResult;
import com.qyhl.tpsb.commonutils.MD5Utils;
import com.qyhl.tpsb.commonutils.SendPhoneCode;
import com.qyhl.tpsb.dto.user.FindUserDTO;
import com.qyhl.tpsb.entity.PermissionEntity;
import com.qyhl.tpsb.entity.SysRoleEntity;
import com.qyhl.tpsb.entity.SysUserEntity;
import com.qyhl.tpsb.service.PermissionService;
import com.qyhl.tpsb.service.SysRoleService;
import com.qyhl.tpsb.service.SysUserService;


/**     
 * method：SysUserController  
 * author：Qiu
 * time：2019-4-2 
 * @version 1.0.0
 */
@Controller
@RequestMapping("/sysUser")
@Api(value = "/sysUser", tags = "系统用户接口")
public class SysUserController {
	
	@Autowired
	private SysUserService sysUserService;
	@Autowired
	private SysRoleService sysRoleService;
	@Autowired
	private PermissionService permissionService;
	
	/**
	 * 前端用户登录
	 * Anthor:Qiu
	 * method：webUserLogin       
	 * @version 1.0.0
	 * time:2019-10-23下午7:30:08
	 */
	@PostMapping(value="/webUserLogin")
	@ResponseBody
	@ApiOperation(value = "前端用户登录",httpMethod = "POST", response = SysUserController.class)
	public AjaxResult webUserLogin(@RequestBody SysUserEntity entity,HttpServletRequest request,HttpSession session){
		
		AjaxResult result = new AjaxResult();
		String password = MD5Utils.md5(entity.getPassword());
		//获取服务端验证码，用于比较用户传来的验证码
		String verifyCodeByServer = (String)request.getSession().getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
		
		//判断验证码是否正确
		if (StringUtils.isEmpty(entity.getVerifyCode())) {
			//验证码不能为空
			result.setState(0);
			result.setMsg("验证码不能为空");
		}else {
			if (!entity.getVerifyCode().equals(verifyCodeByServer)) {
				result.setState(2);
				result.setMsg("验证码不正确，请重新输入验证码");
			}else {
				// 验证用户信息是否正确
				SysUserEntity user = sysUserService.loginValidate(password,entity.getPhone());
				if (!StringUtils.isEmpty(user)) {
					if (!user.getStatus().equals(Constant.ZERO)) {
						result.setState(4);
						result.setMsg("账户已被锁定，请联系管理员");
					}else {
						if (!password.equals(user.getPassword())) {
							result.setState(5);
							result.setMsg("密码不正确，请重新输入密码");
						}else {
							if (!entity.getPhone().equals(user.getPhone())) {
								result.setState(6);
								result.setMsg("手机号不正确，请重新输入");
							}else {
								// 登录成功
								session.setAttribute("webLoginUser", user);
								result.setState(1);
								result.setMsg("恭喜您，登录成功");
							}
						}
					}
					
				}else {
					result.setState(3);
					result.setMsg("用户不存在，请重新输入账户信息");
				}
				
			}
		}
		
		return result;
	}
	/**
	 * 前端用户退出
	 * Anthor:Qiu
	 * method：webUserLogout       
	 * @version 1.0.0
	 * time:2019-10-23下午11:06:41
	 */
	@RequestMapping("webUserLogout")
	@ApiOperation(value = "退出",httpMethod = "GET", response = SysUserController.class)
	public ModelAndView webUserLogout(HttpSession session){
		ModelAndView view = new ModelAndView();
		view.setViewName("/home/index");
		session.removeAttribute("webLoginUser");
		System.out.println("退出系统成功");
		return view;
	}
	
	@PostMapping(value="getUsers")
	@ResponseBody
	@ApiOperation(value = "测试分页获取用户数据",httpMethod = "POST", response = SysUserController.class)
	public AjaxResult getUsers(@RequestBody FindUserDTO findUserDTO){
		AjaxResult result=new AjaxResult();
		Page<SysUserEntity> page = sysUserService.getUsers(findUserDTO);
		if (!StringUtils.isEmpty(page.getRecords())) {
		   result.setData(page);	
		}
		System.out.println("测试的用户信息----"+page);
		return result;
	}
	
	/**
	 * 异步校验用户名是否存在
	 * time:2019-4-5下午3:51:17
	 */
	@PostMapping("validateUserNameExit")
	@ResponseBody
	@ApiOperation(value = "校验用户名是否存在",httpMethod = "POST", response = SysUserController.class)
	public Object validateUserNameExit(@Param("uphone")String uphone){
		AjaxResult result=new AjaxResult();
		SysUserEntity entity=sysUserService.validateUserNameExit(uphone);
		try {
			if (entity!=null) {
				result.setSuccess(true);
			}
		} catch (Exception e) {
			   result.setSuccess(false);
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * 给用户分配角色
	 * Anthor:Qiu
	 * method：save       
	 * @version 1.0.0
	 * time:2019-9-13下午11:15:21 
	 */
	@PostMapping("/doAssignRoleToUser")
	@ResponseBody
	@ApiOperation(value = "给用户分配角色",httpMethod = "POST", response = SysUserController.class)
	public Object doAssignRoleToUser(String userid,String[] unAssignRoleIds){
		AjaxResult result=new AjaxResult();
		Map<String, Object> map = new HashMap<>();
		map.put("userid", userid);
		map.put("roleids", unAssignRoleIds);
		Integer state = sysUserService.doAssignRoleToUser(map);
		if (state >=1) {
			result.setMsg("请求成功");
			result.setSuccess(true);
		}else {
			result.setMsg("请求失败");
			result.setSuccess(false);
		}
		return result;
	}
	
	/**
	 * 删除用户角色
	 * Anthor:Qiu
	 * method：doAssignRoleToUser       
	 * @version 1.0.0
	 * time:2019-9-14上午10:02:05
	 */
	@PostMapping("/doCancelRoleToUser")
	@ResponseBody
	@ApiOperation(value = "删除用户角色",httpMethod = "POST", response = SysUserController.class)
	public Object doCancelRoleToUser(String userid,String[] assignRoleIds){
		AjaxResult result=new AjaxResult();
		Map<String, Object> map = new HashMap<>();
		map.put("userid", userid);
		map.put("roleids", assignRoleIds);
		Integer state = sysUserService.doCancelRoleToUser(map);
		if (state >=1) {
			result.setMsg("请求成功");
			result.setSuccess(true);
		}else {
			result.setMsg("请求失败");
			result.setSuccess(false);
		}
		return result;
	}
	

	@PostMapping("register")
	@ResponseBody
	@ApiOperation(value = "用户注册",httpMethod = "POST", response = SysUserController.class)
	public Object save(@RequestBody SysUserEntity entity){
				AjaxResult result=new AjaxResult();
	
				System.out.println("old mima--"+entity.getPassword());
				entity.setUserid(IDUtils.getId());
				entity.setPassword(MD5Utils.md5(entity.getPassword()));
				System.out.println("success mima--"+entity.getPassword());
				entity.setCreateTime(new Date());
				// 未锁定
				entity.setStatus(0);
				// 存在
				entity.setDeleted(Constant.ONE);
				// 注册用户都是普通用户
				entity.setType(Constant.ZERO);
				
				Integer state = sysUserService.saveEntity(entity);
				if (state == 0) {
					result.setMsg("参数不能为空");
					result.setSuccess(false);
				}else if (state == 1) {
					result.setMsg("操作成功");
					result.setSuccess(true);
				}else if (state == 2) {
					result.setMsg("手机号已存在");
					result.setSuccess(false);
				}else if (state == 3) {
					result.setMsg("用户名称已存在，请重新输入");
					result.setSuccess(false);
				}else if (state == 4) {
					result.setMsg("操作失败");
					result.setSuccess(false);
				}
			
		return result;
	}
	
	@PostMapping("addUser")
	@ResponseBody
	@ApiOperation(value = "管理员添加用户",httpMethod = "POST", response = SysUserController.class)
	public Object save(@RequestBody SysUserEntity entity,HttpSession session){
				SysUserEntity user = (SysUserEntity) session.getAttribute("loginUser");
				AjaxResult result=new AjaxResult();
				entity.setUserid(IDUtils.getId());
				entity.setPassword(MD5Utils.md5(entity.getPassword()));
				System.out.println("success mima--"+entity.getPassword());
				entity.setCreateTime(new Date());
				// 未锁定
				entity.setStatus(0);
				// 存在
				entity.setDeleted(Constant.ONE);
				entity.setCreateId(user.getUserid());
				entity.setCreatePerson(user.getUsername());
				
				Integer state = sysUserService.saveEntity(entity);
				if (state == 0) {
					result.setMsg("参数不能为空");
					result.setSuccess(false);
				}else if (state == 1) {
					result.setMsg("操作成功");
					result.setSuccess(true);
				}else if (state == 2) {
					result.setMsg("手机号已存在");
					result.setSuccess(false);
				}else if (state == 3) {
					result.setMsg("用户名称已存在，请重新输入");
					result.setSuccess(false);
				}else if (state == 4) {
					result.setMsg("操作失败");
					result.setSuccess(false);
				}
			
		return result;
	}
	
	/**
	 * 修改用户信息 update  
	 */
	@PostMapping("/update")
	@ResponseBody
	@ApiOperation(value = "修改用户信息",httpMethod = "POST", response = SysUserController.class)
	public Object update(@RequestBody SysUserEntity entity,HttpSession session){
		SysUserEntity user = (SysUserEntity) session.getAttribute("loginUser");
		entity.setUpdateId(user.getUserid());
		entity.setUpdatePerson(user.getUsername());
		AjaxResult result=new AjaxResult();
		  if (StringUtils.isEmpty(entity)) {
			  result.setMsg("参数不能为空");
			  result.setSuccess(false);
		  }
		  Integer state = sysUserService.updateUserById(entity);
		  if (state == 1) {
			  result.setSuccess(true);
			  result.setMsg("操作成功");
		  }else if (state ==0) {
			  result.setSuccess(false);
			  result.setMsg("操作失败");
		  }else if (state == 2) {
			  result.setSuccess(false);
			  result.setMsg("不存在该用户");
		}
		return result;
	}
	
	/**
	 * 批量删除用户
	 * Anthor:Qiu
	 * method：update       
	 * @version 1.0.0
	 * time:2019-9-12下午9:52:03
	 */
	@PostMapping("/batchRemoveUsers")
	@ResponseBody
	@ApiOperation(value = "批量删除用户",httpMethod = "POST", response = SysUserController.class)
	public Object batchRemoveUsers(@RequestBody List<SysUserEntity> entityList,HttpSession session){
	
		AjaxResult result=new AjaxResult();
		  if (StringUtils.isEmpty(entityList)) {
			  result.setMsg("参数不能为空");
			  result.setSuccess(false);
		  }
		  Integer state = sysUserService.batchRemoveUsers(entityList);
		  if (state == 1) {
			  result.setSuccess(true);
			  result.setMsg("操作成功");
		  }else if (state ==0) {
			  result.setSuccess(false);
			  result.setMsg("操作失败");
		  }
		return result;
	}
	
	/**
	 * 校验用户名
	 */
	@RequestMapping("userLogin")
	@ResponseBody
	@ApiOperation(value = "校验用户名是否被锁",httpMethod = "POST", response = SysUserController.class)
	public Object userLoginValidate(SysUserEntity entity, HttpSession session){
		String path = session.getServletContext().getContextPath();
		System.out.println("原始密码："+entity.getPassword());
		AjaxResult result=new AjaxResult();
		String upassword=MD5Utils.md5(entity.getPassword());
		System.out.println("hash值密码："+upassword);
		SysUserEntity user=sysUserService.loginValidate(upassword , entity.getPhone());
		try {
			if (user!=null) {
				if (!user.getStatus().equals(Constant.ZERO)) {
					result.setState(2);
					System.out.println("用户被锁定");
				}else {
					if (!user.getPassword().equals(upassword)) {
						result.setState(1);
						System.out.println("登录失败");
					}else {
						System.out.println("注册时数据库hash值密码："+user.getPassword());
						session.setAttribute("loginUser", user);
						// 通过用户获取用户的权限信息
						List<PermissionEntity> permssions= permissionService.getAllUserPermissionByUserId(user);
						
						Map<Integer, PermissionEntity> permissionMap = new HashMap<Integer, PermissionEntity>();
						// 根节点
						PermissionEntity root = null;
						// set防止路径重复
					    Set<String> uriSet = new HashSet<String>();
						for (PermissionEntity permission : permssions) {
							permissionMap.put(permission.getId(), permission);
							// 用户已授权权限
							if (!StringUtils.isEmpty(permission.getUrl())) {
								uriSet.add(path + permission.getUrl());
							}
						}
						
						// 保存一授权权限
						session.setAttribute("AuthUriSet",uriSet);
						
						for (PermissionEntity item : permssions) {
							PermissionEntity child = item;
							if (child.getPid().equals(Constant.ZERO)) {
								root = item;
							}else {
								PermissionEntity parent = permissionMap.get(child.getPid());
								// 组合关系
								parent.getChildren().add(child);
							}
						}
						
					    // 保存权限
						session.setAttribute("rootPermission", root);
						
						result.setState(0);
						result.setUserType(user.getType());
						System.out.println("登录成功");
					}
				}
			}else {
					result.setState(3);
					System.out.println("该用户不存在，请重新输入");
			}
		} catch (Exception e) {
			e.printStackTrace();
			result.setState(4);
			System.out.println("系统异常==="+e.getMessage());
		}
		return result;
		
	}
	
	@RequestMapping("userLogout")
	@ApiOperation(value = "退出",httpMethod = "GET", response = SysUserController.class)
	public Object userLogot(HttpSession session){
		session.removeAttribute("loginUser");
		System.out.println("退出系统成功");
		return "redirect:login.html";
	}
	
	/**
	 * 登录页面
	 */
	@RequestMapping("/login.html")
	public ModelAndView GoIndex(){
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/login");
		return modelAndView;
	}
	
	/**
	 * 权限不足提示页面
	 */
	@RequestMapping("/error.html")
	public ModelAndView GoError(){
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/error");
		return modelAndView;
	}

	
	/**
	 * 获取用户数据
	 * getUserData
	 */
	@GetMapping("getUserData")
	@ResponseBody
	@ApiOperation(value = "获取所有系统用户数据信息",httpMethod = "GET", response = SysUserController.class)
	public Object getUserData(@RequestParam(value="page",defaultValue="1")Integer page,
			@RequestParam(value="limit",defaultValue="10")Integer limit,
			@RequestParam(value="send_name",defaultValue="")String send_name){
		LayuiAPiResult result=new LayuiAPiResult();
		
		// 查询实体类，用于传递参数
		FindUserDTO findUserDTO = new FindUserDTO();
		// 当前页
		findUserDTO.setPage(page);
		// 每页显示条数
		findUserDTO.setLimit(limit);
		// 搜索参数
		findUserDTO.setSearch(send_name);
		Page<SysUserEntity> pageVo = sysUserService.getList(findUserDTO);
		  
		if (!StringUtils.isEmpty(pageVo.getRecords())) {
	    	result.setCode(0);
			result.setMsg("请求成功");
			result.setCount(Integer.parseInt(String.valueOf(pageVo.getTotal())));
			result.setData(pageVo.getRecords());
			result.setPage(page);
			result.setLimit(limit);
		}else {
			result.setCode(1);
			result.setMsg("请求失败");
		}
		return result;
		
	}
	
	/**
	 * 获取角色列表,并跳转角色分配页面
	 */
	@PostMapping("/getRoleList")
	@ResponseBody
	@ApiOperation(value = "获取角色列表",httpMethod = "POST", response = SysRoleController.class)
	public Object getRoleList(String userid,HttpServletRequest request){
		String uid = request.getParameter("id");
		AjaxResult result=new AjaxResult();
		
		List<SysRoleEntity> role = sysRoleService.getList();
		// 未分配角色
		List<SysRoleEntity> unAssignRole = new ArrayList<>();
		// 已分配角色
		List<SysRoleEntity> assignRole = new ArrayList<>();
		
		//查询关系表已分配角色
		List<String> roleids = sysUserService.findAssignRolesByUserId(uid);
		
		if (!StringUtils.isEmpty(role)) {
			for (SysRoleEntity item : role) {
				if (roleids.contains(item.getId())) {
					assignRole.add(item);
				}else {
					unAssignRole.add(item);
				}
			}
			result.setSuccess(true);
			result.setMsg("请求成功");
		    result.setAssignData(assignRole);
		    result.setUnAssignData(unAssignRole);
		}else {
			result.setSuccess(false);
			result.setMsg("获取角色失败");
		}
		return result;
		
	}
	

	@PostMapping(value="deleteById")
	@ResponseBody
	@ApiOperation(value = "删除用户",httpMethod = "POST", response = SysUserController.class)
	public Object deleteUser(HttpServletRequest request,HttpSession session){
    String id = request.getParameter("id");
		SysUserEntity user = (SysUserEntity) session.getAttribute("loginUser");
		AjaxResult result=new AjaxResult();
		try {
			if (!StringUtils.isEmpty(id)) {
				Integer state = sysUserService.removeById(id,user.getUserid());
				if (state==1) {
					result.setMsg("不能对自己进行删除操作");
					result.setSuccess(false);
				}else if (state==2) {
					result.setMsg("删除成功");
					result.setSuccess(true);
				}else if (state==3) {
					result.setMsg("删除失败");
					result.setSuccess(false);
				}else if (state==4) {
					result.setMsg("不存在ID为"+id+"的用户");
					result.setSuccess(false);
				}else if (state==5) {
					result.setMsg("参数ID不能为空");
			    	result.setSuccess(false);
				}else if (state==6) {
					result.setMsg("不能删除自己的账户");
			    	result.setSuccess(false);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
		}
		return result;
	}
	
	/**
	 * 激活用户
	 * activeUser
	 */
	@PostMapping(value="activeUser")
	@ResponseBody
	@ApiOperation(value = "用户解锁（激活）",httpMethod = "POST", response = SysUserController.class)
	public Object activeUser(HttpServletRequest request){
		String id = request.getParameter("id");
		AjaxResult result=new AjaxResult();
		try {
			sysUserService.activeUser(id);
			result.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
		}
		
		return result;
	}
	
	/**
	 * forbiddenUser
	 * 禁用用户
	 */
	@PostMapping(value="forbiddenUser")
	@ResponseBody
	@ApiOperation(value = "禁用用户（锁定）",httpMethod = "POST", response = SysUserController.class)
	public Object forbiddenUser(HttpServletRequest request){
		String id = request.getParameter("id");
		AjaxResult result=new AjaxResult();
		try {
			sysUserService.forbiddenUser(id);
			result.setSuccess(true);
			System.out.println("激活用户成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
			System.out.println("激活用户失败");
		}
		
		return result;
	}
	
	
	/**
	 * 用户修改密码
	 * userUpdatePassWord
	 */
	@RequestMapping("userUpdatePassWord")
	@ResponseBody
	@ApiOperation(value = "用户修改密码",httpMethod = "POST", response = SysUserController.class)
	public Object userUpdatePassWord(HttpServletRequest request,HttpServletResponse response,HttpSession session){
		AjaxResult result=new AjaxResult();
		// 用户修改密码应该是web登录用户
		SysUserEntity sysUserEntity = (SysUserEntity) session.getAttribute("loginUser");
		
		String oldpassword = request.getParameter("oldpassword");
		
		String opassMd5 = MD5Utils.md5(oldpassword);
		
		String newpassword = request.getParameter("newpassword");
		String newpassMd5 = MD5Utils.md5(newpassword);
		
		System.out.println("新密码==="+oldpassword+"旧密码==="+newpassword);
		
		SysUserEntity user=sysUserService.updatePassWord(sysUserEntity.getUserid());
		
		//验证码
		String verifyCodeExpected = (String)request.getSession().getAttribute(
                com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
		 String verifyCodeActual = request.getParameter("verifyCode");
		if (StringUtils.isEmpty(verifyCodeActual)) {
			result.setState(2);
			System.out.println("验证码不能为空");
		} else if(!verifyCodeActual.equals(verifyCodeExpected)){
			result.setState(3);
			System.out.println("验证码不正确，请重新输入");
			
		}else {
			System.out.println("进行密码验证");
				if (!opassMd5.equals(user.getPassword())) {
				result.setState(0);
				System.out.println("原始密码不正确");
			}else {
				SysUserEntity userEntity=new SysUserEntity();
				userEntity.setUserid(sysUserEntity.getUserid());
				userEntity.setPassword(newpassMd5);
				sysUserService.userUpdateNewPassWord(userEntity);
				result.setState(1);
				System.out.println("修改密码成功");
			}
		}
		
		return result;
		
	}
	
	/**
	 * 管理员初始化用户密码
	 */
	@RequestMapping("initUserPassword")
	@ResponseBody
	@ApiOperation(value = "管理员初始化密码",httpMethod = "POST", response = SysUserController.class)
	public Object initUserPassword(@RequestParam("id")String id){
		String initpass="12345678";
		String userMiMaInitWord = MD5Utils.md5(initpass);
		AjaxResult result=new AjaxResult();
		SysUserEntity userEntity=new SysUserEntity();
		userEntity.setUserid(id);
		userEntity.setPassword(userMiMaInitWord);
		try {
			sysUserService.initUserPasswordByAdmin(userEntity);
			result.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
		}
		return result;
	}
	
	
}
