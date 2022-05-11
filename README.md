# tld_amapsearch

#### 介绍
高德地图插件的封装，在官方基础上增加查询控件，可以dev搜索以下控件:

#### 主要功能

1.增加地图查询功能，查询功能如下

​    （1）关键子检索 POI

​    （2）周边检索 POI

​    （3）天气检索

​    （4）地理编码（地址转坐标）

​    （5）逆地理编码（坐标转地址）


#### 安装教程
  ```dart
  tld_amap_search: ^last_version
  ```

#### 使用说明

1. ##### tld_amapsearch导包：
   ```dart
   import 'package:tld_amapsearch/tld_amapSearch.dart';
   ```

2. ###### 在官方sdk上重新封装过，如需使用，可单独引入：

   (1).定位权限配置，使用第三方 permission_handler 动态权限工具，  使用方法请移步 permission_handler
   (2).tld_amapsearch使用

   ``` Dart
  Future<void> initAmapKey() async {
    bool result =
        await TldAmapSearch.initKey(androidKey: '安卓key', iosKey: '苹果key');
    print(result);
  }

  setPrivacy() async {
    await TldAmapSearch.updatePrivacyShow(hasShow: true, hasContains: true);
    await TldAmapSearch.updatePrivacyAgree(hasAgree: true);
  }

  void searchAround() async {
    await TldAmapSearch.searchAround(
        longitude: 106.642904,
        latitude: 26.653841,
        back: (code, SearchResult data) {
          print(data);
        });
  }

  void searchkeyword() async {
    await TldAmapSearch.searchKeyword(
        keyWord: '万达广场',
        back: (code, SearchResult data) {
          print(data);
        });
  }
  
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

  void geocode() async {
    //地理编码
    await TldAmapSearch.geocoding(address: "北京市", back: (code, data) {});
    //逆地理编码
    await TldAmapSearch.reGeocoding(
        longitude: 106.642904, latitude: 26.653841, back: (code, data) {});
  }
  
  ```


