import 'package:flutter/material.dart';

class CardRow extends StatelessWidget {
  final Color color;
  final String title;
  final String content;

  CardRow(this.color, this.title, this.content);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: Text(title, style: TextStyle(fontSize: 16.0)),
        ),
        Flexible(
            child: Text(
          content,
          style: TextStyle(fontSize: 15.0),
          overflow: TextOverflow.ellipsis,
          maxLines: 10,
        )),
      ],
    );
  }
}
