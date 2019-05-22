import 'package:shared_preferences/shared_preferences.dart';

class UserPrefs {

  SharedPreferences prefs;

  UserPrefs(){
    InitiatePrefs();
  }

  InitiatePrefs() async{
    prefs = await SharedPreferences.getInstance();
  }

  bool PrefsOn(){
    if(prefs != null){
      return true;
    } else {
      return false;
    }
  }

  DeleteVariable(key){
    prefs.remove(key);
  }

  SetValue(String key, var value){
    String type = value.runtimeType.toString();
    switch(type){
      case "String":{
        prefs.setString(key, value);
      }
      break;
      case "int":{
        prefs.setInt(key, value);
      }
      break;
      case "double":{
        prefs.setDouble(key, value);
      }
      break;
      case "bool":{
        prefs.setBool(key, value);
      }
      break;
      case "List<String>":{
        prefs.setStringList(key, value);
      }
      break;
      case "List<int>":{
        List<String> stringList = [];
        for(var item in value){
          stringList.add(item.toString());
        }
        prefs.setStringList(key, stringList);
      }
      break;
      case "List<double>":{
        List<String> stringList = [];
        for(var item in value){
          stringList.add(item.toString());
        }
        prefs.setStringList(key, stringList);
      }
      break;
      case "List<bool>":{
        List<String> stringList = [];
        for(var item in value){
          stringList.add(item.toString());
        }
        prefs.setStringList(key, stringList);
      }
      break;
    }
  }

  GetValue(String key){
    return prefs.get(key);
  }

  GetList(String key, String type){
    switch(type){
      case "String":{
        return GetValue(key);
      }
      break;
      case "int":{
        List<int> genericList =  [];
        for(var item in GetValue(key)){
          genericList.add(int.parse(item));
        }
        return genericList;
      }
      break;
      case "double":{
        List<double> genericList =  [];
        for(var item in GetValue(key)){
          genericList.add(double.parse(item));
        }
        return genericList;
      }
      break;
      case "bool":{
        List<bool> genericList =  GetValue(key).map((i)=>i.toLowerCase()=='true').toList();
        for(var item in GetValue(key)){
          genericList.add(item.toLowerCase()=='true');
        }
        return genericList;
      }
      break;
    }
  }

  toList(){

  }

}