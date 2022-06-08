package com.tld.extend.tld_amapsearch;

import java.io.Serializable;

public class TruckInfo implements Serializable {
    private String plateProvince;
    private String plateNumber;
    private float truckAxis;
    private float truckHeight;
    private float truckWidth;
    private float truckLoad;
    private float truckWeight;

    public TruckInfo(String plateProvince, String plateNumber, float truckAxis, float truckHeight, float truckWidth, float truckLoad, float truckWeight) {
        this.plateProvince = plateProvince;
        this.plateNumber = plateNumber;
        this.truckAxis = truckAxis;
        this.truckHeight = truckHeight;
        this.truckWidth = truckWidth;
        this.truckLoad = truckLoad;
        this.truckWeight = truckWeight;
    }

    public String getPlateProvince() {
        return plateProvince;
    }

    public void setPlateProvince(String plateProvince) {
        this.plateProvince = plateProvince;
    }

    public String getPlateNumber() {
        return plateNumber;
    }

    public void setPlateNumber(String plateNumber) {
        this.plateNumber = plateNumber;
    }

    public float getTruckAxis() {
        return truckAxis;
    }

    public void setTruckAxis(float truckAxis) {
        this.truckAxis = truckAxis;
    }

    public float getTruckHeight() {
        return truckHeight;
    }

    public void setTruckHeight(float truckHeight) {
        this.truckHeight = truckHeight;
    }

    public float getTruckWidth() {
        return truckWidth;
    }

    public void setTruckWidth(float truckWidth) {
        this.truckWidth = truckWidth;
    }

    public float getTruckLoad() {
        return truckLoad;
    }

    public void setTruckLoad(float truckLoad) {
        this.truckLoad = truckLoad;
    }

    public float getTruckWeight() {
        return truckWeight;
    }

    public void setTruckWeight(float truckWeight) {
        this.truckWeight = truckWeight;
    }
}
