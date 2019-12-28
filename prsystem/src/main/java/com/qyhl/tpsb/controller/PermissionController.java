package com.qyhl.tpsb.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javassist.tools.framedump;

import javax.servlet.http.HttpSession;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qyhl.tpsb.commonutils.AjaxResult;
import com.qyhl.tpsb.commonutils.Constant;
import com.qyhl.tpsb.entity.PermissionEntity;
import com.qyhl.tpsb.entity.SysRoleEntity;
import com.qyhl.tpsb.entity.SysUserEntity;
import com.qyhl.tpsb.service.PermissionService;

@Controller
@RequestMapping("/permission")
@Api(value = "/permission", tags = "权限(菜单)接口")
public class PermissionController {
	
	@Autowired
	private PermissionService permissionService;
	
	/**
	 * deleteById
	 * 删除菜单
	 */
	@PostMapping(value="/deleteById/{id}")
	@ResponseBody
	@ApiOperation(value = "删除菜单",httpMethod = "POST",response=PermissionController.class)
	public AjaxResult deleteById(@PathVariable("id")Integer id){
		 AjaxResult result = new AjaxResult();
		
		Integer state = permissionService.deletePermissionById(id);
		if (state == 1) {
			result.setMsg("操作成功");
		    result.setSuccess(true);
		 }else if (state == 0) {
			 result.setMsg("操作失败");
		     result.setSuccess(false);
		 }else if (state == 2) {
			 result.setMsg(String.format("不存在 s% 的菜单", id));
	         result.setSuccess(false);
		 }else if (state == 3) {
			 result.setMsg(String.format("传入参数不能为  s%", id));
	         result.setSuccess(false);
		 }else if (state == 4) {
			result.setMsg("不能删除系统菜单(根目录),删除后菜单树会消失");
			result.setSuccess(false);
		}		
		return result;
	}
	
	
	
	/**
	 * 添加菜单
	 * method：add       
	 * @version 1.0.0
	 * time:2019-9-17下午10:25:11
	 */
	@PostMapping(value="/add")
	@ResponseBody
	@ApiOperation(value = "添加菜单",httpMethod = "POST",response=PermissionController.class)
	public AjaxResult add(@RequestBody PermissionEntity permission,HttpSession session){
		SysUserEntity user = (SysUserEntity) session.getAttribute("loginUser");
		 AjaxResult result = new AjaxResult();
		
		Integer state = permissionService.add(permission,user);
		if (state == 1) {
			result.setMsg("操作成功");
		    result.setSuccess(true);
		 }else if (state == 4){
			result.setMsg("操作失败");
		    result.setSuccess(false);
		 }else if (state == 0) {
			 result.setMsg("父级不存在,请重新选择父级");
		     result.setSuccess(false);
		 }else if (state == 2) {
			 result.setMsg("url 路径已存在,请重新输入");
	         result.setSuccess(false);
		 }else if (state == 3) {  
			 result.setMsg("菜单名称已存在，请重新输入");
             result.setSuccess(false);
		 }else if (state == 5) {  
			 result.setMsg("参数不能为空");
             result.setSuccess(false);
		 }		
		return result;
	}
	
	/**
	 * 根据Id更新菜单
	 * method：update       
	 * @version 1.0.0
	 * time:2019-9-18下午7:49:19
	 */
	@PostMapping(value="/update")
	@ResponseBody
	@ApiOperation(value = "根据Id更新菜单",httpMethod = "POST",response=PermissionController.class)
	public AjaxResult update(@RequestBody PermissionEntity permission,HttpSession session){
		SysUserEntity user = (SysUserEntity) session.getAttribute("loginUser");
		 AjaxResult result = new AjaxResult();
		
		Integer state = permissionService.update(permission,user);
		if (state == 1) {
			result.setMsg("操作成功");
		    result.setSuccess(true);
		 }else if (state == 0) {
			 result.setMsg("操作失败");
		     result.setSuccess(false);
		 }else if (state == 2) {
			 result.setMsg("更新参数不能为空");
		     result.setSuccess(false);
		 }else if (state == 3) {
			 result.setMsg("url 路径已存在,请重新输入");
	         result.setSuccess(false);
		 }else if (state == 4) {  
			 result.setMsg("菜单名称已存在，请重新输入");
             result.setSuccess(false);
		 }else if (state == 5) {  
			 result.setMsg("更新菜单不存在");
             result.setSuccess(false);
		 }			
		return result;
	}
	
	
	/**
	 * 异步加载菜单树形数据，layui树调用
	 * method：loadTreeData       
	 * @version 1.0.0
	 * time:2019-9-18下午7:48:03
	 */
	@PostMapping("/loadTreeData")
	@ResponseBody
	@ApiOperation(value = "异步加载菜单树形数据",httpMethod = "POST", response = PermissionController.class)
	public AjaxResult loadTreeData(){
		AjaxResult result = new AjaxResult();
		List<PermissionEntity> permissions = new ArrayList<>();
		// 查询所有菜单数据
		 List<PermissionEntity> ps = permissionService.findAllPermissions();
		 // 为提高效率采用map的索引查询
		 Map<Integer, PermissionEntity> map = new HashMap<Integer,PermissionEntity>();
		 // 将权限封装到map
		 for (PermissionEntity item : ps) {
			map.put(item.getId(), item);
		   }
		 for (PermissionEntity item : ps) {
			 // 子节点
			   PermissionEntity child = item;
				if (item.getPid().equals(Constant.ZERO)) {
					// 根节点
					permissions.add(item);
				}else {
					// 根据索引查询父级
					PermissionEntity parent = map.get(child.getPid());
					parent.getChildren().add(child);
				}
			}
		 result.setSuccess(true);
		 result.setData(permissions);
		return result;
		
	}
	
	/***
	 * 供ztree调用
	 * method：loadAssignTreeData       
	 * @version 1.0.0
	 * time:2019-9-24下午9:19:32
	 */
	@PostMapping("/loadAssignTreeData")
	@ResponseBody
	public Object loadAssignTreeData(String roleid){
		List<PermissionEntity> permissions = new ArrayList<>();
		List<PermissionEntity> ps = permissionService.findAllPermissionsByZtree();
		
		//获取当前角色已经分配权限信息
		List<Integer> permids = permissionService.queryPermissiondisByRoid(roleid);
		
		Map<Integer, PermissionEntity> permissionMap = new HashMap<Integer, PermissionEntity>();
		for(PermissionEntity p : ps){
			//判断是否已分配
			if (permids.contains(p.getId())) {
				p.setChecked(true);
			}else {
				p.setChecked(false);
			}
			
			//将许可放入map中，并对应id关联许可名称
			permissionMap.put(p.getId(),p);
		}
		for(PermissionEntity pss:ps){
			//子节点
			PermissionEntity child=pss;
			if (pss.getPid()==0) {
				permissions.add(pss);
			}else {
				//在map中找父节点，通过key来找父节点
				PermissionEntity parent=permissionMap.get(child.getPid());
				parent.getChildren().add(child);
			}
		}
		
		
		return permissions;
	}
	
	/*// 递归查询子节点,效率比较低
	private void findChlidrenPermissions(PermissionEntity parent){
		 List<PermissionEntity> chlidrenNodes = permissionService.findAllChlidrenPermissions(parent.getId());
		 
		 for (PermissionEntity permission : chlidrenNodes) {
			 findChlidrenPermissions(permission);
		}
		 parent.setChildren(chlidrenNodes);
	}
*/
	
	
	
}
