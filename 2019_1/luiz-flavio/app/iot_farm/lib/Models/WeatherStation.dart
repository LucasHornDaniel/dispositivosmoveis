import 'package:iot_farm/Data/ShowMessage.dart';
import 'package:iot_farm/Data/ConnectionAPI.dart';
import 'dart:convert';

class WeatherStation {

  String name, identifier;
  int code_farm,code_station;
  bool active;
  var values;

  WeatherStation(this.name, this.identifier, this.active, this.code_farm, this.code_station, {this.values});

  WeatherStation.fromJson(Map<String, dynamic> json)
      : code_farm = int.parse(json['code_farm']),
        code_station = int.parse(json['code_station']),
        name = json['name'],
        identifier = json['identifier'],
        active = (json['active'] == 'Y' ? true : false),
        values = json['values'];

  Map<String, dynamic> toJson() =>
      {
        'code_farm': code_farm,
        'code_station': code_station,
        'name': name,
        'identifier': identifier,
        'active': active,
        'values': values,
      };

  ConnectionAPI _connectionAPI = new ConnectionAPI();
  ShowMessage _showMessage = new ShowMessage();

  Future<bool> changeWeatherStationActiveState(context,bool newValue) async{
    return await SendNewState(context,newValue);
  }

  Future<bool> SendNewState(context,bool newValue) async{
    bool oldValue = newValue?false:true;

    try{
      _connectionAPI.url = "UpdateStationState";
      _connectionAPI.body = json.encode({
        "id":this.code_station,
        "active": newValue?'Y':'N',
      });
      var result = await _connectionAPI.doSimpleRequest("post");

      if(result == "true"){
        this.active = newValue;
        return newValue;
      } else {
        _showMessage.ShowMessageError(context,"The new state of the station could not be registered. Please, check the internet conection and try again later.");
        return oldValue;
      }
    }catch(e){
      print(e);
      _showMessage.ShowMessageError(context,"The new state of the station could not be registered. Please, try again.");
      return oldValue;
    }

  }

  String FormatMac(){
    return identifier.splitMapJoin(new RegExp("\.{2}"),onMatch: (m)=>'${m.group(0)+":"}').substring(0,17);
  }
}

