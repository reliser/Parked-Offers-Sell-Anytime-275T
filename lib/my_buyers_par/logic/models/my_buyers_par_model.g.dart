// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_buyers_par_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyBuyersParModelAdapter extends TypeAdapter<MyBuyersParModel> {
  @override
  final int typeId = 1;

  @override
  MyBuyersParModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyBuyersParModel(
      id: fields[0] as int,
      selectItems: (fields[1] as List).cast<MainParModel>(),
      selectDate: fields[2] as DateTime,
      name: fields[3] as String,
      number: fields[4] as int,
      buyers: (fields[5] as List).cast<String>(),
      price: fields[6] as double,
      status: fields[7] as String,
      sellingPrice: fields[8] as double,
    );
  }

  @override
  void write(BinaryWriter writer, MyBuyersParModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.selectItems)
      ..writeByte(2)
      ..write(obj.selectDate)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.number)
      ..writeByte(5)
      ..write(obj.buyers)
      ..writeByte(6)
      ..write(obj.price)
      ..writeByte(7)
      ..write(obj.status)
      ..writeByte(8)
      ..write(obj.sellingPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyBuyersParModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
