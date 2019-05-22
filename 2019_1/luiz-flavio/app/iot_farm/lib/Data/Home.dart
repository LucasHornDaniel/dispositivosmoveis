import 'package:flutter/material.dart';
import 'package:iot_farm/Models/Farm.dart';
import 'package:iot_farm/Data/ConnectionAPI.dart';
import 'dart:convert';
import 'package:iot_farm/Data/UserPrefs.dart';
import 'package:iot_farm/Data/ShowMessage.dart';

class Home {

  List<Farm> farms;
  ConnectionAPI _connectionAPI = new ConnectionAPI();
  UserPrefs prefs = new UserPrefs();
  ShowMessage _showMessage = new ShowMessage();
  bool canQueryFarms = true;

  Future<List<Farm>> GetFarms() async{
    if(!canQueryFarms){
      return farms;
    }

    if(!prefs.PrefsOn()){
      await prefs.InitiatePrefs();
    }
    var code_user = await prefs.GetValue("code_user");
    _connectionAPI.url = "GetAllFarm";
    _connectionAPI.body = json.encode({
      "id":code_user
    });
    await _connectionAPI.doResultRequest("Farm");
    farms = await _connectionAPI.GetFullList();
    canQueryFarms = false;
    print("query farms");
    return this.farms;
  }

  Future<bool> AddFarm(context, TextEditingController farmNameFieldController) async{
    try{
      if(!prefs.PrefsOn()){
        await prefs.InitiatePrefs();
      }
      var code_user = await prefs.GetValue("code_user");
      var farname = farmNameFieldController.text[0].toUpperCase() + farmNameFieldController.text.substring(1);
      _connectionAPI.url = "InsertFarm";

      if(code_user == "" || farname == ""){
        _showMessage.ShowMessageError(context,"Error: Please check the fields.");
        return false;
      }

      _connectionAPI.body = json.encode({
        "id":code_user,
        "name":farname
      });
      var result = await _connectionAPI.doSimpleRequest("post");

      if(result == "true"){
        _showMessage.ShowMessageSuccess(context,"Farm '"+farname+"' was successfully registered.");
        farmNameFieldController.text = "";
        Navigator.pop(context);
        return true;
      } else {
        _showMessage.ShowMessageError(context,"The farm could not be registered. Please, check the internet conection and try again later.");
        return false;
      }
    } catch(e){
      print(e.toString());
      _showMessage.ShowMessageError(context,"The farname could not be registered. Please, try again.");
      return false;
    }

  }

}