import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parked_offers_sell_anytime_275_t/bttn_parkedf.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParketOnbrtdsd extends StatefulWidget {
  const ParketOnbrtdsd({super.key});

  @override
  State<ParketOnbrtdsd> createState() => _ParketOnbrtdsdState();
}

class IujdsParketOnbrtdsd {
  final String image;
  final String title;
  IujdsParketOnbrtdsd({required this.image, required this.title});
}

class _ParketOnbrtdsdState extends State<ParketOnbrtdsd> {
  final PageController psParketOnbrtdsd = PageController();
  int xdParketOnbrtdsd = 0;

  @override
  Widget build(BuildContext context) {
    final inactive = const Color(0xFF0E2A4D);
    final active = const Color(0xFF29A1FF);
    return Scaffold(
      backgroundColor: const Color(0xFF001F3F),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: psParketOnbrtdsd,
              onPageChanged: (i) => setState(() => xdParketOnbrtdsd = i),
              itemCount: majbnSalllOnb.length,
              itemBuilder:
                  (context, i) => ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r),
                    ),
                    child: Image.asset(
                      majbnSalllOnb[i].image,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 25.h),
                Text(
                  majbnSalllOnb[xdParketOnbrtdsd].title,
                  style: TextStyle(
                    fontSize: 33.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25.h),
                Row(
                  children: [
                    SizedBox(
                      width: 140.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          majbnSalllOnb.length,
                          (i) => AnimatedContainer(
                            duration: const Duration(milliseconds: 265),
                            width: 36.w,
                            height: 8.h,
                            decoration: BoxDecoration(
                              color: i == xdParketOnbrtdsd ? active : inactive,
                              borderRadius: BorderRadius.circular(40.r),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          if (xdParketOnbrtdsd < majbnSalllOnb.length - 1) {
                            psParketOnbrtdsd.nextPage(
                              duration: const Duration(milliseconds: 280),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const BttnParkedf(),
                              ),
                              (_) => false,
                            );
                            final p = await SharedPreferences.getInstance();
                            await p.setBool('ParkeQwsssdOffersdd', false);
                          }
                        },
                        child: IntrinsicWidth(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              color: active,
                            ),
                            child: Center(
                              child: Text(
                                'Next',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final List<IujdsParketOnbrtdsd> majbnSalllOnb = [
    IujdsParketOnbrtdsd(
      image: 'assets/images/onbrerrr1.png',
      title: 'Create a card with\nyour item and set your\nown price',
    ),
    IujdsParketOnbrtdsd(
      image: 'assets/images/onbrerrr2.png',
      title: 'Exchange contacts\nwith buyers and make\nsales',
    ),
    IujdsParketOnbrtdsd(
      image: 'assets/images/onbrerrr3.png',
      title: 'Track your earnings\nfrom your garage sales\nof your items',
    ),
  ];
}
