import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/connectivity_provider.dart';
import 'package:restaurant_app/provider/reminder_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/screens/detail_screen.dart';
import 'package:restaurant_app/theme/font_style.dart';
import 'package:restaurant_app/utils/constant.dart';
import 'package:restaurant_app/widget/banner.dart';
import 'package:restaurant_app/widget/restaurant_item.dart';
import 'package:restaurant_app/widget/search.dart';
import 'package:restaurant_app/widget/text_icon.dart';

class MyHomeScreen extends StatelessWidget {
  static const routeName = '/home';

  const MyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var connectivityProvider = Provider.of<ConnectivityProvider>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (connectivityProvider.connectivity == ConnectivityResult.none) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              duration: Duration(milliseconds: 500),
              content: Text(noInternetMessage)),
        );
      }
    });

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16.0,),
                MySearch(
                  onTextChanged: (value) {
                    context.read<RestaurantProvider>().searchQuery = value;
                  },
                  onClearText: () {
                    context.read<RestaurantProvider>().searchQuery = '';
                  },
                ),
                const SizedBox(height: 16.0),
                Consumer<ReminderProvider>(
                  builder: (context, state, _) {
                    return MyBanner(onPressed: () {
                      if (state.hasPermission) {

                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please give permission for notification")));
                        state.requestNotificationPermission();
                      }
                    }, isSubscribe: true,);
                  },
                ),
                const SizedBox(height: 16.0),
                MyTextIcon(
                    iconData: Icons.stars,
                    iconColor: Colors.pinkAccent,
                    text: nearLocation,
                    textStyle: myTextTheme.titleSmall),
                const SizedBox(
                  height: 16.0,
                ),
                _buildList()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    return Consumer<RestaurantProvider>(builder: (context, state, _) {
      switch (state.searchState) {
        case SearchState.loading:
          return const Align(
              alignment: Alignment.center, child: CircularProgressIndicator());
        case SearchState.success:
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.searchResult.restaurants.length,
            itemBuilder: (context, index) {
              return MyRestaurantItem(
                item: state.searchResult.restaurants[index],
                onPressed: () {
                  Navigator.pushNamed(context, MyDetailScreen.routeName,
                          arguments: state.searchResult.restaurants[index])
                      .then((_) {
                    MyDetailScreen.isLoad = false;
                  });
                },
              );
            },
          );
        case SearchState.empty:
          return Align(alignment: Alignment.center, child: Text(state.message));
        case SearchState.error:
          return Align(alignment: Alignment.center, child: Text(state.message));
      }
    });
  }
}
