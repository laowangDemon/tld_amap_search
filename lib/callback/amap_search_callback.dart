// typedef InitBack = Function(int? code, bool data);
import 'package:tld_amapsearch/forecast_result.dart';
import 'package:tld_amapsearch/geocoding_result.dart';
import 'package:tld_amapsearch/live_result.dart';
import 'package:tld_amapsearch/poiresult.dart';
import 'package:tld_amapsearch/regeocoding_result.dart';

typedef PoiResultBack = Function(int? code, SearchResult data);
typedef LiveResultBack = Function(int? code, LiveResult data);
typedef ForeCastResultBack = Function(int? code, ForeCastResult data);
typedef GeocodingResultBack = Function(int? code, GeocodingResult data);
typedef ReGeocodingResultBack = Function(int? code, ReGeocodingResult data);
