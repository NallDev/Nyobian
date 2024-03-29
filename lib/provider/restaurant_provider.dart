import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/model/search_restaurant_response.dart';
import 'package:restaurant_app/data/network/api_service.dart';
import 'package:restaurant_app/utils/constant.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  late SearchRestaurantResponse _searchRestaurantResponse;
  late SearchState _searchState;
  List<Restaurant> _allRestaurant = [];
  String _message = '';
  String _search = '';

  RestaurantProvider({required this.apiService}) {
    _searchRestaurant();
  }

  SearchRestaurantResponse get searchResult => _searchRestaurantResponse;
  SearchState get searchState => _searchState;
  String get message => _message;
  List<Restaurant> get allRestaurants => _allRestaurant;

  Future<dynamic> _searchRestaurant() async {
    _searchState = SearchState.loading;
    notifyListeners();
    try {
      final search = await apiService.searchRestaurant(_search);

      if (search.restaurants.isNotEmpty) {
        _searchState = SearchState.success;
        notifyListeners();
        if (_allRestaurant.isEmpty) {
          _allRestaurant = search.restaurants;
        }
        return _searchRestaurantResponse = search;
      } else {
        _searchState = SearchState.empty;
        notifyListeners();
        return _message = noData;
      }
    } on SocketException {
      _searchState = SearchState.error;
      notifyListeners();
      return _message = noInternetMessage;
    } catch (exception) {
      _searchState = SearchState.error;
      notifyListeners();
      return _message = failedLoadedData;
    }
  }

  set searchQuery(String value) {
    _search = value;
    notifyListeners();
    _searchRestaurant();
  }
}

enum SearchState { loading, success, empty, error }
