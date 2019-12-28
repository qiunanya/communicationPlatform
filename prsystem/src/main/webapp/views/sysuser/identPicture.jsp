<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>识别管理</title>
<%
 pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<link rel="stylesheet" href="${APP_PATH}/layui-v2.4.5/layui/css/layui.css">
<link rel="stylesheet" href="${APP_PATH}/css/layout/index.css">
</head>
<body>
       <div style="padding: 20px; background-color: #F2F2F2;">
		  <div class="layui-row layui-col-space15">
		    <div class="layui-col-md4">
		      <div class="layui-card">
		        <div class="layui-card-header" style="text-align: center;">上传识别图片</div>
		        <div class="layui-card-body" style="text-align: center;">
		           <div>
						<div class="layui-upload-drag" id="identimg" style="width: 99%;padding: 0;height: 370px">
					
							<div id="upload_img" style="display: none;">
								<img class="layui-upload-img" id="img" style="height: 370px;width: 99%;object-fit: contain;">
							</div>
							  
							<div id="upload_text" style="height: 225px;">
								<div style="margin-top: 125px;">
									<i class="layui-icon"></i>
									<p>点击此处上传图片，或将文件拖拽到此处</p>
									<span style="color:red;">最大允许10MB单个文件上传</span>
								</div>
							</div>
						  
						</div>
						
						<div style="margin-top: 5px;">
							 <button id="start_ident" class="layui-btn layui-btn-normal" style="width: 100%">启动图片识别</button>
							 <input type="text" id="upload_imgNAME" style="display: none;">
						</div>
						
					</div>
					
		        </div>
		      </div>
		    </div>
		    
		    <div class="layui-col-md5">
		      <div class="layui-card">
		         <div class="layui-card-header" style="text-align: center;">
		            <button class="layui-btn layui-btn-normal" id="saveIdentResultBtn">保存识别结果</button>
		        </div>
		        <div class="layui-card-header" style="text-align: center;">一、图片识别结果</div>
		        <div class="layui-card-body" style="text-align: center;height: 371px;overflow: Auto;">
		        	
		        	<h5 id="no-result-h5" style="line-height: 371px;">暂无识别结果</h5>
		            <div style="display: none;" id="result_view">
						<div style="width: 100%;">
						   <table class="layui-table" lay-size="sm" id="result_table" style="text-align: center;">
								<colgroup><col><col width="100px;"></colgroup>
								<tr>
								    <th style="text-align: center;">内容</th>
								    <th style="text-align: center;">准确率</th>
								</tr>    
							</table>
						</div>
					</div>
					
		        </div>
		      </div>
		    </div>
		    
		    <!--图片包含内容-->
		    <div class="layui-col-md5" style="margin-left:auto;">
		      <div class="layui-card">
		        <div class="layui-card-header" style="text-align: center;">二、图片识别报告信息</div>
		        <div class="layui-card-body" style="text-align: center;height: 415px;overflow: Auto;">
		        	
		        	<h5 id="include-no-result-h5" style="line-height: 415px;">暂无识别报告信息</h5>
		            
		            <div style="display: none;" id="include_result_view">
						<div style="width: 100%;">
						   <table class="layui-table" lay-size="sm" id="include_result_table" style="text-align: center;">
								  
							</table>
						</div>
					</div>
					
		        </div>
		      </div>
		    </div>
		    
		  </div>
	</div>
	
  
  <script src="${APP_PATH}/js/jquery-2.1.1.min.js"></script>
  <script src="${APP_PATH}/layui-v2.4.5/layui/layui.js"></script>
  <script type="text/javascript">
	    var imageIDENTreslut="";
		layui.use(['layer','form','upload'],function(){
			var upload=layui.upload;
			var layer=layui.layer;
			var form=layui.form;
			
			upload.render({
				elem:'#identimg',
				url:'${APP_PATH}/up_files/upload_img',
				field:'identimg',//设置文本域字段名
				auto: false,	/* 不自动上传 */
			    accept:'images',
			    exts:'jpg|png|gif',// 限制上传图片类型
			    bindAction: '#start_ident',
				choose: function(obj){ 
					//预读本地文件示例，不支持ie8
					obj.preview(function(index, file, result){
					  $('#img').attr('src', result); //图片链接（base64）
					  $("#upload_imgNAME").val(file.name);//图片名称赋值给upload_imgNAME input，做选择文件判断
					});
					$("#upload_text").hide();
					$("#upload_img").show();
			        //layer.load(1,{shade: [0.5,'#696969']}); //上传loading
			    },
			    before: function(obj){
			    	layer.load(0,{
						shade: [0.5,'#696969'],
						content: '图片识别中，请耐心等待...',
						success: function (layero) {
					        layero.find('.layui-layer-content').css({
					            'padding-top': '39px',
					            'width': '60px'
					        });
					    }
					});
			    },
			    //成功回调
			    done: function(res,index){
			    	//序列化后台传过来的数据content
			    	var data=$.parseJSON(res.content);
			    	// 最终返回的识别结果conclusion
			    	imageIDENTreslut=data.conclusion;
			    	console.log("识别结果是==="+imageIDENTreslut);
			    	
			    	if(res.info=="ERROR"){
			    		layer.alert("文件上传失败,请重试！",{icon:2},function(){
			    			location.reload();//刷新页面
			    		});
			    	}
			    	if(data.log_id==""){
			    		layer.alert("图片识别失败，请重试！",{icon:2});
			    		layer.closeAll('loading');
			    		return;
			    	}
			    	layer.closeAll('loading');
			    	
			    	$("#no-result-h5").hide();
			    	$("#result_view").hide();
			    	$("#result_table").empty();
			    	// 图片包含信息
			    	$("#include-no-result-h5").hide();
			    	$("#include_result_view").hide();
			    	$("#include_result_table").empty();
			    	
			    	//设置表格宽度
			    	$("#result_table").append("<colgroup><col width=\"100px;\"><col><col width=\"100px;\"></colgroup>");
			    	//设置表头
			    	$("#result_table").append("<tr><th style=\"text-align: center;\">编号</th><th style=\"text-align: center;\">内容</th><th style=\"text-align: center;\">准确率</th></tr> ");
			    	
			    	//设置表格宽度
			    	$("#include_result_table").append("<colgroup><col width=\"100px;\"><col><col width=\"100px;\"></colgroup>");
			    	//设置表头
			    	$("#include_result_table").append("<tr><th style=\"text-align: center;\">编号</th><th style=\"text-align: center;\">图片识别报告信息项</th><th style=\"text-align: center;\">包含率</th></tr> ");
			    	
			    	var i=1;	//记录编号
			    	var image_Content="";		//记录数据
			    	$.each(data.result,function(index, value){
			    		$("#result_table").append("<tr><td>"+ i++ +"</td><td>"+value.class_name+"</td><td>"+value.probability+"</td></tr>");
			    		image_Content += value.class_name;
			    		}); 
			    	
			    	$("#result_view").show(1500);
			    	$("#article_content").val(image_Content);		//识别框显示数据
			    	
			    	// 图片包含信息表
			    	var c=1;	//记录编号
			    	var include_image_Content="";		//记录数据
			    	
			    	$.each(data.result_fine,function(index, value){
			    		$("#include_result_table").append("<tr><td>"+ c++ +"</td><td>"+value.class_name+"</td><td id='bgToRed'>"+value.probability+"</td></tr>");
			    		include_image_Content += value.class_name;
			    	});
			    	
			    	
			    	$("#include_result_view").show(1500);
			    	$("#article_content").val(include_image_Content);
			    	
			    	}
			    ,error: function(index, upload){
			    	layer.closeAll('loading');
			    	layer.alert("文件上传失败,请重试！",{icon:2},function(){
		    			location.reload();//刷新页面
		    		});
			    }
			});
			
			
			$("#start_ident").on("click",function(){
				
				var upload_imgNAME=$("#upload_imgNAME").val();
				if(upload_imgNAME==""){
					layer.msg("请选择图片！",{icon:2,time: 2000});
					return;
				}
				
			});
			
			// 保存图片识别结果
			$("#saveIdentResultBtn").on("click",function(){
				if(imageIDENTreslut==""){
					layer.msg("暂无要保存的数据",{icon : 2,time : 2000, shade : 0.3});
				}else{
					/* layer.msg("识别结果是"+iresult+"-----",{icon : 6,time : 6000, shade : 0.3}); */
					var loadingIndex = null;
					var conclusions =imageIDENTreslut;
			    	$.ajax({
			    		type : "POST",
			    		url  : "${APP_PATH}/up_files/saveIdentResultByUser",
			    		data : {conclusion:conclusions},
			    		dataType : "json",
			    		beforeSend : function() {
			    			loadingIndex = layer.msg('处理中', {icon: 16,shade:0.3});
			    		},
			    		success : function(result) {
			    			layer.close(loadingIndex);
			    			if ( result.success==true) {
			    				 layer.msg("保存成功", {time:2000, icon:6, shift:6}, function(){
				                       	
			                       });
			    			}else{
		                       layer.msg("保存失败", {time:2000, icon:5, shift:6}, function(){
		                       	
		                       });
			    			}
			    		}
			    	});
					
				}
				
				
			});
			
			
			
		});
	
	</script>
  
</body>
</html>