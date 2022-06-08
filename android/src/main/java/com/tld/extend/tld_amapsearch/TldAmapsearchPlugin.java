package com.tld.extend.tld_amapsearch;

import android.app.Activity;
import android.util.Log;

import androidx.annotation.NonNull;

import com.alibaba.fastjson.TypeReference;
import com.amap.api.services.core.LatLonPoint;
import com.amap.api.services.core.ServiceSettings;
import com.tld.extend.tld_amapsearch.TruckInfo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** TldAmapsearchPlugin */
public class TldAmapsearchPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {

  private MethodChannel channel;
  private Activity activity;

  AmapSearchClient amapSearchClient;
  GeocodingClient geocodingClient;

  public AmapSearchClient getAmapSearchClient() {
    if (amapSearchClient == null) amapSearchClient = new AmapSearchClient(activity);
    return amapSearchClient;
  }

  public GeocodingClient getGeocodingClient() {
    if (geocodingClient==null) geocodingClient = new GeocodingClient(activity);
    return geocodingClient;
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "tld_AmapSearch");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    switch (call.method){
      case "getPlatformVersion":
        result.success("Android " + android.os.Build.VERSION.RELEASE);
        break;
      case "initKey":
        // 初始化sdk
        String apiKey = call.argument("apiKey");
        ServiceSettings.getInstance().setApiKey(apiKey);
        result.success(true);
        break;
      case "updatePrivacyShow":
        // 显示用户协议
        Boolean hasShow = call.argument("hasShow");
        Boolean hasContains = call.argument("hasContains");
        if (hasShow==null) hasShow = false;
        if (hasContains==null) hasContains = false;
        ServiceSettings.updatePrivacyShow(activity,hasShow,hasContains);
        result.success("success");
        break;
      case "updatePrivacyAgree":
        //同意用户隐私协议
        Boolean hasAgree = call.argument("hasAgree");
        if (hasAgree==null) hasAgree = false;
        ServiceSettings.updatePrivacyAgree(activity,hasAgree);
        result.success("success");
        break;
      case "searchAround":
        // 搜索周边
        String keyWord = call.argument("keyWord");
        String city = call.argument("city");
        Integer page = call.argument("page");
        Integer limit = call.argument("limit");
        Integer radius = call.argument("radius");
        double longitude = call.argument("longitude");
        double latitude = call.argument("latitude");
        if (page == null) page = 0;
        if (limit == null) limit = 10;
        getAmapSearchClient().searchAround(longitude,latitude,keyWord,city,page,limit,radius,((code, data) -> {
          result.success(JsonUtil.toJson(toResult(code,data)));
        }));
        break;
      case "keywordsSearch":
        getAmapSearchClient().searchKeyWord(call.argument("keyWord"),call.argument("city"),call.argument("page"),call.argument("limit"),((code,data) -> {
          result.success(JsonUtil.toJson(toResult(code,data)));
        }));
        break;
      case "weatherSearch":
        getAmapSearchClient().searchWeather(call.argument("city"),call.argument("isLive"),((code, data) -> {
          result.success(JsonUtil.toJson(toResult(code,data)));
        }));
        break;
        case "geocoding":
        //地理编码
        String address = call.argument("address");
        String cityOrAdcode = call.argument("cityOrAdcode");
        getGeocodingClient().geocoding(address, cityOrAdcode, new SearchBack() {
          @Override
          public void back(final int code,final Map<String,Object> map) {
            result.success(JsonUtil.toJson(toResult(code,map)));
          }
        });
        break;
      case "reGeocoding":
        //逆地理编码
        Integer scope = call.argument("scope");
        if (scope == null) scope = 300;
        LatLonPoint latLonPoint  = new LatLonPoint(call.argument("latitude"), call.argument("longitude"));
        getGeocodingClient().reGeocoding(latLonPoint, scope, new SearchBack() {
          @Override
          public void back(final int code,final Map<String,Object> map) {
            result.success(JsonUtil.toJson(toResult(code,map)));
          }
        });
      case "routeSearch": {
        //线路规划
        Integer drivingMode = call.argument("drivingMode");
        double startLat = call.argument("startLat");
        double startLng = call.argument("startLng");
        double endLat = call.argument("endLat");
        double endLng = call.argument("endLng");
        getAmapSearchClient().routeSearch(new LatLonPoint(startLat, startLng),new LatLonPoint(endLat, endLng), drivingMode, new SearchBack() {
          @Override
          public void back(final int code,final Map<String,Object> map) {
            result.success(JsonUtil.toJson(toResult(code,map)));
          }
        });
        break;
      }
      case "truckRouteSearch": {
        //线路规划 --步行
        double startLat = call.argument("startLat");
        double startLng = call.argument("startLng");
        double endLat = call.argument("endLat");
        double endLng = call.argument("endLng");
        getAmapSearchClient().truckRouteSearch(new LatLonPoint(startLat, startLng), new LatLonPoint(endLat, endLng), new SearchBack() {
          @Override
          public void back(final int code,final Map<String,Object> map) {
            result.success(JsonUtil.toJson(toResult(code,map)));
          }
        });
        break;
      }
      default:
        result.notImplemented();
        break;
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    activity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {

  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
    onAttachedToActivity(binding);
  }

  @Override
  public void onDetachedFromActivity() {

  }

  private Map<String,Object> toResult(int code, Object o){
    Map<String,Object> map= new HashMap<>();
    map.put("code",code);
    map.put("data",o);
    return map;
  }

}
