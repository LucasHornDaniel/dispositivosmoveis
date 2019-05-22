import 'package:flutter/material.dart';
import 'package:iot_farm/Data/Login.dart';
import 'package:iot_farm/Data/AppThemeData.dart';

class EnrollScreen extends StatefulWidget {
  @override
  _EnrollScreenState createState() => _EnrollScreenState();
}

class _EnrollScreenState extends State<EnrollScreen> {

  var login = new Login();

  // fields variables
  TextEditingController nameFieldController = new TextEditingController();
  TextEditingController loginFieldController = new TextEditingController();
  TextEditingController passwordFieldController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enroll"),
        centerTitle: true,
      ),
      body: new Container(
        child:  Padding(
          padding: EdgeInsets.only(left:MediaQuery.of(context).size.height*paddingPercentage,right:MediaQuery.of(context).size.height*paddingPercentage),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new TextFormField(
                decoration: new InputDecoration(hintText: "enter your full name", labelText: "Your name"),
                controller: nameFieldController,
              ),
              new TextFormField(
                decoration: new InputDecoration(hintText: "enter your user name", labelText: "Your username"),
                controller: loginFieldController,
              ),
              SizedBox(height: sizeLineSpace,),
              new TextFormField(
                decoration: new InputDecoration(hintText: "enter your password", labelText: "Your password"),
                controller: passwordFieldController,
              ),
              SizedBox(height: sizeLineSpace,),
              new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Expanded(
                    child: new RaisedButton(
                      onPressed: (){
                        login.RegisterUser(context,nameFieldController,loginFieldController,passwordFieldController);
                      },
                      child: new Text("Enroll"),
                      textTheme: ButtonTextTheme.primary,
                      color: AppThemeData.primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
