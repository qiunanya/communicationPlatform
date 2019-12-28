<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>角色管理</title>
<%
 pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<link rel="stylesheet" href="${APP_PATH}/layui-v2.4.5/layui/css/layui.css">
<link rel="stylesheet" href="${APP_PATH}/ztree/zTreeStyle.css">
<link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
<style type="text/css">
	.tree li {
	        list-style-type: none;
			cursor:pointer;
		}
  .layui-input{
    width:263px;
    display:inline;
    float:left;
  }
</style>
</head>
<body>
    <!--编辑角色弹窗-->
    <div style="display: none;" id="editRoleArea" class="change-pas-box">
		    <form class="layui-form" id="fromChangeArea" action="">
               <input type="hidden" name="id" id="rid">
		        <div class="layui-form-item">
		            <label class="layui-form-label" style="margin-top:15px;">角色名称:</label>
		            <div class="layui-input-block">
		                <input type="text" name="name" id="roleName" class="layui-input" style="margin-top:15px;">
		            </div>
		        </div>
		    </form>
	</div>
	<!--添加角色弹窗-->
    <div style="display: none;" id="addRoleArea" class="change-pas-box">
	    <form class="layui-form" id="addForm" action="">
	        <div class="layui-form-item">
	            <label class="layui-form-label" style="margin-top:15px;">角色名称:</label>
	            <div class="layui-input-block">
	                <input type="text" name="name" id="addRoleName" class="layui-input" style="margin-top:15px;">
	            </div>
	        </div>
	    </form>
	</div>
	
