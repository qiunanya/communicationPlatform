<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>文章详情页</title>
<%
 pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<link rel="stylesheet" href="${APP_PATH}/layui-v2.4.5/layui/css/layui.css">
<link rel="stylesheet" href="${APP_PATH}/layui-v2.4.5/layui/css/modules/layui-icon-extend/iconfont.css">
<link rel="stylesheet" href="${APP_PATH}/css/global/global.css">
</head>
<body>
 <!--头部信息 -->
<%@ include file="../../home/common/header.jsp" %>
 <div class="layui-container">
    <div class="layui-row">
        <div class="layui-col-xs12 layui-col-sm12 layui-col-md12">
	          <div class="layui-row" style="margin:10px;">
			    <div class="layui-col-md12">
			        <h2 style="display:inline;margin-right:20px;"> ${articleInfo.articleTitle}</h2>
		            <span title="发布用户"><span class="iconfont layui-icon-extendyonghu"></span>：${user.username}</span>
			        <span title="评论"><span class="iconfont layui-icon-extendpinglun1"></span>：254</span>
			        <span title="浏览量"><span class="iconfont layui-icon-extendliulan"></span>：12</span>             
			    </div>
			    
			  </div>
			  
			   <div class="layui-row" style="border:1px solid #bebcbc;border-radius:5px;">
				    <div class="layui-col-md9" style="margin:10px;">
				         ${articleInfo.articleContent}        
				    </div>
				    <div class="layui-col-md3">
				                     你的内容 3/12
				    </div>
			  </div>
	    </div>
	    
    </div>
    
 </div>
<!--底部信息 -->
<%@ include file="../../home/common/footer.jsp" %>
<script src="${APP_PATH}/js/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/layui-v2.4.5/layui/layui.js"></script>
</body>
</html>