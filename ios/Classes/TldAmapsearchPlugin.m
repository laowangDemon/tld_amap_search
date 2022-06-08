#import "TldAmapsearchPlugin.h"
#import <objc/runtime.h>

@implementation TldAmapsearchPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"tld_AmapSearch"
            binaryMessenger:[registrar messenger]];
  TldAmapsearchPlugin* instance = [[TldAmapsearchPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary<NSString*, id>* args = call.arguments;
    self.result = result;
    if ([call.method isEqualToString:@"initKey"]){
        [self initKey:args[@"apiKey"]];
    }else{
        self.search = [[AMapSearchAPI alloc] init];
        self.search.delegate = self;
        if ([call.method isEqualToString:@"updatePrivacyShow"]) {
            BOOL hasShow = (BOOL)[NSNumber numberWithBool:args[@"hasShow"]];
            BOOL hasContains = (BOOL)[NSNumber numberWithBool:args[@"hasContains"]];
            [self setPrivacyShow:hasShow andContains:hasContains];
        }else if ([call.method isEqualToString:@"updatePrivacyAgree"]) {
            BOOL hasAgree = (BOOL)[NSNumber numberWithBool:args[@"hasAgree"]];
            [self setPrivacyAgree:hasAgree];
        }else if ([call.method isEqualToString:@"searchAround"]) {
            double lat = [args[@"latitude"] doubleValue];
            double lng = [args[@"longitude"] doubleValue];
            NSString *keyword = args[@"keyWord"];
            NSString *city = args[@"city"];
            int limit = [args[@"limit"] intValue];
            int page = [args[@"page"] intValue];
            int radius = [args[@"radius"] intValue];
            [self searchAroundWithLng:lng andLat:lat andKeyWord:keyword andCity:city andLimit:limit andPage:page andRadius:radius];
        }else if ([call.method isEqualToString:@"keywordsSearch"]) {
            NSString *keyword = args[@"keyWord"];
            NSString *city = args[@"city"];
            int limit = [args[@"limit"] intValue];
            int page = [args[@"page"] intValue];
            [self searchKeyWordWithKeyWord:keyword andCity:city andLimit:limit andPage:page];
        }else if ([call.method isEqualToString:@"weatherSearch"]) {
            NSString *city = args[@"city"];
            bool isLive = [args[@"isLive"] boolValue];
            [self searchWeatherWithCity:city andIsLive:isLive];
        }else if ([call.method isEqualToString:@"geocoding"]) {
            NSString* address = args[@"address"];
            NSString* cityOrAdcode = args[@"cityOrAdcode"];
            [self searchGeoWithAddress:address andCityCode:cityOrAdcode];
        }else if ([call.method isEqualToString:@"reGeocoding"]) {
            double lat = [args[@"latitude"] doubleValue];
            double lng = [args[@"longitude"] doubleValue];
            int scope = 300;
            [self searchReGeoWithLng:lng andLat:lat andScope:scope];
        } else if ( ([@"routeSearch" isEqualToString:call.method])) {
            NSNumber* drivingMode = args[@"drivingMode"];
            double lat1 = [args[@"startLat"] doubleValue];
            double lng1 = [args[@"startLng"] doubleValue];
            double lat2 = [args[@"endLat"] doubleValue];
            double lng2 = [args[@"endLng"] doubleValue];
            //起点对象
            AMapGeoPoint* origin =[AMapGeoPoint locationWithLatitude:lat1 longitude:lng1];
            //终点对象
            AMapGeoPoint* destination =[AMapGeoPoint locationWithLatitude:lat2 longitude:lng2];
            //构造途径点对象集合
            NSMutableArray<AMapGeoPoint *> *waypoints = [NSMutableArray array];
            [waypoints addObject:origin];
            [waypoints addObject:destination];
            //构造高德地图检索请求
            AMapDrivingRouteSearchRequest *navi = [[AMapDrivingRouteSearchRequest alloc] init];
            navi.requireExtension = YES;
            if(![drivingMode isEqual:[NSNull null]]){
                navi.strategy = drivingMode.intValue;
            }
            navi.origin = origin;
            navi.destination = destination;
            navi.waypoints = waypoints;
            //发送请求
            [self.search AMapDrivingRouteSearch:navi];
        } else if ( ([@"truckRouteSearch" isEqualToString:call.method])) {
            NSString* wayPointsJson = args[@"wayPointsJson"];
            double lat1 = [args[@"startLat"] doubleValue];
            double lng1 = [args[@"startLng"] doubleValue];
            double lat2 = [args[@"endLat"] doubleValue];
            double lng2 = [args[@"endLng"] doubleValue];
            //起点对象
            AMapGeoPoint* origin =[AMapGeoPoint locationWithLatitude:lat1 longitude:lng1];
            //终点对象
            AMapGeoPoint* destination =[AMapGeoPoint locationWithLatitude:lat2 longitude:lng2];

            //构造高德地图检索请求
            AMapWalkingRouteSearchRequest *nav = [[AMapWalkingRouteSearchRequest alloc]  init];
            nav.origin=origin;
            nav.destination=destination;
            //发送请求
            [self.search AMapWalkingRouteSearch:nav];
        } else{
            result(FlutterMethodNotImplemented);
        }
    }
}

/// 初始化
- (void)initKey:(NSString*)apiKey {
    [AMapServices sharedServices].apiKey = apiKey;
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
}

/// 设置隐私协议
- (void)setPrivacyShow:(BOOL)hasShow andContains:(BOOL)hasContains {
    AMapPrivacyShowStatus showStatus = hasShow?AMapPrivacyShowStatusDidShow:AMapPrivacyShowStatusNotShow;
    AMapPrivacyInfoStatus infoStatus = hasContains?AMapPrivacyInfoStatusDidContain:AMapPrivacyInfoStatusNotContain;
    [AMapSearchAPI updatePrivacyShow:showStatus privacyInfo:infoStatus];
}

- (void)setPrivacyAgree:(BOOL)hasAgree {
    AMapPrivacyAgreeStatus agreeStatus = hasAgree?AMapPrivacyAgreeStatusDidAgree:AMapPrivacyAgreeStatusNotAgree;;
    [AMapSearchAPI updatePrivacyAgree:agreeStatus];
}

/// 周边范围搜索
-(void)searchAroundWithLng:(double)longitude andLat:(double)latitude andKeyWord:(NSString *)keyWord andCity:(NSString *)city andLimit:(int)limit andPage:(int)page andRadius:(int)radius {
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location            = [AMapGeoPoint locationWithLatitude:latitude longitude:longitude];
    request.keywords            = keyWord;
    request.radius = radius;
    request.page = page;
    request.city = city;
    request.offset = limit;
    request.requireExtension    = YES;
    [self.search AMapPOIAroundSearch:request];
}

/// 关键字搜索
-(void)searchKeyWordWithKeyWord:(NSString *)keyWord andCity:(NSString *)city andLimit:(int)limit andPage:(int)page {
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    request.keywords            = keyWord;
    request.city                = city;
    request.requireExtension    = YES;
    //搜索SDK 3.2.0 中新增加的功能，只搜索本城市的POI
    request.cityLimit           = YES;
    request.requireSubPOIs      = YES;
    [self.search AMapPOIKeywordsSearch:request];
}


/// 获取天气数据
- (void)searchWeatherWithCity:(NSString *)city andIsLive:(BOOL)isLive{
    AMapWeatherSearchRequest *request = [[AMapWeatherSearchRequest alloc] init];
    request.city = city;
    request.type = isLive ? AMapWeatherTypeLive : AMapWeatherTypeForecast;
    [self.search AMapWeatherSearch:request];
}

/// 地理编码
- (void)searchGeoWithAddress:(NSString *)address andCityCode:(NSString *)cityCode {
    //构造查询
    AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc] init];
    geo.address = address;
    geo.city = cityCode;
    //发送请求
    [self.search AMapGeocodeSearch:geo];
}

