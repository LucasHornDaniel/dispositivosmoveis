import 'package:flutter/material.dart';
import 'package:iot_farm/Models/Sensor.dart';

class SoilSensorListTile extends StatefulWidget {

  Sensor soilSensor;

  SoilSensorListTile(Key godKey, this.soilSensor) : super(key: godKey);
  _SoilSensorListTileState createState() => new _SoilSensorListTileState(this.soilSensor);
}

class _SoilSensorListTileState extends State<SoilSensorListTile> {

  final Sensor soilSensor;

  bool activeSoilSensorValue = false;
  bool activeSensorValueChecked;

  _SoilSensorListTileState(this.soilSensor);

  Icon iconTrailing = Icon(Icons.arrow_forward_ios);

  var result;

  @override
  void initState() {
    // TODO: implement initState
    this.activeSoilSensorValue = this.soilSensor.active;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/InspectSoilSensor", arguments: soilSensor);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Text("Name: ",textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold,)),
              new Text("Identifier: ",textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold,)),
            ],
          ),
          new Expanded(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(soilSensor.name,textAlign: TextAlign.left,),
                new Text(soilSensor.FormatMac(),textAlign: TextAlign.left,),
              ],
            ),
          ),
          new Switch(
            value: activeSoilSensorValue,
            onChanged: (bool newValue) async{
              activeSensorValueChecked = await soilSensor.changeSoilSensorActiveState(context,newValue);
              setState(() {
                activeSoilSensorValue = activeSensorValueChecked;
              });
            },
          )
        ],
      ),
    );
  }
}
