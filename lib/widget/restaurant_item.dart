import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/theme/font_style.dart';
import 'package:restaurant_app/utils/screen_size.dart';
import 'package:restaurant_app/widget/text_icon.dart';

class MyRestaurantItem extends StatelessWidget {
  final Restaurant item;
  final void Function() onPressed;

  const MyRestaurantItem(
      {Key? key, required this.item, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width90 = ScreenSize.getWidth(context) * 0.9;
    double height30 = ScreenSize.getHeight(context) * 0.3;

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: width90,
          height: height30,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 16.0, // has the effect of softening the shadow
                  spreadRadius: 1.0, // has the effect of extending the shadow
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0)),
                child: Image.network(
                  item.pictureId,
                  fit: BoxFit.fitWidth,
                  height: height30 / 2,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.name,
                      style: myTextTheme.titleSmall?.copyWith(color: Colors.pink),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      item.description,
                      style: myTextTheme.labelSmall?.copyWith(color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyTextIcon(
                          text: item.rating.toString(),
                          iconData: Icons.star,
                          iconColor: Colors.yellow,
                        ),
                        MyTextIcon(
                            text: item.city, iconData: Icons.location_city)
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
