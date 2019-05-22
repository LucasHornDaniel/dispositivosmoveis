import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:iot_farm/Models/DataGraphic.dart';
import 'package:iot_farm/Data/ShowMessage.dart';
import 'package:iot_farm/Data/ConnectionAPI.dart';
import 'dart:convert';

class LineChartEasy extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  ConnectionAPI _connectionAPI = new ConnectionAPI();
  ShowMessage _showMessage = new ShowMessage();

  LineChartEasy(this.seriesList, {this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory LineChartEasy.withSampleData() {
    return new LineChartEasy(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  factory LineChartEasy.loadDataSensor(code_sensor){

    ConnectionAPI _connectionAPI = new ConnectionAPI();
    ShowMessage _showMessage = new ShowMessage();
    List<DataGraphic> listDataGraphic = [];

    _connectionAPI.url = "GetLastTenSensorData";
    _connectionAPI.body = json.encode({
      "id":code_sensor
    });
    _connectionAPI.doResultRequest("DataGraphic");
    listDataGraphic = _connectionAPI.GetFullList();

    return new LineChartEasy(
      [
        new charts.Series<DataGraphic, int>(
          id: 'Desktop',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (DataGraphic data, _) => data.index,
          measureFn: (DataGraphic data, _) => data.value,
          data: listDataGraphic,
        )
        // Configure our custom bar target renderer for this series.
          ..setAttribute(charts.rendererIdKey, 'customArea'),
      ],
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(seriesList,
        animate: animate,
        customSeriesRenderers: [
          new charts.LineRendererConfig(
            // ID used to link series to this renderer.
              customRendererId: 'customArea',
              includeArea: true,
              stacked: true),
        ]);
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<DataGraphic, int>> _createSampleData() {


    final myFakeDesktopData = [
      new DataGraphic(0, 5),
      new DataGraphic(1, 25),
      new DataGraphic(2, 100),
      new DataGraphic(3, 75),
    ];

//    var myFakeTabletData = [
//      new DataGraphic(0, 10),
//      new DataGraphic(1, 50),
//      new DataGraphic(2, 200),
//      new DataGraphic(3, 150),
//    ];

    return [
      new charts.Series<DataGraphic, int>(
        id: 'Desktop',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (DataGraphic data, _) => data.index,
        measureFn: (DataGraphic data, _) => data.value,
        data: myFakeDesktopData,
      )
      // Configure our custom bar target renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'customArea'),
      //adicional linha
//      new charts.Series<DataGraphic, int>(
//        id: 'Tablet',
//        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
//        domainFn: (DataGraphic data, _) => data.index,
//        measureFn: (DataGraphic data, _) => data.value,
//        data: myFakeTabletData,
//      ),
    ];
  }
}