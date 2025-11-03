part of 'daily_data_model.dart';

class DailyDataModelAdapter extends TypeAdapter<DailyDataModel> {
  @override
  final int typeId = 0;

  @override
  DailyDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyDataModel(
      waterCups: fields[0] as int,
      meals: (fields[1] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as List).cast<FoodItem>())),
      totalProtein: fields[2] as int,
      totalFats: fields[3] as int,
      totalCarbs: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DailyDataModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.waterCups)
      ..writeByte(1)
      ..write(obj.meals)
      ..writeByte(2)
      ..write(obj.totalProtein)
      ..writeByte(3)
      ..write(obj.totalFats)
      ..writeByte(4)
      ..write(obj.totalCarbs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
