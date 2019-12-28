package com.qyhl.tpsb.filter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.util.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.qyhl.tpsb.entity.SysUserEntity;
/**
 * 登录拦截器
 * method：LoginInterceptor  
 * author：Qiu
 * time：2019-10-10 
 * @version 1.0.0
 */
public class LoginInterceptor implements HandlerInterceptor {

	/**
	 * 完成视图渲染之后执行
	 */
	@Override
	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

    /**
     * 控制器执行之后执行	
     */
	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {
		// TODO Auto-generated method stub
		
	}

	/**
	 * 控制器执行业务逻辑之前执行  true继续执行  false停止执行
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object params) throws Exception {
		// 判断用户是否登录
		HttpSession session = request.getSession();
		SysUserEntity user =(SysUserEntity) session.getAttribute("loginUser");
		if (StringUtils.isEmpty(user)) {
			String path = session.getServletContext().getContextPath();
			response.sendRedirect(path+"/sysUser/login.html");
			return false;
		}else {
			return true;
		}
		
	}

}
