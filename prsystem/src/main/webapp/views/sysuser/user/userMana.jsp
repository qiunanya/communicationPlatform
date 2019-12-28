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
<link rel="stylesheet" href="${APP_PATH}/bootstrap-3.3.7/css/bootstrap.min.css">
<style type="text/css">
  .layui-input{
    width:263px;
    display:inline;
    float:left;
  }
  .layui-form-select .layui-edge{
         position: absolute;
	     right: 5px;
	     top: 19px;
  }
  a:hover{
     text-decoration:none;
  }
</style>
</head>
<body>
    <!--自定义用户分配角色弹窗  -->
     <div style="display: none;" id="assignRoleToUser" class="change-pas-box">
          <div class="panel panel-default">
			  <div class="panel-body">
				<form id="roleForm" role="form" class="form-inline">
				  <input type="hidden" name="userid" value="" id="userId"/>
				  <div class="form-group">
					<label for="exampleInputPassword1">未分配角色列表</label><br>
					<select id="leftRoleOption" name="unAssignRoleIds" class="form-control" multiple size="10" style="width:200px;height:200px;overflow-y:auto;" >
                       
                       <!-- <option value="tl">TL</option>
                        <option value="gl">GL</option>
                        <option value="qa">QA</option>
                        <option value="pm">PM</option> -->
                    </select>
				  </div>
				  <div class="form-group">
                        <ul>
                            <li id="leftToRightBtn" class="btn btn-default glyphicon glyphicon-chevron-right"></li>
                            <br>
                            <li id="rightToLeftBtn" class="btn btn-default glyphicon glyphicon-chevron-left" style="margin-top:20px;"></li>
                        </ul>
				  </div>
				  <div class="form-group">
					<label for="exampleInputPassword1">已分配角色列表</label><br>
					<select id="rightRoleOption" name="assignRoleIds" class="form-control" multiple size="10" style="width:200px;height:200px;overflow-y:auto;" >
                       <!--  <option value="qc">QC</option>
                        <option value="pg">PG</option>
                        <option value="sa">SA</option> -->
                    </select>
				  </div>
				</form>
			  </div>
			</div>
     </div>
     
    <!--编辑用户弹窗-->
    <div style="display: none;" id="editUserArea" class="change-pas-box">
	    <form class="layui-form" id="editUserForm" action="">
              <input type="hidden" name="userid" id="uid">
	        <div class="layui-form-item">
	            <label class="layui-form-label" style="margin-top:15px;width:90px;">用户名称:</label>
	            <div class="layui-input-block">
	                <input type="text" name="username" id="editUserName" class="layui-input" style="margin-top:15px;">
	            </div>
	        </div>
	        <div class="layui-form-item">
	            <label class="layui-form-label">手机号:</label>
	            <div class="layui-input-block">
	                <input type="text" name="phone" id="editPhone" class="layui-input">
	            </div>
	        </div>
	        
	        <div class="layui-form-item">
	             <label class="layui-form-label" style="width:90px;">用户身份:</label>
	             <div class="layui-input-block" style="width:263px;">
			        <select name="type" lay-search id="editUserType">
					  <option value="0" >普通用户</option>
					  <option value="1" >系统管理员</option>
					</select> 
			    </div>
	        </div>
	        
	        <div class="layui-form-item">
	             <label class="layui-form-label">状态:</label>
	             <div class="layui-input-block">
			      <input type="radio" name="status" value="0" title="启用" id="editStatus1">
			      <input type="radio" name="status" value="1" title="禁用" id="editStatus2">
			    </div>
	        </div>
	    </form>
	</div>
	<!--添加用户-->
	<div style="display: none;" id="addUserArea" class="change-pas-box">
	    <form class="layui-form" id="addUserForm" action="">
	        <div class="layui-form-item">
	            <label class="layui-form-label" style="margin-top:15px;width:90px;">用户名称:</label>
	            <div class="layui-input-block">
	                <input type="text" name="username" id="addUserName" class="layui-input" style="margin-top:15px;">
	            </div>
	        </div>
	        <div class="layui-form-item">
	            <label class="layui-form-label">手机号:</label>
	            <div class="layui-input-block">
	                <input type="text" name="phone" id="addPhone" class="layui-input">
	            </div>
	        </div>
	        <div class="layui-form-item">
	            <label class="layui-form-label">密码:</label>
	            <div class="layui-input-block">
	                <input type="password" name="password" id="addPassword" class="layui-input">
	            </div>
	        </div>
	        <div class="layui-form-item">
	             <label class="layui-form-label" style="width:90px;">用户身份:</label>
	             <div class="layui-input-block" style="width:263px;">
			        <select name="type" lay-search id="addUserType">
					  <option value="0" selected>普通用户</option>
					  <option value="1" >系统管理员</option>
					</select> 
			    </div>
	        </div>
	        <div class="layui-form-item">
	             <label class="layui-form-label">状态:</label>
	             <div class="layui-input-block">
			      <input type="radio" name="status" value="0" title="启用" checked>
			      <input type="radio" name="status" value="1" title="禁用" >
			    </div>
	        </div>
	    </form>
	</div>
 
  <div class="layui-container" style="margin:10px 0 -10px 0;">
       <div class="layui-form-item">
    		<!-- <label class="layui-form-label" style="width:90px;">用户名：</label> -->
	    <div class="layui-input-block">
	      <input type="text" name="username" id="search_user" required  lay-verify="required" placeholder="用户姓名、手机号" autocomplete="off" class="layui-input">
	      <button class="layui-btn" lay-submit="" id="searchBtn" data-type="getInfo" style="float: left;">搜索</button>
	    </div>
    </div>
 </div>
    

  <!-- layui表格 -->
