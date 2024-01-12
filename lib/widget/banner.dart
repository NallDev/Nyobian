import 'package:flutter/material.dart';
import 'package:restaurant_app/theme/font_style.dart';
import 'package:restaurant_app/utils/constant.dart';
import 'package:restaurant_app/utils/screen_size.dart';

class MyBanner extends StatelessWidget {
  final void Function() onPressed;
  const MyBanner({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width80 = ScreenSize.getWidth(context) * 0.8;
    double height30 = ScreenSize.getHeight(context) * 0.3;

    return Container(
      width: double.infinity,
      height: height30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.pinkAccent, Colors.white],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              discount,
              style: myTextTheme.titleLarge?.copyWith(color: Colors.white),
            ),
            Text(
              firstOrder,
              style: myTextTheme.bodyMedium?.copyWith(color: Colors.white),
            ),
            ElevatedButton(
              onPressed: () {
                onPressed;
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.pinkAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(orderNow),
            ),
          ],
        ),
      ),
    );
  }
}
