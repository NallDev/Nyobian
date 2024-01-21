import 'package:restaurant_app/data/model/detail_restaurant_response.dart';

class ReviewRestaurantResponse {
  final bool error;
  final String message;
  final List<CustomerReview> customerReviews;

  ReviewRestaurantResponse({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  factory ReviewRestaurantResponse.fromJson(Map<String, dynamic> json) => ReviewRestaurantResponse(
    error: json["error"],
    message: json["message"],
    customerReviews: List<CustomerReview>.from(json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
  );
}