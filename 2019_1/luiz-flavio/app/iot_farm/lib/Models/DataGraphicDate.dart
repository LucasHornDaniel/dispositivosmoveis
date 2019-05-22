import 'dart:convert';

class DataGraphicDate{
  String date;
  int value;

  DataGraphicDate(this.date,this.value);

  DataGraphicDate.fromJson(Map<String, dynamic> json)
      : date = json['date'],
        value = int.parse(json['value']);

  Map<String, dynamic> toJson() =>
      {
        'index': date,
        'value': value,
      };
}