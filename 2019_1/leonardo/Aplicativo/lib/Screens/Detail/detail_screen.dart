import 'package:flutter/material.dart';
import 'package:maintenance_status/Controllers/ServiceOrder.controller.dart';
import 'package:maintenance_status/Models/ServiceOrder.model.dart';
import 'package:maintenance_status/Screens/Home/Components/CardRow.dart';

class DetailScreen extends StatelessWidget {
  final ServiceOrder serviceOrder;
  final ServiceOrderController serviceOrderController = new ServiceOrderController();

  DetailScreen(this.serviceOrder);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 33, 113, 1.0),
          title: Text("Detalhes"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              CardRow(Color.fromRGBO(250, 250, 250, 1.0), "Data da requisição:", serviceOrder.getDataFormatada()),
              Divider(color: Colors.black),
              CardRow(Color.fromRGBO(255, 255, 255, 1.0), "Status:", serviceOrder.status),
              Divider(color: Colors.black),
              CardRow(Color.fromRGBO(255, 255, 255, 1.0), "Produto:", serviceOrder.product),
              Divider(color: Colors.black),
              CardRow(Color.fromRGBO(250, 250, 250, 1.0), "Descrição do problema:", serviceOrder.problemDescription),
              Divider(color: Colors.black),
              CardRow(Color.fromRGBO(255, 255, 255, 1.0), "Materiais necessarios:", serviceOrder.getProductsAsString()),
              Divider(color: Colors.black),
              CardRow(Color.fromRGBO(255, 255, 255, 1.0), "Serviços necessarios:", serviceOrder.getServicesAsString()),
              Divider(color: Colors.black),
              CardRow(Color.fromRGBO(250, 250, 250, 1.0), "Custo total:", "R\$ " + serviceOrder.solutionPrice.toString()),
              Divider(color: Colors.black),
              Row(
                children: <Widget>[
                  Expanded(
                      child: RaisedButton(
                    child: const Text('Confirmar', style: TextStyle(color: Colors.white)),
                    color: Color.fromRGBO(0, 33, 113, 1.0),
                    onPressed: () async {
                      bool result = await serviceOrderController.updateServiceOrderStatus(serviceOrder.id.toString());
                      if(result){
                        Navigator.pop(context);
                      }
                    },
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
