import 'package:flutter/material.dart';
import 'package:iot_farm/Data/Login.dart';
import 'package:iot_farm/Data/AppThemeData.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var login = new Login();

  // fields variables
  TextEditingController loginFieldController = new TextEditingController();
  TextEditingController passwordFieldController = new TextEditingController();

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
        leading: new Container(),
      ),
      body: new Container(
          child:  Padding(
            padding: EdgeInsets.only(left:MediaQuery.of(context).size.height*paddingPercentage,right:MediaQuery.of(context).size.height*paddingPercentage),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new TextFormField(
                  decoration: new InputDecoration(hintText: "enter your user name", labelText: "Your username"),
                  controller: loginFieldController,
                ),
                SizedBox(height: sizeLineSpace,),
                new TextFormField(
                  decoration: new InputDecoration(hintText: "enter your password", labelText: "Your password"),
                  controller: passwordFieldController,
                  obscureText: true,
                ),
                SizedBox(height: sizeLineSpace,),
                new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Expanded(
                      child: new RaisedButton(
                        onPressed: (){
                          login.doLogin(context, loginFieldController, passwordFieldController);
                        },
                        child: new Text("Login"),
                        textTheme: ButtonTextTheme.primary,
                        color: AppThemeData.primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: sizeLineSpace,),
                new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Expanded(
                        child: new RaisedButton(
                          onPressed: (){
                            Navigator.pushNamed(context, "/Enroll");
                          },
                          child: new Text("Enroll"),
                          textTheme: ButtonTextTheme.primary,
                          color: AppThemeData.buttonColor,
                        ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
    );
  }
}
