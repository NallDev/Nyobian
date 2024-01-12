import 'package:flutter/material.dart';
import 'package:restaurant_app/theme/font_style.dart';
import 'package:restaurant_app/widget/banner.dart';
import 'package:restaurant_app/widget/search.dart';
import 'package:restaurant_app/widget/text_icon.dart';

class MyHomeScreen extends StatelessWidget {
  static const routeName = '/home';

  const MyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MySearch(),
              SizedBox(height: 16.0,),
              MyBanner(onPressed: () {

              }),
              SizedBox(height: 16.0,),
              MyTextIcon(iconData: Icons.stars, iconColor: Colors.pinkAccent, text: "Near your location", textStyle: myTextTheme.titleSmall)
            ],
          ),
        ),
      ),
    );
  }
}