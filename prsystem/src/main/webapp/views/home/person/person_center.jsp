<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>个人中心</title>
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
     <li class="layui-nav-item layui-this">
      <a href="${APP_PATH}/views/home/person/person_center.jsp">
        <i class="layui-icon">&#xe620;</i>
                      基本设置
      </a>
    </li>
    <li class="layui-nav-item">
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
    <div class="layui-tab layui-tab-brief" lay-filter="user">
      <ul class="layui-tab-title" id="LAY_mine">
        <li class="layui-this" lay-id="info">我的资料</li>
        <li lay-id="avatar">头像</li>
        <li lay-id="pass">密码</li>
        <li lay-id="bind">帐号绑定</li>
      </ul>
      <div class="layui-tab-content" style="padding: 20px 0;">
        <div class="layui-form layui-form-pane layui-tab-item layui-show">
          <form method="post">
            <div class="layui-form-item">
              <label for="L_email" class="layui-form-label">邮箱</label>
              <div class="layui-input-inline">
                <input type="text" id="L_email" name="email" required lay-verify="email" autocomplete="off" value="" class="layui-input">
              </div>
              <div class="layui-form-mid layui-word-aux">如果您在邮箱已激活的情况下，变更了邮箱，需<a href="activate.html" style="font-size: 12px; color: #4f99cf;">重新验证邮箱</a>。</div>
            </div>
            <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">昵称</label>
              <div class="layui-input-inline">
                <input type="text" id="L_username" name="username" required lay-verify="required" autocomplete="off" value="" class="layui-input">
              </div>
              <div class="layui-inline">
                <div class="layui-input-inline">
                  <input type="radio" name="sex" value="0" checked title="男">
                  <input type="radio" name="sex" value="1" title="女">
                </div>
              </div>
            </div>
            <div class="layui-form-item">
              <label for="L_city" class="layui-form-label">城市</label>
              <div class="layui-input-inline">
                <input type="text" id="L_city" name="city" autocomplete="off" value="" class="layui-input">
              </div>
            </div>
            <div class="layui-form-item layui-form-text">
              <label for="L_sign" class="layui-form-label">签名</label>
              <div class="layui-input-block">
                <textarea placeholder="随便写些什么刷下存在感" id="L_sign"  name="sign" autocomplete="off" class="layui-textarea" style="height: 80px;"></textarea>
              </div>
            </div>
            <div class="layui-form-item">
              <button class="layui-btn" key="set-mine" lay-filter="*" lay-submit>确认修改</button>
            </div>
          </div>
          
          <div class="layui-form layui-form-pane layui-tab-item">
            <div class="layui-form-item">
              <div class="avatar-add">
                <p>建议尺寸168*168，支持jpg、png、gif，最大不能超过50KB</p>
                <button type="button" class="layui-btn upload-img">
                  <i class="layui-icon">&#xe67c;</i>上传头像
                </button>
                <img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg">
                <span class="loading"></span>
              </div>
            </div>
          </div>
          
          <div class="layui-form layui-form-pane layui-tab-item">
            <form action="/user/repass" method="post">
              <div class="layui-form-item">
                <label for="L_nowpass" class="layui-form-label">当前密码</label>
                <div class="layui-input-inline">
                  <input type="password" id="oldPassWord" name="oldpassword" required lay-verify="required" autocomplete="off" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <label for="L_pass" class="layui-form-label">新密码</label>
                <div class="layui-input-inline">
                  <input type="password" id="newPassWord" name="newpassword" required lay-verify="required" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid layui-word-aux">6到16个字符</div>
              </div>
              <!-- <div class="layui-form-item">
                <label for="L_repass" class="layui-form-label">确认密码</label>
                <div class="layui-input-inline">
                  <input type="password" id="L_repass" name="repass" required lay-verify="required" autocomplete="off" class="layui-input">
                </div>
              </div> -->
              <!-- 谷歌验证码 -->
			<div class="layui-form-item">
			    <label class="layui-form-label">验证码</label>
			     <div class="layui-input-inline">
			      <input type="text" name="verifyCode" class="layui-input" id="j_captcha" placeholder="验证码">
			     </div>
			    <div class="item-input">
			        <img id="captcha_img" alt="点击更换" title="点击更换" style="cursor: pointer;"
			            onclick="changeVerifyCode(this)" src="${APP_PATH}/Kaptcha"/>
			    </div>
			</div>

              <div class="layui-form-item">
                <button class="layui-btn" key="set-mine" lay-filter="userUpdatePassWordForm" lay-submit>确认修改</button>
              </div>
            </form>
          </div>
          
          <div class="layui-form layui-form-pane layui-tab-item">
            <ul class="app-bind">
              <li class="fly-msg app-havebind">
                <i class="iconfont icon-qq"></i>
                <span>已成功绑定，您可以使用QQ帐号直接登录Fly社区，当然，您也可以</span>
                <a href="javascript:;" class="acc-unbind" type="qq_id">解除绑定</a>
                
                <!-- <a href="" onclick="layer.msg('正在绑定微博QQ', {icon:16, shade: 0.1, time:0})" class="acc-bind" type="qq_id">立即绑定</a>
                <span>，即可使用QQ帐号登录Fly社区</span> -->
              </li>
              <li class="fly-msg">
                <i class="iconfont icon-weibo"></i>
                <!-- <span>已成功绑定，您可以使用微博直接登录Fly社区，当然，您也可以</span>
                <a href="javascript:;" class="acc-unbind" type="weibo_id">解除绑定</a> -->
                
                <a href="" class="acc-weibo" type="weibo_id"  onclick="layer.msg('正在绑定微博', {icon:16, shade: 0.1, time:0})" >立即绑定</a>
                <span>，即可使用微博帐号登录Fly社区</span>
              </li>
            </ul>
          </div>
        </div>

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
	layui.use(['element','form','layer'], function(){
	var element = layui.element,
	      form = layui.form,
	      layer = layui.layer;
	
	//监听提交
	  form.on('submit(userUpdatePassWordForm)', function(data){
		
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
              }else if(data.state == 2){
            	  layer.alert("验证码不能为空",{icon: 2,time:2000});
              }else if(data.state == 0){
            	  layer.alert("原始密码不正确，请重新输入",{icon: 2,time:2000});
              }else if(data.state == 3){
            	  layer.alert("验证码不正确，请重新输入",{icon: 2,time:2000});
              }
          }
        });
	
	    return false;
	  });
	 
	});
	function changeVerifyCode(img){
		console.log(1111,img);
		img.src="${APP_PATH}/Kaptcha?" + Math.floor(Math.random()*100);
	}
	
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