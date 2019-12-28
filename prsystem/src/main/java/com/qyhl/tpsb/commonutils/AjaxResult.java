package com.qyhl.tpsb.commonutils;

public class AjaxResult {
	private Integer code;
	private boolean success;
    private Object data;
    private Integer state;
    private Integer userType;
    private String msg;
    private Object identResult;
    // 未分配角色
    private Object unAssignData;
    // 已分配角色
    private Object assignData;
	
	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public Integer getUserType() {
		return userType;
	}

	public void setUserType(Integer userType) {
		this.userType = userType;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Object getUnAssignData() {
		return unAssignData;
	}

	public void setUnAssignData(Object unAssignData) {
		this.unAssignData = unAssignData;
	}

	public Object getAssignData() {
		return assignData;
	}

	public void setAssignData(Object assignData) {
		this.assignData = assignData;
	}

	public Integer getCode() {
		return code;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

	public Object getIdentResult() {
		return identResult;
	}

	public void setIdentResult(Object identResult) {
		this.identResult = identResult;
	}
	
	
	
}
