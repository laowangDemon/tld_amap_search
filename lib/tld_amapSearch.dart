import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:tld_amapsearch/callback/amap_search_callback.dart';
import 'package:tld_amapsearch/forecast_result.dart';
import 'package:tld_amapsearch/geocoding_result.dart';
import 'package:tld_amapsearch/live_result.dart';
import 'package:tld_amapsearch/poiresult.dart';
import 'package:tld_amapsearch/regeocoding_result.dart';
import 'package:tld_amapsearch/route_result.dart';
import 'package:tld_amapsearch/truckInfo_result.dart';

class TldAmapSearch {
  static const MethodChannel _channel = MethodChannel('tld_AmapSearch');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// 初始化key
  static Future<bool> initKey(
      {required String androidKey, required String iosKey}) async {
    bool result = await _channel.invokeMethod('initKey', {
      "apiKey": Platform.isIOS ? iosKey : androidKey,
    });
    return result;
  }

  /// 隐私协议
  static Future<void> updatePrivacyShow(
      {bool? hasShow, bool? hasContains}) async {
    await _channel.invokeMethod('updatePrivacyShow',
        {"hasShow": hasShow ?? false, "hasContains": hasContains ?? false});
  }

  static Future<void> updatePrivacyAgree({bool? hasAgree}) async {
    await _channel
        .invokeMethod('updatePrivacyAgree', {"hasAgree": hasAgree ?? false});
  }

  /// 周边搜索
  static Future<void> searchAround(
      {required double longitude,
      required double latitude,
      String keyWord = '',
      String city = '',
      int limit = 20,
      int page = 1,
      int radius = 1000,
      PoiResultBack? back}) async {
    String result = await _channel.invokeMethod('searchAround', {
      'longitude': longitude,
      'latitude': latitude,
      'keyWord': keyWord,
      'city': city,
      'limit': limit,
      'page': page,
      'radius': radius
    });
    if (result.isNotEmpty) {
      Map? map = json.decode(result);
      if (map != null && back != null) {
        back(map['code'] as int, SearchResult.fromJson(map["data"]));
      }
    }
  }

  /// 关键字搜索
  static Future<void> searchKeyword(
      {required String? keyWord,
      String? city,
      int? page = 1,
      int? limit = 20,
      PoiResultBack? back}) async {
    var result = await _channel.invokeMethod('keywordsSearch', {
      "keyWord": keyWord,
      "city": city,
      "page": page,
      "limit": limit,
    });
    if (result.isNotEmpty) {
      Map? map = json.decode(result);
      if (map != null && back != null) {
        back(map['code'] as int, SearchResult.fromJson(map["data"]));
      }
    }
  }

  /// 天气查询
  /// isLive是否是实时天气
  static Future<void> weatherSearch(
      {required String city,
      bool isLive = true,
      LiveResultBack? liveBack,
      ForeCastResultBack? foreBack}) async {
    var result = await _channel
        .invokeMethod('weatherSearch', {'city': city, 'isLive': isLive});
    if (result.isNotEmpty) {
      Map? map = json.decode(result);
      if (isLive) {
        if (map != null && liveBack != null) {
          liveBack(map['code'] as int, LiveResult.fromJson(map["data"]));
        }
      } else {
        if (map != null && foreBack != null) {
          foreBack(map['code'] as int, ForeCastResult.fromJson(map["data"]));
        }
      }
    }
  }

  ///地理编码
  static Future<void> geocoding({
    required String? address,
    String? cityOrAdcode,
    GeocodingResultBack? back,
  }) async {
    final String? jsonStr = await _channel.invokeMethod('geocoding', {
      "address": address,
      "cityOrAdcode": cityOrAdcode,
    });
    if (jsonStr != null) {
      Map? map = json.decode(jsonStr);
      if (map != null && back != null) {
        back(map['code'] as int, GeocodingResult.fromJson(map["data"]));
      }
    }
  }

  ///逆地理编码
  static Future<void> reGeocoding(
      {required double longitude,
      required double latitude,
      ReGeocodingResultBack? back}) async {
    final String? jsonStr = await _channel.invokeMethod(
        'reGeocoding', {"longitude": longitude, "latitude": latitude});
    if (jsonStr != null) {
      Map? map = json.decode(jsonStr);
      if (map != null && back != null) {
        back(map['code'] as int, ReGeocodingResult.fromJson(map["data"]));
      }
    }
  }

  /// 驾车线路规划
  static Future<void> routeSearch({
    required List<SearchLocation> wayPoints,
    int? drivingMode,
    RouteResultBack? back,
  }) async {
    final String? jsonStr = await _channel.invokeMethod('routeSearch', {
      "wayPointsJson": json.encode(wayPoints),
      "drivingMode": drivingMode,
    });
    if (jsonStr != null) {
      Map? map = json.decode(jsonStr);
      if (map != null && back != null) {
        back(map['code'] as int, RouteResult.fromJson(map["data"]));
      }
    }
  }

  /// 步行线路规划
  static Future<void> truckRouteSearch({
    required List<SearchLocation> wayPoints,
    RouteResultBack? back,
  }) async {
    final String? jsonStr = await _channel.invokeMethod(
        'truckRouteSearch', {"wayPointsJson": json.encode(wayPoints)});
    if (jsonStr != null) {
      Map? map = json.decode(jsonStr);
      if (map != null && back != null) {
        back(map['code'] as int, RouteResult.fromJson(map["data"]));
      }
    }
  }
}
