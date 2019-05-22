import 'package:flutter/material.dart';
import 'package:iot_farm/Models/Farm.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:iot_farm/Data/AppThemeData.dart';

class FarmListTile extends StatelessWidget {

  final Farm farm;

  FarmListTile(this.farm);

  Icon iconTrailing = Icon(Icons.arrow_forward_ios);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ExpansionTile(
            title: Text(farm.name),
            leading: Icon(MdiIcons.flower, size: 40,),
            initiallyExpanded: false,
            backgroundColor: Color.fromARGB(50, 204,247,238),
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(2),
                              child: Container(
                                child: Text("Humidity Sensors"),
                                padding: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.all(Radius.circular(10.0))
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5,bottom: 5,left: 40,right: 40),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(MdiIcons.leak,color: Colors.lightGreenAccent,size: 36.0,),
                              Text(farm.activeSoilSensors.toString()),
                              Spacer(flex: 1,),
                              Icon(MdiIcons.leak,color: Colors.redAccent,size: 36.0,),
                              Text(farm.inactiveSoilSensors.toString()),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(2),
                              child: Container(
                                child: Text("Weather Stations"),
                                padding: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5,bottom: 5,left: 40,right: 40),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(MdiIcons.leak,color: Colors.lightGreenAccent,size: 36.0,),
                              Text(farm.activeWeatherStations.toString()),
                              Spacer(flex: 1,),
                              Icon(MdiIcons.leak,color: Colors.redAccent,size: 36.0,),
                              Text(farm.inactiveWeatherStations.toString()),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        new RaisedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/InspectFarm", arguments: farm);
                          },
                          child: new Text("Inspect Farm"),
                          textTheme: ButtonTextTheme.primary,
                          color: AppThemeData.primaryColor,
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
