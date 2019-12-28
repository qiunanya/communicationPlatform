package com.qyhl.tpsb.tests;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;

import com.alibaba.fastjson.JSON;
import com.baidu.aip.imagecensor.AipImageCensor;
public class IdentImageTest {
	
	public static final String APP_ID = "15932836";
    public static final String API_KEY = "N5eGLqemOnyQ3WDxEXRFp0Rn";
    public static final String SECRET_KEY = "4kbh7TxNem0ZKfCRITcZe7fKyNkiOv0t";
    
    /**
     * public static final String APP_ID = "15760429";
    public static final String API_KEY = "hD1HN0HbGmKmfgegWMBSXeEy";
    public static final String SECRET_KEY = "8WBAh6nRotSGRRQETnLLMfQSGUasdOAo";
     * Anthor:Qiu
     * method：main       
     * @version 1.0.0
     * time:2019-4-3下午10:52:40
     */
    
    public static void main(String[] args) {
    	AipImageCensor client = new AipImageCensor(APP_ID, API_KEY, SECRET_KEY);
        client.setConnectionTimeoutInMillis(2000);
        client.setSocketTimeoutInMillis(60000);
        
        sample(client);
    }
    
    public static void sample(AipImageCensor client) {

     
        String image = "E:\\dachuangtupian\\fff.jpg";
        
        JSONObject res=client.antiPorn(image);	
        
        // 获取识别结果
        Map<String, Object> map=new HashMap<>();
        Object object = res.get("result");
        map.put("name", res.get("result"));
        System.out.println("识别map结果=="+map);
        System.out.println("取出map中的class_name"+map);
        
        System.out.println(res.toString());
        
    }

}