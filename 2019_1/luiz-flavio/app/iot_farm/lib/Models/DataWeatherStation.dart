class DataWeatherStation {
  final int code_weatherstation;
  final String datereceive;
  final String stationidentifier;
  final int winddirection;
  final int windspeed;
  final int atmosphericpressure;
  final int waterevaporation;
  final String insolation;
  final int airhumidity;
  final int solarradiation;
  final int fluvialprecipitation;
  final int temperature;
  final int soiltemperature;

  DataWeatherStation(this.code_weatherstation,this.datereceive,this.stationidentifier,this.winddirection,this.windspeed,this.atmosphericpressure,
      this.waterevaporation,this.insolation,this.airhumidity,this.solarradiation,this.fluvialprecipitation,this.temperature,this.soiltemperature);

  DataWeatherStation.fromJson(Map<String, dynamic> json)
      : code_weatherstation = int.parse(json['code_weatherstation']),
        datereceive = json['datereceive'],
        stationidentifier = json['stationidentifier'],
        winddirection = int.parse(json['winddirection']),
        windspeed = int.parse(json['windspeed']),
        atmosphericpressure = int.parse(json['atmosphericpressure']),
        waterevaporation = int.parse(json['waterevaporation']),
        insolation = json['insolation'],
        airhumidity = int.parse(json['airhumidity']),
        solarradiation = int.parse(json['solarradiation']),
        fluvialprecipitation = int.parse(json['fluvialprecipitation']),
        temperature = int.parse(json['temperature']),
        soiltemperature = int.parse(json['soiltemperature']);

  Map<String, dynamic> toJson() =>
      {
        'code_weatherstation': code_weatherstation,
        'datereceive': datereceive,
        'stationidentifier': stationidentifier,
        'winddirection': winddirection,
        'windspeed': windspeed,
        'atmosphericpressure': atmosphericpressure,
        'waterevaporation': waterevaporation,
        'insolation': insolation,
        'airhumidity': airhumidity,
        'solarradiation': solarradiation,
        'fluvialprecipitation': fluvialprecipitation,
        'temperature': temperature,
        'soiltemperature': soiltemperature
      };
}