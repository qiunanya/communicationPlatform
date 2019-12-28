<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户管理</title>
<%
 pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="${APP_PATH}/layui-v2.4.5/layui/css/layui.css">

    <style type="text/css">
     
    </style>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
			<div class="layui-header">
				<a href="">
					<div class="layui-logo">后台管理系统</div>
				</a>
				<!-- 头部区域（可配合layui已有的水平导航） -->
				<ul class="layui-nav layui-layout-left">
					<li class="layui-nav-item">
						<a href="${APP_PATH}">返回前台</a>
					</li>
					<li class="layui-nav-item">
						<a href="">商品管理</a>
					</li>
					<li class="layui-nav-item">
						<a href="">用户</a>
					</li>
					<li class="layui-nav-item">
						<a href="javascript:;">其它系统</a>
						<dl class="layui-nav-child">
							<dd>
								<a href="">邮件管理</a>
							</dd>
							<dd>
								<a href="">消息管理</a>
							</dd>
							<dd>
								<a href="">授权管理</a>
							</dd>
						</dl>
					</li>
				</ul>
				<ul class="layui-nav layui-layout-right">
					<li class="layui-nav-item">
						<a href="javascript:;">
							<img src="https://gitee.com/uploads/66/890966_Leytton.png?1512991922" class="layui-nav-img"> Leytton </a>
						<dl class="layui-nav-child">
							<dd>
								<a href="javascript:;" onclick="addTab(this);" tab_url="http://www.llqqww.com">基本资料</a>
							</dd>
							<dd>
								<a href="">安全设置</a>
							</dd>
						</dl>
					</li>
					<li class="layui-nav-item">
						<a href="/mp.php/login/logout"><i class="layui-icon layui-icon-close-fill"></i> 退出系统</a>
					</li>
				</ul>
			</div>
			<div class="layui-side layui-bg-black">
				<div class="layui-side-scroll">
					<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
					<ul class="layui-nav layui-nav-tree">
						<li class="layui-nav-item layui-nav-itemed">
							<a class="" href="javascript:;">基本信息</a>
							<dl class="layui-nav-child">
								<dd class="layui-this">
									<a href="javascript:;" >基本信息</a>
								</dd>
							</dl>
						</li>
						<li class="layui-nav-item layui-nav-itemed">
							<a href="javascript:;">开源作品</a>
							<dl class="layui-nav-child">
								<dd>
									<a href="javascript:;" class="layTabPlus" tab_url="https://gitee.com/Leytton/ThinkJD">
										<i class="layui-icon layui-icon-star"> </i>
										ThinJDBC
									</a>
								</dd>
								<dd>
									<a href="javascript:;" class="layTabPlus" tab_url="https://gitee.com/Leytton/SimJQ">SimJQ</a>
								</dd>
								<dd>
									<a href="javascript:;" class="layTabPlus" tab_url="https://gitee.com/Leytton/layTabPlus" tab_jump="true">layTabPlus</a>
								</dd>
							</dl>
						</li>
						<li class="layui-nav-item layui-nav-itemed">
							<a href="javascript:;">关于作者</a>
							<dl class="layui-nav-child">
								<dd><a href="javascript:void(0);" class="layTabPlus" tab_url="http://www.llqqww.com">网站</a></dd>
								<dd><a href="javascript:void(0);" class="layTabPlus" tab_url="https://blog.csdn.net/leytton">博客</a></dd>
							</dl>	
						</li>
						<li class="layui-nav-item">
							<a href="javascript:;">其它</a>
							<dl class="layui-nav-child">
								<dd><a href="javascript:void(0);" class="layTabPlus" tab_url="http://www.llqqww.com">网站</a></dd>
								<dd><a href="javascript:void(0);" class="layTabPlus" tab_url="https://blog.csdn.net/leytton">博客</a></dd>
							</dl>	
						</li>
						<li class="layui-nav-item">
							<a href="javascript:void(0);" class="layTabPlus" tab_url="https://blog.csdn.net/leytton">CSDN</a>
						</li>
					</ul>
				</div>
			</div>

			<div class="layui-body">
				<!-- 内容主体区域 -->
				<div class="layui-tab" lay-filter="demoTab" lay-allowClose="true">
					<ul class="layui-tab-title">
						<li class="layui-this noclose" lay-id='base_info'>基本信息</li>
					</ul>
					<div class="layui-tab-content" style="padding:0px;">
						<div class="layui-tab-item layui-show">
							<div class="sysNotice col">
								<blockquote class="layui-elem-quote title">基本信息</blockquote>
								<table class="layui-table">
									<tbody>
										<tr>
											<td>当前版本</td>
											<td class="version">V1.2</td>
										</tr>
										<tr>
											<td>开发作者</td>
											<td class="author">Leytton</td>
										</tr>
										<tr>
											<td>项目首页</td>
											<td class="homePage"><a href="https://gitee.com/Leytton/layTabPlus">https://gitee.com/Leytton/layTabPlus</a></td>
										</tr>
										<tr>
											<td colspan="2">
												<script src='https://gitee.com/Leytton/layTabPlus/widget_preview'></script>
												<style>
												.pro_name a{color: #4183c4;}
												.osc_git_title{background-color: #fff;}
												.osc_git_box{background-color: #fff;}
												.osc_git_box{border-color: #E3E9ED;}
												.osc_git_info{color: #666;}
												.osc_git_main a{color: #9B9B9B;}
												</style>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="layui-footer">
				© 2018 <a href="https://gitee.com/Leytton/layTabPlus">layTabPlus</a> - by Leytton
			</div>
		</div>

    <script src="${APP_PATH}/js/jquery-2.1.1.min.js"></script>
    <script src="${APP_PATH}/layui-v2.4.5/layui/layui.all.js"></script>
       <script>
			var $ = layui.jquery;
			var layer = layui.layer;
			var element = layui.element;
			var util = layui.util;
			var table = layui.table;
		</script>
		<script src="${APP_PATH}/js/layTabPlus.js"></script>
		<script>
			layTabPlus.init({
				lay_filter: 'demoTab'
			});
		</script>
</body>
</html>