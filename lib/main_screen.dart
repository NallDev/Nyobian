import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/favorite_screen.dart';
import 'package:restaurant_app/screens/home_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main';
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _currentIndex = 0;

  final List<Widget> _screens = [
    const MyHomeScreen(),
    const MyFavoriteScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Home"),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.favorite),
            title: const Text("Favorites"),
          ),
        ],
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.grey[400],
      ),
    );
  }
}
