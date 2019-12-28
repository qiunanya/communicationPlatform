package com.qyhl.tpsb.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.qyhl.tpsb.entity.ArticleCategory;
import com.qyhl.tpsb.service.ArticleCategoryService;
@Controller
@RequestMapping("/index.html")
public class HomeController {
	@Autowired
	private ArticleCategoryService articleCategoryService;
	
	/**
	 * 跳转到用户前端页面
	 */
	@RequestMapping("toIndexUI")
	public ModelAndView toIndexUI(){
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/home/index");
		return modelAndView;
	}
	
	/**
	 * 跳转到用户中心
	 * */
	@RequestMapping("toUserCenterUI")
	public ModelAndView toUserCenterUI(){
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/home/person/person_center");
		return modelAndView;
	}
	
	/**
	 * 跳转到文章管理
	 * */
	@RequestMapping("toMyArticleUI")
	public ModelAndView toMyArticleUI(){
		ModelAndView modelAndView = new ModelAndView();
		List<ArticleCategory> list = articleCategoryService.getList();
		modelAndView.addObject("articleCategory", list);
		modelAndView.setViewName("/home/person/myarticle");
		return modelAndView;
	}
	
	/**
	 * 跳转到我的消息
	 * */
	@RequestMapping("toMyMessageUI")
	public ModelAndView toMyMessageUI(){
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/home/person/mymessage");
		return modelAndView;
	}
	
	/**
	 * 跳转前端登录界面
	 * */
	@RequestMapping("toWebLoginUI")
	public ModelAndView toWebLoginUI(){
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/home/webLogin");
		return modelAndView;
	}
	
}
