class RouteResult {
  List<Paths>? paths;

  RouteResult({this.paths});

  RouteResult.fromJson(Map<String, dynamic> json) {
    if (json['paths'] != null) {
      paths = <Paths>[];
      json['paths'].forEach((v) {
        paths!.add(Paths.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.paths != null) {
      data['paths'] = this.paths!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Paths {
  num? restriction;
  String? polyline;
  num? distance;
  List<Steps>? steps;
  num? totalTrafficLights;
  num? duration;
  String? strategy;
  num? tollDistance;
  num? tolls;

  Paths(
      {this.restriction,
      this.polyline,
      this.distance,
      this.steps,
      this.totalTrafficLights,
      this.duration,
      this.strategy,
      this.tollDistance,
      this.tolls});

  Paths.fromJson(Map<String, dynamic> json) {
    restriction = json['restriction'];
    distance = json['distance'];
    if (json['steps'] != null) {
      steps = <Steps>[];
      json['steps'].forEach((v) {
        steps!.add(Steps.fromJson(v));
      });
    }
    totalTrafficLights = json['totalTrafficLights'];
    duration = json['duration'];
    strategy = json['strategy'];
    tollDistance = json['tollDistance'];
    tolls = json['tolls'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['restriction'] = this.restriction;
    data['distance'] = this.distance;
    if (this.steps != null) {
      data['steps'] = this.steps!.map((v) => v.toJson()).toList();
    }
    data['totalTrafficLights'] = this.totalTrafficLights;
    data['duration'] = this.duration;
    data['strategy'] = this.strategy;
    data['tollDistance'] = this.tollDistance;
    data['tolls'] = this.tolls;
    return data;
  }
}

class Steps {
  String? orientation;
  String? assistantAction;
  List<Cities>? cities;
  num? tollDistance;
  String? tollRoad;
  String? road;
  String? action;
  String? instruction;
  List<Tmcs>? tmcs;
  String? polyline;
  num? duration;
  num? distance;
  num? tolls;

  Steps(
      {this.orientation,
      this.assistantAction,
      this.cities,
      this.tollDistance,
      this.tollRoad,
      this.road,
      this.action,
      this.instruction,
      this.tmcs,
      this.polyline,
      this.duration,
      this.distance,
      this.tolls});

  Steps.fromJson(Map<String, dynamic> json) {
    orientation = json['orientation'];
    assistantAction = json['assistantAction'];
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities!.add(Cities.fromJson(v));
      });
    }
    tollDistance = json['tollDistance'];
    tollRoad = json['tollRoad'];
    road = json['road'];
    action = json['action'];
    instruction = json['instruction'];
    if (json['tmcs'] != null) {
      tmcs = <Tmcs>[];
      json['tmcs'].forEach((v) {
        tmcs!.add(Tmcs.fromJson(v));
      });
    }
    polyline = json['polyline'];
    duration = json['duration'];
    distance = json['distance'];
    tolls = json['tolls'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['orientation'] = this.orientation;
    data['assistantAction'] = this.assistantAction;
    if (this.cities != null) {
      data['cities'] = this.cities!.map((v) => v.toJson()).toList();
    }
    data['tollDistance'] = this.tollDistance;
    data['tollRoad'] = this.tollRoad;
    data['road'] = this.road;
    data['action'] = this.action;
    data['instruction'] = this.instruction;
    if (this.tmcs != null) {
      data['tmcs'] = this.tmcs!.map((v) => v.toJson()).toList();
    }
    data['polyline'] = this.polyline;
    data['duration'] = this.duration;
    data['distance'] = this.distance;
    data['tolls'] = this.tolls;
    return data;
  }
}

class Cities {
  String? citycode;
  int? num;
  List<Districts>? districts;
  String? city;
  String? adcode;

  Cities({this.citycode, this.num, this.districts, this.city, this.adcode});

  Cities.fromJson(Map<String, dynamic> json) {
    citycode = json['citycode'];
    num = json['num'];
    if (json['districts'] != null) {
      districts = <Districts>[];
      json['districts'].forEach((v) {
        districts!.add(Districts.fromJson(v));
      });
    }
    city = json['city'];
    adcode = json['adcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['citycode'] = this.citycode;
    data['num'] = this.num;
    if (this.districts != null) {
      data['districts'] = this.districts!.map((v) => v.toJson()).toList();
    }
    data['city'] = this.city;
    data['adcode'] = this.adcode;
    return data;
  }
}

class Districts {
  dynamic center;
  String? adcode;
  dynamic polylines;
  String? citycode;
  String? level;
  dynamic districts;
  String? name;

  Districts(
      {this.center,
      this.adcode,
      this.polylines,
      this.citycode,
      this.level,
      this.districts,
      this.name});

  Districts.fromJson(Map<String, dynamic> json) {
    center = json['center'];
    adcode = json['adcode'];
    polylines = json['polylines'];
    citycode = json['citycode'];
    level = json['level'];
    districts = json['districts'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['center'] = this.center;
    data['adcode'] = this.adcode;
    data['polylines'] = this.polylines;
    data['citycode'] = this.citycode;
    data['level'] = this.level;
    data['districts'] = this.districts;
    data['name'] = this.name;
    return data;
  }
}

class Tmcs {
  String? status;
  num? distance;
  String? polyline;

  Tmcs({this.status, this.distance, this.polyline});

  Tmcs.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    distance = json['distance'];
    polyline = json['polyline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['distance'] = this.distance;
    data['polyline'] = this.polyline;
    return data;
  }
}
