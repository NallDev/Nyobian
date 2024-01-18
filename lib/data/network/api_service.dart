import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/search_restaurant_response.dart';

class ApiService {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev/";

  Future<SearchRestaurantResponse> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse("$_baseUrl/search?q=$query"));

    if (response.statusCode == 200) {
      return SearchRestaurantResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load search restaurant");
    }
  }
}