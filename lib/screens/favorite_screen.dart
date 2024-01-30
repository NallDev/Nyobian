import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/search_restaurant_response.dart';
import 'package:restaurant_app/provider/db_provider.dart';

import '../theme/font_style.dart';
import '../utils/constant.dart';
import '../widget/restaurant_item.dart';
import '../widget/text_icon.dart';
import 'detail_screen.dart';

class MyFavoriteScreen extends StatelessWidget {
  const MyFavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Consumer<DbProvider>(
        builder: (context, state, _) {
          switch (state.dbState) {
            case DbState.success:
              return SafeArea(
                  child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 16.0,
                      ),
                      MyTextIcon(
                        iconData: Icons.stars,
                        iconColor: Colors.pinkAccent,
                        text: myRestaurantFavorites,
                        textStyle: myTextTheme.titleSmall,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      _buildList(state.favorites)
                    ],
                  ),
                ),
              ));
            case DbState.empty:
              return _emptyView();
            case DbState.error:
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
              if (state.favorites.isNotEmpty) {
                return _buildList(state.favorites);
              } else {
                return _emptyView();
              }
          }
        },
      ),
    );
  }

  Widget _buildList(List<Restaurant> favorites) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        return MyRestaurantItem(
          item: favorites[index],
          onPressed: () {
            Navigator.pushNamed(context, MyDetailScreen.routeName,
                    arguments: favorites[index])
                .then((_) {
              MyDetailScreen.isLoad = false;
            });
          },
        );
      },
    );
  }

  Widget _emptyView() {
    return Center(
      child: Lottie.asset('assets/anim/empty.json'),
    );
  }
}
