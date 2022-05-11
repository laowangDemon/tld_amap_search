// ignore_for_file: prefer_collection_literals, unnecessary_this

import 'package:tld_amapsearch/poiresult.dart';

class ReGeocodingResult {
  RegeocodeAddress? regeocodeAddress;

  ReGeocodingResult({this.regeocodeAddress});

  ReGeocodingResult.fromJson(Map<String, dynamic> json) {
    regeocodeAddress = json['regeocodeAddress'] != null
        ? RegeocodeAddress.fromJson(json['regeocodeAddress'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.regeocodeAddress != null) {
      data['regeocodeAddress'] = this.regeocodeAddress!.toJson();
    }
    return data;
  }
}

class RegeocodeAddress {
  dynamic roadinters;
  dynamic roads;
  AddressComponent? addressComponent;
  String? formattedAddress;
  dynamic pois;
  dynamic aois;

  RegeocodeAddress(
      {this.roadinters,
      this.roads,
      this.addressComponent,
      this.formattedAddress,
      this.pois,
      this.aois});

  RegeocodeAddress.fromJson(Map<String, dynamic> json) {
    roadinters = json['roadinters'];
    roads = json['roads'];
    addressComponent = json['addressComponent'] != null
        ? AddressComponent.fromJson(json['addressComponent'])
        : null;
    formattedAddress = json['formattedAddress'];
    pois = json['pois'];
    aois = json['aois'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['roadinters'] = this.roadinters;
    data['roads'] = this.roads;
    if (this.addressComponent != null) {
      data['addressComponent'] = this.addressComponent!.toJson();
    }
    data['formattedAddress'] = this.formattedAddress;
    data['pois'] = this.pois;
    data['aois'] = this.aois;
    return data;
  }
}

class AddressComponent {
  String? neighborhood;
  String? building;
  String? province;
  String? countryCode;
  String? city;
  String? citycode;
  String? district;
  String? adcode;
  StreetNumber? streetNumber;
  String? country;
  String? township;
  String? towncode;

  AddressComponent(
      {this.neighborhood,
      this.building,
      this.province,
      this.countryCode,
      this.city,
      this.citycode,
      this.district,
      this.adcode,
      this.streetNumber,
      this.country,
      this.township,
      this.towncode});

  AddressComponent.fromJson(Map<String, dynamic> json) {
    neighborhood = json['neighborhood'];
    building = json['building'];
    province = json['province'];
    countryCode = json['countryCode'];
    city = json['city'];
    citycode = json['citycode'];
    district = json['district'];
    adcode = json['adcode'];
    streetNumber = json['streetNumber'] != null
        ? StreetNumber.fromJson(json['streetNumber'])
        : null;
    country = json['country'];
    township = json['township'];
    towncode = json['towncode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['neighborhood'] = this.neighborhood;
    data['building'] = this.building;
    data['province'] = this.province;
    data['countryCode'] = this.countryCode;
    data['city'] = this.city;
    data['citycode'] = this.citycode;
    data['district'] = this.district;
    data['adcode'] = this.adcode;
    if (this.streetNumber != null) {
      data['streetNumber'] = this.streetNumber!.toJson();
    }
    data['country'] = this.country;
    data['township'] = this.township;
    data['towncode'] = this.towncode;
    return data;
  }
}

class StreetNumber {
  String? direction;
  String? number;
  String? street;
  SearchLocation? location;
  num? distance;

  StreetNumber(
      {this.direction, this.number, this.street, this.location, this.distance});

  StreetNumber.fromJson(Map<String, dynamic> json) {
    direction = json['direction'];
    number = json['number'];
    street = json['street'];
    location = json['location'] != null
        ? SearchLocation.fromJson(json['location'])
        : null;
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['direction'] = this.direction;
    data['number'] = this.number;
    data['street'] = this.street;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['distance'] = this.distance;
    return data;
  }
}
