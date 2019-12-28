<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>我的消息</title>
<%
 pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<link rel="stylesheet" href="${APP_PATH}/layui-v2.4.5/layui/css/layui.css">
<link rel="stylesheet" href="${APP_PATH}/css/global/global.css">
<link rel="stylesheet" href="${APP_PATH}/css/admin/center.css">
    <style type="text/css">
     
    </style>
</head>
<body>
 <!--头部信息 -->
<%@ include file="../../home/common/header.jsp" %>
 <div class="layui-container fly-marginTop fly-user-main">
  <ul class="layui-nav layui-nav-tree layui-inline" lay-filter="user">
     <li class="layui-nav-item">
      <a href="${APP_PATH}/views/home/person/person_center.jsp">
        <i class="layui-icon">&#xe620;</i>
                        基本设置
      </a>
    </li>
    <li class="layui-nav-item ">
      <a href="${APP_PATH}/index.html/toMyArticleUI">
        <i class="layui-icon">&#xe609;</i>
                     文章管理
      </a>
    </li>
    <li class="layui-nav-item">
      <a href="index.html">
        <i class="layui-icon">&#xe612;</i>
                     用户中心
      </a>
    </li>
    <li class="layui-nav-item layui-this">
      <a href="${APP_PATH}/views/home/person/mymessage.jsp">
        <i class="layui-icon">&#xe611;</i>
                      我的消息
      </a>
    </li>
  </ul>

  <div class="site-tree-mobile layui-hide">
    <i class="layui-icon">&#xe602;</i>
  </div>
  <div class="site-mobile-shade"></div>
  
  <div class="site-tree-mobile layui-hide">
    <i class="layui-icon">&#xe602;</i>
  </div>
  <div class="site-mobile-shade"></div>
  
  <div class="fly-panel fly-panel-user" pad20>
	  <div class="layui-tab layui-tab-brief" lay-filter="user" id="LAY_msg" style="margin-top: 15px;">
	    <button class="layui-btn layui-btn-danger" id="LAY_delallmsg">清空全部消息</button>
	    <div  id="LAY_minemsg" style="margin-top: 10px;">
        <!--<div class="fly-none">您暂时没有最新消息</div>-->
        <ul class="mine-msg">
          <li data-id="123">
            <blockquote class="layui-elem-quote">
              <a href="/jump?username=Absolutely" target="_blank"><cite>Absolutely</cite></a>回答了您的求解<a target="_blank" href="/jie/8153.html/page/0/#item-1489505778669"><cite>layui后台框架</cite></a>
            </blockquote>
            <p><span>1小时前</span><a href="javascript:;" class="layui-btn layui-btn-small layui-btn-danger fly-delete">删除</a></p>
          </li>
          <li data-id="123">
            <blockquote class="layui-elem-quote">
              系统消息：欢迎使用 layui
            </blockquote>
            <p><span>1小时前</span><a href="javascript:;" class="layui-btn layui-btn-small layui-btn-danger fly-delete">删除</a></p>
          </li>
        </ul>
      </div>
	  </div>
	</div>

</div>  
  
 
<!--底部信息 -->
<%@ include file="../../home/common/footer.jsp" %>
<script src="${APP_PATH}/js/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/layui-v2.4.5/layui/layui.js"></script>

<script type="text/javascript">
	//注意：导航 依赖 element 模块，否则无法进行功能性操作
	layui.use(['element'], function(){
	var element = layui.element;
	 
	});
</script>
</body>
</html>
<style>
	.sysNotice .layui-table {
		margin-top: 0;
		border-left: 5px solid #e2e2e2;
	}
	
	.layui-elem-quote.title {
		padding: 10px 15px;
		margin-bottom: 0;
	}
	
	.sysNotice {
		width: 75%;
	}
	.code{
		color: #c7254e;
		background-color: #f9f2f4;
		border-radius: 2px;
		padding: 4px 2px 0;
	}
</style>