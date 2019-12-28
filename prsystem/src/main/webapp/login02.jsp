<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
 pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>用户首页界面</title>
	<link rel="stylesheet" type="text/css" href="${APP_PATH}/css/layout/styles.css">
	   <link rel="stylesheet" href="${APP_PATH}/css/layout/jigsaw.css">
	   <link rel="stylesheet" href="${APP_PATH}/homePage.jsp"  media="all">
	   <link rel="stylesheet" href="${APP_PATH}/layui-v2.4.5/layui/css/layui.css"  media="all">
	  <style>
	  	
	  	  #msg {
      width: 100%;
      line-height: 40px;
      font-size: 14px;
      text-align: center;
    }
   
	  </style>
</head>
<body>

<div class="layui-layout layui-layout-admin">
  <div class="layui-header">
    <div class="layui-logo" style="color: white; font-size:20px">图片识别系统</div>
    <ul class="layui-nav layui-layout-right">
    	<li class="layui-nav-item"><a href="homePage.jsp">首页</a></li>
      <li class="layui-nav-item"><a href="login.jsp">管理员登录入口</a></li>
      <li class="layui-nav-item"><a href="login.jsp">注册</a></li>
    </ul>
  </div>
</div>

	<div class="jq22-container" style="padding-top: 50px;width:90%; height:70%;">
		<div class="login-wrap" >
			<div class="login-html" style="padding: 30px 50px 50px 50px;width:90%; height:70%; background-color:#272727">
				<input id="tab-1" type="radio" name="tab" class="sign-in" checked ><label for="tab-1" class="tab"  style="font-size:18px">登录</label>
				<input id="tab-2" type="radio" name="tab" class="sign-up"><label for="tab-2" class="tab" style="font-size:18px">注册</label>
				
				<div class="login-form">
					<form id="userLoginForm">
					<div class="sign-in-htm">
						<div class="group">
							<label for="user" class="label">手机号</label>
							<input id="phoneLogin" name="phone" value="admin" type="text" class="input" autocomplete="off" placeholder="请输入手机号或者姓名" style="width: 100%;height:40px">
						</div> 

						<div class="group">
							<label for="pass" class="label">密码</label>
							<input id="passwordLogin" type="password" name="password" class="input" data-type="password" autocomplete="off" placeholder="请输入密码" style="width: 100%;height:40px">
						</div>
						<div class="group">
							<div class="container">
							    <div id="captcha" style="position: relative" data-type="password"></div>
								<div id="msg"></div>
							</div>
						</div>
						<div class="group">
							<input id="check" type="checkbox" class="check" checked>
							<label for="check"><span class="icon" style="background-color:#8080C0;"></span> 保持登录</label>
						</div>						
						<div class="group">
							<input style="background-color:#8080C0;width: 100%;height:40px" type="button" class="button" value="登录" onclick="sub()">
						</div>
						<!-- <div class="hr"  style="position: relative;"></div> -->
						
						<div class="foot-lnk">
							<li class="layui-nav-item"><a href="repwd.jsp" style="color:#8080C0">忘记密码？</a></li>
						
						</div>
					</div>
					</form>
					<!--用户注册 -->
					<form id="userRegitForm">
					<div class="sign-up-htm">
						<div class="group">
							<label for="user" class="label">用户名</label>
							<input id="userName" type="text" name="username" class="input" autocomplete="off" placeholder="请输入邮箱" style="width: 100%;height:40px">
						</div>
						<div class="group">
							<label for="pass" class="label">密码</label>
							<input id="passsNord" type="password" name="password" class="input" data-type="password" autocomplete="off" placeholder="请输入密码"style="width: 100%;height:40px">
						</div>
						<div class="group">
							<label for="pass" class="label" >确认密码</label>
							<input id="passsNord2" type="password" class="input" data-type="password" autocomplete="off" placeholder="请重复输入密码" style="width: 100%;height:40px">
						</div>
						<div class="group">
							<label for="pass" class="label">手机号</label>
							<input id="userPhone" type="text" name="phone" class="input" autocomplete="off" placeholder="请输入11位手机号码" style="width: 100%;height:40px">
						</div>
						<div class="group">
							<input style="background-color:#8080C0; width: 100%;height:40px" type="button" id="userRegitBtn" class="button" value="立即注册">
						</div>
						<!-- <div class="hr"></div> -->
						<div class="foot-lnk">
							<label for="tab-1">返回登录</a>
						</div>
					</div>
					</form>
					
				</div>
			</div>
		</div>
	</div>
	
	<p style="color:#000;text-align: center;font-size:20px;">make © 2019.色情图片识别系统 </p>
	<script src="${APP_PATH}/js/jquery-2.1.1.min.js"></script>
	<%-- <script src="${APP_PATH}/layui-v2.4.5/layui/layui.js"></script> --%>
	<script src="${APP_PATH}/js/jigsaw.js"></script>
	<script src="${APP_PATH}/layer/layer.js"></script>