/// 逆地理编码
- (void)searchReGeoWithLng:(double)longitude andLat:(double)latitude andScope:(int)scope {
    //构造查询
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    regeo.location  = [AMapGeoPoint locationWithLatitude:latitude longitude:longitude];
    regeo.radius = scope;
    //发送请求
    [self.search AMapReGoecodeSearch:regeo];
}

#pragma mark ---------AMapSearchDelegate-------
///  搜索回调
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    // poi列表
    NSArray<AMapPOI *>* poiArray = response.pois;
    NSMutableArray<NSMutableDictionary *> *pois = [NSMutableArray arrayWithCapacity:poiArray.count];
    for (AMapPOI *poi in poiArray) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        NSDictionary *locationDict = @{
            @"longitude":[NSNumber numberWithFloat:poi.location.longitude],
            @"latitude":[NSNumber numberWithFloat:poi.location.latitude],
        };
        [dict setValue:locationDict forKey:@"location"];
        [dict setValue:poi.city forKey:@"city"];
        [dict setValue:poi.citycode forKey:@"citycode"];
        [dict setValue:poi.province forKey:@"province"];
        [dict setValue:poi.adcode forKey:@"adcode"];
        [dict setValue:poi.address forKey:@"address"];
        [dict setValue:poi.type forKey:@"type"];
        [dict setValue:poi.typecode forKey:@"typeCode"];
        [dict setValue:poi.uid forKey:@"uid"];
        [dict setValue:poi.tel forKey:@"tel"];
        [dict setValue:[NSString stringWithFormat:@"%ld",(long)poi.distance] forKey:@"distance"];
        [dict setValue:poi.name forKey:@"title"];
        [dict setValue:poi.district forKey:@"district"];
        [pois addObject:dict];
    }
    //重新构造完成 数据为配合android已调整
    NSDictionary* map = @{
        @"code":@1000,
        @"data":@{@"pois":pois}
    };
    //转 json 字符串
    NSData* jsonData =[NSJSONSerialization dataWithJSONObject:map options:NSJSONWritingPrettyPrinted error:nil];
    NSString* jsonStr =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    if (self.result != nil) {
        self.result(jsonStr);
    }
}

