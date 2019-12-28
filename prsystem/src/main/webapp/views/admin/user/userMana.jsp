<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>
<%
 pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<link rel="stylesheet" href="${APP_PATH}/layui-v2.4.5/layui/css/layui.css">
<style type="text/css">
  .layui-input{
    width:263px;
    display:inline;
    float:left;
  }
</style>
</head>
<body>
    <div class="layui-container" style="margin:10px 0 -10px 0;">
         <div class="layui-form-item">
		    <label class="layui-form-label">用户名：</label>
		    <div class="layui-input-block">
		      <input type="text" name="username" id="search_user" required  lay-verify="required" placeholder="用户ID、用户姓名、手机号" autocomplete="off" class="layui-input">
		      <button class="layui-btn" lay-submit="" id="searchBtn" data-type="getInfo" style="float: left;">搜索</button>
		    </div>
		 </div>
   </div>
    

        <!-- layui表格 -->
	    <table class="layui-table" id="demo" lay-filter="test"></table>
	
	    <!-- 表格事件绑定,可以放到页面任意位置 -->
	    <script type="text/html" id="barDemo">
            <a class="layui-btn layui-btn-xs" lay-event="detail">查看</a>
            <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
            <a class="layui-btn layui-btn-xs" lay-event="mifypassword">初始化密码</a>
            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
            
        </script>
        <script type="text/html" id="barStatus">
        {{#  if(d.status == 1){ }}
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="open">启用</a>
        {{#  } }}
        {{#  if(d.status == 0){ }}
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="forbidden">禁用</a>
        {{#  } }}
    </script>

<script src="${APP_PATH}/js/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/layui-v2.4.5/layui/layui.all.js"></script>
<script language="javascript">
		 //Demo
        layui.use(['layer','table'], function () {
            var layer = layui.layer,
                table = layui.table,
                util = layui.util;
         //第一个实例
    var tableObj = table.render({
                elem: '#demo'
                , id:'userTableDatas'
                , height: 700
                , url: '${APP_PATH}/sysUser/getUserData' //数据接口
                , method: 'GET'
                , title: '用户表'
                , page:true//开启分页
                , toolbar: 'default' //开启工具栏，此处显示默认图标，可以自定义模板，详见文档
                /* , totalRow: true  */
                , cols: [[ //表头
                    {type: 'checkbox', fixed: 'left'}
                    ,{ field: 'userid', title: '#ID', width:120, sort: false}
                    , { field: 'username', title: '用户姓名'}
                    , { field: 'phone', title: '手机号'}
                    , { field: 'status', title: '状态',templet:'#barStatus' }
                    , { field: 'createTime', title: '创建时间',width: 177,templet:function(d){return util.toDateString(d.createTime, "yyyy-MM-dd HH:mm:ss");}}
                    , { fixed: 'right',title:'操作', width: 260, align: 'center', toolbar: '#barDemo' }
                ]]
               , text: {
               	//自定义一些文本提示
                   none: '暂无相关数据' //默认：无数据。注：该属性为 layui 2.2.5 开始新增
               }
               , skin: 'row'
               , size: 'lg'
               , even: true
               ,initSort: {
            	    field: 'userid' //排序字段，对应 cols 设定的各字段名
            	    ,type: 'asc' //排序方式  asc: 升序、desc: 降序、null: 默认排序
            	      }
               
            });
         
			 // 执行搜索，表格重载
			    $('#searchBtn').on('click', function () {
			    	 // 搜索条件
			        var send_name = $('#search_user').val();
			    	 var send_Name=$.trim(send_name);
			    	if(send_Name == null || send_Name == ""){
			    		layer.msg("用户名不能为空");
			    	}else{
			    		table.reload('userTableDatas', {
				            method: 'GET'
				            , where: {
				                'send_name': send_Name,
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
                    case 'add':
                        layer.msg('添加');
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
                    case 'delete':
                        if (data.length === 0) {
                            layer.msg('请选择一行');
                        } else {
                            layer.msg('删除');
                        }
                        break;
                };
            });

            //监听行工具事件
            table.on('tool(test)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
                var data = obj.data //获得当前行数据
                    , layEvent = obj.event; //获得 lay-event 对应的值
                if (layEvent === 'detail') {
                    layer.msg('查看操作');
                    
                }else if(layEvent === 'mifypassword'){
                	layer.confirm('确定初始化【'+data.username+'】用户的密码? 是否继续',{icon: 3, title:'提示'}, function (index) {
                    	var loadingIndex = null;
    			    	$.ajax({
    			    		type : "POST",
    			    		url  : "${APP_PATH}/sysUser/initUserPassword",
    			    		data :{id : data.userid},
    			    		beforeSend : function() {
    			    			loadingIndex = layer.msg('处理中', {icon: 16});
    			    		},
    			    		success : function(result) {
    			    			layer.close(loadingIndex);
    			    			if ( result.success) {
    			    				tableObj.reload();
    		                       layer.msg("密码初始化成功", {time:1000, icon:6}, function(){
    		                       	
    		                       });
    			    			} else {
    		                       layer.msg("操作失败", {time:2000, icon:5, shift:6}, function(){
    		                       	
    		                       });
    			    			}
    			    		}
    			    	});
                    	});
                	
                	
                }else if (layEvent === 'del') {
                	
                    layer.confirm('确定永久删除【'+data.username+'】用户吗? 是否继续',{icon: 3, title:'提示'}, function (index) {
                        
                        layer.close(index);
                        //向服务端发送删除指令
                        $.ajax({
             			   type:"post",
                 		   url:"${APP_PATH}/sysUser/deleteById",
                 		   data:{id:data.userid},
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
                 		    	obj.del(); //删除对应行（tr）的DOM结构
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
                    layer.msg('编辑操作');
                }else if(layEvent === 'open'){
                	layer.confirm('确定要激活【'+data.username+'】用户吗? 是否继续',{icon: 3, title:'提示'}, function (index) {
                	var loadingIndex = null;
			    	$.ajax({
			    		type : "POST",
			    		url  : "${APP_PATH}/sysUser/activeUser",
			    		data :{id : data.userid},
			    		beforeSend : function() {
			    			loadingIndex = layer.msg('处理中', {icon: 16});
			    		},
			    		success : function(result) {
			    			layer.close(loadingIndex);
			    			if ( result.success) {
			    				tableObj.reload();
		                       layer.msg("操作成功", {time:1000, icon:6}, function(){
		                       	
		                       });
			    			} else {
		                       layer.msg("操作失败", {time:2000, icon:5, shift:6}, function(){
		                       	
		                       });
			    			}
			    		}
			    	});
                	});
                }else if(layEvent === 'forbidden'){
                	layer.confirm('确定要禁用【'+data.username+'】用户吗? 是否继续',{icon: 3, title:'提示'}, function (index) {
                    	var loadingIndex = null;
    			    	$.ajax({
    			    		type : "POST",
    			    		url  : "${APP_PATH}/sysUser/forbiddenUser",
    			    		data : {id : data.userid},
    			    		beforeSend : function() {
    			    			loadingIndex = layer.msg('处理中', {icon: 16});
    			    		},
    			    		success : function(result) {
    			    			layer.close(loadingIndex);
    			    			if ( result.success) {
    			    				tableObj.reload();
    		                       layer.msg("操作成功", {time:1000, icon:6}, function(){
    		                       	
    		                       });
    			    			} else {
    		                       layer.msg("操作失败", {time:2000, icon:5, shift:6}, function(){
    		                       	
    		                       });
    			    			}
    			    		}
    			    	});
                    	});
                }
            });
           
            
           
        });	 
		 
		 
       
       </script>
</body>
</html>