import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/model/detail_restaurant_response.dart';
import 'package:restaurant_app/data/network/api_service.dart';

import '../utils/constant.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  DetailState _detailState = DetailState.loading;
  ReviewState _reviewState = ReviewState.success;
  late Restaurant _detailRestaurant;
  List<CustomerReview> _listReview = [];
  String _message = "";
  bool _isExpand = false;
  String _myReview = "";

  DetailRestaurantProvider({required this.apiService});

  DetailState get state => _detailState;
  List<CustomerReview> get listReview => _listReview.reversed.toList();
  ReviewState get reviewState => _reviewState;
  Restaurant get detailResult => _detailRestaurant;
  String get message => _message;
  bool get isExpand => _isExpand;
  String get myReview => _myReview;

  Future<dynamic> fetchDetailRestaurant(String id) async {
    _detailState = DetailState.loading;
    notifyListeners();
    try {
      final detail = await apiService.detailRestaurant(id);

      _detailState = DetailState.success;
      notifyListeners();
      _listReview = detail.restaurant.customerReviews;
      return _detailRestaurant = detail.restaurant;
    } on SocketException {
      _detailState = DetailState.error;
      notifyListeners();
      return _message = noInternetMessage;
    } catch (exception) {
      _detailState = DetailState.error;
      notifyListeners();
      return _message = failedLoadedData;
    }
  }

  Future<dynamic> sendReviewRestaurant(String id) async {
    _reviewState = ReviewState.loading;
    notifyListeners();
    try {
      final review = await apiService.sendReviewRestaurant(id, _myReview);
      _reviewState = ReviewState.success;
      notifyListeners();
      return _listReview = review.customerReviews;
    } on SocketException {
      _reviewState = ReviewState.error;
      notifyListeners();
      return _message = noInternetMessage;
    } catch (exception) {
      _reviewState = ReviewState.error;
      notifyListeners();
      return _message = failedSendingReview;
    }
  }

  void setExpand(bool value) {
    _isExpand = value;
    notifyListeners();
  }

  void setReviewText(String value) {
    _myReview = value;
    notifyListeners();
  }
}

enum DetailState {loading, success, error}
enum ReviewState {loading, success, error}