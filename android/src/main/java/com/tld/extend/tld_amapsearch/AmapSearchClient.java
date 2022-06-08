package com.tld.extend.tld_amapsearch;

import android.content.Context;
import android.util.Log;

import com.amap.api.services.core.AMapException;
import com.amap.api.services.core.LatLonPoint;
import com.amap.api.services.core.PoiItem;
import com.amap.api.services.poisearch.PoiResult;
import com.amap.api.services.poisearch.PoiSearch;
import com.amap.api.services.route.WalkPath;
import com.amap.api.services.route.WalkRouteResult;
import com.amap.api.services.route.WalkStep;
import com.amap.api.services.weather.LocalDayWeatherForecast;
import com.amap.api.services.weather.LocalWeatherForecastResult;
import com.amap.api.services.weather.LocalWeatherLive;
import com.amap.api.services.weather.LocalWeatherLiveResult;
import com.amap.api.services.weather.WeatherSearch;
import com.amap.api.services.weather.WeatherSearchQuery;
import com.amap.api.services.route.District;
import com.amap.api.services.route.DrivePath;
import com.amap.api.services.route.DriveRouteResult;
import com.amap.api.services.route.DriveStep;
import com.amap.api.services.route.RouteSearch;
import com.amap.api.services.route.RouteSearchCity;
import com.amap.api.services.route.TMC;
import com.tld.extend.tld_amapsearch.PoiQueryListener;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AmapSearchClient {

    private final Context context;

    public AmapSearchClient(Context context) {
        this.context = context;
    }

    // 周边范围搜索
    public void searchAround(double longitude, double latitude, String keyWord, String city, int page, int limit,int radius,final SearchBack searchBack) {
        try {
            PoiSearch.Query query = new PoiSearch.Query(keyWord,"",city);
            query.setPageSize(limit);// 设置每页最多返回多少条poiitem
            query.setPageNum(page);//设置查询页码
            PoiSearch poiSearch = new PoiSearch(context,query);
            poiSearch.setBound(new PoiSearch.SearchBound(new LatLonPoint(latitude,
                    longitude), radius));
            poiSearch.setOnPoiSearchListener(new PoiQueryListener() {
                @Override
                public void onPoiSearched(PoiResult poiResult, int i) {
                    Map<String,Object> map = new HashMap<>();
                    List<Map<String,Object>> pois = new ArrayList<>();
                    for (PoiItem poiItem:poiResult.getPois()){
                        Map<String,Object> poiItemMap = new HashMap<>();
                        poiItemMap.put("location",poiItem.getLatLonPoint());
                        poiItemMap.put("city",poiItem.getCityName());
                        poiItemMap.put("citycode",poiItem.getCityCode());
                        poiItemMap.put("district",poiItem.getAdName());
                        poiItemMap.put("province",poiItem.getProvinceName());
                        poiItemMap.put("adcode",poiItem.getAdCode());
                        poiItemMap.put("address",poiItem.getSnippet());
                        poiItemMap.put("type",poiItem.getTypeDes());
                        poiItemMap.put("typeCode",poiItem.getTypeCode());
                        poiItemMap.put("uid",poiItem.getPoiId());
                        poiItemMap.put("tel",poiItem.getTel());
                        poiItemMap.put("distance",poiItem.getDistance());
                        poiItemMap.put("title",poiItem.getTitle());
                        pois.add(poiItemMap);
                    }
                    map.put("pois",pois);
                    searchBack.back(i,map);
                }
            });
            poiSearch.searchPOIAsyn();
        }catch (AMapException e){

        }
    }

    // 关键字搜索
    public void searchKeyWord(String keyWord, String city, int page, int limit,final SearchBack searchBack) {
        try {
            PoiSearch.Query query = new PoiSearch.Query(keyWord,"",city);
            query.setPageSize(limit);// 设置每页最多返回多少条poiitem
            query.setPageNum(page);//设置查询页码
            PoiSearch poiSearch = new PoiSearch(context,query);
            poiSearch.setOnPoiSearchListener(new PoiQueryListener() {
                @Override
                public void onPoiSearched(PoiResult poiResult, int i) {
                    Map<String,Object> map = new HashMap<>();
                    List<Map<String,Object>> pois = new ArrayList<>();
                    for (PoiItem poiItem:poiResult.getPois()){
                        Map<String,Object> poiItemMap = new HashMap<>();
                        poiItemMap.put("location",poiItem.getLatLonPoint());
                        poiItemMap.put("city",poiItem.getCityName());
                        poiItemMap.put("citycode",poiItem.getCityCode());
                        poiItemMap.put("district",poiItem.getAdName());
                        poiItemMap.put("province",poiItem.getProvinceName());
                        poiItemMap.put("adcode",poiItem.getAdCode());
                        poiItemMap.put("address",poiItem.getSnippet());
                        poiItemMap.put("type",poiItem.getTypeDes());
                        poiItemMap.put("typeCode",poiItem.getTypeCode());
                        poiItemMap.put("uid",poiItem.getPoiId());
                        poiItemMap.put("tel",poiItem.getTel());
                        poiItemMap.put("distance",poiItem.getDistance());
                        poiItemMap.put("title",poiItem.getTitle());
                        pois.add(poiItemMap);
                    }
                    map.put("pois",pois);
                    searchBack.back(i,map);
                }
            });
            poiSearch.searchPOIAsyn();
        }catch (AMapException e){

        }
    }

    // 天气搜索
    public void searchWeather(String city,Boolean isLive,final SearchBack searchBack) {
        int type = 1;
        if (isLive){
            type = 1;
        }else{
            type = 2;
        }
        try {
            WeatherSearchQuery query = new WeatherSearchQuery(city, type);
            WeatherSearch weatherSearch = new WeatherSearch(context);
            weatherSearch.setQuery(query);
            weatherSearch.setOnWeatherSearchListener(new WeatherSearch.OnWeatherSearchListener() {
                @Override
                public void onWeatherLiveSearched(LocalWeatherLiveResult localWeatherLiveResult, int i) {
                    Map<String,Object> map = new HashMap<>();
                    if (localWeatherLiveResult != null&&localWeatherLiveResult.getLiveResult() != null) {
                        LocalWeatherLive result = localWeatherLiveResult.getLiveResult();
                        map.put("weather",result.getWeather());
                        map.put("reportTime",result.getReportTime());
                        map.put("temperature",result.getTemperature());
                        map.put("windDirection",result.getWindDirection());
                        map.put("windPower",result.getWindPower());
                        map.put("humidity",result.getHumidity());

                    }else{
                        map.put("message","天气获取失败，请参考错误码");
                    }
                    searchBack.back(i,map);
                }

                @Override
                public void onWeatherForecastSearched(LocalWeatherForecastResult localWeatherForecastResult, int i) {
                    Map<String,Object> map = new HashMap<>();
                    if (localWeatherForecastResult != null&&localWeatherForecastResult.getForecastResult() != null) {
                        List<Map<String,Object>> weathers = new ArrayList<>();
                        for (LocalDayWeatherForecast weather:localWeatherForecastResult.getForecastResult().getWeatherForecast()){
                            Map<String,Object> weatherMap = new HashMap<>();
                            weatherMap.put("weather",weather.getDayWeather());
                            weatherMap.put("date",weather.getDate());
                            weatherMap.put("nightWeather",weather.getNightWeather());
                            weatherMap.put("dayWindDirection",weather.getDayWindDirection());
                            weatherMap.put("dayTemp",weather.getDayTemp());
                            weatherMap.put("nightTemp",weather.getNightTemp());
                            weatherMap.put("nightWindDirection",weather.getNightWindDirection());
                            weatherMap.put("nightWindPower",weather.getNightWindPower());
                            weatherMap.put("week",weather.getWeek());
                            weatherMap.put("dayWindPower",weather.getDayWindPower());
                            weathers.add(weatherMap);
                        }
                        map.put("weathers",weathers);
                    }else{
                        map.put("message","天气获取失败，请参考错误码");
                    }
                    searchBack.back(i,map);
                }
            });
            weatherSearch.searchWeatherAsyn(); //异步搜索
        }catch (AMapException e){
            e.printStackTrace();
        }
    }

    /**
     * 普通线路规划
     */
    RouteSearch routeSearch;

    public RouteSearch getRouteSearch() throws AMapException {
        if (routeSearch == null) routeSearch = new RouteSearch(context);
        return routeSearch;
    }

    public void routeSearch(LatLonPoint start,LatLonPoint end, Integer drivingMode, final SearchBack searchBack) {
        try {
            final RouteSearch.FromAndTo fromAndTo = new RouteSearch.FromAndTo(
                    start, end);
            RouteSearch.DriveRouteQuery query = new RouteSearch.DriveRouteQuery(fromAndTo, 0, null,
                    null, "");// 第一个
            getRouteSearch().setRouteSearchListener(new DriveRouteSearchListener() {
                @Override
                public void onDriveRouteSearched(DriveRouteResult driveRouteResult, int i) {
                    Map<String,Object> map = new HashMap<>();
                    List<DrivePath> drivePaths = driveRouteResult.getPaths();
                    List<Map<String,Object>> paths = new ArrayList<>();
                    for (DrivePath drivePath:drivePaths){
                        Map<String, Object> pathMap = JsonUtil.toMap(drivePath);
                        String polyline = LatlngUtil.objListJoin(drivePath.getPolyline());
                        pathMap.put("polyline",polyline);
                        List<Map<String,Object>> steps = new ArrayList<>();
                        for (DriveStep step : drivePath.getSteps()){
                            Map<String, Object> stepMap = JsonUtil.toMap(step);
                            List<Map<String,Object>> citys = new ArrayList<>();
                            for (RouteSearchCity city:step.getRouteSearchCityList()){
                                Map<String, Object> cityMap = JsonUtil.toMap(city);
                                cityMap.put("city",city.getSearchCityName());
                                cityMap.put("adcode",city.getSearchCityAdCode());
                                cityMap.put("citycode",city.getSearchCitycode());
                                List<Map<String,Object>> districts = new ArrayList<>();
                                for (District district:city.getDistricts()){
                                    Map<String, Object> districtMap = JsonUtil.toMap(district);
                                    districtMap.put("adcode",district.getDistrictAdcode());
                                    districtMap.put("name",district.getDistrictName());
                                    districts.add(districtMap);
                                }
                                cityMap.put("district",districts);
                                citys.add(cityMap);
                            }
                            stepMap.remove("routeSearchCityList");
                            stepMap.put("cities",citys);
                            List<Map<String,Object>> tmcs = new ArrayList<>();
                            for (TMC tmc:step.getTMCs()){
                                Map<String, Object> tmcMap = JsonUtil.toMap(tmc);
                                tmcMap.put("polyline",LatlngUtil.objListJoin(tmc.getPolyline()));
                            }
                            stepMap.remove("tMCs");
                            stepMap.put("tmcs",tmcs);
                            stepMap.put("polyline",LatlngUtil.objListJoin(step.getPolyline()));
                            steps.add(stepMap);
                        }
                        pathMap.put("steps",steps);
                        paths.add(pathMap);
                    }
                    map.put("paths",paths);
                    searchBack.back(i,map);
                }
            });
            getRouteSearch().calculateDriveRouteAsyn(query);
        } catch (AMapException e) {
            e.printStackTrace();
        }
    }

    /**
     * 步行
     */
    public void truckRouteSearch(LatLonPoint start,LatLonPoint end, final SearchBack searchBack) {
        try {
          final RouteSearch.FromAndTo fromAndTo = new RouteSearch.FromAndTo(
                  start, end);
            RouteSearch.WalkRouteQuery query = new RouteSearch.WalkRouteQuery(fromAndTo, 0);
            getRouteSearch().setRouteSearchListener(new DriveRouteSearchListener() {
                @Override
                public void onDriveRouteSearched(DriveRouteResult driveRouteResult, int i) {

                }

                @Override
                public void onWalkRouteSearched(WalkRouteResult result, int code) {
                    Map<String, Object> map = new HashMap<>();
                    List<WalkPath> drivePaths = result.getPaths();
                    List<Map<String, Object>> paths = new ArrayList<>();
                    for (WalkPath walkPath : drivePaths) {
                        Map<String, Object> pathMap = JsonUtil.toMap(walkPath);
                        List<Map<String, Object>> steps = new ArrayList<>();
                        StringBuilder polylineStr = new StringBuilder();
                        for (WalkStep step : walkPath.getSteps()){
                            Map<String, Object> stepMap = JsonUtil.toMap(step);
                            stepMap.put("polyline",LatlngUtil.objListJoin(step.getPolyline()));
                            steps.add(stepMap);
                        }
                        pathMap.put("steps",steps);
                        paths.add(pathMap);
                    }
                    map.put("paths", paths);
                    searchBack.back(code, map);
                }
            });
            getRouteSearch().calculateWalkRouteAsyn(query);
        } catch (AMapException e) {
            e.printStackTrace();
        }
    }
}
