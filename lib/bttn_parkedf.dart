import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parked_offers_sell_anytime_275_t/analytics_par/analytics_par.dart';
import 'package:parked_offers_sell_anytime_275_t/main_par/main_par.dart';
import 'package:parked_offers_sell_anytime_275_t/my_buyers_par/my_buyers_par.dart';
import 'package:parked_offers_sell_anytime_275_t/settings_par/settings_par.dart';

class BttnParkedf extends StatefulWidget {
  const BttnParkedf({super.key, this.indBttnParkedf = 0});

  final int indBttnParkedf;

  @override
  State<BttnParkedf> createState() => _BttnParkedfState();
}

class _BttnParkedfState extends State<BttnParkedf> {
  late int indsaBttnParkedf;
  final List<Widget> _pagaBttnParkedf = const [
    MainPar(),
    MyBuyersPar(),
    AnalyticsPar(),
    SettingsPar(),
  ];

  void _scvvBttnParkedf(int index) {
    setState(() {
      indsaBttnParkedf = index;
    });
  }

  @override
  void initState() {
    super.initState();
    indsaBttnParkedf = widget.indBttnParkedf;
  }

  Widget sswrBttnParkedf(int index, String icon) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _scvvBttnParkedf(index),
        child: Container(
          color: Colors.transparent,
          height: 72.h,
          width: 68.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              indsaBttnParkedf == index
                  ? Container(
                    height: 4,
                    width: 4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xff10A3F6),
                    ),
                  )
                  : const SizedBox(),
              SizedBox(height: 4.h),
              Container(
                padding: EdgeInsets.all(3.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color:
                      indsaBttnParkedf == index
                          ? Color(0xffCAE4FF).withOpacity(0.11)
                          : Colors.transparent,
                ),
                child: Image.asset(
                  icon,
                  width: indsaBttnParkedf == index ? 32 : 24,
                  height: indsaBttnParkedf == index ? 32 : 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pagaBttnParkedf[indsaBttnParkedf],
      bottomNavigationBar: SafeArea(
        child: IntrinsicHeight(
          child: Container(
            margin: EdgeInsets.only(left: 30.w,right: 30.w,bottom: 25.h),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: const Color(0xFF3D424A),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                sswrBttnParkedf(0, 'assets/images/btpar1.png'),
                sswrBttnParkedf(1, 'assets/images/btpar2.png'),
                sswrBttnParkedf(2, 'assets/images/btpar3.png'),
                sswrBttnParkedf(3, 'assets/images/btpar4.png'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
