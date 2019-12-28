<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>扩展页面</title>
<%
 pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<link rel="stylesheet" href="${APP_PATH}/layui-v2.4.5/layui/css/layui.css">
<script src="${APP_PATH}/js/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/layui-v2.4.5/layui/layui.all.js"></script>
    <style type="text/css">
     
    </style>
</head>
<body>
		<table class="layui-table"  lay-even lay-skin="row" lay-size="lg">
		  <colgroup>
		    <col width="150">
		    <col width="200">
		    <col>
		  </colgroup>
		  <thead>
		    <tr>
		      <th>姓名</th>
		      <th>联系方式</th>
		      <th>座右铭</th>
		    </tr> 
		  </thead>
		  <tbody>
		    <tr>
		      <td>邱南亚</td>
		      <td>1766226354@qq.com</td>
		      <td>真理是探索出来的</td>
		    </tr>
		    <tr>
		      <td>杨云</td>
		      <td>1018823427@qq.com</td>
		      <td>没有梦想和咸鱼有什么区别</td>
		    </tr>
		    <tr>
		      <td>黄小朝</td>
		      <td>1183529371@qq.com</td>
		      <td>不想输 就别懒</td>
		    </tr>
		    <tr>
		      <td>罗集景</td>
		      <td>1778356299@qq.com</td>
		      <td>好好学习，天天向上</td>
		    </tr>
		  </tbody>
		</table>

</body>
</html>