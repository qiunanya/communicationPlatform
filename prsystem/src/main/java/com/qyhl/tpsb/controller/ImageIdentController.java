package com.qyhl.tpsb.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.alibaba.fastjson.JSONObject;
import com.qyhl.tpsb.commonutils.AjaxResult;
import com.qyhl.tpsb.commonutils.IDUtils;
import com.qyhl.tpsb.commonutils.IdentImage;
import com.qyhl.tpsb.commonutils.ImageSaveBasePath;
import com.qyhl.tpsb.commonutils.LayEditAPICode;
import com.qyhl.tpsb.commonutils.LayuiAPiResult;
import com.qyhl.tpsb.entity.IdentPicEntity;
import com.qyhl.tpsb.entity.SysUserEntity;
import com.qyhl.tpsb.service.ImageIdentService;

/**
 * @author:邱南亚
 * @date:2019-4-6下午3:50:10
 */
@Controller
@RequestMapping(value="/up_files", produces = { "text/html;charset=UTF-8;", "application/json;charset=UTF-8;" })
@Api(value = "/up_files", tags = "图片识别接口")
public class ImageIdentController {
	
	public String imgesavepath = " ";
	
	
	@Autowired
	private ImageIdentService imageIdentService;
	
	@RequestMapping("upload_img")
	@ResponseBody
	public Object upload_img(HttpServletRequest request,HttpSession session){
		JSONObject msgjson=new JSONObject();
		SysUserEntity sysUserEntity = (SysUserEntity) session.getAttribute("loginUser");
		
		System.out.println("当前用户id=="+sysUserEntity.getUserid());
		
		IdentPicEntity ident=new IdentPicEntity();
		
		// 1、获取前台传来的文件域的文件信息
		MultipartHttpServletRequest multipart=(MultipartHttpServletRequest)request;
		MultipartFile identimg=multipart.getFile("identimg");
		
		// 2、 判断获取的文件
		if (!identimg.isEmpty()) {
			String oldfilename = identimg.getOriginalFilename();
			System.out.println("获取源文件名称=="+oldfilename);
			
			// 3、 获取文件类型
			String fileType = oldfilename.substring(oldfilename.lastIndexOf("."));
			System.out.println("上传文件后缀=="+fileType);
			
			// 4、 生成uuid字符串
			String newfilename=UUID.randomUUID().toString()+fileType;
			System.out.println("新的文件名=="+newfilename);
			
			// 5、 生成文件
			File file=new File(ImageSaveBasePath.IMG_PATH+sysUserEntity.getUserid()+"/", newfilename);
			
			// 6、 判断文件是否存在
			if (!file.getParentFile().exists()) {
				file.getParentFile().mkdirs();
			}
			
			try {
				// 7、 上传文件
				identimg.transferTo(file);	
			} catch (IOException e) {
				e.printStackTrace();
				msgjson.put("info", "ERROR");
				return msgjson.toString();
			}
			
			// 8、图片真实路径
			String img_path=ImageSaveBasePath.IMG_PATH + sysUserEntity.getUserid()+"/"+newfilename;
			System.out.println("图片真实路径=="+img_path);
			
			// 识别内容
			String identContent = IdentImage.getImage(img_path);
			
			System.out.println("识别内容为=="+identContent);
			
			// 封装数据
		    ident.setUserid(sysUserEntity.getUserid());
		    ident.setImgname(oldfilename);
		    ident.setIdenturl(img_path);
		    ident.setIdentimg(ImageSaveBasePath.IMG_PATH_XN+sysUserEntity.getUserid()+"/"+newfilename);
		    imgesavepath=ImageSaveBasePath.IMG_PATH_XN+sysUserEntity.getUserid()+"/"+newfilename;
		    ident.setIdenttime(new Date());
		    ident.setIdentcontent(identContent);
		    ident.setStatus(0);
		    
		    msgjson.put("content", identContent);
			
		}else {
			msgjson.put("info", "ERROR");
		}
		
		// 保存数据到数据库
		 ident.setIdentid(IDUtils.getId());
		 ident.setCreateId(sysUserEntity.getUserid());
		 ident.setCreatePerson(sysUserEntity.getUsername());
		 ident.setCreateTime(new Date());
		Integer res=imageIdentService.saveIdentEntity(ident);
		
		if (res==1) {
			msgjson.put("info", "SUCCESS");
		}else {
			msgjson.put("info", "ERROR");
		}
		
		return msgjson.toString();
	}
	
