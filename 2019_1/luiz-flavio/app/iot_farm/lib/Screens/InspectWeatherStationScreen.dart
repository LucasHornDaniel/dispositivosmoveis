import 'package:flutter/material.dart';
import 'package:iot_farm/Data/AppThemeData.dart';
import 'package:iot_farm/Data/InspectWeatherStation.dart';
import 'package:iot_farm/Models/WeatherStation.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:iot_farm/Data/DateLineChartEasy.dart';
import 'package:iot_farm/Models/DataGraphic.dart';
import 'package:iot_farm/Models/DataGraphicDate.dart';
import 'package:iot_farm/Models/DataWeatherStation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';

class InspectWeatherStationScreen extends StatefulWidget {
  @override
  _InspectWeatherStationScreenState createState() =>
      _InspectWeatherStationScreenState();
}

class _InspectWeatherStationScreenState extends State<InspectWeatherStationScreen> {
  WeatherStation weatherStation;

  bool activeWeatherStationValue = false;
  bool activeWeatherStationChecked = false;

  var inspectWeatherStation = new InspectWeatherStation();

  DateLineChartEasy lineChart;

  bool graphicShowedOnce = false;

  ScrollController weatherStationDataListController = new ScrollController();
  double positionScroll;
  bool canUpdatePosition = true;

  Timer timerWihoutSetPosition;
  Timer timerSetPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(positionScroll == null){
      positionScroll = weatherStationDataListController.initialScrollOffset;
    }

