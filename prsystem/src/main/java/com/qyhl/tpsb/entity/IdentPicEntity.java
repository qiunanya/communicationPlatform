package com.qyhl.tpsb.entity;
/**
 * 图片识别实体类
 */
import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
@TableName("tb_identpic")
public class IdentPicEntity extends BaseInfo implements Serializable{

	private static final long serialVersionUID = 1L;
	@TableId
	private String identid;
	private String userid;
	private String imgname;
	private Date identtime;
	private String identimg;
	private String identurl;
	private String identcontent;
	private Integer status;
	private String identresult;
	private String username;
	public String getIdentid() {
		return identid;
	}
	public void setIdentid(String identid) {
		this.identid = identid;
	}
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getImgname() {
		return imgname;
	}
	public void setImgname(String imgname) {
		this.imgname = imgname;
	}
	public Date getIdenttime() {
		return identtime;
	}
	public void setIdenttime(Date identtime) {
		this.identtime = identtime;
	}
	public String getIdentimg() {
		return identimg;
	}
	public void setIdentimg(String identimg) {
		this.identimg = identimg;
	}
	public String getIdenturl() {
		return identurl;
	}
	public void setIdenturl(String identurl) {
		this.identurl = identurl;
	}
	public String getIdentcontent() {
		return identcontent;
	}
	public void setIdentcontent(String identcontent) {
		this.identcontent = identcontent;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	
	
	public String getIdentresult() {
		return identresult;
	}
	public void setIdentresult(String identresult) {
		this.identresult = identresult;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	
	@Override
	public String toString() {
		return "IdentPicEntity [identid=" + identid + ", userid=" + userid
				+ ", imgname=" + imgname + ", identtime=" + identtime
				+ ", identimg=" + identimg + ", identurl=" + identurl
				+ ", identcontent=" + identcontent + ", status=" + status
				+ ", identresult=" + identresult + ", username=" + username
				+ "]";
	}
	
	
	
	

}
