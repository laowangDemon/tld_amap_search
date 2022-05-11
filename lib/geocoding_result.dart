// ignore_for_file: prefer_collection_literals, unnecessary_this

import 'package:tld_amapsearch/poiresult.dart';

class GeocodingResult {
  List<GeocodeAddressList>? geocodeAddressList;

  GeocodingResult({this.geocodeAddressList});

  GeocodingResult.fromJson(Map<String, dynamic> json) {
    if (json['geocodeAddressList'] != null) {
      geocodeAddressList = <GeocodeAddressList>[];
      json['geocodeAddressList'].forEach((v) {
        geocodeAddressList!.add(GeocodeAddressList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.geocodeAddressList != null) {
      data['geocodeAddressList'] =
          this.geocodeAddressList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GeocodeAddressList {
  String? neighborhood;
  String? postcode;
  String? building;
  String? province;
  String? level;
  String? formattedAddress;
  SearchLocation? location;
  String? city;
  String? citycode;
  String? district;
  String? adcode;
  String? township;
  String? country;

  GeocodeAddressList(
      {this.neighborhood,
      this.postcode,
      this.building,
      this.province,
      this.level,
      this.formattedAddress,
      this.location,
      this.city,
      this.citycode,
      this.district,
      this.adcode,
      this.township,
      this.country});

  GeocodeAddressList.fromJson(Map<String, dynamic> json) {
    neighborhood = json['neighborhood'];
    postcode = json['postcode'];
    building = json['building'];
    province = json['province'];
    level = json['level'];
    formattedAddress = json['formattedAddress'];
    location = json['location'] != null
        ? SearchLocation.fromJson(json['location'])
        : null;
    city = json['city'];
    citycode = json['citycode'];
    district = json['district'];
    adcode = json['adcode'];
    township = json['township'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['neighborhood'] = this.neighborhood;
    data['postcode'] = this.postcode;
    data['building'] = this.building;
    data['province'] = this.province;
    data['level'] = this.level;
    data['formattedAddress'] = this.formattedAddress;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['city'] = this.city;
    data['citycode'] = this.citycode;
    data['district'] = this.district;
    data['adcode'] = this.adcode;
    data['township'] = this.township;
    data['country'] = this.country;
    return data;
  }
}
