import 'package:flutter/material.dart';
import 'package:maintenance_status/Data/shared_prefs.dart';
import 'package:maintenance_status/Screens/Home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  SharedPrefs prefs = SharedPrefs();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF00008B), Color(0xFF000080)],
                    ),
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(90))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Spacer(),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 230.0,
                        height: 230.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/technics.png'))),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Usuário",
                      labelStyle:
                          TextStyle(color: Colors.black, fontSize: 18.0),
                      icon: Icon(Icons.person_outline),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      labelText: "Senha",
                      labelStyle: const TextStyle(
                          color: Colors.black, fontSize: 18.0),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: RaisedButton(
                    color: Color.fromRGBO(0, 33, 113, 1.0),
                    child: Container(
                        width: 150.0,
                        height: 25.0,
                        child: Text('Login',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white, fontSize: 20.0))),
                    splashColor: Color.fromRGBO(13, 71, 161, 1.0),
                    shape: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(10.0))),
                    elevation: 8.0,
                    onPressed: () async {
                      await prefs.setConfigs(
                          emailController.text, passwordController.text);
                      var userType = await prefs.doLogin();
                      print(userType.toString());
                      if (userType == "Login ou Senha Incorretos!") {
                        showInSnackBar(2000, userType, Colors.red);
                      } else if (userType != false) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                            (Route<dynamic> routes) => false);
                      } else {
                        showInSnackBar(
                            2000, "Erro Ao Realizar Login!", Colors.red);
                      }
                    },
                  ),
                ),
              ])
            ],
          ),
        )));
  }

  void showInSnackBar(int time, String message, Color color) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        backgroundColor: color,
        duration: Duration(milliseconds: time),
        content: new Text(message)));
  }
}
