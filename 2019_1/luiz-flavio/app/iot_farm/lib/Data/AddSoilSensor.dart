import 'package:flutter/material.dart';
import 'package:iot_farm/Data/ShowMessage.dart';
import 'package:iot_farm/Data/ConnectionAPI.dart';
import 'dart:convert';
import 'package:iot_farm/Data/UserPrefs.dart';

class AddSoilSensor {

  ConnectionAPI _connectionAPI = new ConnectionAPI();
  ShowMessage _showMessage = new ShowMessage();
  var prefs = new UserPrefs();

  changeSensorActiveState(bool newValue) {
    return newValue;
  }

  RegisterSensor(context, TextEditingController nameFieldController, TextEditingController identifierFieldController, bool activeSensorValue, int code) async{
    try{
      _connectionAPI.url = "InsertSensor";

      var code_farm = code;
      var name = nameFieldController.text[0].toUpperCase()+nameFieldController.text.substring(1);
      var identifier = identifierFieldController.text.toUpperCase();
      var active = activeSensorValue;

      if(name == "" || identifier == "" || active == null || code_farm == null){
        _showMessage.ShowMessageError(context,"Error: Please check the fields.");
        return;
      }

      _connectionAPI.body = json.encode({
        "id": code_farm,
        "name":name,
        "identifier":identifier,
        "active":active?'Y':'N',
      });
      var result = await _connectionAPI.doSimpleRequest("post");
      if(result == "true"){
        _showMessage.ShowMessageSuccess(context,"Your sensor was successfully registered.");
        Navigator.pop(context,true);
      } else {
        _showMessage.ShowMessageError(context,"The sensor could not be registered. Please, check the internet conection and try again later.");
      }
    } catch(e){
      print(e.toString());
      _showMessage.ShowMessageError(context,"The sensor could not be registered. Please, try again.");
    }

  }

}
