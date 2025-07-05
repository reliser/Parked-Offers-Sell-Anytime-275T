// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive_flutter/hive_flutter.dart';

part 'main_par_model.g.dart';

@HiveType(typeId: 0)
class MainParModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String image;
  @HiveField(2)
  DateTime selectDate;
  @HiveField(3)
  String name;
  @HiveField(4)
  int quantity;
  @HiveField(5)
  String description;
  @HiveField(6)
  double price;
  @HiveField(7)
  String condition;
  @HiveField(8)
  bool history;
  MainParModel({
    required this.id,
    required this.image,
    required this.selectDate,
    required this.name,
    required this.quantity,
    required this.description,
    required this.price,
    required this.condition,
    required this.history,
  });
}