    weatherStationDataListController.addListener((){
      if(canUpdatePosition){
        positionScroll = weatherStationDataListController.offset;
        print("Scroll value: "+positionScroll.toString());
      } else {
        print("Can't update position. The Last position is: "+positionScroll.toString());
      }
    });
  }

  TimerWihoutPosition(){
//    if(timerWihoutSetPosition != null){
//      timerWihoutSetPosition.cancel();
//    }
    timerWihoutSetPosition = new Timer(new Duration(seconds: 10), () {
      if(this.mounted){
        canUpdatePosition = false;
        setState(() {
          inspectWeatherStation.canQueryValues = true;
          print("updated");
        });
      }
    });
  }

  TimerWithPosition(){
//    if(timerSetPosition != null){
//      timerSetPosition.cancel();
//    }
    timerSetPosition = new Timer(new Duration(milliseconds: 200), () {
      weatherStationDataListController.jumpTo(positionScroll);
      canUpdatePosition = true;
      TimerWihoutPosition();
    });
  }

  Widget NoDataInfo(){
    TimerWihoutPosition();

    return Container(
      child: Center(
        child: Text("No data loaded for inactive station...."),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    weatherStation = ModalRoute.of(context).settings.arguments;

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: new Scaffold(
        appBar: AppBar(
          title: Text("Inspect Weather Station"),
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
                    controller:weatherStationDataListController,
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
                            child: new Text(weatherStation.name),
                          ),
                          title: weatherStation.name,
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
                                  weatherStation.FormatMac(),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ),
                          new Switch(
                            value: weatherStation.active,
                            onChanged: (bool newValue) async {
                              activeWeatherStationChecked =
                              await weatherStation.changeWeatherStationActiveState(
                                  context, newValue);
                              setState(() {
                                weatherStation.active = activeWeatherStationChecked;
                              });
                            },
                          )
                        ],
                      ),
                      new Padding(
                        padding: EdgeInsets.only(bottom: 5, top: 5),
                        child: new Divider(),
                      ),
                      !weatherStation.active?
                          NoDataInfo()
                          :FutureBuilder(
                          future: !inspectWeatherStation.waitRequest?inspectWeatherStation.GetDataGraphicDateWeatherStation(
                              weatherStation.code_station):inspectWeatherStation.listDataGraphicDate,
                          builder: (context, snapshotValuesWeatherStation) {
                            switch (snapshotValuesWeatherStation.connectionState) {
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
                                  if (snapshotValuesWeatherStation.hasError) {
                                    return Text(
                                        'Error: ${snapshotValuesWeatherStation.error}');
                                  } else if (snapshotValuesWeatherStation.hasData) {
                                    if (snapshotValuesWeatherStation.data == null || snapshotValuesWeatherStation.data.length == 0) {
                                      return new Container(
                                        child: Center(
                                          child: Text("No data loaded...."),
                                        ),
                                      );
                                    }

                                    //get full data
                                    List<DataWeatherStation> fullData = snapshotValuesWeatherStation.data;
                                    //create list of separate data
                                    List<DataGraphicDate> winddirectionData = [];
                                    List<DataGraphicDate> windSpeedData = [];
                                    List<DataGraphicDate> atmosphericpressureData = [];
                                    List<DataGraphicDate> waterevaporationData = [];
                                    List<DataGraphicDate> insolationData = [];
                                    List<DataGraphicDate> airhumidityData = [];
                                    List<DataGraphicDate> solarradiationData = [];
                                    List<DataGraphicDate> fluvialprecipitationData = [];
                                    List<DataGraphicDate> temperatureData = [];
                                    List<DataGraphicDate> soiltemperatureData = [];

                                    //set separate data
                                    for(DataWeatherStation row in fullData){
                                      winddirectionData.add(new DataGraphicDate(row.datereceive, row.winddirection));
                                      windSpeedData.add(new DataGraphicDate(row.datereceive, row.windspeed));
                                      atmosphericpressureData.add(new DataGraphicDate(row.datereceive, row.atmosphericpressure));
                                      waterevaporationData.add(new DataGraphicDate(row.datereceive, row.waterevaporation));
                                      insolationData.add(new DataGraphicDate(row.datereceive, DateTime.parse('0000-00-00 '+row.insolation).hour));
                                      airhumidityData.add(new DataGraphicDate(row.datereceive, row.airhumidity));
                                      solarradiationData.add(new DataGraphicDate(row.datereceive, row.solarradiation));
                                      fluvialprecipitationData.add(new DataGraphicDate(row.datereceive, row.fluvialprecipitation));
                                      temperatureData.add(new DataGraphicDate(row.datereceive, row.temperature));
                                      soiltemperatureData.add(new DataGraphicDate(row.datereceive, row.soiltemperature));
                                    }

                                    Widget winddirection = DateLineChartEasy(winddirectionData,title:'Wind Direction');
                                    Widget windspeed = DateLineChartEasy(windSpeedData,title:'Wind Speed');
                                    Widget atmosphericpressure = DateLineChartEasy(atmosphericpressureData,title:'Atmospheric Pressure');
                                    Widget waterevaporation = DateLineChartEasy(waterevaporationData,title:'Water Evaporation');
                                    Widget insolation = DateLineChartEasy(insolationData,title:'Insolation');
                                    Widget airhumidity = DateLineChartEasy(airhumidityData,title:'Air Humidity');
                                    Widget solarradiation = DateLineChartEasy(solarradiationData,title:'Solar Radiation');
                                    Widget fluvialprecipitation = DateLineChartEasy(fluvialprecipitationData,title:'Fluvial Precipitation');
                                    Widget temperature = DateLineChartEasy(temperatureData,title:'Temperature');
                                    Widget soiltemperature = DateLineChartEasy(soiltemperatureData,title:'Soil Temperature');

                                    Widget graphicList = Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        //new graphic
                                        winddirection,
                                        new Padding(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: new Divider(),
                                        ),
                                        //new graphic
                                        windspeed,
                                        new Padding(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: new Divider(),
                                        ),
                                        //new graphic
                                        atmosphericpressure,
                                        new Padding(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: new Divider(),
                                        ),
                                        //new graphic
                                        waterevaporation,
                                        new Padding(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: new Divider(),
                                        ),
                                        //new graphic
                                        insolation,
                                        new Padding(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: new Divider(),
                                        ),
                                        //new graphic
                                        airhumidity,
                                        new Padding(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: new Divider(),
                                        ),
                                        //new graphic
                                        solarradiation,
                                        new Padding(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: new Divider(),
                                        ),
                                        //new graphic
                                        fluvialprecipitation,
                                        new Padding(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: new Divider(),
                                        ),
                                        //new graphic
                                        temperature,
                                        new Padding(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: new Divider(),
                                        ),
                                        //new graphic
                                        soiltemperature,
                                        new Padding(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: new Divider(),
                                        ),
                                      ],
                                    );
                                    //end of element list
                                    print("gerated");

                                    if(!canUpdatePosition){
                                      print("with timerposition");
                                      TimerWithPosition();
                                    } else {
                                      print("without timerposition");
                                      TimerWihoutPosition();
                                    }

                                    return graphicList;

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
