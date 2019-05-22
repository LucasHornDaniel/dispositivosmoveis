import 'package:flutter/material.dart';
import 'package:iot_farm/Models/Sensor.dart';
import 'package:iot_farm/Models/WeatherStation.dart';
import 'package:iot_farm/Data/ShowMessage.dart';
import 'package:iot_farm/Data/UserPrefs.dart';
import 'package:iot_farm/Data/ConnectionAPI.dart';
import 'package:iot_farm/Data/EasyTimer.dart';
import 'dart:convert';
import 'dart:async';

class InspectFarm  {

  List<Sensor> sensors;
  List<WeatherStation> stations;
  ConnectionAPI _connectionAPI = new ConnectionAPI();
  UserPrefs prefs = new UserPrefs();
  bool canQueryStations = true;
  bool canQuerySensors = true;

  Future<List<Sensor>> GetSoilSensors(code_farm) async{
    if(!canQuerySensors){
      return sensors;
    }

    if(!prefs.PrefsOn()){
      await prefs.InitiatePrefs();
    }
    _connectionAPI.url = "GetAllSensor";
    _connectionAPI.body = json.encode({
      "id":code_farm
    });
    await _connectionAPI.doResultRequest("Sensor");
    sensors = await _connectionAPI.GetFullList();
    canQuerySensors = false;
    return this.sensors;
  }

  Future<List<WeatherStation>> GetWeatherStations(code_farm) async{
    if(!canQueryStations){
      return stations;
    }

    if(!prefs.PrefsOn()){
      await prefs.InitiatePrefs();
    }
    _connectionAPI.url = "GetAllStation";
    _connectionAPI.body = json.encode({
      "id":code_farm
    });
    await _connectionAPI.doResultRequest("WeatherStation");
    stations = await _connectionAPI.GetFullList();
    canQueryStations = false;
    return this.stations;
  }

}
