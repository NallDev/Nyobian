import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/screens/detail_screen.dart';
import 'package:restaurant_app/theme/font_style.dart';
import 'package:restaurant_app/widget/banner.dart';
import 'package:restaurant_app/widget/restaurant_item.dart';
import 'package:restaurant_app/widget/search.dart';
import 'package:restaurant_app/widget/text_icon.dart';

class MyHomeScreen extends StatelessWidget {
  static const routeName = '/home';

  const MyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: FutureBuilder(
            future: DefaultAssetBundle.of(context)
                .loadString('assets/data/local_restaurant.json'),
            builder: (context, snapshot) {
              final List<Restaurant> restaurants =
                  parseRestaurants(snapshot.data);
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MySearch(onTextChanged: (value) {
                      print("TEXT SEARCH : $value");
                    }),
                    SizedBox(height: 16.0),
                    MyBanner(onPressed: () {
                      Navigator.pushNamed(context, MyDetailScreen.routeName,
                          arguments: restaurants[0]);
                    }),
                    SizedBox(height: 16.0),
                    MyTextIcon(
                        iconData: Icons.stars,
                        iconColor: Colors.pinkAccent,
                        text: "Near your location",
                        textStyle: myTextTheme.titleSmall),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: restaurants.length,
                        itemBuilder: (context, index) {
                          return MyRestaurantItem(
                            item: restaurants[index],
                            onPressed: () {
                              Navigator.pushNamed(context, MyDetailScreen.routeName, arguments: restaurants[index]);
                            },
                          );
                        }),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
