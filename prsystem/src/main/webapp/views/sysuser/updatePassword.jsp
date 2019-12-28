<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户修改密码</title>
<%
 pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<link rel="stylesheet" href="${APP_PATH}/layui-v2.4.5/layui/css/layui.css">
<script src="${APP_PATH}/js/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/layui-v2.4.5/layui/layui.js"></script>
    <style type="text/css">
    .layui-input{
	    width:263px;
	    display:inline;
	    float:left;
	  }
    </style>
</head>
<body>
<div class="layui-container" style="margin-top:20px;">
	<form class="layui-form" action="">
	  <div class="layui-form-item">
	    <label class="layui-form-label"><span style="color:red;">*</span>原始密码</label>
	    <div class="layui-input-block">
	      <input type="text" name="oldpassword" id="oldPassWord" required  lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input">
	       
	    </div>
	    
	  </div>
	  <div class="layui-form-item">
	    <label class="layui-form-label"><span style="color:red;">*</span>新密码</label>
	    <div class="layui-input-inline">
	      <input type="password" name="newpassword" id="newPassWord" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
	    </div>
	  </div>
	  
	  <div class="layui-form-item">
	    <div class="layui-input-block">
	      <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
	      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
	    </div>
	  </div>
	</form>
 </div>
<script>
//Demo
	layui.use('form', function(){
	  var form = layui.form;
	  
	  //监听提交
	  form.on('submit(formDemo)', function(data){
		
	    /* layer.msg(JSON.stringify(data.field)); */
		  $.ajax({
              url: "${APP_PATH}/sysUser/userUpdatePassWord",
              type: "post",
              async: false,   //不要让它异步提交
              data: data.field,
              dataType: "json",
              success: function (data) {
                  if(data.state==1){
                      layer.alert("修改成功",{icon: 6,time:2000},function () {
                          layer.close(layer.index);
                          window.parent.location="${APP_PATH}/sys_user/touser";    //重新加载父页面
                      });
                  } else{
                      layer.alert("原始密码不正确，请重新输入",{icon: 2,time:2000});
                  }
              }
          });
		
		  
	    return false;
	  });
	});
</script>

</body>
</html>