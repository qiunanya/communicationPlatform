<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>我发布的文章</title>
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
    <li class="layui-nav-item layui-this">
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
    <li class="layui-nav-item">
      <a href="${APP_PATH}/index.html/toMyMessageUI">
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
    <!--
    <div class="fly-msg" style="margin-top: 15px;">
      您的邮箱尚未验证，这比较影响您的帐号安全，<a href="activate.html">立即去激活？</a>
    </div>
    -->
    <div class="layui-tab layui-tab-brief" lay-filter="user">
     <!--  <button type="button" class="layui-btn">立即发布文章<i class="layui-icon layui-icon-add-1"></i> </button> -->
      <ul class="layui-tab-title" id="LAY_mine">
        <li data-type="mine-jie" lay-id="index" class="layui-this">我的文章<span class="layui-badge">99+</span></li>
        <li data-type="collection" data-url="/collection/find/" lay-id="collection">收藏文章<span class="layui-badge">66</span></li>
        <li data-type="mine-article" lay-id="article">发布文章</li>
      </ul>
      <div class="layui-tab-content" style="padding: 20px 0;">
        <div class="layui-tab-item layui-show">
          <ul class="mine-view jie-row">
            <li>
              <a class="jie-title" href="../jie/detail.html" target="_blank">基于 layui 的极简社区页面模版</a>
              <i>2017/3/14 上午8:30:00</i>
              <a class="mine-edit" href="/jie/edit/8116">编辑</a>
              <em>661阅/10答</em>
            </li>
            <li>
              <a class="jie-title" href="../jie/detail.html" target="_blank">基于 layui 的极简社区页面模版</a>
              <i>2017/3/14 上午8:30:00</i>
              <a class="mine-edit" href="/jie/edit/8116">编辑</a>
              <em>661阅/10答</em>
            </li>
            <li>
              <a class="jie-title" href="../jie/detail.html" target="_blank">基于 layui 的极简社区页面模版</a>
              <i>2017/3/14 上午8:30:00</i>
              <a class="mine-edit" href="/jie/edit/8116">编辑</a>
              <em>661阅/10答</em>
            </li>
          </ul>
          <div id="LAY_page"></div>
        </div>
        <div class="layui-tab-item">
          <ul class="mine-view jie-row">
            <li>
              <a class="jie-title" href="../jie/detail.html" target="_blank">基于 layui 的极简社区页面模版</a>
              <i>收藏于23小时前</i>  </li>
          </ul>
          <div id="LAY_page1"></div>
        </div>
        
        <!-- 发布文章页面 -->
        <div class="layui-tab-item">
           <form class="layui-form" action="">
			  <div class="layui-form-item">
			    <label class="layui-form-label">文章名称</label>
			    <div class="layui-input-block">
			      <input type="text" name="articleTitle" id="articleTitle" required lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input">
			    </div>
			  </div>
			  <!-- <div class="layui-form-item">
			    <label class="layui-form-label">密码框</label>
			    <div class="layui-input-inline">
			      <input type="password" name="password" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
			    </div>
			    <div class="layui-form-mid layui-word-aux">辅助文字</div>
			  </div> -->
			  <div class="layui-form-item">
			    <label class="layui-form-label">所属分类</label>
			    <div class="layui-input-block">
			      <select name="categoryId" id="categoryId" lay-search lay-verify="required">
			       <c:forEach items="${articleCategory}" var="category">
			          <option value="${category.categoryId}">${category.categoryName}</option>
			       </c:forEach>
			        
			       <!--  <option value="0">北京</option>
			        <option value="1">上海</option>
			        <option value="2">广州</option>
			        <option value="3">深圳</option>
			        <option value="4">杭州</option> -->
			      </select>
			    </div>
			  </div>
			  
			   <div class="layui-form-item">
			       <div class="layui-input-block">
			          <textarea name="articleContent" id="releaseArticleArea" class="layui-textarea" placeholder="详细描述" style="display: none;"></textarea>
			       </div>
			   </div>
			  
			 
			  <div class="layui-form-item">
			    <div class="layui-input-block">
			      <button class="layui-btn" id="releaseArticleForm">立即发布</button>
			      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
			      <button type="button" id="privewBtn" class="layui-btn layui-btn-primary">预览</button>
			    </div>
			  </div>
		  </form>
       </div>
        
      </div>
    </div>
  </div>
</div>
 
<!--底部信息 -->
<%@ include file="../../home/common/footer.jsp" %>
<script src="${APP_PATH}/js/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/layui-v2.4.5/layui/layui.js"></script>
<script src="${APP_PATH}/layer/layer.js"></script>

