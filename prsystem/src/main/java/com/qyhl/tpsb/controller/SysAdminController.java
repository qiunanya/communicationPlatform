package com.qyhl.tpsb.controller;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.qyhl.tpsb.commonutils.AjaxResult;
import com.qyhl.tpsb.commonutils.MD5Utils;
import com.qyhl.tpsb.entity.SysAdminEntity;
import com.qyhl.tpsb.service.SysAdminService;

/**     
 * method：SysAdminController  
 * author：Qiu
 * time：2019-4-5 
 * @version 1.0.0
 */
@Controller
public class SysAdminController {
	@Autowired
	private SysAdminService sysAdminService;
	
	@RequestMapping("/adminLogin")
	@ResponseBody
	public Object adminLogin(SysAdminEntity entity,HttpSession session){
		String apassword=MD5Utils.md5(entity.getPassword());
		AjaxResult result=new AjaxResult();
		SysAdminEntity admin=sysAdminService.login(entity.getPhone(),apassword);
			if (admin != null) {
				if (admin.getPassword().equals(apassword)) {
					session.setAttribute("loginAdmin",admin);
					result.setState(0);
				}else {
					result.setState(1);
				}
				// result.setSuccess(true);
			}else {
				// result.setSuccess(false);
				result.setState(2);
			}
		
		return result;
		
	}
	
	/**
	 * 退出
	 * adminLogout
	 */
	@RequestMapping("/adminLogout")
	public Object userLogot(HttpSession session){
		session.removeAttribute("loginAdmin");
		System.out.println("管理员退出成功");
		return "redirect:touser";
	}
	
	@RequestMapping("/touser")
	public ModelAndView GoIndex(){
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/login");
		return modelAndView;
	}

}
