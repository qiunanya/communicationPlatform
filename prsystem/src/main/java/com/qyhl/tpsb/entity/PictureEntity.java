package com.qyhl.tpsb.entity;

import java.io.Serializable;
import java.util.Date;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
@TableName("tb_pic")
public class PictureEntity extends BaseInfo implements Serializable{
   

	private static final long serialVersionUID = 1L;
	@TableId
	private Long picid;
	private Long userid;
	private String picurl;
	private String pictitle;
	private Date uploadtime;
	private String piccontent;
	private Integer status;
	public Long getPicid() {
		return picid;
	}
	public void setPicid(Long picid) {
		this.picid = picid;
	}
	public Long getUserid() {
		return userid;
	}
	public void setUserid(Long userid) {
		this.userid = userid;
	}
	public String getPicurl() {
		return picurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}
	public String getPictitle() {
		return pictitle;
	}
	public void setPictitle(String pictitle) {
		this.pictitle = pictitle;
	}
	public Date getUploadtime() {
		return uploadtime;
	}
	public void setUploadtime(Date uploadtime) {
		this.uploadtime = uploadtime;
	}
	public String getPiccontent() {
		return piccontent;
	}
	public void setPiccontent(String piccontent) {
		this.piccontent = piccontent;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	
	@Override
	public String toString() {
		return "PictureEntity [picid=" + picid + ", userid=" + userid
				+ ", picurl=" + picurl + ", pictitle=" + pictitle
				+ ", uploadtime=" + uploadtime + ", piccontent=" + piccontent
				+ ", status=" + status + ", getPicid()=" + getPicid()
				+ ", getUserid()=" + getUserid() + ", getPicurl()="
				+ getPicurl() + ", getPictitle()=" + getPictitle()
				+ ", getUploadtime()=" + getUploadtime() + ", getPiccontent()="
				+ getPiccontent() + ", getStatus()=" + getStatus()
				+ ", getClass()=" + getClass() + ", hashCode()=" + hashCode()
				+ ", toString()=" + super.toString() + "]";
	}
	
	
	
	
}
