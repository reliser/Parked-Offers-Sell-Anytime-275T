// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive_flutter/hive_flutter.dart';
import 'package:parked_offers_sell_anytime_275_t/main_par/logic/models/main_par_model.dart';

part 'my_buyers_par_model.g.dart';

@HiveType(typeId: 1)
class MyBuyersParModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  List<MainParModel> selectItems;
  @HiveField(2)
  DateTime selectDate;
  @HiveField(3)
  String name;
  @HiveField(4)
  int number;
  @HiveField(5)
  List<String> buyers;
  @HiveField(6)
  double price;
  @HiveField(7)
  String status;
  @HiveField(8)
  double sellingPrice;
  MyBuyersParModel({
    required this.id,
    required this.selectItems,
    required this.selectDate,
    required this.name,
    required this.number,
    required this.buyers,
    required this.price,
    required this.status,
    required this.sellingPrice,
  });
}