/// 天气回调
- (void)onWeatherSearchDone:(AMapWeatherSearchRequest *)request response:(AMapWeatherSearchResponse *)response {
    if (response.lives.count != 0){
        NSArray<AMapLocalWeatherLive *> *livesArray = response.lives;
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        AMapLocalWeatherLive *live = livesArray[0];
        [dict setValue:live.weather forKey:@"weather"];
        [dict setValue:live.reportTime forKey:@"reportTime"];
        [dict setValue:live.temperature forKey:@"temperature"];
        [dict setValue:live.windDirection forKey:@"windDirection"];
        [dict setValue:live.windPower forKey:@"windPower"];
        [dict setValue:live.humidity forKey:@"humidity"];
        //重新构造完成 数据为配合android已调整
        NSDictionary* map = @{
            @"code":@1000,
            @"data":dict
        };
        //转 json 字符串
        NSData* jsonData =[NSJSONSerialization dataWithJSONObject:map options:NSJSONWritingPrettyPrinted error:nil];
        NSString* jsonStr =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        if (self.result != nil) {
            self.result(jsonStr);
        }
    }else{
        NSArray<AMapLocalDayWeatherForecast *> *foreArray = response.forecasts[0].casts;
        NSMutableArray<NSMutableDictionary *> *focus = [NSMutableArray arrayWithCapacity:foreArray.count];
        for (AMapLocalDayWeatherForecast *fores in foreArray) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setValue:fores.dayWeather forKey:@"weather"];
            [dict setValue:fores.date forKey:@"date"];
            [dict setValue:fores.nightWeather forKey:@"nightWeather"];
            [dict setValue:fores.dayWind forKey:@"dayWindDirection"];
            [dict setValue:fores.dayTemp forKey:@"dayTemp"];
            [dict setValue:fores.nightTemp forKey:@"nightTemp"];
            [dict setValue:fores.nightWind forKey:@"nightWindDirection"];
            [dict setValue:fores.nightPower forKey:@"nightWindPower"];
            [dict setValue:fores.week forKey:@"week"];
            [dict setValue:fores.dayPower forKey:@"dayWindPower"];
            [focus addObject:dict];
        }
        //重新构造完成 数据为配合android已调整
        NSDictionary* map = @{
            @"code":@1000,
            @"data":@{@"weathers":focus}
        };
        //转 json 字符串
        NSData* jsonData =[NSJSONSerialization dataWithJSONObject:map options:NSJSONWritingPrettyPrinted error:nil];
        NSString* jsonStr =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        if (self.result != nil) {
            self.result(jsonStr);
        }
    }
}

