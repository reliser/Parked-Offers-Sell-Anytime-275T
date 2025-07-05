import 'package:hive_flutter/hive_flutter.dart';
import 'package:parked_offers_sell_anytime_275_t/main_par/logic/models/main_par_model.dart';

class MainParRepo {
  static const _boxMainPar = 'myMainParModel';

  static Future<List<MainParModel>> getMainPar() async {
    final mainPards = await Hive.openBox<MainParModel>(_boxMainPar);
    return mainPards.values.toList();
  }

  static Future<void> setMainPar(MainParModel model) async {
    final mainPards = await Hive.openBox<MainParModel>(_boxMainPar);
    await mainPards.add(model);
  }

  static Future<void> deleteMainPar(int id) async {
    final mainPards = await Hive.openBox<MainParModel>(_boxMainPar);
    final mmMainPar = mainPards.toMap();
    final eedMainPar = mmMainPar.entries.singleWhere(
      (e) => e.value.id == id,
      orElse: () => throw Exception('$id'),
    );
    await mainPards.delete(eedMainPar.key);
    await mainPards.compact();
  }

  static Future<void> updateMainPar(MainParModel updatedModel) async {
    final mainPards = await Hive.openBox<MainParModel>(_boxMainPar);
    final mmMainPar = mainPards.toMap();
    final eedMainPar = mmMainPar.entries.firstWhere(
      (eldsdMainPar) => eldsdMainPar.value.id == updatedModel.id,
      orElse: () => throw Exception('${updatedModel.id}'),
    );
    await mainPards.put(eedMainPar.key, updatedModel);
  }

  static Future<void> updatePriceMin(int id) async {
    final mainPards = await Hive.openBox<MainParModel>(_boxMainPar);
    List<MainParModel> lisvsdIkon =
        mainPards.values.where((e) => e.id == id).toList();
    lisvsdIkon.first.quantity = lisvsdIkon.first.quantity - 1;
    if (lisvsdIkon.first.quantity == 0) {
      lisvsdIkon.first.history = true;
    }
    await lisvsdIkon.first.save();
  }

  static Future<void> updateQuantity(int id, int quantity) async {
    final mainPards = await Hive.openBox<MainParModel>(_boxMainPar);
    List<MainParModel> lisvsdIkon =
        mainPards.values.where((e) => e.id == id).toList();
    lisvsdIkon.first.history = false;
    lisvsdIkon.first.quantity = quantity;
    await lisvsdIkon.first.save();
  }
}
