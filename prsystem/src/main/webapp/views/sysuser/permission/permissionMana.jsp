<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>权限管理</title>
<%
 pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<link rel="stylesheet" href="${APP_PATH}/layui-v2.4.5/layui/css/layui.css">
<link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
<link rel="stylesheet" href="${APP_PATH}/bootstrap-3.3.7/css/bootstrap.min.css">

   <style type="text/css">
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	table tbody tr:nth-child(odd){background:#F4F4F4;}
	table tbody td:nth-child(even){color:#C00;}
	 a:hover{
     text-decoration:none;
  }
   .layui-input{
    width:263px;
    display:inline;
  }
  .layui-form-select .layui-edge{
         position: absolute;
	     right: 5px;
	     top: 19px;
  }
  a:hover{
     text-decoration:none;
  }
  .hide {
         display: none;
     }
     
  .layui-iconpicker-item{
    width:263px !important;
    margin-left: 108px;
  }   
  .layui-iconpicker-icon{
     width: 177px !important;
  }  
  .layui-iconpicker-item > .layui-edge{
     margin-left: 143px;
  } 
  .layui-anim-upbit{
    margin-left: 102px;
  }
	</style>
</head>
<body>
 <div class="container">
    <div class="row">
        <div class="col-md-12">
            <h3>菜单树 </h3>
        </div>
        <div class="col-md-12">
	       <div class="change-pas-box">
             <div class="panel panel-default">
				  <div class="panel-body">
					   <div id="permissionTree" ></div>
				  </div>
			 </div>
           </div>
	    </div>
    </div>
 </div>
 
 <!--添加菜单弹窗-->
	<div style="display: none;" id="addPermissionArea" class="change-pas-box">
	    <form class="layui-form" id="addPermissionForm" action="">
	        <div class="layui-form-item">
	            <label class="layui-form-label" style="margin-top:15px;width:90px;">菜单名称:</label>
	            <div class="layui-input-block">
	                <input type="text" name="title" id="addTitle" class="layui-input" style="margin-top:15px;">
	            </div>
	        </div>
	        <div class="layui-form-item">
	            <label class="layui-form-label">路径:</label>
	            <div class="layui-input-block">
	                <input type="text" name="url" id="addUrl" placeholder="例如：user/index" class="layui-input">
	            </div>
	        </div>
	       
	        <div class="layui-form-item">
	             <label class="layui-form-label" >图标:</label>
	             <input type="text" id="iconPicker" lay-filter="iconPicker" style="margin-left:256px;">
	             <!-- <div class="layui-input-block" style="width:263px;">
			        <select name="icon" lay-search id="addIcon">
					  <option value="0" selected>普通用户</option>
					  <option value="1" >系统管理员<i class='layui-icon layui-icon-face-smile'/></option>
					</select> 
			    </div> -->
	        </div>
	        <div class="layui-form-item">
	             <label class="layui-form-label">状态:</label>
	             <div class="layui-input-block">
			      <input type="radio" name="status" value="1" title="启用" checked>
			      <input type="radio" name="status" value="0" title="禁用" >
			    </div>
	        </div>
	    </form>
	</div>

<script src="${APP_PATH}/js/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/js/iconData.js"></script>
<script src="${APP_PATH}/layui-v2.4.5/layui/layui.js"></script>
<script src="${APP_PATH}/script/docs.min.js"></script>
<script src="${APP_PATH}/bootstrap-3.3.7/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/module/common.js"></script>
<script type="text/javascript">
       var treeData=[];
        $(function(){
        	
 		    // 加载数据源
 		    $.ajax({
 		    		type : "POST",
 		    		url  : "${APP_PATH}/permission/loadTreeData",
 		    		dataType : "json",
  		            contentType:"application/json;UTF-8",
  		            async:false,
 		    		success : function(result) {
 		    			if ( result.success) {
 		    				treeData = result.data;
 		    			}
 		    		}
 		      });
 		    
 		   // 初始化layui组件
 		     layui.use(['iconPicker','form','tree','layer'], function(){
 			    var tree = layui.tree,
 			       layer = layui.layer,
 			        form = layui.form,
 			       iconPicker = layui.iconPicker;
 			    // 加载图标组件
 			    iconPicker.render({
 	                // 选择器，推荐使用input
 	                elem: '#iconPicker',
 	                // 数据类型：fontClass/unicode，推荐使用fontClass
 	                type: 'fontClass',
 	                // 是否开启搜索：true/false
 	                search: true,
 	                // 是否开启分页：true/false，默认true
 	                page: true,
 	                // 每页显示数量，默认12
 	                limit: 12,
 	                // 点击回调
 	                click: function (data) {
 	                    console.log(data);
 	                }
 	            });

 	            /**
 	             * 选中图标 （常用于更新时默认选中图标）
 	             * @param filter lay-filter
 	             * @param iconName 图标名称，自动识别fontClass/unicode
 	             */
 	            iconPicker.checkIcon('iconPicker', 'layui-icon-star-fill');
 			 
 			    //渲染
 			    var inst1 = tree.render({
 			      elem: '#permissionTree'  //绑定元素
 			      ,data:treeData
 			      ,edit: ['add', 'update', 'del']
 			      ,operate: function(obj){
 			    	    var type = obj.type; //得到操作类型：add、edit、del
 			    	    var data = obj.data; //得到当前节点的数据
 			    	    
 			    	    //Ajax 操作
 			    	    var id = data.id; //得到节点索引
 			    	    if(type === 'add'){ 
 			    	    	layer.open({
 		                        type:1,
 		                        area:['500px', '420px'],
 		                        title: '添加菜单信息',
 		                        content: $("#addPermissionArea"),
 		                        btn: ['提交', '取消'],
 		                        yes: function(index, layero){
 		                        	 var permission ={};
 	                            	 var title =$.trim($("#addTitle").val());
 	                         	     var url= $.trim($("#addUrl").val());
 	                         	     var icon= $("#iconPicker").val();
 	                         	     var status = parseInt($("input[name='status']:checked").val());
 	                         	     permission.title =title;
 	                         	     permission.url = url;
 	                         	     permission.icon = "layui-icon"+" "+icon;
 	                         	     permission.status = status;
 	                         	     permission.pid = id;
 	                         	     if(title == "" || title ==null){
 	                         	    	layer.msg("菜单名称不能为空", {time:1000, icon:5,shift:6,}, function(){
 	     		                         });
 	                                    return false; 
 	                         	     }
 	                         	     if(title.length<1 || title.length >15){
 	                         	    	layer.msg("菜单名称在1-15个字符内", {time:1000, icon:5,shift:6,}, function(){
 	    		                         });
 	                                   return false;
 	                         	      }
 	                         	      if(url == "" || url ==null){
 	                         	    	layer.msg("菜单路径不能为空", {time:1000, icon:5,shift:6,}, function(){
 	     		                         });
 	                                    return false; 
 	                         	     }
 	                         	     if(title.length<1 || title.length >30){
 	                         	    	layer.msg("菜单路径在1-30个字符内", {time:1000, icon:5,shift:6,}, function(){
 	    		                         });
 	                                   return false;
 	                         	      }
 	                         	  
 		                        	  //添加菜单（权限）
 		                        	var loadingIndex = null;
 		        			    	$.ajax({
 		        			    		type : "POST",
 		        			    		url  : "${APP_PATH}/permission/add",
 		        			    		data : JSON.stringify(permission),
 		        			    		dataType : "json",
 							    		contentType:"application/json;UTF-8",
 		        			    		beforeSend : function() {
 		        			    			loadingIndex = layer.msg('处理中', {icon: 16});
 		        			    		},
 		        			    		success : function(result) {
 		        			    			layer.close(loadingIndex);
 		        			    			if ( result.success) {
 		        		                       layer.msg(result.msg, {time:1000, icon:6}, function(){
 		        		                    	     layer.close(index); 
 							    					 location.reload();	
 		        		                       });
 		        			    			} else {
 		        		                       layer.msg(result.msg, {time:2000, icon:5, shift:6}, function(){
 		        		                    	  // $("#addPermissionArea").css({"display":"none"});  
 		        		                       });
 		        			    			}
 		        			    		}
 		        			    	});
 		                        	}
 		                        ,btn2:function(index,layero){
 		                           $("#addPermissionArea").css({"display":"none"});
 		                           location.reload();
 		                        }
 		                        ,cancel: function(layero,index){ 
 		                        	 layer.closeAll();
 		                             $("#addPermissionArea").css({"display":"none"});
 		                             location.reload();
 		                           }
 		                        });
 			    	    } else if(type === 'update'){
                        	    var permission ={};
                        	     permission.id = data.id;
                        	     permission.title =data.title;
                        	     permission.url = data.url;
                        	     permission.icon = data.icon;
                        	     permission.status = data.status;
                        	     permission.pid = data.pid;
	                        	  //添加菜单（权限）
 		                        	var loadingIndex = null;
 		        			    	$.ajax({
 		        			    		type : "POST",
 		        			    		url  : "${APP_PATH}/permission/update",
 		        			    		data : JSON.stringify(permission),
 		        			    		dataType : "json",
 							    		contentType:"application/json;UTF-8",
 		        			    		beforeSend : function() {
 		        			    			loadingIndex = layer.msg('处理中', {icon: 16});
 		        			    		},
 		        			    		success : function(result) {
 		        			    			layer.close(loadingIndex);
 		        			    			if ( result.success) {
 		        		                       layer.msg(result.msg, {time:1000, icon:6}, function(){
 		        		                    	     layer.close(loadingIndex); 
 							    					 location.reload();	
 		        		                       });
 		        			    			} else {
 		        		                       layer.msg(result.msg, {time:2000, icon:5, shift:6}, function(){
 		        		                    	  // $("#addPermissionArea").css({"display":"none"});  
 		        		                       });
 		        			    			}
 		        			    		}
 		        			    	});
 		                     
 			    	    	
 			    	    } else if(type === 'del'){ //删除节点
 		                        //向服务端发送删除指令
 		                        $.ajax({
 		             			   type:"post",
 		                 		   url:"${APP_PATH}/permission/deleteById/"+id,
 		                 		   async:false,
 		                 		   dataType:"json",
 		                 		   success:function(result){
 		                 		     if(result.success){
 		                 		    	layer.msg(result.msg, {time:1000, icon:6}, function(){
					    					 location.reload();	
        		                       });
 		                 		     }else{
 		                 		    	layer.msg(result.msg, {time:2000, icon:5, shift:6}, function(){
 		                 		    		  location.reload();
	        		                       });
 		                 		    	
 		                 		     }	  
 		                 		   },
 		                 		   error:function(result){
 		                 			  layer.msg('处理异常，请联系管理员',{time:2000,icon:5});
 		                 		   }
 		             		   });
 			    	    };
 			    	  }
 			    
 			      
 			    });
 		     });
 		    
 		    
 		    
        });
        
	 
   
</script>
</body>
</html>