<script>
	   
	    var flag=false;	
		function sub(){
			var LoginName=document.getElementById('phoneLogin').value;
			var LoginPass=document.getElementById('passwordLogin').value;
			if(LoginName==null || LoginName==""){
				   layer.msg("用户名不能为空", {time:2000, icon:5, shift:6}, function(){
				       	
			       });
				  return;
			   }
			if(LoginName.length<0 || LoginName.length>11){
				   layer.msg("手机号字符必须是11位", {time:2000, icon:5, shift:6}, function(){
				       	
			       });
				  return;
			   }
			if(LoginPass==null || LoginPass==""){
				   layer.msg("密码不能为空", {time:2000, icon:5, shift:6}, function(){
				       	
			       });
				  return;
			   }
			if(LoginPass.length<2|| LoginPass.length>20){
				   layer.msg("密码字符在2~20位", {time:2000, icon:5, shift:6}, function(){
				       	
			       });
				  return;
			   }
			
			
			// 发起请求
			var loadingIndex = null;
	    	$.ajax({
	    		type : "POST",
	    		url  : "${APP_PATH}/sysUser/userLogin",
	    		data : $("#userLoginForm").serialize(),
	    		beforeSend : function() {
	    			loadingIndex = layer.msg('处理中', {icon: 16});
	    		},
	    		success : function(result) {
	    			layer.close(loadingIndex);
	    			if ( result.state==0) {
                       layer.msg("登录成功", {time:1000, icon:6}, function(){
                       	window.location.href = "${APP_PATH}/sys_user/toadmin";
                       });
	    			} else {
                       layer.msg("用户名或密码错误，请重新新输入", {time:2000, icon:5, shift:6}, function(){
                       	
                       });
	    			}
	    		}
	    	});
			
	    	/* var cname="admin";
			var cpass="123"; */
			
			if(LoginName==cname && LoginPass==cpass && flag==true){
			alert("登录成功!");
				//window.location.href="#";
			}else{
				if(flag==false){
					alert("验证失败!");
					return;
				}
				alert("用户名或密码错误!");
			}
	      }
	 
		jigsaw.init(document.getElementById('captcha'), function () {
	  	  flag=true;
	      document.getElementById('msg').innerHTML = '验证成功！';
	    });
	   
	   
   
   //注册
   $(function(){
	   $("#userRegitBtn").click(function(){
		   var uName=$("#userName").val();
		   var upass1=$("#passsNord").val();
		   var upass2=$("#passsNord2").val();
		   var uphone=$("#userPhone").val();
		   if(uName==null || uName==""){
			   layer.msg("用户名不能为空", {time:2000, icon:5, shift:6}, function(){
			       	
		       });
			  return;
		   }
		   if(uName.length<2|| uName.length>6){
			   layer.msg("用户名字符在2~6位", {time:2000, icon:5, shift:6}, function(){
			       	
		       });
			  return;
		   }
		   if(upass1==null || upass1==""){
			   layer.msg("密码不能为空", {time:2000, icon:5, shift:6}, function(){
			       	
		       });
			  return;
		   }
		   if(upass2==null || upass2==""){
			   layer.msg("确认密码不能为空", {time:2000, icon:5, shift:6}, function(){
			       	
		       });
			  return;
		   }
		   if(upass1!=upass2){
			   layer.msg("两次密码不一致，请重新输入", {time:2000, icon:5, shift:6}, function(){
			       	
		       });
			  return;
		   }
		   if(uphone==null || uphone==""){
			   layer.msg("手机号不能为空", {time:2000, icon:5, shift:6}, function(){
			       	
		       });
			  return;
		   }
		   var TEL_REGEXP = /^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$/;
		   if(!TEL_REGEXP.test(uphone)){
			   layer.msg("手机号格式错误！", {time:2000, icon:5, shift:6}, function(){
			       	
		       });
			   return;
		   }
		   if(uphone.length!=11){
			   layer.msg("手机号必须是11位", {time:2000, icon:5, shift:6}, function(){
			       	
		       });
			  return;
		   }
		 
		   //验证通过后提交表单
		   var loadingIndex = null;
	    	$.ajax({
	    		type : "POST",
	    		url  : "${APP_PATH}/sysUser/savaEntity",
	    		data : $("#userRegitForm").serialize(),
	    		beforeSend : function() {
	    			loadingIndex = layer.msg('处理中', {icon: 16});
	    		},
	    		success : function(result) {
	    			layer.close(loadingIndex);
	    			if ( result.success ) {
                       layer.msg("用户信息保存成功", {time:1000, icon:6}, function(){
                       	window.location.href = "${APP_PATH}/";
                       });
	    			} else {
                       layer.msg("用户信息保存失败，请重新操作", {time:2000, icon:5, shift:6}, function(){
                       	
                       });
	    			}
	    		}
	    	});
		   
		   
		   
	   });
	  
	   
	   
   });
	
</script>
</body>
</html>