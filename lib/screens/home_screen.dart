import 'package:flutter/material.dart';
import 'package:restaurant_app/widget/banner.dart';
import 'package:restaurant_app/widget/search.dart';

class MyHomeScreen extends StatelessWidget {
  static const routeName = '/home';

  const MyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MySearch(),
            SizedBox(height: 16.0,),
            MyBanner(onPressed: () {
        
            }),
          ],
        ),
      ),
    );
  }
}