import 'package:flutter/material.dart';
import 'package:restaurant_app/theme/font_style.dart';

class MyTextIcon extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final IconData iconData;
  final Color? iconColor;
  const MyTextIcon(
      {Key? key,
      required this.text,
      this.textStyle,
      required this.iconData,
      this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          iconData,
          color: iconColor ?? Colors.grey,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: textStyle ?? myTextTheme.labelLarge,
        ),
      ],
    );
  }
}