<table class="layui-table" id="demo" lay-filter="test"></table>
  <!--自定义表格头部工具栏-->
  <script type="text/html" id="toolbarDemo">
	 <div class="layui-btn-container">
		<button class="layui-btn layui-btn-sm" lay-event="addUser">
            <i class="layui-icon layui-icon-add-1"></i>新增</button>
		<button class="layui-btn layui-btn-danger layui-btn-sm" lay-event="batchDelete">
            <i class="layui-icon layui-icon-delete"></i>批量删除</button>
	 </div>
  </script>
  <!-- 自定义表格行监听工具 -->
  <script type="text/html" id="barDemo">
     <a class="layui-btn layui-btn-xs" lay-event="assignmentRole"><i class="layui-icon layui-icon-auz"></i>权限</a>
     <a class="layui-btn layui-btn-xs" lay-event="edit"><i class="layui-icon layui-icon-edit"></i>编辑</a>
     <a class="layui-btn layui-btn-xs" lay-event="mifypassword"><i class="layui-icon layui-icon-set"></i>初始化密码</a>
     <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i class="layui-icon layui-icon-delete"></i>删除</a>
  </script>
  <!--自定义显示用户状态控制工具-->
  <script type="text/html" id="barStatus">
     {{#  if(d.status == 1){ }}
       <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="open">解除锁定</a>
     {{#  } }}
     {{#  if(d.status == 0){ }}
       <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="forbidden">锁定</a>
     {{#  } }}
  </script>
  <!-- 自定义显示用户状态工具 -->
  <script type="text/html" id="userStatus">
      {{#  if(d.status == 0){ }}
        <a class="layui-btn layui-btn-success layui-btn-xs">正常</a>
      {{#  } }}
      {{#  if(d.status == 1){ }}
        <a class="layui-btn layui-btn-warm layui-btn-xs">已锁定</a>
      {{#  } }}
  </script>
  <!--自定义用户类型 -->
  <script type="text/html" id="userType">
      {{#  if(d.type == 1){ }}
        <a class="layui-btn layui-btn-success layui-btn-xs">管理员</a>
      {{#  } }}
      {{#  if(d.type != 1){ }}
        <a class="layui-btn layui-btn-warm layui-btn-xs">普通用户</a>
      {{#  } }}
  </script>

<script src="${APP_PATH}/js/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/layui-v2.4.5/layui/layui.all.js"></script>
<script src="${APP_PATH}/bootstrap-3.3.7/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/layer/layer.js"></script>
<script language="javascript">
		/* 自定义页面加载完成事件 */
		$(function(){
			  //layer.msg("页面加载完成啦");
			  $("#leftToRightBtn").click(function(){
				  // 获取左边列表选中项
				  var opts = $("#leftRoleOption option:selected");
				  if(opts.length==0){
					  layer.msg("请选择需要分配的角色", {time:2000, icon:5, shift:6}, function(){
	                       });
				  }else{
					// 发起后台交互数据
					var loadingIndex = null;
			    	$.ajax({
			    		type : "POST",
			    		url  : "${APP_PATH}/sysUser/doAssignRoleToUser",
			    		data : $("#roleForm").serialize(),
			    		/* dataType : "json",
			    		contentType:"application/json;UTF-8", */
			    		beforeSend : function() {
			    			loadingIndex = layer.msg('处理中', {icon: 16,shade:0.3});
			    		},
			    		success : function(result) {
			    			layer.close(loadingIndex);
			    			if ( result.success ) {
			    				// 移动数据
		    					 $("#rightRoleOption").append(opts); 
			    				 layer.msg("分配角色数据成功", {time:2000, icon:6}, function(){
			    					
			                       });
			    			}else{
		                       layer.msg("分配角色数据失败", {time:2000, icon:5, shift:6}, function(){
		                    	   layer.close(index); //如果设定了yes回调，需进行手工关闭
		                       });
			    			}
			    		}
			    	}); 
				  }
				  
			  });
			  
			  //右边列表
			  $("#rightToLeftBtn").click(function(){
				  // 获取左边列表选中项
				  var opts = $("#rightRoleOption option:selected");
				  if(opts.length==0){
					  layer.msg("请选择需要取消分配的角色", {time:2000, icon:5, shift:6}, function(){
	                       });
				  }else{ 
					// 发起后台交互数据
					var loadingIndex = null;
			    	$.ajax({
			    		type : "POST",
			    		url  : "${APP_PATH}/sysUser/doCancelRoleToUser",
			    		data : $("#roleForm").serialize(),
			    		/* dataType : "json",
			    		contentType:"application/json;UTF-8", */
			    		beforeSend : function() {
			    			loadingIndex = layer.msg('处理中', {icon: 16,shade:0.3});
			    		},
			    		success : function(result) {
			    			layer.close(loadingIndex);
			    			if ( result.success ) {
			    				// 移动数据
		    					 $("#leftRoleOption").append(opts);
			    				 layer.msg("取消角色数据成功", {time:2000, icon:6}, function(){
			    					
			                       });
			    			}else{
		                       layer.msg("取消角色数据失败", {time:2000, icon:5, shift:6}, function(){
		                    	   layer.close(index); //如果设定了yes回调，需进行手工关闭
		                       });
			    			}
			    		}
			    	}); 
					
					
				  }
				  
			  });
			  
		});

		 //Demo
        layui.use(['layer','table','form'], function () {
            var layer = layui.layer,
                form = layui.form,
                table = layui.table,
                util = layui.util;
         //第一个实例
    var tableObj = table.render({
                elem: '#demo'
                , id:'userTableDatas'
                , height: 650
                , url: '${APP_PATH}/sysUser/getUserData' //数据接口
                , method: 'GET'
                , title: '用户表'
                , page:true//开启分页
                , toolbar: '#toolbarDemo' //开启工具栏，此处显示默认图标，可以自定义模板，详见文档
                /* , totalRow: true  */
                ,defaultToolbar: ['filter', 'print', 'exports']
                , cols: [[ //表头
                    {type: 'checkbox', fixed: 'left'}
                    /* ,{ field: 'userid', title: '#ID', width:120, sort: false} */
                    , { field: 'username', title: '用户姓名'}
                    , { field: 'type', title: '类型',templet:'#userType'}
                    , { field: 'phone', title: '手机号'}
                    , { field: 'status', title: '状态',templet:'#userStatus' }
                    , { field: 'status', title: '状态控制',templet:'#barStatus' }
                    , { field: 'createTime', title: '创建时间',width: 177,templet:function(d){return util.toDateString(d.createTime, "yyyy-MM-dd HH:mm:ss");}}
                    , { fixed: 'right',title:'操作', width: 310, align: 'center', toolbar: '#barDemo' }
                ]]
               , text: {
               	//自定义一些文本提示
                   none: '暂无相关数据' //默认：无数据。注：该属性为 layui 2.2.5 开始新增
               }
               , skin: 'row'
               , size: 'lg'
               , even: true
              
                 });
         
			 // 执行搜索，表格重载
			    $('#searchBtn').on('click', function () {
			    	 // 搜索条件
			        var send_name = $('#search_user').val();
			    	 var send_Name=$.trim(send_name);
			    	if(send_Name == null || send_Name == ""){
			    		layer.msg("请输入您要搜索的内容");
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
                    case 'addUser':
                    	addUser();
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
                                 batchRemoveUser(data);
                        	 });
                        }
                        break;
                };
            });
             // 获取角色列表
             function getRoleList(userid){
            	 // 给隐藏输入赋值用户ID
            	 $("#userId").attr("value",userid);
            	 var loadingIndex = null;
			    	$.ajax({
			    		type : "POST",
			    		url  : "${APP_PATH}/sysUser/getRoleList",
			    		data : {id:userid},
			    		beforeSend : function() {
			    			loadingIndex = layer.msg('处理中', {icon: 16,shade:0.3});
			    		},
			    		success : function(result) {
			    			layer.close(loadingIndex);
			    			if ( result.success ) {
			    				// 取出用户角色列表，渲染到页面
			    				var data =result.unAssignData;
			    				var data2 =result.assignData;
			    				$.each(data,function(i){
			    					$("#leftRoleOption").append("<option value='" + data[i].id +"'>" + data[i].name + "</option>");
			    				});
			    				$.each(data2,function(index){
			    					$("#rightRoleOption").append("<option value='" + data2[index].id +"'>" + data2[index].name + "</option>");
			    				});
			    				 console.log(22222,data,333333,data2);
			    			}else{
		                       layer.msg(result.msg, {time:2000, icon:5, shift:6}, function(){
		                    	   layer.close(index); //如果设定了yes回调，需进行手工关闭
		                       });
			    			}
			    		}
			    	});
             }
             
             // 批量删除用户
             function batchRemoveUser(entityList){
            	// 提交表单
                 var loadingIndex = null;
			    	$.ajax({
			    		type : "POST",
			    		url  : "${APP_PATH}/sysUser/batchRemoveUsers",
			    		data : JSON.stringify(entityList),
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
             
             // 添加用户方法
            function addUser(){
            	layer.open({
                    type:1,
                    area:['500px', '420px']
                    ,title: '添加用户信息'
                    ,content: $("#addUserArea")
                    ,btn: ['提交', '取消']
                    ,yes: function(index, layero){
                   	
                   	 // 校验名称合法性
                        var name = $("#addUserName").val();
                        var phone = $("#addPhone").val();
                        var password= $("#addPassword").val();
                        var userType = $("#addUserType").val();
                        var status = parseInt($("input[name='status']:checked").val());
               	        var nm = $.trim(name);
               	        var ph = $.trim(phone);
               	        var pwd = $.trim(password);
               	        if(ph == '' || ph ==null){
               	        	layer.msg("手机号不能为空", {time:1000, icon:5,shift:6,}, function(){
		                       });
                            return false;
               	        }
               	        if(ph.length<1 || ph.length >11){
               	        	layer.msg("手机号必须是11位字符", {time:1000, icon:5,shift:6,},function(){
		                       });
                             return false;
               	        }
                   	    if(nm=='' || nm ==null){
                         	layer.msg("用户名称不能为空", {time:1000, icon:5,shift:6,}, function(){
		                       });
                            return false;
                         }
                         if(nm.length<1 || nm.length >20){
                       	  layer.msg("用户名称字符在1-20之间",{time:1000,icon:5,shift:6,},function(){
                       	  });
                       	  return false;
                         }
                         if(pwd == '' || pwd == null){
                        	 layer.msg("密码不能为空",{time:1000,icon:5,shift:6,},function(){
                          	  });
                          	  return false;
                         }
                         if(pwd.length<2|| pwd.length>20){
          				   layer.msg("密码字符在2~20位", {time:2000, icon:5, shift:6,}, function(){
          				       	
          			       });
          				  return false;
          			   }
                         
                         // 提交表单
                         var loadingIndex = null;
                         var user = {};
                             user.username = nm;
                             user.phone = ph;
                             user.password = pwd; 
                             user.type = userType;
                             user.status = status;
					    	$.ajax({
					    		type : "POST",
					    		url  : "${APP_PATH}/sysUser/addUser",
					    		data : JSON.stringify(user),
					    		dataType : "json",
					    		contentType:"application/json;UTF-8",
					    		beforeSend : function() {
					    			loadingIndex = layer.msg('处理中', {icon: 16,shade:0.3,});
					    		},
					    		success : function(result) {
					    			layer.close(loadingIndex);
					    			if ( result.success ) {
					    				 layer.msg(result.msg, {time:2000, icon:6, shift:6,}, function(){
					    					 layer.close(index); 
					    					 location.reload();	
					                       });
					    			}else{
				                       layer.msg(result.msg, {time:2000, icon:5, shift:6,}, function(){
				                    	   layer.close(index); //如果设定了yes回调，需进行手工关闭
				                            $("#addUserArea").css({"display":"none"});
				                       });
					    			}
					    		}
					    	});
                   	 }
           	     ,btn2:function(index, layero){
           	    	 $("#addUserArea").css({"display":"none"});
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
                   // layer.msg('查看操作');
                    
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
                 		    	location.reload();
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
                	// 给表单赋值
                	$("#uid").attr("value",data.userid);
                	$("#editUserName").attr("value",data.username);
                	$("#editPhone").attr("value",data.phone);
                	$("#editUserType").val(data.type);
                	$("input[name=status][value=0]").attr("checked", data.status == 0 ? true : false);
                	$("input[name=status][value=1]").attr("checked", data.status == 1 ? true : false);
                	form.render();
                    layer.open({
                        type:1,
                        area:['500px', '420px'],
                        title: '修改用户信息',
                        content: $("#editUserArea"),
                        btn: ['提交', '取消'],
                        yes: function(index, layero){
                        	var user ={};
                        	    user.userid = data.userid;
                        	    user.username = $("#editUserName").val();
                        	    user.phone = $("#editPhone").val();
                        	    user.type = $("#editUserType").val();
                        	    user.status = parseInt($("input[name='status']:checked").val());
                        	   
                        	  // 修改用户
                        	var loadingIndex = null;
        			    	$.ajax({
        			    		type : "POST",
        			    		url  : "${APP_PATH}/sysUser/update",
        			    		data : JSON.stringify(user),
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
        		                    	   $("#editUserArea").css({"display":"none"});  
        		                       });
        			    			}
        			    		}
        			    	});
                        	}
                        ,btn2:function(index,layero){
                           $("#editUserArea").css({"display":"none"});
                           location.reload();
                        }
                        ,cancel: function(layero,index){ 
                        	 layer.closeAll();
                             $("#editUserArea").css({"display":"none"});
                             location.reload();
                           }
                        });
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
                  }else if(layEvent==='assignmentRole'){
                	  getRoleList(data.userid);
                	  layer.open({
                          type:1,
                          area:['500px', '420px'],
                          title: '用户分配角色',
                          content: $("#assignRoleToUser"),
                         // btn: ['提交', '取消'],
                          yes: function(index, layero){
                          	}
                          ,btn2:function(index,layero){
                             $("#assignRoleToUser").css({"display":"none"});
                             location.reload();
                          }
                          ,cancel: function(layero,index){ 
                          	 layer.closeAll();
                               $("#assignRoleToUser").css({"display":"none"});
                               location.reload();
                             }
                          });
                  }
            });
        });	 
		 
</script>
</body>
</html>