/* 地理编码*/
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response{
    NSArray<AMapGeocode *> *geocodes = [response geocodes];
    NSMutableArray<NSDictionary *> *geocodeAddressList = [NSMutableArray arrayWithCapacity:geocodes.count];
    for(AMapGeocode* gc in geocodes){
        [geocodeAddressList addObject:[self getObjectData:gc]];
    }
    //重新构造完成 数据为配合android已调整
    NSDictionary* map = @{
        @"code":@1000,
        @"data":@{
            @"geocodeAddressList":geocodeAddressList
        }
    };
    //转 json 字符串
    NSData* jsonData =[NSJSONSerialization dataWithJSONObject:map options:NSJSONWritingPrettyPrinted error:nil];
    NSString* jsonStr =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    self.result(jsonStr);
}

/* 逆地理编码回调. */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
    AMapReGeocode *regeocode = [response regeocode];
    NSDictionary* regeocodeAddress = [self getObjectData:regeocode];
    //重新构造完成 数据为配合android已调整
    NSDictionary* map = @{
        @"code":@1000,
        @"data":@{
            @"regeocodeAddress":regeocodeAddress
        }
    };
    //转 json 字符串
    NSData* jsonData =[NSJSONSerialization dataWithJSONObject:map options:NSJSONWritingPrettyPrinted error:nil];
    NSString* jsonStr =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    self.result(jsonStr);
}

/* 路径规划(含货车)搜索回调. */
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response{
    AMapRoute *route = [response route];
    //只返回驾车路径信息
    NSArray<AMapPath *>* pathArr = [route paths];
    NSMutableArray<NSDictionary *> *paths = [NSMutableArray arrayWithCapacity:pathArr.count];
    for(AMapPath* path in pathArr){
        //NSString *polyline = [path polyline];
        [paths addObject:[self getObjectData:path]];
    }
    //重新构造完成 数据为配合android已调整
    NSDictionary* map = @{
        @"code":@1000,
        @"data":@{
            @"paths":paths
        }
    };
    //转 json 字符串
    NSData* jsonData =[NSJSONSerialization dataWithJSONObject:map options:NSJSONWritingPrettyPrinted error:nil];
    NSString* jsonStr =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    self.result(jsonStr);
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error{
    NSDictionary* map = @{
        @"code":[NSNumber numberWithInteger:error.code],
        @"message":@"请参考错误码"
    };
    //转 json 字符串
    NSData* jsonData =[NSJSONSerialization dataWithJSONObject:map options:NSJSONWritingPrettyPrinted error:nil];
    NSString* jsonStr =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    self.result(jsonStr);
}


//转NSMutableDictionary
- (NSDictionary*)getObjectData:(id)obj{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);//获得属性列表
    for(int i = 0;i < propsCount; i++){
        objc_property_t prop = props[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];//获得属性的名称
        id value = [obj valueForKey:propName];//kvc读值
        if(value == nil){
            value = [NSNull null];
        }else{
            value = [self getObjectInternal:value];//自定义处理数组，字典，其他类
        }
        [dic setObject:value forKey:propName];
    }
    return dic;
}

- (id)getObjectInternal:(id)obj{
    if([obj isKindOfClass:[NSString class]]
       || [obj isKindOfClass:[NSNumber class]]
       || [obj isKindOfClass:[NSNull class]])
    {
        return obj;
    }
    
    if([obj isKindOfClass:[NSArray class]])
    {
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for(int i = 0;i < objarr.count; i++)
        {
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    
    if([obj isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for(NSString *key in objdic.allKeys)
        {
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self getObjectData:obj];
}


@end
