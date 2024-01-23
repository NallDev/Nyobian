import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyFavoriteScreen extends StatelessWidget {
  const MyFavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Lottie.asset('assets/anim/empty.json'),
      ),
    );
  }
}