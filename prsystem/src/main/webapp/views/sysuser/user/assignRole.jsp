<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>角色分配</title>
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
<div class="panel panel-default">
  <div class="panel-body">
	<form role="form" class="form-inline">
	  <div class="form-group">
		<label for="exampleInputPassword1">未分配角色列表</label><br>
		<select class="form-control" multiple size="10" style="width:100px;overflow-y:auto;">
                     <option value="se">SE</option>
                     <option value="tl">TL</option>
                     <option value="gl">GL</option>
                     <option value="qa">QA</option>
                     <option value="pm">PM</option>
                 </select>
	  </div>
	  <div class="form-group">
                     <ul>
                         <li class="btn btn-default glyphicon glyphicon-chevron-right"></li>
                         <br>
                         <li class="btn btn-default glyphicon glyphicon-chevron-left" style="margin-top:20px;"></li>
                     </ul>
	  </div>
	  <div class="form-group" style="margin-left:40px;">
		<label for="exampleInputPassword1">已分配角色列表</label><br>
		<select class="form-control" multiple size="10" style="width:100px;overflow-y:auto;">
                     
                     <option value="qc">QC</option>
                     <option value="pg">PG</option>
                     
                     <option value="sa">SA</option>
                 </select>
	  </div>
	</form>
  </div>
</div>   
			
<script src="${APP_PATH}/js/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/layui-v2.4.5/layui/layui.all.js"></script>
<script src="${APP_PATH}/bootstrap-3.3.7/js/bootstrap.min.js"></script>
<script language="javascript">
	
  /* 自定义页面加载完成事件 */
  $(function(){
	  //layer.msg("页面加载完成啦");
  });
		 
</script>
</body>
</html>