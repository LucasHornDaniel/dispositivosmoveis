import 'package:charts_common/common.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:iot_farm/Models/DataGraphicDate.dart';

class DateLineChartEasy extends StatelessWidget{
  final List<DataGraphicDate> listDataGraphicDate;
  final bool animate;
  final String title;

  DateLineChartEasy(this.listDataGraphicDate,{this.title = "Sample Data", this.animate});

  //********************DATA GRAPHIC DATE*******************************************
  /// Creates a [TimeSeriesChart] with sample data and no transition.
  WithDataDateLoaded(List<DataGraphicDate> dataList) {
    return new DateLineChartEasy(
      _createGraphicLastIntervalDateData(dataList),
      // Disable animations for image tests.
      animate: false,
    );
  }

  _createGraphicLastIntervalDateData(List<DataGraphicDate> dataList) {

    var series = [
      new charts.Series<DataGraphicDate, DateTime>(
        id: 'Price',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (DataGraphicDate data, _) => DateTime.parse(data.date),
        measureFn: (DataGraphicDate data, _) => data.value,
        data: dataList,
      ),
    ];
    return series;

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return chartWidget();
  }

  Widget chartWidget() {

    var series = [
      new charts.Series<DataGraphicDate, DateTime>(
        id: 'dataSensor',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (DataGraphicDate data, _) => DateTime.parse(data.date),
        measureFn: (DataGraphicDate data, _) => data.value,
        data: listDataGraphicDate,
      ),
    ];

    var chart = new charts.TimeSeriesChart(
      series,
      domainAxis: new charts.DateTimeAxisSpec(
        showAxisLine: true,
        tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(
          minute: charts.TimeFormatterSpec(
            format: 'mm',
            transitionFormat: 'mm:ss'
          ),
        ),
      ),
      animate: false,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
      behaviors: [
        new charts.ChartTitle(this.title,
            behaviorPosition: charts.BehaviorPosition.top,
            titleOutsideJustification: charts.OutsideJustification.middle,
            // Set a larger inner padding than the default (10) to avoid
            // rendering the text too close to the top measure axis tick label.
            // The top tick label may extend upwards into the top margin region
            // if it is located at the top of the draw area.
            innerPadding: 18),
      ],
    );

    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.all(32.0),
            child: new SizedBox(
              height: 200.0,
              child: chart,
            ),
          ),
        ],
      ),
    );
  }
}