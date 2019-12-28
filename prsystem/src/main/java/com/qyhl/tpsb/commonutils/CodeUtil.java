package com.qyhl.tpsb.commonutils;

import javax.servlet.http.HttpServletRequest;

public class CodeUtil {

	public static boolean checkVerifyCode(HttpServletRequest request){
        String verifyCodeExpected = (String)request.getSession().getAttribute(
                com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
        //这里相当于 request.getParameter("verifyCodeActual");
        //String verifyCodeActual = HttpServletRequestUtil.getString(request, "verifyCodeActual");
        String verifyCodeActual = request.getParameter("verifyCode");
        if(verifyCodeActual == null || !verifyCodeActual.equals(verifyCodeExpected)){
            return false;
        }
        return true;
    }

}
