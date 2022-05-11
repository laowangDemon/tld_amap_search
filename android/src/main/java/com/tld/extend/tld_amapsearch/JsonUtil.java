package com.tld.extend.tld_amapsearch;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import java.util.HashMap;
import java.util.Map;

public class JsonUtil {
    public static String toJson(Object o){
        if (o==null) return null;
        try {
            return JSON.toJSONString(o);
        }catch (Exception e){
            return null;
        }
    }

    public static <T> T fromJson(String json, TypeReference<T> typeReference){
        if (json==null) return null;
        try {
            return JSON.parseObject(json,typeReference);
        }catch (Exception e){
            return null;
        }
    }

    public static <T> Map<String,Object> toMap(T o){
        try {
            String s = JsonUtil.toJson(o);
            return JSON.parseObject(s,new TypeReference<Map<String, Object>>(){});
        }catch (Exception e){
            return new HashMap<>();
        }
    }
}
