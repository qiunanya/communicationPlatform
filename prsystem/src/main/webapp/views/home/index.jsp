<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

<title>云智交流平台首页</title>
<%
 pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<link rel="stylesheet" href="${APP_PATH}/layui-v2.4.5/layui/css/layui.css">
<link rel="stylesheet" href="${APP_PATH}/layui-v2.4.5/layui/css/modules/layui-icon-extend/iconfont.css">
<link rel="stylesheet" href="${APP_PATH}/css/global/global.css">
</head>
<body>
 <!--头部信息 -->
<jsp:include page="../home/common/header.jsp"></jsp:include>
<div class="layui-container">  
  <div class="layui-row">
    <div class="layui-col-xs9 layui-col-sm9 layui-col-md9">
      <div class="layui-row">
         <!-- 轮播图  -->
          <div class="layui-carousel" id="test1">
			  <div carousel-item>
			    <div><img src="${APP_PATH}/img/carousel/1.jpg" width="100%" height="172"></div>
			    <div><img src="${APP_PATH}/img/carousel/2.png" width="100%" height="172"></div>
			    <div><img src="${APP_PATH}/img/carousel/2.png" width="100%" height="172"></div>
			  </div>
		  </div>
      </div>
       <!-- 文章列表 -->
	  <div class="layui-row article-out-box" id="list-box" style="width:95%;background:#FFFFFF;">
	      <%-- <div class="layui-card">
			  <div class="layui-card-header">
			     <a href="${APP_PATH}/sysUser/login.html">layui如何使用分页插件？</a>
			  </div>
			  <div class="layui-card-body">
				    卡片式面板面板通常用于非白色背景色的主体内
				    从而映衬出边框投影  卡片式面板面板通常用于非白色背景色的主体内
				    从而映衬出边框投影  卡片式面板面板通常用于非白色背景色的主体内
				    从而映衬出边框投影  卡片式面板面板通常用于非白色背景色的主体内
			  </div>
			  <div class="details-box">
			     <span><span class="iconfont layui-icon-extendyonghu"></span>：李孝利</span>
			     <span><span class="iconfont layui-icon-extendpinglun2"></span>：254</span>
			     <span><span class="iconfont layui-icon-extendshijian"></span>：2019-10-11</span>
			     <span><span class="iconfont layui-icon-extendliulan3"></span>：12</span>
			  </div>
		  </div> --%>
		
	  </div>
	   <!-- 分页插件 -->
		<div id="article-page" style="margin:15px;"></div>
    </div>
    <div class="layui-col-xs3 layui-col-sm3 layui-col-md3">
                 你的内容 3/12
    </div>
</div> 
</div> 
    

<!--底部信息 -->
<jsp:include page="../home/common/footer.jsp"></jsp:include>	  
<script src="${APP_PATH}/js/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/layui-v2.4.5/layui/layui.js"></script>
<script type="text/javascript">
    // 菜单选中后背景色
    $(function(){
    	var currentPage =1;
    	var size =10;
    	var counts = 0;
    	var param={
    		page:currentPage,
    		limit:size
    	};
    	initData(param);
    });	
 
    function initData(param){
  	  $.ajax({
  	    	 url:"${APP_PATH}/article/getPage",
  	    	 data:JSON.stringify(param),
  	    	 type:"POST",
  	    	 dataType : "json",
  	 		 contentType:"application/json;UTF-8",
  	    	 success:function(res){
  	    		 counts = res.data.total;
  	    		 console.log(res.data.total)
  	    		 buildDataPage(res.data);
  	    	 }
  	      });
    }  
     
	//注意：导航 依赖 element 模块，否则无法进行功能性操作
	layui.use(['element','carousel','laypage'], function(){
	var element = layui.element,
	    carousel = layui.carousel,
	    laypage =layui.laypage;
	
	 //建造实例
	  carousel.render({
	    elem: '#test1'
	    ,width: '93%'//设置容器宽度
	    ,height:'176px'
	   // ,arrow: 'always' //始终显示箭头
	    //,anim: 'updown' //切换动画方式
	  });
	 
	 // 文章分页
	//执行一个laypage实例
	  laypage.render({
	    elem: 'article-page' //注意，这里的 test1 是 ID，不用加 # 号
	    ,count: counts //数据总数，从服务端得到
	    ,jump: function(obj, first){
	        //obj包含了当前分页的所有参数，比如：
	        console.log("当前页"+obj.curr); //得到当前页，以便向服务端请求对应页的数据。
	        console.log("条数"+obj.limit); //得到每页显示的条数
	        var param={
	        		page:obj.curr,
	        		limit:obj.limit
	        	};
	        initData(param);
	        if(!first){
	          //do something
	        	
	          //搜索方法可以放这里
	          
	          
	        }
	      }
	  });  
	 
	});
	
    
  
  // 解析返回的分页数据
  function buildDataPage(data){
	  var content = "";
	  console.log(data,6666)
	  var articleList = data.records;
	  articleList.forEach(function(item){
		  if(item.articleCommentCount==null){
			  item.articleCommentCount = 0; 
		  }
		  if(item.articleViews ==null){
			  item.articleViews = 0;
		  }
	  });
	  $.each(articleList,function(index,item){
		  content +="<div class='layui-card'><div class='layui-card-header'><a href='${APP_PATH}/article/details?id="+item.articleId+"' onclick='goArticleInfo("+item.articleId+")'>"
		  +item.articleTitle+"</a></div><div class='details-box'><span><span class='iconfont layui-icon-extendyonghu'></span>："
		  +item.createPerson+"</span><span style='margin-right:13px;'><span class='iconfont layui-icon-extendpinglun2'></span>："
		  +item.articleCommentCount+"</span><span style='margin-right:13px;'><span class='iconfont layui-icon-extendshijian'></span>"
		  +item.createTime+"</span><span><span class='iconfont layui-icon-extendliulan3'></span>："
		  +item.articleViews+"</span></div></div>";
	  });
	  
	 $("#list-box").html(content);
	  
  }
  
 
    
</script>
<style>
.icon {
  width: 1em;
  height: 1em;
  vertical-align: -0.15em;
  fill: currentColor;
  overflow: hidden;
}
</style>
</body>
</html>