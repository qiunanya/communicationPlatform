package com.qyhl.tpsb.commonutils;

public class LayuiAPiResult {
	
	 //0:成功  1：失败
    private Integer code;
    //提示信息
    private String msg;
    
    //总条数
    private Integer count;
    
    private Object data;
    
    /**
	  * 当前页
	  */
    private Integer page = 1;
    /**
	  * 每页显示条数
	  */
    private Integer limit = 10;
    
//  //用户要返回浏览器的数据集合
//    private Map<String, Object> data2 = new HashMap<String, Object>();
	
	 //请求成功
    public static LayuiAPiResult success() {
    	LayuiAPiResult result = new LayuiAPiResult();
        result.setCode(0);
        result.setMsg("处理请求成功");
        return result;
    }

    //请求失败
    public static LayuiAPiResult failed() {
    	LayuiAPiResult result = new LayuiAPiResult();
        result.setCode(1);
        result.setMsg("处理请求失败");
        return result;
    }

	public Integer getCode() {
		return code;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}

	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public Integer getLimit() {
		return limit;
	}

	public void setLimit(Integer limit) {
		this.limit = limit;
	}

	

//	//链式返给浏览器
//    public APiResult add(String key, Object value) {
//        this.getData2().put(key, value);
//        return this;
//    }

    
	
}
