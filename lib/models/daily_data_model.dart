import 'package:hive/hive.dart';
import 'food_item.dart';

part 'daily_data_model.g.dart';

@HiveType(typeId: 0) 
class DailyDataModel extends HiveObject {
  @HiveField(0)
  int waterCups;

  @HiveField(1)
  Map<String, List<FoodItem>> meals;

  @HiveField(2)
  int totalProtein;

  @HiveField(3)
  int totalFats;

  @HiveField(4)
  int totalCarbs;

  DailyDataModel({
    required this.waterCups,
    required this.meals,
    required this.totalProtein,
    required this.totalFats,
    required this.totalCarbs,
  });

  factory DailyDataModel.empty() {
    return DailyDataModel(
      waterCups: 0,
      meals: {
        'Breakfast': [],
        'Lunch time': [],
        'Dinner': [],
      },
      totalProtein: 0,
      totalFats: 0,
      totalCarbs: 0,
    );
  }
}