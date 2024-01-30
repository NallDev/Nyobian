import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/search_restaurant_response.dart';
import 'package:restaurant_app/theme/font_style.dart';
import 'package:restaurant_app/widget/text_icon.dart';

class MyRestaurantItem extends StatelessWidget {
  final Restaurant item;
  final void Function() onPressed;

  const MyRestaurantItem(
      {Key? key, required this.item, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: double.infinity,
          height: 200,
          decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 16.0,
                  spreadRadius: 1.0,
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0)),
                child: Hero(
                  tag:
                      'https://restaurant-api.dicoding.dev/images/medium/${item.pictureId}',
                  child: Image.network(
                    'https://restaurant-api.dicoding.dev/images/medium/${item.pictureId}',
                    fit: BoxFit.fitWidth,
                    height: 100,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        "assets/images/food.png",
                        fit: BoxFit.fitWidth,
                        width: double.infinity,
                        height: 100,
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.name,
                      style:
                          myTextTheme.titleSmall?.copyWith(color: Colors.pink),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      item.description,
                      style:
                          myTextTheme.labelSmall?.copyWith(color: Colors.grey),
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
