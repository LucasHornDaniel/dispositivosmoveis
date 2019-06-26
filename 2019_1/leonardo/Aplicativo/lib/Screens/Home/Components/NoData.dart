import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  final String content;

  NoData(this.content);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Column(
            children: <Widget>[
              Center(child: Icon(Icons.error_outline, size: 70.0, color: Colors.black87)),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Center(
                  child: Text(content, style: TextStyle(color: Colors.black87, fontSize: 20.0)),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
