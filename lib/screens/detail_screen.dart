import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/theme/font_style.dart';
import 'package:restaurant_app/utils/constant.dart';
import 'package:restaurant_app/utils/screen_size.dart';
import 'package:restaurant_app/widget/review_item.dart';
import 'package:restaurant_app/widget/text_icon.dart';
import '../data/model/search_restaurant_response.dart';
import '../widget/list_category.dart';

class MyDetailScreen extends StatelessWidget {
  static const routeName = '/detail';
  final Restaurant restaurant;

  const MyDetailScreen({Key? key, required this.restaurant}) : super(key: key);
  static bool isLoad = false;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!isLoad) {
        isLoad = true;
        Provider.of<DetailRestaurantProvider>(context, listen: false)
            .fetchDetailRestaurant(restaurant.id);
      }
    });

    final double height30 = ScreenSize.getHeight(context) * 0.3;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag:
                      'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                  child: Image.network(
                    'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                    fit: BoxFit.fitWidth,
                    width: double.infinity,
                    height: height30,
                  ),
                ),
                const SafeArea(
                  child: BackButton(color: Colors.pinkAccent),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    restaurant.name,
                    style:
                        myTextTheme.titleMedium?.copyWith(color: Colors.pink),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  MyTextIcon(
                    text: restaurant.rating.toString(),
                    iconData: Icons.star,
                    iconColor: Colors.yellow,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  MyTextIcon(
                      text: restaurant.city, iconData: Icons.location_city),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Consumer<DetailRestaurantProvider>(
                      builder: (context, state, _) {
                    return Column(
                      children: [
                        Text(
                          restaurant.description,
                          style: myTextTheme.labelSmall
                              ?.copyWith(color: Colors.grey),
                          maxLines: state.isExpand ? 100 : 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        GestureDetector(
                          onTap: () {
                            state.setExpand(!state.isExpand);
                          },
                          child: Text(
                            readMore,
                            style: myTextTheme.labelSmall
                                ?.copyWith(color: Colors.pink),
                          ),
                        ),
                      ],
                    );
                  }),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Consumer<DetailRestaurantProvider>(
                      builder: (context, state, _) {
                    switch (state.state) {
                      case DetailState.loading:
                        return const Align(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator());
                      case DetailState.success:
                        return Column(
                          children: [
                            MyListCategory(
                                image: 'assets/images/drink.jpg',
                                title: categoryDrink,
                                category: state.detailResult.menus.drinks),
                            const SizedBox(
                              height: 8.0,
                            ),
                            MyListCategory(
                                image: 'assets/images/food.png',
                                title: categoryFood,
                                category: state.detailResult.menus.foods),
                            ListReview(
                                title: "Last Review",
                                customerReview: state.listReview),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              "Your Review",
                              style: myTextTheme.titleSmall
                                  ?.copyWith(color: Colors.pink),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            TextField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'What is about your review?',
                              ),
                              onChanged: (value) {
                                Provider.of<DetailRestaurantProvider>(context,
                                        listen: false)
                                    .setReviewText(value);
                              },
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            state.reviewState == ReviewState.loading
                                ? const CircularProgressIndicator()
                                : ElevatedButton(
                                    onPressed: () {
                                      if (state.myReview.isNotEmpty) {
                                        Provider.of<DetailRestaurantProvider>(
                                                context,
                                                listen: false)
                                            .sendReviewRestaurant(
                                                restaurant.id);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                duration:
                                                    Duration(milliseconds: 500),
                                                content: Text(
                                                    "Please fill your review before send")));
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.pink,
                                      foregroundColor: Colors.white,
                                    ),
                                    child: const Text("Send Review"),
                                  ),
                            const SizedBox(
                              height: 16.0,
                            ),
                          ],
                        );
                      case DetailState.error:
                        return Align(
                            alignment: Alignment.center,
                            child: Text(state.message));
                    }
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
