import 'dart:convert';
import 'package:iot_farm/Models/User.dart';
import 'package:iot_farm/Models/Farm.dart';
import 'package:http/http.dart' as http;
import 'package:iot_farm/Models/Sensor.dart';
import 'package:iot_farm/Models/WeatherStation.dart';
import 'package:iot_farm/Models/DataGraphic.dart';
import 'package:iot_farm/Models/DataGraphicDate.dart';
import 'package:iot_farm/Models/DataWeatherStation.dart';

class ConnectionAPI {
  static const API_ADDRESS = "http://10.0.2.2:5000/api/IotProject/";
  var url = "GetAllUsers";
  static const HEADERS = {
    "Accept": "application/json",
    "Content-Type": "application/json",
  };
  var body;
  var genericJsonList;
  var genericList;
  var genericType;

  GetUrl() {
    return API_ADDRESS + url;
  }

  GetHeaders() {
    return HEADERS;
  }

  CleanGenericList(){
    genericList = [];
  }

  doResultRequest(type) async {
    genericType = type;
    try {
      http.Response response = await http
          .post(
            this.GetUrl(),
            headers: HEADERS,
            body: this.body,
          )
          .timeout(const Duration(seconds: 3));

      if(response.statusCode != 200){
        throw new Exception("Connection error.");
      }

      var jsonData = json.decode(response.body);

      genericJsonList = jsonDecode(jsonData);

      genericList = CreateList();

      for (var jsonItem in genericJsonList) {
        genericList.add(CreateNewObject(jsonItem));
      }
    } on Exception catch (e) {
      genericList = CreateList();
      print(e);
    }
  }

  doSimpleRequest(typeRequest) async {
    try {
      http.Response response;

      if (typeRequest == "post") {
        response = await http
            .post(
              this.GetUrl(),
              headers: HEADERS,
              body: this.body,
            )
            .timeout(const Duration(seconds: 3));
      } else {
        response = await http
            .get(
              this.GetUrl(),
              headers: HEADERS,
            )
            .timeout(const Duration(seconds: 3));
      }

      return response.body;
    } on Exception catch (e) {
      return "false";
    }
  }

  CreateList() {
    switch (genericType) {
      case "User":
        {
          List<User> list = [];
          return list;
        }
        break;
      case "Farm":
        {
          List<Farm> list = [];
          return list;
        }
        break;
      case "Sensor":{
        List<Sensor> list = [];
        return list;
      }
      break;
      case "WeatherStation":{
        List<WeatherStation> list = [];
        return list;
      }
      break;
      case "DataGraphic":{
        List<DataGraphic> list = [];
        return list;
      }
      break;
      case "Int":{
        List<int> list = [];
        return list;
      }
      break;
      case "DataGraphicDate":{
        List<DataGraphicDate> list = [];
        return list;
      }
      break;
      case "DataWeatherStation":{
        List<DataWeatherStation> list = [];
        return list;
      }
      break;
    }
  }

  CreateNewObject(json) {
    switch (genericType) {
      case "User":
        {
          return new User.fromJson(json);
        }
        break;
      case "Farm":
        {
          return new Farm.fromJson(json);
        }
        break;
      case "Sensor":{
        return new Sensor.fromJson(json);
      }
      break;
      case "WeatherStation":{
        return new WeatherStation.fromJson(json);
      }
      break;
      case "DataGraphic":{
        return new DataGraphic.fromJson(json);
      }
      break;
      case "Int":{
        return int.parse(json['value']);
      }
      break;
      case "DataGraphicDate":{
        return new DataGraphicDate.fromJson(json);
      }
      break;
      case "DataWeatherStation":{
        return new DataWeatherStation.fromJson(json);
      }
      break;
    }
  }

  GetFirstItem() {
    return genericList[0];
  }

  GetLastItem() {
    return genericList[genericList.length - 1];
  }

  GetFullList() {
    return genericList;
  }
}
