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
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
			<div class="layui-header">
				<a href="">
					<div class="layui-logo">图片识别后台管理系统</div>
				</a>
				<!-- 头部区域（可配合layui已有的水平导航） -->
				<ul class="layui-nav layui-layout-left">
					<li class="layui-nav-item">
						<a href="${APP_PATH}">返回前台</a>
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
							<img src="https://gitee.com/uploads/66/890966_Leytton.png?1512991922" class="layui-nav-img">欢迎您：${loginUser.username}</a>
						<dl class="layui-nav-child">
							<dd>
								<a href="javascript:;" onclick="addTab(this);" tab_url="http://www.llqqww.com">基本资料</a>
							</dd>
							<dd>
								<a href="javascript:;" tab_url="${APP_PATH}/sys_user/toUpdatePasswordUI">安全设置</a>
							</dd>
						</dl>
					</li>
					<li class="layui-nav-item">
						<a href="javascript:void(0);" onclick="logout()" title="点击可以退出系统"><i class="layui-icon layui-icon-close-fill"></i> 退出系统</a>
					</li>
				</ul>
			</div>
			<div class="layui-side layui-bg-black">
				<div class="layui-side-scroll">
					<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
					<ul class="layui-nav layui-nav-tree" lay-shrink="all">
						<li class="layui-nav-item">
							<a href="javascript:;">图片识别管理</a>
							<dl class="layui-nav-child">
								<dd>
									<a href="javascript:;" class="layTabPlus" tab_url="${APP_PATH}/sys_user/toIdentPicture">
										<i class="layui-icon layui-icon-star"></i>
										识别页面
									</a>
								</dd>
								<dd>
									<a href="javascript:;" class="layTabPlus" tab_url="${APP_PATH}/sys_user/toMyPictureMana">
									  <i class="layui-icon layui-icon-star"></i>
										识别记录
									</a>
								</dd>
								<dd>
									<a href="javascript:;" class="layTabPlus" tab_url="${APP_PATH}/sys_user/extend" tab_jump="true">
									 <i class="layui-icon layui-icon-star"></i>待扩展区</a>
								</dd>
							</dl>
						</li>
						<!-- 动态获取菜单 -->
						<c:forEach items="${rootPermission.children}" var="permission">
						   <c:if test="${empty permission.children}">
						        <li class="layui-nav-item">
									<a href="javascript:;"><i class="${permission.icon}"></i>${permission.name}</a>
								</li>
						   </c:if>
						   
						   <c:if test="${not empty permission.children }">
						         <li class="layui-nav-item">
									<a href="javascript:;"><i class="${permission.icon}"></i>${permission.name}</a>
									<dl class="layui-nav-child">
									    <c:forEach items="${permission.children}" var="children">
											<dd>
												<a href="javascript:;" class="layTabPlus" tab_url="${APP_PATH}${children.url}">
													<i class="${children.icon}"></i>
													${children.name}
												</a>
											</dd>
										</c:forEach>
									</dl>
								</li>
						   </c:if>
							
						</c:forEach>
						<%-- <li class="layui-nav-item">
							<a href="javascript:;">图片管理</a>
							<dl class="layui-nav-child">
								<dd>
									<a href="javascript:;" class="layTabPlus" tab_url="${APP_PATH}/sys_user/toPictureMana">
										<i class="layui-icon layui-icon-star"></i>
										图片管理
									</a>
								</dd>
							</dl>
						</li>
						<li class="layui-nav-item">
							<a href="javascript:;">系统管理</a>
							<dl class="layui-nav-child">
								<dd>
									<a href="javascript:;" class="layTabPlus" tab_url="${APP_PATH}/sys_user/tousermana">
										<i class="layui-icon layui-icon-group"></i>
										用户管理
									</a>
								</dd>
								<dd>
									<a href="javascript:;" class="layTabPlus" tab_url="${APP_PATH}/sys_user/toRoleMana">
										<i class="layui-icon layui-icon-star"></i>
										角色管理
									</a>
								</dd>
								<dd>
									<a href="javascript:;" class="layTabPlus" tab_url="${APP_PATH}/sys_user/toPermissionMana">
										<i class="layui-icon layui-icon-auz"></i>
										权限管理
									</a>
								</dd>
							</dl>
						</li>
						<li class="layui-nav-item">
							<a href="javascript:;">密码重置</a>
							<dl class="layui-nav-child">
								<dd><a href="javascript:void(0);" class="layTabPlus" tab_url="${APP_PATH}/sys_user/toUpdatePasswordUI">
								<i class="layui-icon layui-icon-star"></i>修改密码</a></dd>
								
							</dl>	
						</li>
						<li class="layui-nav-item">
							<a href="javascript:;">关于作者</a>
							<dl class="layui-nav-child">
								<dd><a href="javascript:void(0);" class="layTabPlus" tab_url="${APP_PATH}/sys_user/conectionToUs">
								<i class="layui-icon layui-icon-star"></i>联系我们</a>
								</dd>
							</dl>	
						</li> --%>
						
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
								
								<table class="layui-table" style="text-align:center;">
								    <thead>
								      <tr>
								         <td colspan="2" style="font-size:24px;">欢迎您来到图片识别系统   *^__^*</td>
								      </tr>
								    </thead>
									<tbody>
										<tr>
											<td>当前版本</td>
											<td class="version">V1.0</td>
										</tr>
										<tr>
											<td>开发作者</td>
											<td class="author">贵州师范学院-杨云</td>
										</tr>
										
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="layui-footer">
				© &nbsp;CopyRight 2019 <a href="#">贵州师范学院</a> -make © 云智交流平台
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
		<script type="text/javascript">
		function logout()
		{
		   layer.confirm("确定要退出系统吗？是否继续",  {icon: 3, title:'提示',shade: 0.2}, function(cindex){
			   window.parent.location="${APP_PATH}/sysUser/userLogout";
   			    layer.close(cindex);
   			}, function(cindex){
   			    layer.close(cindex);
   			});
		}
		  
		</script>
</body>
</html>