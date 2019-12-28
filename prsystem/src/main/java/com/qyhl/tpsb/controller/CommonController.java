package com.qyhl.tpsb.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**     
 * method：DispatcherController  
 * author：Qiu
 * time：2019-4-3 
 * @version 1.0.0
 */
@Controller
@RequestMapping("/sys_user")
public class CommonController {
	
	// 跳转指定页面
	@RequestMapping("touser")
	public ModelAndView GoIndex(){
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("sysuser/index");
		return modelAndView;
	}
	
	@RequestMapping("/toadmin")
	public ModelAndView GoAdminIndex(){
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("admin/index");
		return modelAndView;
	}
	
	
	@RequestMapping("totest")
	public ModelAndView GoAdminTest(){
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("test/index");
		return modelAndView;
	}
	
	@RequestMapping("tousermana")
	public ModelAndView GoUserMana(){
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/sysuser/user/userMana");
		return modelAndView;
	}
	
	@RequestMapping("/toRoleMana")
	public ModelAndView toRoleOfUser(){
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/sysuser/role/roleMana");
		return modelAndView;
	}
	

	@RequestMapping("toPictureMana")
	public ModelAndView toPictureMana(){
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/sysuser/pic/pictureMana");
		return modelAndView;
	}
	
	@RequestMapping("/toPermissionMana")
	public ModelAndView toPermissionMana(){
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/sysuser/permission/permissionMana");
		return modelAndView;
	}
	
	
	@RequestMapping("toIdentPicture")
	public ModelAndView toIdentPicture(){
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/sysuser/identPicture");
		return modelAndView;
	}
	
	@RequestMapping("toMyPictureMana")
	public ModelAndView toMyPictureMana(){
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/sysuser/pictureMana");
		return modelAndView;
	}
	
	
	@RequestMapping("extend")
	public ModelAndView toExtend(){
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/sysuser/extendPage");
		return modelAndView;
	}
	
	
	@RequestMapping("conectionToUs")
	public ModelAndView toConectionToUs(){
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/sysuser/linkPage");
		return modelAndView;
	}
	
	
	@RequestMapping("toUpdatePasswordUI")
	public ModelAndView toUpdatePasswordUI(){
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/sysuser/updatePassword");
		return modelAndView;
	}
	
	@RequestMapping("toArticleMana")
	public ModelAndView toArticleMana(){
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/sysuser/article/articleMana");
		return modelAndView;
	}
	

}