	@RequestMapping("/webUploadImg")
	@ResponseBody
	public AjaxResult webUploadImg(HttpServletRequest request,HttpSession session){
		LayEditAPICode layEditAPICode = new LayEditAPICode();
		AjaxResult result = new AjaxResult();
		SysUserEntity user = (SysUserEntity) session.getAttribute("webLoginUser");
		IdentPicEntity ident = new IdentPicEntity();
		JSONObject msgjson=new JSONObject();
		
		// 1、获取前台传来的文件域的文件信息
				MultipartHttpServletRequest multipart=(MultipartHttpServletRequest)request;
				MultipartFile identimg=multipart.getFile("file");
				
				// 2、 判断获取的文件
				if (!StringUtils.isEmpty(identimg)) {
					String oldfilename = identimg.getOriginalFilename();
					layEditAPICode.setTitle(oldfilename);
					System.out.println("获取源文件名称=="+oldfilename);
					
					// 3、 获取文件类型
					String fileType = oldfilename.substring(oldfilename.lastIndexOf("."));
					System.out.println("上传文件后缀=="+fileType);
					
					// 4、 生成uuid字符串
					String newfilename=UUID.randomUUID().toString()+fileType;
					System.out.println("新的文件名=="+newfilename);
					
					// 5、 生成文件
					File file=new File(ImageSaveBasePath.IMG_PATH+user.getUserid()+"/", newfilename);
				    String url = ImageSaveBasePath.IMG_PATH_XN+user.getUserid()+"/"+newfilename;
					
					// 6、 判断文件是否存在
					if (!file.getParentFile().exists()) {
						file.getParentFile().mkdirs();
					}
					
					try {
						// 7、 上传文件
						identimg.transferTo(file);	
					} catch (IOException e) {
						e.printStackTrace();
						msgjson.put("info", "ERROR");
						result.setCode(1);
						result.setMsg("上传图片失败");
						return result;
					}
					
					// 8、图片真实路径
					String img_path=ImageSaveBasePath.IMG_PATH + user.getUserid()+"/"+newfilename;
					System.out.println("图片真实路径=="+img_path);
					
					// 识别内容
					String identContent = IdentImage.getImage(img_path);
					
					System.out.println("识别内容为=="+identContent);
					
					// 封装数据
				    ident.setUserid(user.getUserid());
				    ident.setImgname(oldfilename);
				    ident.setIdenturl(img_path);
				    ident.setIdentimg(url);
				    layEditAPICode.setSrc(url);
				    imgesavepath=ImageSaveBasePath.IMG_PATH_XN+user.getUserid()+"/"+newfilename;
				    ident.setIdenttime(new Date());
				    ident.setIdentcontent(identContent);
				    result.setIdentResult(identContent);
				    ident.setStatus(0);
				    
				    msgjson.put("content", identContent);
					
				}else {
					msgjson.put("info", "ERROR");
				}
				
				// 保存数据到数据库
				 ident.setIdentid(IDUtils.getId());
				 ident.setCreateId(user.getUserid());
				 ident.setCreatePerson(user.getUsername());
				 ident.setCreateTime(new Date());
				 Integer res=imageIdentService.saveIdentEntity(ident);
				
				if (res==1) {
					result.setCode(0);
					result.setMsg("上传成功");
					result.setSuccess(true);
					result.setData(layEditAPICode);
					//msgjson.put("info", "SUCCESS");
				}else {
					msgjson.put("info", "ERROR");
				}
				
				return result;
	}
	
