// ignore_for_file: unnecessary_this, prefer_collection_literals

class SearchResult {
  List<Poi>? pois;

  SearchResult({this.pois});

  SearchResult.fromJson(Map<String, dynamic> json) {
    if (json['pois'] != null) {
      pois = <Poi>[];
      json['pois'].forEach((v) {
        pois!.add(Poi.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    if (this.pois != null) {
      data['pois'] = this.pois!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Poi {
  SearchLocation? location;
  String? city;
  String? citycode;
  String? district;
  String? province;
  String? adcode;
  String? address;
  String? type;
  String? typeCode;
  String? uid;
  String? tel;
  var distance;
  String? title;

  Poi(
      {this.location,
      this.district,
      this.province,
      this.tel,
      this.city,
      this.adcode,
      this.type,
      this.uid,
      this.distance,
      this.citycode,
      this.address,
      this.title,
      this.typeCode});

  Poi.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? SearchLocation.fromJson(json['location'])
        : null;
    district = json['district'];
    province = json['province'];
    typeCode = json['typeCode'];
    tel = json['tel'];
    city = json['city'];
    adcode = json['adcode'];
    type = json['type'];
    uid = json['uid'];
    distance = json['distance'];
    citycode = json['citycode'];
    address = json['address'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['district'] = this.district;
    data['province'] = this.province;
    data['typeCode'] = this.typeCode;
    data['tel'] = this.tel;
    data['city'] = this.city;
    data['adcode'] = this.adcode;
    data['type'] = this.type;
    data['uid'] = this.uid;
    data['distance'] = this.distance;
    data['citycode'] = this.citycode;
    data['address'] = this.address;
    data['title'] = this.title;
    return data;
  }
}

class SearchLocation {
  double? longitude;
  double? latitude;

  SearchLocation({this.longitude, this.latitude});

  SearchLocation.fromJson(Map<String, dynamic> json) {
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    return data;
  }
}
