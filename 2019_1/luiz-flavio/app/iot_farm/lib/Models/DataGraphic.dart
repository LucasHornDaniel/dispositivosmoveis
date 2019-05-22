import 'dart:convert';

class DataGraphic{
  int index;
  int value;

  DataGraphic(this.index,this.value);

  DataGraphic.fromJson(Map<String, dynamic> json)
      : index = int.parse(json['index']),
        value = int.parse(json['value']);

  Map<String, dynamic> toJson() =>
      {
        'index': index,
        'value': value,
      };
}