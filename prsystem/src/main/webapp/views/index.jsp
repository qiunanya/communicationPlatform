<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户列表</title>
<%
 pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="${APP_PATH}/layui-v2.4.5/layui/css/layui.css">
    <style type="text/css">
     
    </style>
</head>
<body>
这里是view里的hello 首页
<a href="${APP_PATH}/sys_user/touser">用户首页</a>
<a href="${APP_PATH}/sys_user/toadmin">管理员后台</a>
<a href="${APP_PATH}/sys_user/totest">管理员后台测试页面</a>
<script src="${APP_PATH}/js/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/layui-v2.4.5/layui/layui.js"></script>
<script>
//一般直接写在一个js文件中
layui.use(['layer', 'form'], function(){
  var layer = layui.layer
  ,form = layui.form;
  
  layer.msg('Hello World');
});
</script>
</body>
</html>