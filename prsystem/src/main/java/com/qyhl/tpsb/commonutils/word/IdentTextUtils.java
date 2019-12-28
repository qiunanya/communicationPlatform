package com.qyhl.tpsb.commonutils.word;

import java.io.UnsupportedEncodingException;

import org.apache.commons.httpclient.HttpStatus;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.alibaba.fastjson.JSONObject;
/**
 * 文本审核工具类
 * method：BaiduSensitiveWord  
 * author：Qiu
 * time：2019-9-1 
 * @version 1.0.0
 */
public class IdentTextUtils {
	/**
	 *  1	暴恐违禁	默认开启，高级设置可选择关闭
	 *	2	文本色情	默认开启，高级设置可选择关闭
	 *	3	政治敏感	默认开启，高级设置可选择关闭
	 *	4	恶意推广	默认开启，高级设置可选择关闭
     *	5	低俗辱骂	默认开启，高级设置可选择关闭
	 *	6	低质灌水	默认关闭，高级设置可选择开启（解释：没有意思的内容）
	 */
	
	//调用两种方式对比速度
    public static void main(String[] args) {
     String s= "过了一会，刘豪撸下一点白洁上身的裙口，看她露出软柔的部分，刘豪意乱神迷的吸了上去。再过了一会，白洁也呼吸有些加促，她的手忍不住轻轻握住了刘豪的那东西。随着轻抚的动作，白洁的身上裙子被褪了下来";
     String baiDu = identText(s);
     System.out.println("识别结果2="+baiDu);
    // checkText(s);
    }
    
    /**
     * 百度检查文字输入是否合格
     * 调api接口实现
     * @param content
     * @return
     */
    public static boolean checkText(String content){
        CloseableHttpClient client = HttpClientBuilder.create().build();
        String url = APIConfig.WORD_URL+"?access_token="+AuthService.getAuth();
        HttpPost post = new HttpPost(url);

        JSONObject response = null;
        try {
            StringEntity s = new StringEntity("content="+content);
            s.setContentEncoding("UTF-8");
            s.setContentType("application/x-www-form-urlencoded");
            post.setEntity(s);
            HttpResponse res = client.execute(post);
            //200
            if(res.getStatusLine().getStatusCode() == HttpStatus.SC_OK){
                String result = EntityUtils.toString(res.getEntity());
                // 返回json格式：
                System.out.println("识别结果1==="+result);
               // response = JSONObject.parseObject(result);
      
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return false;

    }

    
    /**
     * 测试文本方法2
     */
    public static String identText(String content){
    	// 获取授权码，过期的话需要重新获取一次
        String auth = AuthService.getAuth();
    	//String auth = "24.2dc1cce630cdd2d0b1da1bd9d41251aa.2592000.1569895153.282335-17153667";
     
        // https://aip.baidubce.com/rest/2.0/antispam/v1/spam
    	// 地址
        String url = "https://aip.baidubce.com/rest/2.0/antispam/v2/spam?access_token="+auth;
        HttpHeaders requestHeaders = new HttpHeaders();
        requestHeaders.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        
        MultiValueMap mvm = new LinkedMultiValueMap();
        mvm.add("content",content);
        HttpEntity requestEntity = new HttpEntity(mvm, requestHeaders);
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, requestEntity, String.class);
        String result = response.getBody();
        String str2 = convertEncodingFormat(result, "iso-8859-1", "UTF-8");
        
        return str2;

    }

    /**
     * 将一段错误解码的字符串重新解码
     */
    public static String convertEncodingFormat(String str, String formatFrom, String FormatTo) {
      String result = null;
      if (!(str == null || str.length() == 0)) {
        try {
          result = new String(str.getBytes(formatFrom), FormatTo);
        } catch (UnsupportedEncodingException e) {
          e.printStackTrace();
        }
      }
      return result;
    }
    
    
    	

}
