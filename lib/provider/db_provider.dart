import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/local/db_helper.dart';

import '../data/model/search_restaurant_response.dart';

class DbProvider extends ChangeNotifier {
  final DbHelper dbHelper;

  DbProvider({required this.dbHelper}) {
    _getFavorites();
  }

  DbState _dbState = DbState.empty;
  DbState get dbState => _dbState;

  String _message = "";
  String get message => _message;

  List<Restaurant> _favorites = [];
  List<Restaurant> get favorites => _favorites;

  bool _isRestaurantFavorite = false;
  bool get isRestaurantFavorite => _isRestaurantFavorite;

  void _getFavorites() async {
    _favorites = await dbHelper.getRestaurants();
    if (_favorites.isNotEmpty) {
      _dbState = DbState.success;
    } else {
      _dbState = DbState.empty;
    }
    notifyListeners();
  }

  void isFavorite(String id) async {
    _isRestaurantFavorite = await dbHelper.isRestaurantFavorite(id);
    notifyListeners();
  }

  void addToFavorite(Restaurant restaurant) async {
    try {
      await dbHelper.insertRestaurant(restaurant);
      _getFavorites();
      isFavorite(restaurant.id);
    } catch(exception) {
      _dbState = DbState.error;
      _message = "Error when add to my favorite";
      notifyListeners();
    }
  }

  void deleteMyFavorite(String id) async {
    try {
      await dbHelper.deleteRestaurant(id);
      _getFavorites();
      isFavorite(id);
    } catch (exception) {
      _dbState = DbState.error;
      _message = "Error when delete my favorite";
      notifyListeners();
    }
  }
}

enum DbState {success, empty, error}