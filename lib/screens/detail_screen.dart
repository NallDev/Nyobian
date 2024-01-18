import 'package:flutter/material.dart';
import 'package:restaurant_app/theme/font_style.dart';
import 'package:restaurant_app/utils/constant.dart';
import 'package:restaurant_app/utils/screen_size.dart';
import 'package:restaurant_app/widget/text_icon.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/model/search_restaurant_response.dart';

class MyDetailScreen extends StatefulWidget {
  static const routeName = '/detail';
  final Restaurant restaurant;

  const MyDetailScreen({Key? key, required this.restaurant}) : super(key: key);

  @override
  State<MyDetailScreen> createState() => _MyDetailScreenState();
}

class _MyDetailScreenState extends State<MyDetailScreen> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    final double height30 = ScreenSize.getHeight(context) * 0.3;

    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag: 'https://restaurant-api.dicoding.dev/images/medium/${widget.restaurant.pictureId}',
                  child: Image.network(
                    'https://restaurant-api.dicoding.dev/images/medium/${widget.restaurant.pictureId}',
                    fit: BoxFit.fitWidth,
                    width: double.infinity,
                    height: height30,
                  ),
                ),
                const SafeArea(child: BackButton(color: Colors.pinkAccent),),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 16.0,),
                  Text(
                    widget.restaurant.name,
                    style: myTextTheme.titleMedium?.copyWith(
                        color: Colors.pink),
                  ),
                  const SizedBox(height: 8.0,),
                  MyTextIcon(text: widget.restaurant.rating.toString(),
                    iconData: Icons.star,
                    iconColor: Colors.yellow,),
                  const SizedBox(height: 8.0,),
                  MyTextIcon(text: widget.restaurant.city,
                      iconData: Icons.location_city),
                  const SizedBox(height: 8.0,),
                  Text(
                    widget.restaurant.description,
                    style: myTextTheme.labelSmall?.copyWith(color: Colors.grey),
                    maxLines: isExpand ? 100 : 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpand = !isExpand;
                      });
                    },
                    child: Text(
                      readMore,
                      style: myTextTheme.labelSmall?.copyWith(
                          color: Colors.pink),
                    ),
                  ),
                  // MyListCategory(image: 'assets/images/drink.jpg',
                  //     title: categoryDrink,
                  //     drink: widget.restaurant.menus.drinks),
                  const SizedBox(height: 8.0,),
                  // MyListCategory(image: 'assets/images/food.png',
                  //     title: categoryFood,
                  //     food: widget.restaurant.menus.foods),
                  const SizedBox(height: 8.0,),
                  ElevatedButton(
                    onPressed: () => _makePhoneCall('123'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(orderNow),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}