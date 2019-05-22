import 'package:flutter/material.dart';
import 'package:iot_farm/Screens/InspectSoilSensorScreen.dart';
import 'package:iot_farm/Models/DataGraphic.dart';
import 'package:iot_farm/Models/DataGraphicDate.dart';
import 'package:iot_farm/Models/DataWeatherStation.dart';
import 'package:iot_farm/Data/ShowMessage.dart';
import 'package:iot_farm/Data/ConnectionAPI.dart';
import 'dart:convert';
import 'package:iot_farm/Data/DateLineChartEasy.dart';

class InspectWeatherStation {

  ConnectionAPI _connectionAPI = new ConnectionAPI();
  ShowMessage _showMessage = new ShowMessage();
  List<DataGraphic> listDataGraphic;
  List<DataGraphicDate> listDataGraphicDate;
  bool canQueryValues = true;
  bool waitRequest = false;
  //field for weather station data
  List<DataWeatherStation> listDataWeatherStation;

  Future<List<DataGraphic>> GetDataGraphicSensor(int codeSensor) async{
    if(!canQueryValues){
      return listDataGraphic;
    }

    _connectionAPI.url = "GetLastPeriodSensorData";
    _connectionAPI.body = json.encode({
      "id":codeSensor
    });
    await _connectionAPI.doResultRequest("Int");

    List<int> listValues = await _connectionAPI.GetFullList();
    List<DataGraphic> listTempDataGraphic = [];

    int index = 0;
    for(int value in listValues){
      listTempDataGraphic.add(new DataGraphic(index, value));
      index++;
    }
    listDataGraphic = listTempDataGraphic;
    canQueryValues = false;

    return listDataGraphic;
  }

  Future<List<DataWeatherStation>> GetDataGraphicDateWeatherStation(int codeSensor) async{
    if(!canQueryValues){
      return listDataWeatherStation;
    }
    waitRequest=true;

    _connectionAPI.url = "GetStationLastPeriodDateData";
    _connectionAPI.body = json.encode({
      "id":codeSensor
    });
    print("search data");
    await _connectionAPI.doResultRequest("DataWeatherStation");

    listDataWeatherStation = await _connectionAPI.GetFullList();
    _connectionAPI.CleanGenericList();

    if(listDataWeatherStation == null){
      listDataWeatherStation = [];
    }

    canQueryValues = false;
    waitRequest = false;

    return listDataWeatherStation;
  }

}
