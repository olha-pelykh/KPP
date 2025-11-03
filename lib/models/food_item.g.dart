part of 'food_item.dart';

class FoodItemAdapter extends TypeAdapter<FoodItem> {
  @override
  final int typeId = 1;

  @override
  FoodItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FoodItem(
      name: fields[0] as String,
      details: fields[1] as String,
      imagePath: fields[2] as String,
      isEaten: fields[3] as bool,
      protein: fields[4] as int,
      fats: fields[5] as int,
      carbs: fields[6] as int,
      calories: fields[7] as int,
      rating: fields[8] as double,
      ratingCount: fields[9] as int,
      ingredients: (fields[10] as Map).cast<String, String>(),
      tags: (fields[11] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, FoodItem obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.details)
      ..writeByte(2)
      ..write(obj.imagePath)
      ..writeByte(3)
      ..write(obj.isEaten)
      ..writeByte(4)
      ..write(obj.protein)
      ..writeByte(5)
      ..write(obj.fats)
      ..writeByte(6)
      ..write(obj.carbs)
      ..writeByte(7)
      ..write(obj.calories)
      ..writeByte(8)
      ..write(obj.rating)
      ..writeByte(9)
      ..write(obj.ratingCount)
      ..writeByte(10)
      ..write(obj.ingredients)
      ..writeByte(11)
      ..write(obj.tags);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
