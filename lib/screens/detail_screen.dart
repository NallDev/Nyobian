import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/theme/font_style.dart';
import 'package:restaurant_app/utils/screen_size.dart';
import 'package:restaurant_app/widget/list_category.dart';
import 'package:restaurant_app/widget/text_icon.dart';
import 'package:url_launcher/url_launcher.dart';

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
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  widget.restaurant.pictureId,
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                  height: height30,
                ),
                SafeArea(child: BackButton(color: Colors.pinkAccent),),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SizedBox(height: 16.0,),
                  Text(
                    widget.restaurant.name,
                    style: myTextTheme.titleMedium?.copyWith(
                        color: Colors.pink),
                  ),
                  SizedBox(height: 8.0,),
                  MyTextIcon(text: widget.restaurant.rating.toString(),
                    iconData: Icons.star,
                    iconColor: Colors.yellow,),
                  SizedBox(height: 8.0,),
                  MyTextIcon(text: widget.restaurant.city,
                      iconData: Icons.location_city),
                  SizedBox(height: 8.0,),
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
                      'Read More',
                      style: myTextTheme.labelSmall?.copyWith(
                          color: Colors.pink),
                    ),
                  ),
                  MyListCategory(image: 'assets/images/drink.jpg',
                      title: "Drinks",
                      drink: widget.restaurant.menus.drinks),
                  SizedBox(height: 8.0,),
                  MyListCategory(image: 'assets/images/food.png',
                      title: "Foods",
                      food: widget.restaurant.menus.foods),
                  SizedBox(height: 8.0,),
                  ElevatedButton(
                    onPressed: () => _makePhoneCall("08123456789"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      foregroundColor: Colors.white,
                    ),
                    child: Text("Order Now"),
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