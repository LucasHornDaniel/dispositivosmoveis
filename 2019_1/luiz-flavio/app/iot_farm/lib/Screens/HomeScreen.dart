import 'package:flutter/material.dart';
import 'package:iot_farm/Data/AppThemeData.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:iot_farm/Models/Farm.dart';
import 'package:iot_farm/Components/FarmListTile.dart';
import 'package:iot_farm/Data/Login.dart';
import 'package:iot_farm/Data/Home.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController farmListController = new ScrollController();
  TextEditingController farmNameFieldController = new TextEditingController();

  Login login = new Login();
  Home home = new Home();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Home"),
        centerTitle: true,
        leading: new Container(),
        actions: <Widget>[
          IconButton(
              icon: Icon(MdiIcons.accountArrowRightOutline),
              color: Colors.white,
              onPressed: () {
                login.Logout(context);
              })
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(MdiIcons.plus),
        backgroundColor: Colors.red,
        onPressed: () {
          home.canQueryFarms = false;
          showDialog(
              context: context,
              builder: (context) => new SingleChildScrollView(
                    child: Dialog(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: paddingDialog,
                            right: paddingDialog,
                            top: paddingDialog / 1.5,
                            bottom: paddingDialog * 1.5),
                        child: Column(
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                FlatButton(
                                  child: Icon(MdiIcons.close),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                            TextFormField(
                              controller: farmNameFieldController,
                              decoration: InputDecoration(
                                  hintText: "enter with farm name",
                                  labelText: "Farm name"),
                            ),
                            SizedBox(
                              height: sizeLineSpace * 2,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: RaisedButton(
                                    child: Text("Add Farm"),
                                    color: AppThemeData.primaryColor,
                                    textTheme: ButtonTextTheme.primary,
                                    onPressed: () async {

                                      home.canQueryFarms = await home.AddFarm(
                                          context, farmNameFieldController) as bool;
                                      setState(() {

                                      });
                                    },
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ));
        },
      ),
      body: new Container(
          child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Expanded(
              child: new FutureBuilder(
            future: home.GetFarms(),
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
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    List<Farm> farms = snapshot.data;

                    if(farms == null || farms.length == 0){
                      return new Container(
                        child: Center(
                          child: Text("No data loaded...."),
                        ),
                      );
                    }

                    return ListView.builder(
                      controller: farmListController,
                      itemCount: farms.length,
                      itemBuilder: (context, index) {
                        return FarmListTile(farms[index]);
                      },
                    );
                  }
              }
            },
          )),
        ],
      )),
    );
  }
}
