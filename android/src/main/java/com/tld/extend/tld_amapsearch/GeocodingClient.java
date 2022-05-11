package com.tld.extend.tld_amapsearch;

import android.content.Context;

import com.amap.api.services.core.AMapException;
import com.amap.api.services.core.LatLonPoint;
import com.amap.api.services.geocoder.GeocodeAddress;
import com.amap.api.services.geocoder.GeocodeQuery;
import com.amap.api.services.geocoder.GeocodeResult;
import com.amap.api.services.geocoder.GeocodeSearch;
import com.amap.api.services.geocoder.RegeocodeAddress;
import com.amap.api.services.geocoder.RegeocodeQuery;
import com.amap.api.services.geocoder.RegeocodeResult;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class GeocodingClient {
    private final Context context;
    private GeocodeSearch geocoderSearch = null;

    public GeocodingClient(Context context) {
        this.context = context;
    }

    public GeocodeSearch getGeocoderSearch() throws AMapException {
        if (geocoderSearch == null) geocoderSearch = new GeocodeSearch(context);
        return geocoderSearch;
    }

    /**
     * 地理编码（地址转坐标）
     */
    public void geocoding(String address, String cityOrAdcode, final SearchBack searchBack) {
        try {
            GeocodeQuery query = new GeocodeQuery(address, cityOrAdcode);
            getGeocoderSearch().getFromLocationNameAsyn(query);
            getGeocoderSearch().setOnGeocodeSearchListener(new OnGeocodeSearchListener() {
                @Override
                public void onGeocodeSearched(GeocodeResult geocodeResult, int code) {
                    Map<String,Object> map = new HashMap<>();
                    List<Map<String,Object>> geocodeAddressList = new ArrayList<>();
                    for (GeocodeAddress geocodeAddress:geocodeResult.getGeocodeAddressList()){
                        Map<String,Object> geocodeAddressMap = JsonUtil.toMap(geocodeAddress);
                        geocodeAddressMap.remove("latLonPoint");
                        geocodeAddressMap.put("location",geocodeAddress.getLatLonPoint());
                        geocodeAddressMap.put("formattedAddress",geocodeAddress.getFormatAddress());
                        geocodeAddressList.add(geocodeAddressMap);
                    }
                    map.put("geocodeAddressList",geocodeAddressList);
                    //解析result获取坐标信息
                    searchBack.back(code, map);
                }
            });
        } catch (AMapException e) {
            e.printStackTrace();
        }
    }

    /**
     * 逆地理编码（坐标转地址）
     */
    public void reGeocoding(LatLonPoint point, int scope, final SearchBack searchBack) {
        try {
            RegeocodeQuery query = new RegeocodeQuery(point, scope, GeocodeSearch.AMAP);
            getGeocoderSearch().getFromLocationAsyn(query);
            getGeocoderSearch().setOnGeocodeSearchListener(new OnReGeocodeSearchListener() {
                @Override
                public void onRegeocodeSearched(RegeocodeResult regeocodeResult, int i) {
                    Map<String,Object> map = new HashMap<>();
                    RegeocodeAddress address = regeocodeResult.getRegeocodeAddress();
                    Map<String,Object> regeocodeAddress = JsonUtil.toMap(address);
                    regeocodeAddress.remove("cityCode");
                    regeocodeAddress.put("citycode",address.getCityCode());
                    regeocodeAddress.put("formattedAddress",address.getFormatAddress());
                    Map<String,Object> addressComponent = new HashMap<>();
                    regeocodeAddress.remove("province");
                    addressComponent.put("province",address.getProvince());
                    regeocodeAddress.remove("city");
                    addressComponent.put("city",address.getCity());
                    regeocodeAddress.remove("citycode");
                    addressComponent.put("citycode",address.getCityCode());
                    regeocodeAddress.remove("adcode");
                    addressComponent.put("adcode",address.getAdCode());
                    regeocodeAddress.remove("country");
                    addressComponent.put("country",address.getCountry());
                    regeocodeAddress.remove("township");
                    addressComponent.put("township",address.getTownship());
                    regeocodeAddress.remove("towncode");
                    addressComponent.put("towncode",address.getTowncode());
                    regeocodeAddress.remove("district");
                    addressComponent.put("district",address.getDistrict());
                    if (address.getStreetNumber()!=null){
                        Map<String,Object> streetNumber = JsonUtil.toMap(address.getStreetNumber());
                        streetNumber.put("location",address.getStreetNumber().getLatLonPoint());
                        addressComponent.put("streetNumber",streetNumber);
                    }
                    regeocodeAddress.put("addressComponent",addressComponent);
                    map.put("regeocodeAddress",regeocodeAddress);
                    //解析result获取坐标信息
                    searchBack.back(i, map);
                }
            });
        } catch (AMapException e) {
            e.printStackTrace();
        }
    }
}
