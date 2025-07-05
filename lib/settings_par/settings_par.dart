import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPar extends StatefulWidget {
  const SettingsPar({super.key});

  @override
  State<SettingsPar> createState() => _SettingsParState();
}

class _SettingsParState extends State<SettingsPar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xffFFFFFF),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),

              GestureDetector(
                onTap: () {
                  webParketSewdss(context, 'https://docs.google.com/document/d/1Bl-444BhxJFuHnFvsIWReUvzZsVK5zpQW-FXfZ8aQSs/edit?usp=sharing');
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 28.h),
                  decoration: BoxDecoration(
                    color: Color(0xffFFFFFF).withOpacity(0.1),
                    border: Border.all(
                      color: Color(0xffFFFFFF).withOpacity(0.2),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Privacy Policy',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xffFFFFFF),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              GestureDetector(
                onTap: () {
                  webParketSewdss(context, 'https://sites.google.com/view/henrykbukowski/support-form');
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 28.h),
                  decoration: BoxDecoration(
                    color: Color(0xffFFFFFF).withOpacity(0.1),
                    border: Border.all(
                      color: Color(0xffFFFFFF).withOpacity(0.2),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Support',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xffFFFFFF),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              GestureDetector(
                onTap: () {
                  webParketSewdss(context, 'https://docs.google.com/document/d/1Uawc7FQZYgHuWDG1Ey74Sar5L2Am62u4lnwGZkokzuY/edit?usp=sharing');
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 28.h),
                  decoration: BoxDecoration(
                    color: Color(0xffFFFFFF).withOpacity(0.1),
                    border: Border.all(
                      color: Color(0xffFFFFFF).withOpacity(0.2),
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Terms of Use',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xffFFFFFF),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}

void webParketSewdss(BuildContext context, String llParketSewdss) async {
  final Uri urlParketSewdss = Uri.parse(llParketSewdss);
  if (!await launchUrl(urlParketSewdss)) {
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(llParketSewdss)));
  }
}
