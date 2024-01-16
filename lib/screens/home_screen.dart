import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/screens/detail_screen.dart';
import 'package:restaurant_app/theme/font_style.dart';
import 'package:restaurant_app/utils/constant.dart';
import 'package:restaurant_app/widget/banner.dart';
import 'package:restaurant_app/widget/restaurant_item.dart';
import 'package:restaurant_app/widget/search.dart';
import 'package:restaurant_app/widget/text_icon.dart';

class MyHomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  List<Restaurant> restaurants = [];
  List<Restaurant> filterResults = [];
  String error = "";

  @override
  void initState() {
    loadRestaurants();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MySearch(
                  onTextChanged: (value) {
                    setState(() {
                      value.isNotEmpty
                          ? filterResults = restaurants
                              .where((element) => element.name
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList()
                          : filterResults = restaurants;
                    });
                  },
                  onClearText: () {
                    setState(() {
                      filterResults = restaurants;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                MyBanner(onPressed: () {
                  restaurants.isNotEmpty
                      ? Navigator.pushNamed(context, MyDetailScreen.routeName,
                          arguments: restaurants[0])
                      : null;
                }),
                const SizedBox(height: 16.0),
                MyTextIcon(
                    iconData: Icons.stars,
                    iconColor: Colors.pinkAccent,
                    text: nearLocation,
                    textStyle: myTextTheme.titleSmall),
                if (error.isEmpty) ...[
                  filterResults.isNotEmpty
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: filterResults.length,
                          itemBuilder: (context, index) {
                            return MyRestaurantItem(
                              item: filterResults[index],
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, MyDetailScreen.routeName,
                                    arguments: filterResults[index]);
                              },
                            );
                          },
                        )
                      : Text(
                          noData,
                          style: myTextTheme.bodyLarge
                              ?.copyWith(color: Colors.pinkAccent),
                        ),
                ] else ...[
                  const SizedBox(
                    height: 16.0,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      error,
                      style: myTextTheme.bodyLarge
                          ?.copyWith(color: Colors.pinkAccent),
                    ),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loadRestaurants() async {
    try {
      String jsonString = await DefaultAssetBundle.of(context)
          .loadString('assets/data/local_restaurant.json');
      setState(() {
        restaurants = parseRestaurants(jsonString);
        filterResults = restaurants;
      });
    } catch (e) {
      setState(() {
        error = 'Error with detail : $e';
      });
    }
  }
}
