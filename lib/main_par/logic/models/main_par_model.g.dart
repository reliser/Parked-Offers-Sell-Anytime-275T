// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_par_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MainParModelAdapter extends TypeAdapter<MainParModel> {
  @override
  final int typeId = 0;

  @override
  MainParModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MainParModel(
      id: fields[0] as int,
      image: fields[1] as String,
      selectDate: fields[2] as DateTime,
      name: fields[3] as String,
      quantity: fields[4] as int,
      description: fields[5] as String,
      price: fields[6] as double,
      condition: fields[7] as String,
      history: fields[8] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MainParModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.selectDate)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.quantity)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.price)
      ..writeByte(7)
      ..write(obj.condition)
      ..writeByte(8)
      ..write(obj.history);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MainParModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
