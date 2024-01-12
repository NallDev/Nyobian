import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/home_screen.dart';
import 'package:restaurant_app/theme/font_style.dart';
import 'package:restaurant_app/utils/constant.dart';
import 'package:restaurant_app/utils/screen_size.dart';

class MySplashScreen extends StatelessWidget {
  static const routeName = '/splash';
  static bool hasNavigated = false;
  const MySplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!hasNavigated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        navigateToHome(context);
      });
    }

    double size30 = ScreenSize.getWidth(context) * 0.3;
    double size50 = ScreenSize.getWidth(context) * 0.5;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Image.asset(
              'assets/images/chef_hat_left.png',
              fit: BoxFit.fill,
              width: size30,
              height: size30,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/brand_logo.png',
                  width: size50,
                  height: size30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    opening,
                    style: myTextTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Image.asset(
              'assets/images/bowl_right.png',
              width: size30,
              height: size30,
            ),
          ),
        ],
      ),
    );
  }

  void navigateToHome(BuildContext context) {
    hasNavigated = true;
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, MyHomeScreen.routeName);
    });
  }
}