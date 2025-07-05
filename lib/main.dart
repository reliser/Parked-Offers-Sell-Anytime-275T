import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:parked_offers_sell_anytime_275_t/bttn_parkedf.dart';
import 'package:parked_offers_sell_anytime_275_t/main_par/logic/models/main_par_model.dart';
import 'package:parked_offers_sell_anytime_275_t/my_buyers_par/logic/models/my_buyers_par_model.dart';
import 'package:parked_offers_sell_anytime_275_t/parket_onbrtdsd.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MainParModelAdapter());
  Hive.registerAdapter(MyBuyersParModelAdapter());

  final prevswwddfs = await SharedPreferences.getInstance();
  final fivswwwrt = prevswwddfs.getBool('ParkeQwsssdOffersdd') ?? true;

  final rovDsasot = fivswwwrt ? const ParketOnbrtdsd() : const BttnParkedf();

  runApp(AppParkedOffersdd(child: rovDsasot));

  SharedPreferences ppParketOnbrtdsd = await SharedPreferences.getInstance();
  bool sspParketOnbrtdsd =
      ppParketOnbrtdsd.getBool('ParvswwketOnbrtdsd') ?? true;

  if (sspParketOnbrtdsd) {
    await Future.delayed(const Duration(seconds: 8));
    try {
      final InAppReview inspParketOnbrtdsd = InAppReview.instance;

      if (await inspParketOnbrtdsd.isAvailable()) {
        inspParketOnbrtdsd.requestReview();
      }
    } catch (e) {
      throw Exception(e);
    }
    await ppParketOnbrtdsd.setBool('ParvswwketOnbrtdsd', false);
  }
}

class AppParkedOffersdd extends StatelessWidget {
  const AppParkedOffersdd({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder:
          (_, __) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Parked Offers: Sell Anytime',
            theme: ThemeData(
              fontFamily: 'Lato',
              scaffoldBackgroundColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            ),
            builder:
                (context, page) => Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xff4C545C), Color(0xff17181C)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: page,
                ),
            home: child,
          ),
    );
  }
}
