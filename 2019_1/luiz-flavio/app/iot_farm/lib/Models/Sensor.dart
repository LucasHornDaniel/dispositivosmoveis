import 'package:iot_farm/Data/ShowMessage.dart';
import 'package:iot_farm/Data/ConnectionAPI.dart';
import 'dart:convert';
import 'package:iot_farm/Models/DataGraphic.dart';

class Sensor {

  String name, identifier;
  int code_farm,code_sensor;
  bool active;
  List<DataGraphic> values;

  Sensor(this.name, this.identifier, this.active, this.code_farm, this.code_sensor, {this.values});

  Sensor.fromJson(Map<String, dynamic> json)
      : code_farm = int.parse(json['code_farm']),
        code_sensor = int.parse(json['code_sensor']),
        name = json['name'],
        identifier = json['identifier'],
        active = (json['active'] == 'Y' ? true : false),
        values = [];

  Map<String, dynamic> toJson() =>
      {
        'code_farm': code_farm,
        'code_sensor': code_sensor,
        'name': name,
        'identifier': identifier,
        'active': active,
        'values': values,
      };

  ConnectionAPI _connectionAPI = new ConnectionAPI();
  ShowMessage _showMessage = new ShowMessage();

  Future<bool> changeSoilSensorActiveState(context,bool newValue) async{
    return await SendNewState(context,newValue);
  }

  Future<bool> SendNewState(context,bool newValue) async{
    bool oldValue = newValue?false:true;

    try{
      _connectionAPI.url = "UpdateSensorState";
      _connectionAPI.body = json.encode({
        "id":this.code_sensor,
        "active": newValue?'Y':'N',
      });
      var result = await _connectionAPI.doSimpleRequest("post");

      if(result == "true"){
        this.active = newValue;
        return newValue;
      } else {
        _showMessage.ShowMessageError(context,"The new state of the sensor could not be registered. Please, check the internet conection and try again later.");
        return oldValue;
      }
    }catch(e){
      print(e);
      _showMessage.ShowMessageError(context,"The new state of the sensor could not be registered. Please, try again.");
      return oldValue;
    }

  }

  String FormatMac(){
    return identifier.splitMapJoin(new RegExp("\.{2}"),onMatch: (m)=>'${m.group(0)+":"}').substring(0,17);
  }
}
