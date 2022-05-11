package com.tld.extend.tld_amapsearch;

import com.amap.api.services.core.PoiItem;
import com.amap.api.services.poisearch.PoiResult;
import com.amap.api.services.poisearch.PoiSearch;

public abstract class PoiQueryListener implements PoiSearch.OnPoiSearchListener {
    @Override
    abstract public void onPoiSearched(PoiResult poiResult, int i);

    @Override
    public void onPoiItemSearched(PoiItem poiItem, int i) {

    }

}

