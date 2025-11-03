import 'package:hive/hive.dart';

part 'food_item.g.dart';

@HiveType(typeId: 1)
class FoodItem extends HiveObject {
  @HiveField(0)
  final String name; 

  @HiveField(1)
  final String details; 

  @HiveField(2)
  final String imagePath; 

  @HiveField(3)
  bool isEaten; 

  @HiveField(4)
  final int protein; 

  @HiveField(5)
  final int fats; 

  @HiveField(6)
  final int carbs; 

  @HiveField(7)
  final int calories; 

  @HiveField(8)
  final double rating; 

  @HiveField(9)
  final int ratingCount; 

  @HiveField(10)
  final Map<String, String> ingredients;

  @HiveField(11)
  final List<String> tags;

  FoodItem({
    required this.name,
    required this.details,
    required this.imagePath,
    this.isEaten = false,
    required this.protein,
    required this.fats,
    required this.carbs,
    required this.calories,
    required this.rating,
    required this.ratingCount,
    required this.ingredients,
    required this.tags,
  });
}