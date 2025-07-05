import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:parked_offers_sell_anytime_275_t/my_buyers_par/add_my_buyers_par.dart';
import 'package:parked_offers_sell_anytime_275_t/my_buyers_par/logic/models/my_buyers_par_model.dart';
import 'package:parked_offers_sell_anytime_275_t/my_buyers_par/logic/repositories/my_buyers_par_repo.dart';

class MyBuyersPar extends StatefulWidget {
  const MyBuyersPar({super.key});
  @override
  State<MyBuyersPar> createState() => _MyBuyersParState();
}

class _MyBuyersParState extends State<MyBuyersPar> {
  List<MyBuyersParModel> _iMyBuyersPars = [];
  bool _loMyBuyersParg = false;

  @override
  void initState() {
    super.initState();
    _loadHJjdMyBuyersPar();
  }

  Future<void> _loadHJjdMyBuyersPar() async {
    setState(() => _loMyBuyersParg = true);
    final src = await MyBuyersParRepo.getMyBuyersPar();
    setState(() {
      _iMyBuyersPars = src.reversed.toList();
      _loMyBuyersParg = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My buyers',
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
              _loMyBuyersParg
                  ? Padding(
                    padding: EdgeInsets.only(top: 250.h),
                    child: const Center(child: CupertinoActivityIndicator()),
                  )
                  : _iMyBuyersPars.isNotEmpty
                  ? RefreshIndicator(
                    color: Colors.white,
                    onRefresh: _loadHJjdMyBuyersPar,
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _iMyBuyersPars.length,
                      separatorBuilder: (_, __) => SizedBox(height: 16.h),
                      itemBuilder: (_, index) {
                        final m = _iMyBuyersPars[index];
                        return Container(
                          margin: EdgeInsets.only(
                            bottom:
                                index == _iMyBuyersPars.length - 1 ? 100.h : 0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: const Color(0xffFFFFFF).withOpacity(0.2),
                            ),
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  width: 48.sp,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color:
                                        m.status == 'Actively'
                                            ? const Color(0xffFFA600)
                                            : const Color(0xff007F9C),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.r),
                                      bottomLeft: Radius.circular(20.r),
                                    ),
                                  ),
                                  child: Icon(
                                    m.status == 'Actively'
                                        ? Icons.timer_outlined
                                        : Icons.check,
                                    size: 24.sp,
                                    color: Colors.white,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(16.sp),
                                    decoration: BoxDecoration(
                                      color: const Color(
                                        0xffFFFFFF,
                                      ).withOpacity(0.1),
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(20.r),
                                        topRight: Radius.circular(20.r),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                m.selectItems
                                                    .map((e) => e.name)
                                                    .join(', '),
                                                style: TextStyle(
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: const Color(
                                                    0xffFFFFFF,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if (m.status == 'Completed')
                                              Text(
                                                DateFormat(
                                                  'MMMM dd, yyyy',
                                                ).format(m.selectDate),
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: const Color(
                                                    0xff898989,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                        SizedBox(height: 10.h),
                                        Text(
                                          m.name,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xff10A3F6),
                                          ),
                                        ),
                                        SizedBox(height: 10.h),
                                        Text(
                                          m.number.toString(),
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(height: 10.h),
                                        if (m.buyers.isNotEmpty)
                                          ...m.buyers.map(
                                            (e) => Padding(
                                              padding: EdgeInsets.only(
                                                bottom:
                                                    e == m.buyers.last
                                                        ? 0
                                                        : 10.h,
                                              ),
                                              child: Text(
                                                '- $e',
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        SizedBox(height: 10.h),
                                        const Divider(
                                          color: Color(0xff10A3F6),
                                          height: 0,
                                        ),
                                        SizedBox(height: 10.h),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Price: ',
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    '\$${m.price.toStringAsFixed(2).replaceAll(RegExp(r"(\.0*|0*)$"), "")}',
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: const Color(
                                                        0xff10A3F6,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            if (m.status == 'Completed')
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Selling price: ',
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      '\$${m.sellingPrice.toStringAsFixed(2).replaceAll(RegExp(r"(\.0*|0*)$"), "")}',
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: const Color(
                                                          0xff10A3F6,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                  : Padding(
                    padding: EdgeInsets.only(top: 250.h),
                    child: Center(
                      child: Text(
                        'Add your first buyer',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xffFFFFFF),
                        ),
                      ),
                    ),
                  ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddMyBuyersPar()),
          );
          _loadHJjdMyBuyersPar();
        },
        child: IntrinsicHeight(
          child: Container(
            padding: EdgeInsets.all(12.sp),
            width: 190.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.r),
              color: const Color(0xff10A3F6),
            ),
            child: Center(
              child: Text(
                'Add buyer',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xffFFFFFF),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
