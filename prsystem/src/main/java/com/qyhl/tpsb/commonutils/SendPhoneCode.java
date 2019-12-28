package com.qyhl.tpsb.commonutils;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import java.io.IOException;
import java.net.URISyntaxException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

/**
 * 短信http接口的java代码调用示例
 * 依赖Apache HttpClient 3.1
 *
 * @author songchao
 * @since 2013-12-1
 */
public class SendPhoneCode {
    
    // 单条短信发送http地址
    private static String SINGLE_SEND_SMS="https://sms.yunpian.com/v2/sms/single_send.json";
    
    // 修改为您的apikey
    private static String APIKEY = "ff2dfda396f3c46eae4be03ee2a39c2b";

    //编码格式。发送编码格式统一用UTF-8
    private static String ENCODING = "UTF-8";

    /*public static void main(String[] args) throws IOException, URISyntaxException {
        //修改为您的apikey
        String apikey = "ff2dfda396f3c46eae4be03ee2a39c2b";
        //修改为您要发送的手机号
        String mobile = "18786014641";
        //设置您要发送的内容 (内容必须和某个模板匹配。以下例子匹配的是系统提供的1号模板）
        String text = "【邱南亚】欢迎注册，您的验证码是123456";
        //发短信调用示例
        System.out.println(SortMessageTest.sendSms(apikey, text, mobile));


    }*/

    /**
     * 通用接口发短信(推荐)
     *
     * @param apikey apikey
     * @param text   　短信内容
     * @param mobile 　接受的手机号
     * @return json格式字符串
     * @throws IOException
     */
    public static String sendSms(String text, String mobile) throws IOException {
        Map<String, String> params = new HashMap<String, String>();
        params.put("apikey", APIKEY);
        params.put("text", text);
        params.put("mobile", mobile);
        return post(SINGLE_SEND_SMS, params);
    }

    /**
     * 基于HttpClient 3.1的通用POST方法
     *
     * @param url       提交的URL
     * @param paramsMap 提交<参数，值>Map
     * @return 提交响应
     */
    public static String post(String url, Map<String, String> paramsMap) {
        HttpClient client = new HttpClient();
        try {
            PostMethod method = new PostMethod(url);
            if (paramsMap != null) {
                NameValuePair[] namePairs = new NameValuePair[paramsMap.size()];
                int i = 0;
                for (Map.Entry<String, String> param : paramsMap.entrySet()) {
                    NameValuePair pair = new NameValuePair(param.getKey(), param.getValue());
                    namePairs[i++] = pair;
                }
                method.setRequestBody(namePairs);
                HttpMethodParams param = method.getParams();
                param.setContentCharset(ENCODING);
            }
            client.executeMethod(method);
            return method.getResponseBodyAsString();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }
}