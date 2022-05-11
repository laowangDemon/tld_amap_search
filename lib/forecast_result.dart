// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class ForeCastResult {
  List<Weathers>? weathers;

  ForeCastResult({this.weathers});

  ForeCastResult.fromJson(Map<String, dynamic> json) {
    if (json['weathers'] != null) {
      weathers = <Weathers>[];
      json['weathers'].forEach((v) {
        weathers!.add(new Weathers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.weathers != null) {
      data['weathers'] = this.weathers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Weathers {
  String? date;
  String? week;
  String? nightWeather;
  String? dayWindDirection;
  String? dayTemp;
  String? nightWindDirection;
  String? weather;
  String? nightTemp;
  String? nightWindPower;
  String? dayWindPower;

  Weathers(
      {this.date,
      this.week,
      this.nightWeather,
      this.dayWindDirection,
      this.dayTemp,
      this.nightWindDirection,
      this.weather,
      this.nightTemp,
      this.nightWindPower,
      this.dayWindPower});

  Weathers.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    week = json['week'];
    nightWeather = json['nightWeather'];
    dayWindDirection = json['dayWindDirection'];
    dayTemp = json['dayTemp'];
    nightWindDirection = json['nightWindDirection'];
    weather = json['weather'];
    nightTemp = json['nightTemp'];
    nightWindPower = json['nightWindPower'];
    dayWindPower = json['dayWindPower'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['week'] = this.week;
    data['nightWeather'] = this.nightWeather;
    data['dayWindDirection'] = this.dayWindDirection;
    data['dayTemp'] = this.dayTemp;
    data['nightWindDirection'] = this.nightWindDirection;
    data['weather'] = this.weather;
    data['nightTemp'] = this.nightTemp;
    data['nightWindPower'] = this.nightWindPower;
    data['dayWindPower'] = this.dayWindPower;
    return data;
  }
}
