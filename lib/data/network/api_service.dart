import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/detail_restaurant_response.dart';
import 'package:restaurant_app/data/model/review_restaurant_response.dart';
import 'package:restaurant_app/utils/constant.dart';

import '../model/search_restaurant_response.dart';

class ApiService {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev/";

  Future<SearchRestaurantResponse> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse("$_baseUrl/search?q=$query"));

    if (response.statusCode == 200) {
      return SearchRestaurantResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception(failedWhenLoadListRestaurant);
    }
  }

  Future<DetailRestaurantResponse> detailRestaurant(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));

    if (response.statusCode == 200) {
      return DetailRestaurantResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception(failedLoadedDetailRestaurant);
    }
  }

  Future<ReviewRestaurantResponse> sendReviewRestaurant(
      String id, String review) async {
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({
      'id': id,
      'name': myName,
      'review': review,
    });

    final response = await http.post(Uri.parse("$_baseUrl/review"),
        headers: headers, body: body);

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return ReviewRestaurantResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception(failedSendingReview);
    }
  }
}
