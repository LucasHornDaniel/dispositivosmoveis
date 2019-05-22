
class Farm {

  int code_farm;
  String name;
  int activeSoilSensors,inactiveSoilSensors;
  int activeWeatherStations,inactiveWeatherStations;

  Farm(this.code_farm,this.name,this.activeSoilSensors,this.inactiveSoilSensors,this.activeWeatherStations,this.inactiveWeatherStations);

  Farm.fromJson(Map<String, dynamic> json)
      : code_farm = int.parse(json['code_farm']),
        name = json['name'],
        activeSoilSensors = int.parse(json['activesensor']),
        inactiveSoilSensors = int.parse(json['inactivesensor']),
        activeWeatherStations = int.parse(json['activestation']),
        inactiveWeatherStations = int.parse(json['inactivestation']);

  Map<String, dynamic> toJson() =>
      {
        'code_farm': code_farm,
        'name': name,
        'activesensor': activeSoilSensors,
        'inactivesensor': inactiveSoilSensors,
        'activestation': activeWeatherStations,
        'inactivestation': inactiveWeatherStations,
      };
}
