package com.qyhl.tpsb.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
/**
 * 角色控制类
 * method：SysRoleController  
 * author：Qiu
 * time：2019-9-3 
 * @version 1.0.0
 */
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.baomidou.mybatisplus.plugins.Page;
import com.qyhl.tpsb.commonutils.AjaxResult;
import com.qyhl.tpsb.commonutils.LayuiAPiResult;
import com.qyhl.tpsb.dto.role.FindRoleDTO;
import com.qyhl.tpsb.entity.SysRoleEntity;
import com.qyhl.tpsb.entity.SysUserEntity;
import com.qyhl.tpsb.service.SysRoleService;

@Controller
@RequestMapping(value="/role")
@Api(tags = "系统角色接口")
public class SysRoleController {
	@Autowired
	private SysRoleService sysRoleService;
	
	
	@RequestMapping("/goPermissionPage")
	public ModelAndView goPermissionPage(String roleid){
		ModelAndView model = new ModelAndView();
		model.addObject("roleid", roleid);
		model.setViewName("/sysuser/role/assign");
		return model;
	}
	
	@PostMapping(value="/doAssignPermission")
	@ResponseBody
	@ApiOperation(value = "给角色分配权限",httpMethod = "POST",response=SysRoleController.class)
	public AjaxResult doAssignPermission(String roleid,Integer [] permissionids){
		
		 AjaxResult result = new AjaxResult();
		 Map<String, Object> map = new HashMap<>();
		 map.put("roleid", roleid);
		 map.put("permissionids", permissionids);
		 try {
			 sysRoleService.doAssignPermission(map);
			 result.setSuccess(true);
		} catch (Exception e) {
			 result.setSuccess(false);
			e.printStackTrace();
		}
	
		return result;
	}
	
	
	@PostMapping(value="/add")
	@ResponseBody
	@ApiOperation(value = "添加角色",httpMethod = "POST",response=SysRoleController.class)
	public AjaxResult add(@RequestBody SysRoleEntity sysRoleEntity,HttpSession session){
		SysUserEntity user = (SysUserEntity) session.getAttribute("loginUser");
		 AjaxResult result = new AjaxResult();
		 result.setData(sysRoleEntity);
		 sysRoleService.add(sysRoleEntity,user);
		 result.setSuccess(true);
		return result;
	}
	
	@PostMapping(value="/update")
	@ResponseBody
	@ApiOperation(value = "修改角色",httpMethod = "POST",response=SysRoleController.class)
	public AjaxResult updateByRoleId(@RequestBody SysRoleEntity sysRoleEntity,HttpSession session){
		SysUserEntity user = (SysUserEntity) session.getAttribute("loginUser");
		 AjaxResult result = new AjaxResult();
		 result.setData(sysRoleEntity);
		 Integer state = sysRoleService.updateByRoleId(sysRoleEntity,user);
		 if (state ==1) {
			 result.setSuccess(true);
			 result.setState(1);
			 result.setMsg("更新成功");
		}else if (state == 2) {
			result.setSuccess(false);
			 result.setState(2);
			result.setMsg("不存在ID为"+sysRoleEntity.getId()+"角色信息");
		}else if (state==3) {
			 result.setState(3);
			result.setSuccess(false);
			 result.setMsg("更新失败");
		}
		
		return result;
	}
	
	/**
	 * 批量删除角色
	 * Anthor:Qiu
	 * method：batchRemoveUsers       
	 * @version 1.0.0
	 * time:2019-9-12下午10:25:42
	 */
	@PostMapping("/batchRemoveRoles")
	@ResponseBody
	@ApiOperation(value = "批量删除角色",httpMethod = "POST", response = SysRoleController.class)
	public Object batchRemoveRoles(@RequestBody List<SysRoleEntity> roleList,HttpSession session){
	
		AjaxResult result=new AjaxResult();
		  if (StringUtils.isEmpty(roleList)) {
			  result.setMsg("参数不能为空");
			  result.setSuccess(false);
		  }
		  Integer state = sysRoleService.batchRemoveRoles(roleList);
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
	 * 分页获取角色信息
	 * Anthor:Qiu
	 * method：getData       
	 * @version 1.0.0
	 * time:2019-9-12下午10:25:04
	 */
	@PostMapping("/getData")
	@ResponseBody
	@ApiOperation(value = "分页获取角色信息",httpMethod = "POST", response = SysRoleController.class)
	public Object getData(@RequestBody FindRoleDTO findRoleDTO){
		LayuiAPiResult result=new LayuiAPiResult();
		
		Page<SysRoleEntity> page = sysRoleService.getData(findRoleDTO);
		if (!StringUtils.isEmpty(page.getRecords()) && page.getRecords().size()>0) {
			result.setCode(0);
			result.setPage(findRoleDTO.getPage());
			result.setLimit(findRoleDTO.getLimit());
			result.setMsg("请求成功");
			long total = page.getTotal();
			result.setCount(Integer.parseInt(String.valueOf(total)));
			result.setData(page.getRecords());
		}else {
			result.setCode(1);
			result.setMsg("请求失败");
		}
		return result;
		
	}
	
	/**
	 * 获取角色列表
	 */
	@PostMapping("/getList")
	@ResponseBody
	@ApiOperation(value = "获取角色列表",httpMethod = "POST", response = SysRoleController.class)
	public Object getList(String userid,HttpServletRequest request){
		String uid = request.getParameter("id");
		AjaxResult result=new AjaxResult();
		
		List<SysRoleEntity> list = sysRoleService.getList();
		// 未分配角色
		List<SysRoleEntity> unAssignRole = new ArrayList<>();
		// 未分配角色
		List<SysRoleEntity> assignRole = new ArrayList<>();
		
		//查询已分配角色
		
		
		if (!StringUtils.isEmpty(list) && list.size()>0) {
			result.setSuccess(true);
			result.setMsg("请求成功");
			result.setData(list);
		}else {
			result.setSuccess(false);
			result.setMsg("获取角色失败");
		}
		return result;
		
	}
	
	
	@PostMapping(value="/deleteById")
	@ResponseBody
	@ApiOperation(value = "根据ID删除角色",httpMethod = "POST", response = SysUserController.class)
	public Object deleteUser(HttpServletRequest request,HttpSession session){
    String id = request.getParameter("id");
		SysUserEntity user = (SysUserEntity) session.getAttribute("loginUser");
		AjaxResult result=new AjaxResult();
		try {
			if (!StringUtils.isEmpty(id)) {
				Integer state = sysRoleService.removeById(id,user);
				if (state == 1) {
					result.setMsg("删除成功");
					result.setSuccess(true);
				}else if (state == 2) {
					result.setMsg("不存在ID为"+id+"的角色");
					result.setSuccess(false);
				}else if (state == 3) {
					result.setMsg("系统异常，请联系管理员");
					result.setSuccess(false);
				}else if (state == 4) {
					result.setMsg("参数ID不能为空");
			    	result.setSuccess(false);
				}else if (state == 5) {
					result.setMsg("不能删除系统管理员角色");
			    	result.setSuccess(false);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
		}
		return result;
	}
	
	
	
	

}