<script type="text/javascript">
    var con = "";
   function clearTips(){
	   console.log("获得焦点");
   }

   function toMessage(){
	   window.location.href="${APP_PATH}/index.html/toMyMessageUI";
   }
   
	//注意：导航 依赖 element 模块，否则无法进行功能性操作
	layui.use(['element','layedit','form','jquery'], function(){
	var element = layui.element,
	  layedit = layui.layedit,
	  form = layui.form,
	  jquery = layui.jquery;
	 
	 //上传图片
	 layedit.set({
		 uploadImage:{
			 url:'${APP_PATH}/up_files/webUploadImg',
			 type:'post',
			 success: function (data) {
				 // console.log(data);
	             return false;
	        }
		 }
		 
	 });
	
	//建立编辑器
	var editIndex = layedit.build('releaseArticleArea',{
		height:230,
		//重新定义工具
		tool: [
			  'strong' //加粗
			  ,'italic' //斜体
			  ,'underline' //下划线
			  ,'del' //删除线
			  ,'|' //分割线
			  ,'left' //左对齐
			  ,'center' //居中对齐
			  ,'right' //右对齐
			  ,'link' //超链接
			  ,'unlink' //清除链接
			  ,'face' //表情
			  ,'image' //插入图片
			  ,'code' //插入代码-----官方没有写上，但是代码中有
			  /* ,'preview' */
			]
	 }); 

	 $("#privewBtn").click(function(){
		
		 layer.open({
             type:1,
             area:['500px', '350px']
             ,title: '预览'
             ,content: layedit.getContent(editIndex)
		 });
	 });
	 
	//审核文本内容是否合格，
	$("#articleTitle").blur(function(){
		var title = $.trim($("#articleTitle").val());
		$.ajax({
    		type : "GET",
    		async:false,
    		url  : "${APP_PATH}/article/identText",
    		data : {text:title},
    		success : function(result) {
    			var res = $.parseJSON(result.msg);
    			if(res.result.reject && res.result.reject.length>0){
    				if(res.result.reject[0].label==1){
    					layer.msg("标题含有[暴恐违禁]内容，请重新输入", {time:2000, icon:5, shift:6}, function(){});
    					return false;
    				}else if(res.result.reject[0].label == 2){
    					layer.msg("标题含有[文本色情]内容，请重新输入", {time:2000, icon:5, shift:6}, function(){});
    					return false;
    				}else if(res.result.reject[0].label == 3){
    					layer.msg("标题含有[政治敏感]内容，请重新输入", {time:2000, icon:5, shift:6}, function(){});
    					return false;
    				}else if(res.result.reject[0].label == 4){
    					layer.msg("标题含有[恶意推广]内容，请重新输入", {time:2000, icon:5, shift:6}, function(){});
    					return false;
    				}else if(res.result.reject[0].label == 5){
    					layer.msg("标题含有[低俗辱骂]内容，请重新输入", {time:2000, icon:5, shift:6}, function(){});
    					return false;
    				}else if(res.result.reject[0].label == 6){
    					layer.msg("标题含有[低质灌水]内容，请重新输入", {time:2000, icon:5, shift:6}, function(){});
    					return false;
    				}
    			}
    			console.log(res.result);
    			
    		}
    	});
	});
	
	 
     // 提交文本
	 $("#releaseArticleForm").click(function(){
		 var content = layedit.getContent(editIndex);
		 var article = $.trim($("#articleTitle").val());
		 var cid = $("#categoryId").val();
		 if(article =="" || article ==null){
			 layer.msg("文章名称不能为空", {time:2000, icon:5, shift:6}, function(){	});
			 return false;
		 }
		 if(article.length<1 || article.length>30){
			 layer.msg("文章名称长度在1-30个字符之间", {time:2000, icon:5, shift:6}, function(){});
			 return false;
		 }
		 if(content == "" ||content ==null){
			 layer.msg("文章内容不能为空", {time:2000, icon:5, shift:6}, function(){});
			 return false;
		 }
		 
		 
		 //发起后台请求
		 var loadingIndex = null;
             var requestParam= {};
             requestParam.articleTitle= article;
             requestParam.categoryId = cid;
             requestParam.articleContent = content;
	    	$.ajax({
	    		type : "POST",
	    		async:false,
	    		url  : "${APP_PATH}/article/add",
	    		data : JSON.stringify(requestParam),
	    		dataType : "json",
	    		contentType:"application/json;UTF-8",
	    		beforeSend : function() {
	    			loadingIndex = layer.msg('处理中', {icon: 16,shade:0.3,});
	    		},
	    		success : function(result) {
	    			layer.close(loadingIndex);
	    			if ( result.state==1) {
	    				 layer.msg(result.msg, {time:2000, icon:6, shift:6,}, function(){
	    					 location.reload();	
	                       });
	    			}else if( result.state == 0){
                       layer.msg(result.msg, {time:2000, icon:5, shift:6,}, function(){});
       
	    			}else if( result.state== 2){
	                       layer.msg(result.msg, {time:2000, icon:5, shift:6,}, function(){});  
		    		}else if( result.state== 4){
	                       layer.msg(result.msg, {time:2000, icon:5, shift:6,}, function(){});  
		    		}
	    		}
	    	});
		 return false;
	});
	 
	});
	
	
</script>
</body>
</html>
<style>
	.sysNotice .layui-table {
		margin-top: 0;
		border-left: 5px solid #e2e2e2;
	}
	.layui-layedit{
	  width:573px;
	  overflow-x:auto;
	}
	
	img{
	     width:60%;
	     height:60%;	    
	}
	
	#LAY_layedit_1 > img{
	     width:60%;
	     height:60%;	
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