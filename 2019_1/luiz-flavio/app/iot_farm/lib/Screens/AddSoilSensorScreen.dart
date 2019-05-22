import 'package:flutter/material.dart';
import 'package:iot_farm/Data/AppThemeData.dart';
import 'package:iot_farm/Data/AddSoilSensor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:iot_farm/Models/Farm.dart';

class AddSoilSensorScreen extends StatefulWidget {
  @override
  _AddSoilSensorScreenState createState() => _AddSoilSensorScreenState();
}

class _AddSoilSensorScreenState extends State<AddSoilSensorScreen> {

  var addSoilSensor = new AddSoilSensor();
  Farm farm;

  // fields variables
  TextEditingController nameFieldController = new TextEditingController();
  TextEditingController identifierFieldController = new TextEditingController();
  bool activeSensorValue = false;
  bool activeSensorValueChecked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    farm = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Soil Sensor"),
        centerTitle: true,
      ),
      body: new Container(
        child:  new Padding(
          padding: EdgeInsets.only(left:MediaQuery.of(context).size.height*paddingPercentage,right:MediaQuery.of(context).size.height*paddingPercentage),
          child: new ListView(
            children: <Widget>[
              SizedBox(height: sizeLineSpace*3,),
              new Material(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Ink(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.greenAccent, width: 4.0),
                      color: Colors.green[900],
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(1.0, 2.0),
                          blurRadius: 3.0,
                        ),
                      ]
                    ),
                    child: InkWell(
                      //This keeps the splash effect within the circle
                      borderRadius: BorderRadius.circular(1000.0), //Something large to ensure a circle
                      child: Padding(
                        padding:EdgeInsets.all(20.0),
                        child: Icon(
                          MdiIcons.flower,
                          size: 80.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              new Center(
                child: new Title(
                    color: Colors.green,
                    child: new Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: new Text(farm.name),
                    ),
                  title: farm.name,
                ),
              ),
              SizedBox(height: sizeLineSpace*2,),
              new Divider(
                height: 3,
                color: AppThemeData.primaryColor,
              ),
              new Divider(
                height: 3,
                color: AppThemeData.primaryColor,
              ),
              SizedBox(height: sizeLineSpace*3,),
              new TextFormField(
                decoration: new InputDecoration(hintText: "enter with sensor name", labelText: "Sensor name"),
                controller: nameFieldController,
              ),
              SizedBox(height: sizeLineSpace,),
              new TextFormField(
                decoration: new InputDecoration(hintText: "enter with sensor identifier", labelText: "Sensor identifier"),
                controller: identifierFieldController,
              ),
              SizedBox(height: sizeLineSpace,),
              new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text("Active: "),
                  new Switch(
                    value: activeSensorValue,
                    onChanged: (bool newValue){
                      activeSensorValueChecked = addSoilSensor.changeSensorActiveState(newValue);
                      setState(() {
                        activeSensorValue = activeSensorValueChecked;
                      });
                    },
                  )
                ],
              ),
              SizedBox(height: sizeLineSpace,),
              new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Expanded(
                    child: new RaisedButton(
                      onPressed: (){
                        addSoilSensor.RegisterSensor(context, nameFieldController, identifierFieldController, activeSensorValue, farm.code_farm);
                      },
                      child: new Text("Add Soil Sensor"),
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
