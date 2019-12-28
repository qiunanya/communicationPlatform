package com.qyhl.tpsb.filter;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.qyhl.tpsb.entity.PermissionEntity;
import com.qyhl.tpsb.service.PermissionService;

public class AuthInterceptor extends HandlerInterceptorAdapter {
	@Autowired
	private PermissionService permissionService;

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		boolean flag = false;
		// 获取用户请求路径
		String uri = request.getRequestURI();
		String path = request.getSession().getServletContext().getContextPath();
		// 判断当前路径是否需要权限验证
		
		// 查询所有需要验证的权限集合
		List<PermissionEntity> permissions = permissionService.findAllPermissions();
		// set防止路径重复
	    Set<String> uriSet = new HashSet<String>();
	    if (!StringUtils.isEmpty(permissions)) {
			for (PermissionEntity permission : permissions) {
				if (!StringUtils.isEmpty(permission.getUrl())) {
					uriSet.add(path + permission.getUrl());
				}
			}
			
			if (uriSet.contains(uri)) {
				// 需要做权限验证
				// 当前的用户是否有对应的权限，在用户登录时添加权限
				@SuppressWarnings("unchecked")
				Set<String> authedUriSets =(Set<String>) request.getSession().getAttribute("AuthUriSet");
				if (authedUriSets.contains(uri)) {
					// 已授权
					flag = true;
				}else {
					// 未授权
					response.sendRedirect(path + "/sysUser/error.html");
					flag = false;
				}
				
			}else {
				// 不包含，不用做权限验证，继续访问
				flag = true;
			}
		}else {
			System.out.println("路径集合为空！");
		}
	    return flag;
	}

}
