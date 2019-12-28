<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>头部</title>
<%
 pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<link rel="stylesheet" href="${APP_PATH}/layui-v2.4.5/layui/css/layui.css">
</head>
<body>
<div class="layui-fluid">
    <div class="layui-row">
        <div class="layui-col-xs12 layui-col-sm12 layui-col-md12">
	         <ul class="layui-nav" lay-filter="">
			  <li class="layui-nav-item"><a href="${APP_PATH}/index.html/toIndexUI">最新文章</a></li>
			  <li class="layui-nav-item"><a href="javascript:;">产品</a></li>
			  <li class="layui-nav-item"><a href="javascript:;">大数据</a></li>
			  <!-- <li class="layui-nav-item">
			    <a href="javascript:;">解决方案</a>
			    <dl class="layui-nav-child"> 二级菜单
			      <dd><a href="">移动模块</a></dd>
			      <dd><a href="">后台模版</a></dd>
			      <dd><a href="">电商平台</a></dd>
			    </dl>
			  </li> -->
			  <li class="layui-nav-item"><a href="">社区</a></li>
			  <!-- 未登录的状态 -->
		        <c:if test="${empty webLoginUser}">
				      <li class="layui-nav-item">
				        <a class="iconfont icon-touxiang layui-hide-xs" href="user/login.html"></a>
				      </li>
				      <li class="layui-nav-item">
				        <a href="${APP_PATH}/index.html/toWebLoginUI" target="_blank">登入</a>
				      </li>
				      <li class="layui-nav-item">
				        <a href="user/reg.html">注册</a>
				      </li>
			    </c:if> 
		      <!-- 登录后的状态 -->
		      <c:if test="${not empty webLoginUser}">
				   <li class="layui-nav-item">
				    <a href=""><img src="//t.cn/RCzsdCq" class="layui-nav-img">${webLoginUser.username}</a>
				    <dl class="layui-nav-child">
				      <dd><a href="${APP_PATH}/index.html/toUserCenterUI">个人中心</a></dd>
				      <dd><a href="javascript:;">修改信息</a></dd>
				      <dd><a href="javascript:;">安全管理</a></dd>
				      <dd><a href="#" onclick="webLogout()">退了</a></dd>
				    </dl>
				  </li>
			  </c:if>
			   <li class="layui-nav-item">
			    <a href="${APP_PATH}/sysUser/login.html">后台登陆</a>
			  </li>
			  
			 <!--  <li class="layui-nav-item" style="float:right;">
			    <a href="">个人中心<span class="layui-badge-dot"></span></a>
			  </li> -->
		</ul>
   </div>
</div>
</div>
<script src="${APP_PATH}/js/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/layer/layer.js"></script>
<script type="text/javascript">
	function webLogout(){
	   console.log(6666)
	   layer.confirm("确定要退出系统吗？是否继续",  {icon: 3, title:'提示',shade: 0.2}, function(cindex){
		   window.parent.location="${APP_PATH}/sysUser/webUserLogout";
			    layer.close(cindex);
			}, function(cindex){
			    layer.close(cindex);
			});
	}
</script>
</body>
</html>
 <!--  <div class="layui-col-xs4 layui-col-sm7 layui-col-md8 layui-hide-md">
	      移动：4/12 | 平板：7/12 | 桌面：8/12
	    </div>
	    <div class="layui-col-xs4 layui-col-sm5 layui-col-md4">
	      移动：4/12 | 平板：5/12 | 桌面：4/12
	    </div> -->