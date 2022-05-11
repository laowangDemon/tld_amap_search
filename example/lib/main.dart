// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tld_amapsearch/forecast_result.dart';
import 'package:tld_amapsearch/live_result.dart';
import 'dart:async';
import 'package:tld_amapsearch/poiresult.dart';
import 'package:tld_amapsearch/tld_amapsearch.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initAmapKey();
    setPrivacy();
  }

  /// 初始化高德key
  Future<void> initAmapKey() async {
    bool result =
        await TldAmapSearch.initKey(androidKey: '安卓key', iosKey: '苹果key');
    print(result);
  }

  /// 设置隐私权限
  setPrivacy() async {
    await TldAmapSearch.updatePrivacyShow(hasShow: true, hasContains: true);
    await TldAmapSearch.updatePrivacyAgree(hasAgree: true);
  }

  /// 周边范围搜索
  void searchAround() async {
    await TldAmapSearch.searchAround(
        longitude: 106.642904,
        latitude: 26.653841,
        back: (code, SearchResult data) {
          print(data);
        });
  }

  /// 关键字搜索
  void searchkeyword() async {
    await TldAmapSearch.searchKeyword(
        keyWord: '万达广场',
        back: (code, SearchResult data) {
          print(data);
        });
  }

  /// 天气查询
  void searchWeather() async {
    await TldAmapSearch.weatherSearch(
        city: '北京市',
        isLive: true,
        liveBack: (code, LiveResult result) {
          print(result);
        },
        foreBack: (code, ForeCastResult result) {
          print(result);
        });
  }

  // 地理编码
  void geocode() async {
    //地理编码
    await TldAmapSearch.geocoding(address: "北京市", back: (code, data) {});
    //逆地理编码
    await TldAmapSearch.reGeocoding(
        longitude: 106.642904, latitude: 26.653841, back: (code, data) {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              TextButton(child: Text('周边范围搜索'), onPressed: searchAround),
              SizedBox(height: 50),
              TextButton(child: Text('关键字搜索'), onPressed: searchkeyword),
              SizedBox(height: 50),
              TextButton(child: Text('天气查询'), onPressed: searchWeather)
            ],
          ),
        ),
      ),
    );
  }
}
