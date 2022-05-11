package com.tld.extend.tld_amapsearch;

import com.amap.api.services.geocoder.GeocodeResult;
import com.amap.api.services.geocoder.GeocodeSearch;
import com.amap.api.services.geocoder.RegeocodeResult;

public abstract class OnReGeocodeSearchListener implements  GeocodeSearch.OnGeocodeSearchListener{
    @Override
    public abstract void onRegeocodeSearched(RegeocodeResult regeocodeResult, int i);

    @Override
    public  void onGeocodeSearched(GeocodeResult geocodeResult, int i)  {

    }
}

