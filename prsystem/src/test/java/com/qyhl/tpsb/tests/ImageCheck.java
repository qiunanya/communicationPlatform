package com.qyhl.tpsb.tests;

import java.io.File;
import org.json.JSONObject;

import com.baidu.aip.imagecensor.AipImageCensor;

/**     
 * method：ImageCheck  
 * author：Qiu
 * time：2019-4-3 
 * @version 1.0.0
 */

public class ImageCheck {

	//设置APPID/AK/SK
    private static final String APP_ID = "15915411";
    private static final String API_KEY = "q2EW5LIwUagCUtZY4GTHpvWv";
    private static final String SECRET_KEY = "unW0vyybeGRzfegjCxG6SfecF2OwFeVl";

    
    /**
     * @param path 图片地址
     */
    public void checkPornograp(String path) {
        if (!new File(path).exists()) {
            throw new NullPointerException("图片不存在");
        }
        // 初始化一个AipImageCensor
        AipImageCensor client = new  AipImageCensor(APP_ID, API_KEY, SECRET_KEY);
        // 可选：设置网络连接参数
        client.setConnectionTimeoutInMillis(2000);
        client.setSocketTimeoutInMillis(60000);
        // 调用接口
        JSONObject res = client.antiPorn(path);
        System.out.println(res.toString(2));
    }


	public static void main(String[] args) {
		ImageCheck imageCheck = new ImageCheck();
		String path = "E:\\dachuangtupian\\dddd.gif";
		imageCheck.checkPornograp(path);

	}

}
