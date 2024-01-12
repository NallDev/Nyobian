import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/utils/screen_size.dart';
import 'package:restaurant_app/widget/text_icon.dart';

class MyRestaurantItem extends StatelessWidget {
  final Restaurant item;
  const MyRestaurantItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width80 = ScreenSize.getWidth(context) * 0.8;
    double height20 = ScreenSize.getHeight(context) * 0.2;

    return Container(
      width: width80,
      height: height20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Image.network(item.pictureId, fit: BoxFit.fitWidth,),
          Text(item.name),
          Text(item.description),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyTextIcon(text: item.rating.toString(), iconData: Icons.star),
              MyTextIcon(text: item.city, iconData: Icons.location_city)
            ],
          ),
        ],
      ),
    );
  }
}