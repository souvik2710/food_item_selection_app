// To parse this JSON data, do
//
//     final foodItems = foodItemsFromJson(jsonString);

import 'dart:convert';

List<FoodItems> foodItemsFromJson(String str) => List<FoodItems>.from(json.decode(str).map((x) => FoodItems.fromJson(x)));

String foodItemsToJson(List<FoodItems> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoodItems {
  final int id;
  final String recipeName;
  final Nutrition nutrition;
  final double price;
  final String description;
  final String imageUrl;
  final bool hitsOfTheWeek;

  FoodItems({
    required this.id,
    required this.recipeName,
    required this.nutrition,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.hitsOfTheWeek,
  });

  factory FoodItems.fromJson(Map<String, dynamic> json) => FoodItems(
    id:json["id"],
    recipeName: json["recipe_name"],
    nutrition: Nutrition.fromJson(json["nutrition"]),
    price: json["price"]?.toDouble(),
    description: json["description"],
    imageUrl: json["image_url"],
    hitsOfTheWeek: json["hits_of_the_week"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "recipe_name": recipeName,
    "nutrition": nutrition.toJson(),
    "price": price,
    "description": description,
    "image_url": imageUrl,
    "hits_of_the_week": hitsOfTheWeek,
  };
}

class Nutrition {
  final int kcal;
  final int grams;
  final int protein;
  final int fats;
  final int carbs;

  Nutrition({
    required this.kcal,
    required this.grams,
    required this.protein,
    required this.fats,
    required this.carbs,
  });

  factory Nutrition.fromJson(Map<String, dynamic> json) => Nutrition(
    kcal: json["kcal"],
    grams: json["grams"],
    protein: json["protein"],
    fats: json["fats"],
    carbs: json["carbs"],
  );

  Map<String, dynamic> toJson() => {
    "kcal": kcal,
    "grams": grams,
    "protein": protein,
    "fats": fats,
    "carbs": carbs,
  };
}
