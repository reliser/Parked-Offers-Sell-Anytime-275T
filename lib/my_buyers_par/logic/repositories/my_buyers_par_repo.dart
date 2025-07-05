import 'package:hive_flutter/hive_flutter.dart';
import 'package:parked_offers_sell_anytime_275_t/my_buyers_par/logic/models/my_buyers_par_model.dart';

class MyBuyersParRepo {
  static const _boxMyBuyersPar = 'myMyBuyersParModel';

  static Future<List<MyBuyersParModel>> getMyBuyersPar() async {
    final myBuyersPards = await Hive.openBox<MyBuyersParModel>(_boxMyBuyersPar);
    return myBuyersPards.values.toList();
  }

  static Future<void> setMyBuyersPar(MyBuyersParModel model) async {
    final myBuyersPards = await Hive.openBox<MyBuyersParModel>(_boxMyBuyersPar);
    await myBuyersPards.add(model);
  }

  static Future<void> deleteMyBuyersPar(int id) async {
    final myBuyersPards = await Hive.openBox<MyBuyersParModel>(_boxMyBuyersPar);
    final mmMyBuyersPar = myBuyersPards.toMap();
    final eedMyBuyersPar = mmMyBuyersPar.entries.singleWhere(
      (e) => e.value.id == id,
      orElse: () => throw Exception('$id'),
    );
    await myBuyersPards.delete(eedMyBuyersPar.key);
    await myBuyersPards.compact();
  }

  static Future<void> updateMyBuyersPar(MyBuyersParModel updatedModel) async {
    final myBuyersPards = await Hive.openBox<MyBuyersParModel>(_boxMyBuyersPar);
    final mmMyBuyersPar = myBuyersPards.toMap();
    final eedMyBuyersPar = mmMyBuyersPar.entries.firstWhere(
      (eldsdMyBuyersPar) => eldsdMyBuyersPar.value.id == updatedModel.id,
      orElse: () => throw Exception('${updatedModel.id}'),
    );
    await myBuyersPards.put(eedMyBuyersPar.key, updatedModel);
  }
}
