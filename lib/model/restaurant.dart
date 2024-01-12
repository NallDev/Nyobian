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

}

class Menus {
  final List<Drink> foods;
  final List<Drink> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });

}

class Drink {
  final String name;

  Drink({
    required this.name,
  });

}