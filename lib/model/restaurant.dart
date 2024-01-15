import 'dart:convert';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final Menus menus;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  factory Restaurant.fromJson(Map<String, dynamic> restaurant) {
    double parsedRating = changeToDouble(restaurant['rating']);

    return Restaurant(
      id: restaurant['id'],
      name: restaurant['name'],
      description: restaurant['description'],
      pictureId: restaurant['pictureId'],
      city: restaurant['city'],
      rating: parsedRating,
      menus: Menus.fromJson(restaurant['menus']),
    );
  }

  static double changeToDouble(dynamic value) {
    return value.toDouble();
  }
}

class Menus {
  final List<Food> foods;
  final List<Drink> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> menus) => Menus(
    foods: List<Food>.from(menus['foods'].map((x) => Food.fromJson(x))),
    drinks: List<Drink>.from(menus['drinks'].map((x) => Drink.fromJson(x))),
  );
}

class Food {
  final String name;

  Food({
    required this.name,
  });

  factory Food.fromJson(Map<String, dynamic> food) => Food(
    name: food['name'],
  );
}

class Drink {
  final String name;

  Drink({
    required this.name,
  });

  factory Drink.fromJson(Map<String, dynamic> drink) => Drink(
      name: drink['name'],
  );
}

List<Restaurant> parseRestaurants(String? json) {
  if (json == null) {
    return [];
  }

  final Map<String, dynamic> decodedJson = jsonDecode(json);
  final List<dynamic> restaurantsJson = decodedJson['restaurants'];
  return restaurantsJson.map((json) => Restaurant.fromJson(json)).toList();
}