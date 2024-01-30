import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/model/search_restaurant_response.dart';

void main() {
  test('should parsing json to restaurant', () {
    String jsonString = '''
    {
    "id": "rqdv5juczeskfw1e867",
    "name": "Melting Pot",
    "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
    "pictureId": "14",
    "city": "Medan",
    "rating": 4.2
    }
    ''';

    Map<String, dynamic> json = jsonDecode(jsonString);
    Restaurant restaurant = Restaurant.fromJson(json);

    expect(restaurant.id, "rqdv5juczeskfw1e867");
    expect(restaurant.name, "Melting Pot");
    expect(restaurant.description, "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...");
    expect(restaurant.pictureId, "14");
    expect(restaurant.city, "Medan");
    expect(restaurant.rating, 4.2);
  });
}