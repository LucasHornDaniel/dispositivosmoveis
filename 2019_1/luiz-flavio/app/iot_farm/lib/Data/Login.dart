import 'package:flutter/material.dart';
import 'package:iot_farm/Data/ConnectionAPI.dart';
import 'dart:convert';
import 'package:iot_farm/Models/User.dart';
import 'package:iot_farm/Data/UserPrefs.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iot_farm/Data/ShowMessage.dart';

class Login {

  ConnectionAPI _connectionAPI = new ConnectionAPI();
  List<User> users;
  User user;
  var prefs = new UserPrefs();
  ShowMessage _showMessage = new ShowMessage();

  Login(){

  }

  doLogin(context, TextEditingController loginFieldController, TextEditingController passwordFieldController) async{
    user = null;

    try{
      await this.GetUserLogin(loginFieldController.text,passwordFieldController.text);
    } catch(e){
      print(e.toString());
      ShowLoginError(context);
    }

    if(user != null){
      SaveUserLogin();
      Navigator.pushNamed(context, "/Home");
    } else {
      ShowLoginError(context);
    }
  }

  ShowLoginError(context){
    Fluttertoast.showToast(
        msg: "Error on Login. Please check the internet connection or the fields username and password.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }



  GetUserLogin(username,password) async {
    _connectionAPI.url = "GetUserLogin";
    _connectionAPI.body = json.encode({
      "username":username,
      "password":password
    });
    await _connectionAPI.doResultRequest("User");
    this.user = _connectionAPI.GetFirstItem();
  }

  SaveUserLogin(){
    prefs.SetValue("username",user.username);
    prefs.SetValue("name", user.name);
    prefs.SetValue("code_user",user.code_user);
    prefs.SetValue("logged",true);
  }

  Logout(context){
    CleanUserLogin();
    Navigator.pop(context,"/Login");
  }

  CleanUserLogin(){
    prefs.DeleteVariable("username");
    prefs.DeleteVariable("name");
    prefs.DeleteVariable("code_user");
    prefs.DeleteVariable("logged");
  }

  CheckLogin(context) async{
    if(await UserLogged()){
      Navigator.popAndPushNamed(context, "/Home");
    }
  }

  Future<bool> UserLogged() async{
    try{
      if(!prefs.PrefsOn()){
        await prefs.InitiatePrefs();
      }

      var name = prefs.GetValue("name");
      var username = prefs.GetValue("username");
      var code_user = prefs.GetValue("code_user");
      var logged = prefs.GetValue("logged");

      if(name != null && username != null && code_user != null && logged != null){
        return true;
      } else {
        CleanUserLogin();
        return false;
      }
    }catch(e){
      CleanUserLogin();
      return false;
    }
  }

  RegisterUser(context, TextEditingController nameFieldController, TextEditingController loginFieldController, TextEditingController passwordFieldController) async{
    try{
      _connectionAPI.url = "InsertUser";
      var name = nameFieldController.text;
      var username = loginFieldController.text;
      var password = passwordFieldController.text;

      if(name == "" || username == "" || password == ""){
        _showMessage.ShowMessageError(context,"Error: Please check the fields.");
        return;
      }

      _connectionAPI.body = json.encode({
        "name":name,
        "username":username,
        "password":password
      });
      var result = await _connectionAPI.doSimpleRequest("post");

      if(result == "true"){
        _showMessage.ShowMessageSuccess(context,"Wellcome, "+nameFieldController.text+". Your user was successfully registered.");
        Navigator.pop(context);
      } else {
        _showMessage.ShowMessageError(context,"The user could not be registered. Please, check the internet conection and try again later.");
      }
    } catch(e){
      print(e.toString());
      _showMessage.ShowMessageError(context,"The user could not be registered. Please, try again.");
    }

  }

}