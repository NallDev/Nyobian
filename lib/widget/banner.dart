import 'package:flutter/material.dart';
import 'package:restaurant_app/theme/font_style.dart';
import 'package:restaurant_app/utils/constant.dart';

class MyBanner extends StatelessWidget {
  final void Function() onPressed;
  final bool isSubscribe;
  const MyBanner({Key? key, required this.onPressed, required this.isSubscribe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.pinkAccent, Colors.pinkAccent.shade100],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                subscribeNow,
                style: myTextTheme.titleLarge?.copyWith(color: Colors.white),
              ),
            ),
            Flexible(
              child: Text(
                subscribeBenefit,
                style: myTextTheme.bodyMedium?.copyWith(color: Colors.white),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Flexible(
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSubscribe ? Colors.grey : Colors.pink[700],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(isSubscribe ? unsubscribe : subscribe),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
