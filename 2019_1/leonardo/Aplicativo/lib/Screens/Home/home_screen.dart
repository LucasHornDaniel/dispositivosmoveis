import 'package:flutter/material.dart';
import 'package:maintenance_status/Models/ServiceOrder.model.dart';
import 'package:maintenance_status/Screens/Detail/detail_screen.dart';
import 'package:maintenance_status/Screens/Home/Components/SelectListIcon.dart';

import '../../Controllers/ServiceOrder.controller.dart';
import '../login_screen.dart';
import './Components/CardRow.dart';
import './Components/NoData.dart';

class HomeScreen extends StatefulWidget {
  final ServiceOrderController serviceOrderController =
      new ServiceOrderController();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Ordens de serviço"),
          backgroundColor: Color.fromRGBO(0, 33, 113, 1.0),
          centerTitle: true,
          actions: <Widget>[
            //logout
            IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.white,),
              onPressed: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (Route<dynamic> routes) => false);
              },
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: FutureBuilder<List<ServiceOrder>>(
              future: widget.serviceOrderController.getServiceOrders(),
              builder: (context, AsyncSnapshot<List<ServiceOrder>> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                    break;
                  case ConnectionState.done:
                    if (snapshot.hasData) {
                      print(snapshot.data.length);
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              child: ExpansionTile(
                                title: Text(
                                    snapshot.data[index].product.toString() +
                                        "\n" +
                                        snapshot.data[index].status,
                                    style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)),
                                leading:
                                    SelectListIcon(snapshot.data[index].status),
                                initiallyExpanded: false,
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Column(
                                        children: <Widget>[
                                          CardRow(
                                              Color.fromRGBO(
                                                  250, 250, 250, 1.0),
                                              "Data da requisição:",
                                              snapshot.data[index]
                                                  .getDataFormatada()),
                                          Divider(color: Colors.black),
                                          CardRow(
                                              Color.fromRGBO(
                                                  255, 255, 255, 1.0),
                                              "Status:",
                                              snapshot.data[index].status),
                                          Divider(color: Colors.black),
                                          CardRow(
                                              Color.fromRGBO(
                                                  250, 250, 250, 1.0),
                                              "Descrição do problema:",
                                              snapshot.data[index]
                                                  .problemDescription),
                                          Divider(color: Colors.black),
                                          (snapshot.data[index].status ==
                                                  "Aguardando Confirmação")
                                              ? Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                        child: RaisedButton(
                                                      child: const Text(
                                                          'Verificar Detalhes',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                      color: Color.fromRGBO(0, 33, 113, 1.0),
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            new MaterialPageRoute(
                                                                builder: (context) =>
                                                                    DetailScreen(
                                                                        snapshot
                                                                            .data[index])));
                                                      },
                                                    )),
                                                  ],
                                                )
                                              : Column()
                                        ],
                                      ))
                                ],
                              ),
                            );
                          });
                    } else {
                      return NoData("Não Existem Ordens de Serviço Pendentes");
                    }
                    break;
                  default:
                    return Container();
                }
              }),
        ),
      ),
    );
  }
}
