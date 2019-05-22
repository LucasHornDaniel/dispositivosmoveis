import 'package:flutter/material.dart';
import 'package:iot_farm/Data/AppThemeData.dart';
import 'package:iot_farm/Data/InspectSoilSensor.dart';
import 'package:iot_farm/Models/Sensor.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:iot_farm/Data/DateLineChartEasy.dart';
import 'package:iot_farm/Models/DataGraphic.dart';
import 'package:iot_farm/Models/DataGraphicDate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';

class InspectSoilSensorScreen extends StatefulWidget {
  @override
  _InspectSoilSensorScreenState createState() =>
      _InspectSoilSensorScreenState();
}

class _InspectSoilSensorScreenState extends State<InspectSoilSensorScreen> {
  Sensor soilSensor;

  bool activeSoilSensorValue = false;
  bool activeSensorValueChecked = false;

  var inspectSoilSensor = new InspectSoilSensor();

  DateLineChartEasy lineChart;

  bool graphicShowedOnce = false;

  Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  SetTimer(){
    if(timer != null){
      timer.cancel();
    }
    timer = new Timer(new Duration(seconds: 10), () {
      if(this.mounted){
        setState(() {
          inspectSoilSensor.canQueryValues = true;
          print("updated");
        });
      }
    });
  }

  Widget NoDataInfo(){
    SetTimer();
    return Container(
      child: Center(
        child: Text("No data loaded for inactive sensor...."),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    soilSensor = ModalRoute.of(context).settings.arguments;

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Inspect Soil Sensor"),
          centerTitle: true,
        ),
        body: Container(
          child: new Container(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  child: new ListView(
                    children: <Widget>[
                      new Material(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Ink(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.greenAccent, width: 4.0),
                                color: Colors.green[900],
                                shape: BoxShape.circle,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(1.0, 2.0),
                                    blurRadius: 3.0,
                                  ),
                                ]),
                            child: InkWell(
                              //This keeps the splash effect within the circle
                              borderRadius: BorderRadius.circular(1000.0),
                              //Something large to ensure a circle
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
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
                            child: new Text(soilSensor.name),
                          ),
                          title: soilSensor.name,
                        ),
                      ),
                      SizedBox(
                        height: sizeLineSpace * 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
//                            new Text("Name: ",textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold,)),
                              new Text("Identifier: ",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                          new Expanded(
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
//                              new Text(soilSensor.name,textAlign: TextAlign.left,),
                                new Text(
                                  soilSensor.FormatMac(),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ),
                          new Switch(
                            value: soilSensor.active,
                            onChanged: (bool newValue) async {
                              activeSensorValueChecked =
                                  await soilSensor.changeSoilSensorActiveState(
                                      context, newValue);
                              setState(() {
                                soilSensor.active = activeSensorValueChecked;
                              });
                            },
                          )
                        ],
                      ),
                      new Padding(
                        padding: EdgeInsets.only(bottom: 5, top: 5),
                        child: new Divider(),
                      ),
                      !soilSensor.active?
                          NoDataInfo()
                          :FutureBuilder(
                          future: !inspectSoilSensor.waitRequest?inspectSoilSensor.GetDataGraphicDateSensor(
                              soilSensor.code_sensor):inspectSoilSensor.listDataGraphicDate,
                          builder: (context, snapshotValuesSoilSensor) {
                            switch (snapshotValuesSoilSensor.connectionState) {
                              case ConnectionState.none:
                              case ConnectionState.waiting:
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    SpinKitChasingDots(
                                      color: Colors.green,
                                      size: 100.0,
                                    ),
                                    SizedBox(
                                      height: sizeLineSpace,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child: new Text(
                                        "Loading...",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    )
                                  ],
                                );
                              case ConnectionState.active:
                              case ConnectionState.done:
                                try{
                                  if (snapshotValuesSoilSensor.hasError) {
                                    return Text(
                                        'Error: ${snapshotValuesSoilSensor.error}');
                                  } else if (snapshotValuesSoilSensor.hasData) {
                                    if (snapshotValuesSoilSensor.data == null || snapshotValuesSoilSensor.data.length == 0) {
                                      return new Container(
                                        child: Center(
                                          child: Text("No data loaded...."),
                                        ),
                                      );
                                    }

                                    List<DataGraphicDate> data = snapshotValuesSoilSensor.data;

                                    SetTimer();

                                    return new DateLineChartEasy(data,title:'Soil Humidity');
                                  }
                                } catch(e){
                                  return new Container(
                                    child: Center(
                                      child: Text("No data loaded...."),
                                    ),
                                  );
                                }
                            };
                          }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
