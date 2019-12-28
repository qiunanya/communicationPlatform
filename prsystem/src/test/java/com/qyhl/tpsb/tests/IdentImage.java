package com.qyhl.tpsb.tests;

import org.json.JSONObject;

import com.baidu.aip.imagecensor.AipImageCensor;


public class IdentImage {
	
	public static final String APP_ID = "15932836";	//APP_ID
    public static final String API_KEY = "N5eGLqemOnyQ3WDxEXRFp0Rn";	//API_KEY
    public static final String SECRET_KEY = "4kbh7TxNem0ZKfCRITcZe7fKyNkiOv0t";	//SECRET_KEY
    
    /*public static final String APP_ID = "15726174";	//APP_ID
    public static final String API_KEY = "O8wM3BUUvth7FRyZg3Len1It";	//API_KEY
    public static final String SECRET_KEY = "GKf4VZsu77UcGliiz96eipWcYKPmInGx";	//SECRET_KEY
    */    
    public static String getImage(String url) {
    	AipImageCensor client = new AipImageCensor(APP_ID, API_KEY, SECRET_KEY);

        client.setConnectionTimeoutInMillis(2000);
        client.setSocketTimeoutInMillis(60000);
        
        String content=sample(url,client);
        
        return content;
    }
    
    public static String sample(String url,AipImageCensor client) {
        
        JSONObject res = client.antiPorn(url);
        
        return res.toString();
        
    }

}