<!--给角色赋权弹窗-->
    <div style="display: none;" id="addPermissionToRoleArea" class="change-pas-box">
	    <form class="layui-form" id="addForm" action="">
	       <!--  <div id="permissionTree" style="margin-left:100px;"></div> -->
	        <ul id="permissionTree" class="ztree"></ul>
	    </form>
	</div>	
	
 <!-- 搜索用户 -->		
  <div class="layui-container" style="margin:10px 0 -10px 0;">
     <div class="layui-form-item">
	    <label class="layui-form-label">查询：</label>
	    <div class="layui-input-block">
	      <input type="text" name="username" id="search_user" required  lay-verify="required" placeholder="文章名称、创建人、浏览次数" autocomplete="off" class="layui-input">
	      <button class="layui-btn" lay-submit="" id="searchBtn" data-type="getInfo" style="float: left;">搜索</button>
	    </div>
   </div>
 </div>
   
  
    <!-- layui表格 -->
 <table class="layui-table" id="demo" lay-filter="test"></table>
  
 <!--自定义表格头部工具栏-->
 <script type="text/html" id="toolbarDemo">
	<div class="layui-btn-container">
	   <button class="layui-btn layui-btn-danger layui-btn-sm" lay-event="batchDelete">
            <i class="layui-icon layui-icon-delete"></i>批量删除</button>
	</div>
 </script>

 <!-- 自定义表格行监听工具-->
 <script type="text/html" id="barDemo">
     <a class="layui-btn layui-btn-info layui-btn-xs" lay-event="detail">详情</a>
     <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i class="layui-icon layui-icon-delete"></i>删除</a>
 </script>
 
 <!--自定义角色状态显示-->
 <script type="text/html" id="barStatus">
    {{#  if(d.status == 1){ }}
       <a class="layui-btn layui-btn-success layui-btn-xs">正常</a>
    {{#  } }}
    {{#  if(d.status == 0){ }}
       <a class="layui-btn layui-btn-danger layui-btn-xs" >失效</a>
    {{#  } }}
 </script>

<script src="${APP_PATH}/js/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/layui-v2.4.5/layui/layui.js"></script>
<script src="${APP_PATH}/ztree/jquery.ztree.all-3.5.min.js"></script>
<script type="text/javascript">
        // layui表格组件加载	 
        layui.use(['layer','table','util','tree'], function () {
            var layer = layui.layer,
                table = layui.table,
                util = layui.util,
                tree = layui.tree;
         
         //第一个实例
        var tableObj = table.render({
                elem: '#demo'
                , id:'userTableDatas'
                , height: 650
                , url: '${APP_PATH}/article/getArticleList' //数据接口
                , method: 'get'
                , title: '角色表'
                , page:true//开启分页
                , toolbar: '#toolbarDemo' //开启工具栏，此处显示默认图标，可以自定义模板，详见文档
                ,defaultToolbar: ['filter', 'print', 'exports']
                , cols: [[ //表头
                    {type: 'checkbox', fixed: 'left'}
                    , { field: 'articleTitle', title: '文章名称'} 
                    , { field: 'createPerson', title: '创建人'}
                    , { field: 'articleViews', title: '浏览次数'}
                    , { field: 'status', title: '状态',templet:'#barStatus' }
                    , { field: 'createTime', title: '创建时间',width: 185,sort:true,templet:function(d){return util.toDateString(d.createTime, "yyyy-MM-dd HH:mm:ss");}}
                    , { fixed: 'right',title:'操作', width: 145, align: 'center', toolbar: '#barDemo' }
                ]]
               , text: {
               	//自定义一些文本提示
                   none: '暂无相关数据' //默认：无数据。注：该属性为 layui 2.2.5 开始新增
               }
               , skin: 'row'
               , size: 'lg'
               , even: true
               ,initSort: {
            	    field: 'createTime' //排序字段，对应 cols 设定的各字段名
            	    ,type: 'desc' //排序方式  asc: 升序、desc: 降序、null: 默认排序
            	      }
            });
         
			 // 执行搜索，表格重载
			    $('#searchBtn').on('click', function () {
			    	 // 搜索条件
			        var send_name = $('#search_user').val();
			    	 var send_Name=$.trim(send_name);
			    	if(send_Name == null || send_Name == ""){
			    		layer.msg("搜索参数不能为空");
			    	}else{
			    		table.reload('userTableDatas', {
				            method: 'POST'
				            , where: {
				                'search': send_Name,
				            }
				            , page: {
				                curr: 1
				            },
				            limit:10
				        });
			    	}
			       
			    });

             //监听头工具栏事件
            table.on('toolbar(test)', function (obj) {
                var checkStatus = table.checkStatus(obj.config.id)
                    , data = checkStatus.data; //获取选中的数据
                switch (obj.event) {
                    case 'addRole':
                    	addRole();
                        break;
                    case 'update':
                        if (data.length === 0) {
                            layer.msg('请选择一行');
                        } else if (data.length > 1) {
                            layer.msg('只能同时编辑一个');
                        } else {
                            layer.alert('编辑 [id]：' + checkStatus.data[0].id);
                        }
                        break;
                    case 'batchDelete':
                        if (data.length === 0) {
                            layer.msg('请选择一行');
                        } else {
                        	layer.confirm('确定永久删除吗? 是否继续',{icon: 3, title:'提示'}, function (index) {
                                layer.close(index);
                                // 发起批量删除请求
                                batchRemoveRole(data);
                       	 });
                        }
                        break;
                };
            });
             
             // 批量删除角色
            function batchRemoveRole(roleList){
            	// 提交表单
                 var loadingIndex = null;
			    	$.ajax({
			    		type : "POST",
			    		url  : "${APP_PATH}/role/batchRemoveRoles",
			    		data : JSON.stringify(roleList),
			    		dataType : "json",
			    		contentType:"application/json;UTF-8",
			    		beforeSend : function() {
			    			loadingIndex = layer.msg('处理中', {icon: 16,shade:0.3});
			    		},
			    		success : function(result) {
			    			layer.close(loadingIndex);
			    			if ( result.success ) {
			    				 layer.msg(result.msg, {time:2000, icon:6, shift:6}, function(){
			    					 location.reload();
			    					 layer.close(index); 
			                       });
			    			}else{
		                       layer.msg(result.msg, {time:2000, icon:5, shift:6}, function(){
		                    	   layer.close(index); //如果设定了yes回调，需进行手工关闭
		                       });
			    			}
			    		}
			    	});
             }
             
             // 添加角色
             function addRole(){
            	 layer.open({
                     type:1,
                     area:['500px', '300px']
                     ,title: '添加角色'
                     ,content: $("#addRoleArea")
                     ,btn: ['提交', '取消']
                     ,yes: function(index, layero){
                    	
                    	 // 校验名称合法性
                         var name = $("#addRoleName").val();
                   	     var nm = $.trim(name);
                    	 if(nm=='' || nm ==null){
                          	layer.msg("角色名称不能为空", {time:1000, icon:5}, function(){
		                       });
                             return false;
                          }
                          if(nm.length<1 || nm.length >20){
                        	  layer.msg("角色名称字符在1-20之间",{time:1000,icon:5},function(){
                        	  });
                        	  return false;
                          }
                          
                          // 提交表单
                          var loadingIndex = null;
                          var role = {};
                         	 role.name =nm;
					    	$.ajax({
					    		type : "POST",
					    		url  : "${APP_PATH}/role/add",
					    		data : JSON.stringify(role),
					    		dataType : "json",
					    		contentType:"application/json;UTF-8",
					    		beforeSend : function() {
					    			loadingIndex = layer.msg('处理中', {icon: 16,shade:0.3});
					    		},
					    		success : function(result) {
					    			layer.close(loadingIndex);
					    			if ( result.success ) {
					    				 layer.msg("操作成功", {time:2000, icon:6, shift:6}, function(){
					    					 layer.close(index); 
					    					 location.reload();	
					                       });
					    			}else{
				                       layer.msg("操作失败", {time:2000, icon:5, shift:6}, function(){
				                    	   layer.close(index); //如果设定了yes回调，需进行手工关闭
				                            $("#addRoleArea").css({"display":"none"});
				                       });
					    			}
					    		}
					    	});
                    	 }
            	     ,btn2:function(index, layero){
            	    	 $("#addRoleArea").css({"display":"none"});
            	     }
           	         ,cancel: function(layero,index){ 
                         layer.closeAll();
                         location.reload();
                        }
            	     
                     });
             }

            //监听行工具事件
            table.on('tool(test)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
                var data = obj.data //获得当前行数据
                    , layEvent = obj.event; //获得 lay-event 对应的值
                if (layEvent === 'detail') {
                    layer.msg('查看操作');
                    
                }else if(layEvent === 'permission'){
                    
                   window.location.href="${APP_PATH}/role/goPermissionPage?roleid="+data.id;
                   /* layer.open({
                        type:1,
                        area:['500px', '400px']
                        ,title: '角色赋权'
                        ,content: $("#addPermissionToRoleArea")
                        ,btn: ['提交', '取消']
                        ,yes: function(index, layero){
                        	//获取当前节点
                        	var treeObj = $.fn.zTree.getZTreeObj("permissionTree");
                        	//获取已选中的节点
                        	var nodes = treeObj.getCheckedNodes(true);
                        	
                            if(nodes.length<=0){
                            	 layer.msg("请至少选择一个需要分配的权限信息", {time:2000, icon:5, shift:6,shade:0.3}, function(){
				                       });
                            	return false;
                            }else{
                            	var loadingIndex = null;
                            	// 自定义拼串
                            	var d = "roleid="+data.id;
                            	$.each(nodes,function(i,item){
                            		d += "&permissionids="+item.id;
                            	});
                            	
                            	$.ajax({
       					    		type : "POST",
       					    		url  : "${APP_PATH}/role/doAssignPermission",
       					    		data : d,
       					    		beforeSend : function() {
       					    			loadingIndex = layer.msg('处理中', {icon: 16,shade:0.3});
       					    		},
       					    		success : function(result) {
       					    			layer.close(loadingIndex);
       					    			if ( result.success ) {
       					    				 layer.msg("分配角色权限成功", {time:2000, icon:6, shift:6}, function(){
       					    					 layer.close(index); 
       					    					 location.reload();	
       					                       });
       					    			}else{
       				                       layer.msg("分配角色权限失败", {time:2000, icon:5, shift:6}, function(){
       				                    	   layer.close(index); //如果设定了yes回调，需进行手工关闭
       				                            $("#addPermissionToRoleArea").css({"display":"none"});
       				                       });
       					    			}
       					    		}
       					    	});
                            }
                        
                       	 }
               	     ,btn2:function(index, layero){
               	    	
               	    	 $("#addPermissionToRoleArea").css({"display":"none"});
               	     }
          	         ,cancel: function(layero,index){ 
                        layer.closeAll();
                        //location.reload();
                        $("#addPermissionToRoleArea").css({"display":"none"});
                       }
           	     
                    }); */
                	
                }else if (layEvent === 'del') {
                    layer.confirm('确定永久删除【'+data.id+'】用户吗? 是否继续',{icon: 3, title:'提示'}, function (index) {
                        obj.del(); //删除对应行（tr）的DOM结构
                        layer.close(index);
                        //向服务端发送删除指令
                        $.ajax({
             			   type:"post",
                 		   url:"${APP_PATH}/article/deleteById",
                 		   data:{id:data.id},
                 		   async:false,
                 		   dataType:"json",
                 		   beforeSend : function() {
                 			 var ii = layer.load();
                 			//此处用setTimeout演示ajax的回调
          	    		    setTimeout(function(){
          	    		      layer.close(ii);
          	    		    }, 2000);
  			    		   },
                 		   success:function(result){
                 		     if(result.success){
                 		    	layer.msg(result.msg,{time:2000,icon:6});
                 		     }else{
                 		    	layer.msg(result.msg,{time:2000,icon:5});
                 		     }	  
                             },
                 		   error:function(result){
                 			  layer.msg('处理异常，请联系管理员',{time:2000,icon:5});
                 		   }
             		   });
                    });
                } else if (layEvent === 'edit') {
                	$("#rid").attr("value",data.id);
                	$("#roleName").attr("value",data.name);
                    layer.open({
                        type:1,
                        area:['500px', '300px']
                        ,title: '修改角色'
                        ,content: $("#editRoleArea")
                        ,btn: ['提交', '取消']
                        ,yes: function(index, layero){
                            //do something  
                            // 校验数据
                            var name = $("#roleName").val();
                            var nm = $.trim(name);
                            if(nm=='' || nm ==null){
                            	layer.msg("角色名称不能为空", {time:1000, icon:5}, function(){
 		                       });
                               return false;
                            }
                            if(nm.length <1 || nm.length > 20){
                            	layer.msg("角色名称字符长度在1-20", {time:1000, icon:5}, function(){
  		                       });
                           	   return false;
                            }
                            // ajax提交表单
                            var loadingIndex = null;
                            var role = {};
                             role.id =$("#rid").val();
                           	 role.name =$("#roleName").val();
					    	$.ajax({
					    		type : "POST",
					    		url  : "${APP_PATH}/role/update",
					    		data : JSON.stringify(role),
					    		dataType : "json",
					    		contentType:"application/json;UTF-8",
					    		beforeSend : function() {
					    			loadingIndex = layer.msg('处理中', {icon: 16,shade:0.3});
					    		},
					    		success : function(result) {
					    			layer.close(loadingIndex);
					    			if ( result.success ) {
					    				 layer.msg("操作成功", {time:2000, icon:6, shift:6}, function(){
					    					 layer.close(index); 
					    					 location.reload();	
					                       });
					    			}else{
				                       layer.msg("操作失败", {time:2000, icon:5, shift:6}, function(){
				                    	   layer.close(index); //如果设定了yes回调，需进行手工关闭
				                            $("#editRoleArea").css({"display":"none"});
				                       });
					    			}
					    		}
					    	});
                          }
                        ,btn2: function(index, layero){
                        	    //按钮【按钮二】的回调
                        	   // layer.msg("点击了取消按钮");
                        	    $("#editRoleArea").css({"display":"none"});
                        	    //return false 开启该代码可禁止点击该按钮关闭
                        	  }
                         ,cancel: function(layero,index){ 
                          layer.closeAll();
                          location.reload();
                         }
                       
                    });
                }
            });
  
           
        });	  
       
 </script>
</body>
</html>