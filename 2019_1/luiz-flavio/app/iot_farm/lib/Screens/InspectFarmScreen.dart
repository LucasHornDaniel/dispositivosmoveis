import 'package:flutter/material.dart';
import 'package:iot_farm/Data/AppThemeData.dart';
import 'package:iot_farm/Data/InspectFarm.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:iot_farm/Models/Sensor.dart';
import 'package:iot_farm/Models/WeatherStation.dart';
import 'package:iot_farm/Models/Farm.dart';
import 'package:iot_farm/Components/SoilSensorListTile.dart';
import 'package:iot_farm/Components/WeatherStationListTile.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';

class InspectFarmScreen extends StatefulWidget {
  @override
  _InspectFarmScreenState createState() => _InspectFarmScreenState();
}

class _InspectFarmScreenState extends State<InspectFarmScreen> {
  Farm farm;
  InspectFarm _inspectFarm = new InspectFarm();
  var result;

  ScrollController soilSensorListController = new ScrollController();
  ScrollController weatherStationListController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    farm = ModalRoute.of(context).settings.arguments;

    return WillPopScope(
      onWillPop: () async{
//        Navigator.popAndPushNamed(context, "/Home", arguments: true);
        Navigator.pop(context, farm);
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text("Inspect Farm"),
            centerTitle: true,
          ),
          body: Container(
            child: new Container(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Material(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Ink(
                        decoration: BoxDecoration(
                            border:
                            Border.all(color: Colors.greenAccent, width: 4.0),
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
                        child: new Text(farm.name),
                      ),
                      title: farm.name,
                    ),
                  ),
                  SizedBox(
                    height: sizeLineSpace * 2,
                  ),
                  new Container(
                    decoration: BoxDecoration(color: Colors.lightGreen),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Text(
                          "Humidity Sensors",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        new IconButton(
                            icon: new Icon(
                              MdiIcons.plus,
                              color: Colors.white,
                            ),
                            iconSize: 40,
                            onPressed: () async {
                              result = await Navigator.pushNamed(context, "/AddSoilSensor",
                                  arguments: farm);
                              if(result == true){
                                setState(() {
                                  _inspectFarm.canQuerySensors = true;
                                });
                              }
                            })
                      ],
                    ),
                  ),
                  new Expanded(
                    child: new FutureBuilder(
                      future: !_inspectFarm.canQuerySensors
                          ? _inspectFarm.GetSoilSensors(farm.code_farm)
                          : Future.delayed(Duration(seconds: 1)).then((value) {
                        return _inspectFarm.GetSoilSensors(farm.code_farm);
                      }),
                      builder: (context, AsyncSnapshot snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            break;
                          case ConnectionState.waiting:
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SpinKitChasingDots(
                                  color: Colors.green,
                                  size: 50.0,
                                ),
                              ],
                            );
                            break;
                          case ConnectionState.active:
                            break;
                          case ConnectionState.done:
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              List<Sensor> sensors = _inspectFarm.sensors;

                              //clean values
                              farm.activeSoilSensors = 0;
                              farm.inactiveSoilSensors = 0;

                              for(Sensor sensor in sensors){
                                if(sensor.active){
                                  farm.activeSoilSensors++;
                                } else {
                                  farm.inactiveSoilSensors++;
                                }
                              }

                              return ListView.builder(
                                controller: soilSensorListController,
                                itemCount: sensors.length,
                                itemBuilder: (context, index) {
                                  final godKey =
                                  new GlobalKey<_InspectFarmScreenState>();
                                  return SoilSensorListTile(godKey, sensors[index]);
                                },
                              );
                            }
                            break;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: sizeLineSpace * 2,
                  ),
                  new Container(
                    decoration: BoxDecoration(color: Colors.lightGreen),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Text(
                          "Weather Stations",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        new IconButton(
                            icon: new Icon(
                              MdiIcons.plus,
                              color: Colors.white,
                            ),
                            iconSize: 40,
                            onPressed: () async{
                              result = await Navigator.pushNamed(context, "/AddWeatherStation",
                                  arguments: farm);
                              if(result == true){
                                setState(() {
                                  _inspectFarm.canQueryStations = true;
                                });
                              }
                            })
                      ],
                    ),
                  ),
                  new Expanded(
                    child: new FutureBuilder(
                      future: !_inspectFarm.canQueryStations
                          ? _inspectFarm.GetWeatherStations(farm.code_farm)
                          : Future.delayed(Duration(seconds: 2)).then((value) {
                        return _inspectFarm.GetWeatherStations(
                            farm.code_farm);
                      }),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SpinKitChasingDots(
                                  color: Colors.green,
                                  size: 50.0,
                                ),
                              ],
                            );
                          case ConnectionState.active:
                          case ConnectionState.done:
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              List<WeatherStation> stations = _inspectFarm.stations;

                              //clean values
                              farm.activeWeatherStations = 0;
                              farm.inactiveWeatherStations = 0;

                              for(WeatherStation station in stations){
                                if(station.active){
                                  farm.activeWeatherStations++;
                                } else {
                                  farm.inactiveWeatherStations++;
                                }
                              }

                              return ListView.builder(
                                controller: weatherStationListController,
                                itemCount: stations.length,
                                itemBuilder: (context, index) {
                                  final godKey =
                                  new GlobalKey<_InspectFarmScreenState>();
                                  return WeatherStationListTile(
                                      godKey, stations[index]);
                                },
                              );
                            }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
