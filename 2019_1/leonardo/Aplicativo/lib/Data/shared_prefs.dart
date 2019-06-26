import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class SharedPrefs {
  SharedPreferences prefs;
  Dio dio = new Dio();

  setConfigs(String login, String password) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("login", login);
    prefs.setString("password", password);
    prefs.setString('baseurl', 'http://10.0.2.2:4000');
  }

  Future<bool> isConfigured() async {
    prefs = await SharedPreferences.getInstance();
    String login = prefs.getString("login").toString();
    String password = prefs.getString("password").toString();

    return (login != "null" && password != null) ? true : false;
  }

  Future<bool> isLoggedIn() async {
    prefs = await SharedPreferences.getInstance();
    var res = prefs.getString("login").toString();
    return (res != "null") ? true : false;
  }

  Future<dynamic> doLogin() async {
    print("teste");
    prefs = await SharedPreferences.getInstance();
    String login = prefs.getString('login');
    String password = prefs.getString('password');
    String baseUrl = prefs.getString('baseurl');
    if(login == '' || password == ''){
      return "Login ou Senha Incorretos!";
    }

    Response response = await dio.post(baseUrl + '/login', data: {"email": "${login}", "password": "${password}"});

    if(response.statusCode == 200){
      prefs.setString('name', response.data['user']['firstName'] + response.data['user']['lastName']);
      prefs.setString('token', response.data['token']);
      prefs.setString('userid', response.data['user']['id'].toString());
      return response;
    }else if(response.statusCode == 401){
      return "Login ou Senha Incorretos!";
    }else{
      return response.statusCode.toString();
    }
  }

  Future<String> getToken() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString("token").toString();
  }
  Future<String> getUserId() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString("userid").toString();
  }
  Future<String> getBaseUrl() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString("baseurl").toString();
  }

  void clearConfigs() async {
    prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
