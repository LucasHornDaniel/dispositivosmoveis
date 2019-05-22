import 'package:flutter/material.dart';
import 'package:iot_farm/Models/WeatherStation.dart';

class WeatherStationListTile extends StatefulWidget {

  WeatherStation weatherStation;

  WeatherStationListTile(Key godKey, this.weatherStation) : super(key: godKey);
  _WeatherStationListTileState createState() => new _WeatherStationListTileState(this.weatherStation);
}

class _WeatherStationListTileState extends State<WeatherStationListTile> {

  final WeatherStation weatherStation;

  bool activeWeatherStationValue = false;
  bool weatherStationValueChecked = false;

  _WeatherStationListTileState(this.weatherStation);

  Icon iconTrailing = Icon(Icons.arrow_forward_ios);

  @override
  void initState() {
    // TODO: implement initState
    this.activeWeatherStationValue = this.weatherStation.active;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/InspectWeatherStation", arguments: weatherStation);
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
                new Text(weatherStation.name,textAlign: TextAlign.left,),
                new Text(weatherStation.FormatMac(),textAlign: TextAlign.left,),
              ],
            ),
          ),
          new Switch(
            value: activeWeatherStationValue,
            onChanged: (bool newValue) async{
              weatherStationValueChecked = await weatherStation.changeWeatherStationActiveState(context,newValue);
              setState(() {
                activeWeatherStationValue = weatherStationValueChecked;
              });
            },
          )
        ],
      ),
    );
  }
}
