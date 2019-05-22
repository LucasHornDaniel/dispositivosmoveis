import 'package:flutter/material.dart';
import 'package:iot_farm/Data/AppThemeData.dart';
import 'package:iot_farm/Screens/AddSoilSensorScreen.dart';
import 'package:iot_farm/Screens/AddWeatherStationScreen.dart';
import 'package:iot_farm/Screens/EnrollScreen.dart';
import 'package:iot_farm/Screens/HomeScreen.dart';
import 'package:iot_farm/Screens/InspectFarmScreen.dart';
import 'package:iot_farm/Screens/InspectSoilSensorScreen.dart';
import 'package:iot_farm/Screens/InspectWeatherStationScreen.dart';
import 'package:iot_farm/Screens/LoginScreen.dart';
import 'package:iot_farm/Data/Login.dart';
import 'package:iot_farm/Models/Farm.dart';

class  Routes {
  var routes = <String, WidgetBuilder>{
    "/AddSoilSensor": (BuildContext context) => new AddSoilSensorScreen(),
    "/AddWeatherStation": (BuildContext context) => new AddWeatherStationScreen(),
    "/Enroll": (BuildContext context) => new EnrollScreen(),
    "/Home":  (BuildContext context) => new HomeScreen(),
    "/InspectFarm":  (BuildContext context) => new InspectFarmScreen(),
    "/InspectSoilSensor":  (BuildContext context) => new InspectSoilSensorScreen(),
    "/InspectWeatherStation":  (BuildContext context) => new InspectWeatherStationScreen(),
    "/": (BuildContext context) => new LoginScreen(),
    "/Login": (BuildContext context) => new LoginScreen()
  };

  var initialRoute = "/Login";
  var title = "Login";

  Routes() {
    CheckLogin();
  }

  CheckLogin() async{
    Login login = new Login();

    bool userLogged = await login.UserLogged();

    if(userLogged){
      title = "Home";
      initialRoute = "/Home";
    }

    runApp(new MaterialApp(
        title: title,
        theme: AppThemeData,
        initialRoute: initialRoute,
        routes: routes
    ));
  }
}