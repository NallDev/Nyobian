import 'package:flutter/material.dart';

class MyTextIcon extends StatelessWidget {
  final String text;
  final IconData iconData;

  const MyTextIcon({Key? key, required this.text, required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          iconData,
          color: Colors.grey,
        ),
        SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}