	/**
	 * 用户获取图片识别记录
	 * getIdentImageData
	 * @author:邱南亚
	 * @date:2019-4-6下午10:13:48
	 */
	@SuppressWarnings("unused")
	@RequestMapping("getIdentImageData")
	@ResponseBody
	public Object getIdentImageData(@RequestParam(value="page")Integer page,
			@RequestParam(value="limit")Integer limit,
			@RequestParam(value="send_name",defaultValue="")String send_name,
			HttpSession session){
		LayuiAPiResult result=new LayuiAPiResult();
		SysUserEntity user = (SysUserEntity) session.getAttribute("loginUser");
		String userid = user.getUserid();
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("start", (page-1)*limit);
		map.put("size", limit);
		map.put("userid", userid);
		map.put("picname", send_name);
		
		// 查询总条数
	    int totalCount=imageIdentService.userGetTotalCount(map);
	    List<IdentPicEntity> identImg=null;
	    if (totalCount==0) {
		    	result.setCode(0);
				result.setMsg("该用户没有识别记录");
				result.setCount(totalCount);
				result.setData(identImg);
		}else {
			
			identImg=imageIdentService.getPages(map);
			System.out.println("识别内容是==="+identImg.get(0));
			
			if (identImg!=null) {
		    	result.setCode(0);
				result.setMsg("请求成功");
				result.setCount(totalCount);
				result.setData(identImg);
			}else {
				result.setCode(0);
				result.setMsg("该用户没有识别记录");
				result.setCount(totalCount);
				result.setData(identImg);
			}
			
		}
		
		return result;
	}
	
	/**
	 * getImageDataPage
	 * 管理员获取图片信息
	 */
	@RequestMapping("getImageDataPage")
	@ResponseBody
	public Object getImageDataPage(
			@RequestParam(value="page",defaultValue="1")Integer page,
			@RequestParam(value="limit",defaultValue="10")Integer limit,
			@RequestParam(value="send_name",defaultValue="")String send_name,
			HttpSession session){
		LayuiAPiResult result=new LayuiAPiResult();
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("start", (page-1)*limit);
		map.put("size", limit);
		map.put("picname", send_name);
		
		int totalCount=imageIdentService.adminGetCount(map);
		
		List<IdentPicEntity> identImg=imageIdentService.getImageDataPage(map);
		if (identImg!=null) {
	    	result.setCode(0);
			result.setMsg("请求成功");
			result.setCount(totalCount);
			result.setData(identImg);
		}else {
			result.setCode(1);
			result.setMsg("请求失败");
			
		}
		
		return result;
		
	}
	
	
	/**
	 * deleteById
	 */
	@PostMapping(value="deleteById")
	@ResponseBody
	public Object deleteIdentImage(HttpServletRequest request){
		String id = request.getParameter("id");
		AjaxResult result=new AjaxResult();
		try {
			int i=imageIdentService.deleteById(Long.valueOf(Integer.parseInt(id)));
			if (i==1) {
				result.setSuccess(true);
			}else {
				result.setSuccess(false);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
		}
		return result;
	}
	
	/**
	 * 用户保存识别图片结果
	 * saveIdentResultByUser
	 */
	@PostMapping(value="saveIdentResultByUser")
	@ResponseBody
	@ApiOperation(value = "用户保存识别图片结果",httpMethod = "POST", response = SysUserController.class)
	public AjaxResult saveIdentResultByUser(HttpServletRequest request,HttpServletResponse response){
		String conclusion = request.getParameter("conclusion");
		
		AjaxResult result=new AjaxResult();
	  
		// 前台传来的字符数组转换成字符串
		System.out.println("前台传来识别结果是==="+conclusion);
		
		
		IdentPicEntity ident=new IdentPicEntity();
		ident.setIdentresult(conclusion);
		try {
			if (imgesavepath==null || imgesavepath=="") {
				result.setSuccess(false);
				System.out.println("保存识别路径img不能为空");
			}else {
				ident.setIdentimg(imgesavepath);
				int i=imageIdentService.saveImageIdentResult(ident);
				System.out.println("i======="+i);
				if (i != 0) {
					result.setSuccess(true);
				}else {
					result.setSuccess(false);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
		}
		return result;
	}
	
	
	

}
