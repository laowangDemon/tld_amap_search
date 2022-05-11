// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class LiveResult {
  String? windPower;
  String? weather;
  String? temperature;
  String? humidity;
  String? windDirection;
  String? reportTime;

  LiveResult(
      {this.windPower,
      this.weather,
      this.temperature,
      this.humidity,
      this.windDirection,
      this.reportTime});

  LiveResult.fromJson(Map<String, dynamic> json) {
    windPower = json['windPower'];
    weather = json['weather'];
    temperature = json['temperature'];
    humidity = json['humidity'];
    windDirection = json['windDirection'];
    reportTime = json['reportTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['windPower'] = this.windPower;
    data['weather'] = this.weather;
    data['temperature'] = this.temperature;
    data['humidity'] = this.humidity;
    data['windDirection'] = this.windDirection;
    data['reportTime'] = this.reportTime;
    return data;
  }
}
