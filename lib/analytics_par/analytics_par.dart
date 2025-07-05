import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:parked_offers_sell_anytime_275_t/my_buyers_par/logic/models/my_buyers_par_model.dart';
import 'package:parked_offers_sell_anytime_275_t/my_buyers_par/logic/repositories/my_buyers_par_repo.dart';

class AnalyticsPar extends StatefulWidget {
  const AnalyticsPar({super.key});
  @override
  State<AnalyticsPar> createState() => _AnalyticsParState();
}

class _AnalyticsParState extends State<AnalyticsPar> {
  List<MyBuyersParModel> _allAnalyticsPar = [];
  List<DateTime> _monthsAnalyticsPar = [];
  DateTime? _selectedMonthAnalyticsPar;
  bool _loadMonthAnalytiinMonthAnalyti = true;

  @override
  void initState() {
    super.initState();
    _loadMonthAnalyti();
  }

  Future<void> _loadMonthAnalyti() async {
    final sMonthAnalc = await MyBuyersParRepo.getMyBuyersPar();
    _allAnalyticsPar =
        sMonthAnalc.where((e) => e.status == 'Completed').toList();
    _allAnalyticsPar.sort((a, b) => b.selectDate.compareTo(a.selectDate));
    _monthsAnalyticsPar =
        _allAnalyticsPar
            .map((e) => DateTime(e.selectDate.year, e.selectDate.month))
            .toSet()
            .toList()
          ..sort((a, b) => a.compareTo(b));
    _selectedMonthAnalyticsPar =
        _monthsAnalyticsPar.isEmpty ? null : _monthsAnalyticsPar.last;
    setState(() => _loadMonthAnalytiinMonthAnalyti = false);
  }

  Map<int, double> _ieByDayMonthAnalyti() {
    final maMonthAnalp = <int, double>{};
    if (_selectedMonthAnalyticsPar == null) return maMonthAnalp;
    final monthAnal = _selectedMonthAnalyticsPar!;
    final itMonthAnalyems = _allAnalyticsPar.where(
      (e) =>
          e.selectDate.year == monthAnal.year &&
          e.selectDate.month == monthAnal.month,
    );
    for (final itMonthAnaly in itMonthAnalyems) {
      final dMonthAn = itMonthAnaly.selectDate.day;
      maMonthAnalp[dMonthAn] =
          (maMonthAnalp[dMonthAn] ?? 0) + itMonthAnaly.sellingPrice;
    }
    return maMonthAnalp;
  }

  double _totalInmeMonthAnalyti() =>
      _ieByDayMonthAnalyti().values.fold<double>(0, (p, e) => p + e);

  List<MyBuyersParModel> _itemsForMontheMonthAnalyti() {
    if (_selectedMonthAnalyticsPar == null) return [];
    final m = _selectedMonthAnalyticsPar!;
    return _allAnalyticsPar
        .where(
          (e) => e.selectDate.year == m.year && e.selectDate.month == m.month,
        )
        .toList();
  }

  BarChartData _chartDataMontyti() {
    final daDataMontyta = _ieByDayMonthAnalyti();
    final maxYataMonty =
        daDataMontyta.values.isEmpty ? 1.0 : daDataMontyta.values.reduce(max);
    final bavdswwps = List.generate(31, (i) {
      final vdsvdse = daDataMontyta[i + 1] ?? 0;
      return BarChartGroupData(
        x: i + 1,
        barRods: [
          BarChartRodData(
            toY: vdsvdse,
            width: 8.w,
            borderRadius: BorderRadius.circular(4.r),
            color: const Color(0xff10A3F6),
          ),
        ],
      );
    });
    return BarChartData(
      barGroups: bavdswwps,
      gridData: FlGridData(
        drawVerticalLine: true,
        verticalInterval: 1,
        drawHorizontalLine: true,
        horizontalInterval: maxYataMonty / 5,
        getDrawingVerticalLine:
            (_) => FlLine(
              color: const Color(0xff10A3F6).withOpacity(0.15),
              strokeWidth: 1,
            ),
        getDrawingHorizontalLine:
            (_) => FlLine(
              color: const Color(0xff10A3F6).withOpacity(0.15),
              strokeWidth: 1,
            ),
      ),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            interval: maxYataMonty / 5,
            showTitles: true,
            getTitlesWidget:
                (v, __) => Text(
                  '\$${v.toInt()}',
                  style: TextStyle(fontSize: 10.sp, color: Colors.white),
                ),
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            reservedSize: 18,
            showTitles: true,
            interval: 1,
            getTitlesWidget:
                (v, __) =>
                    v % 1 == 0
                        ? Text(
                          v.toInt().toString().padLeft(2, '0'),
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.white,
                          ),
                        )
                        : const SizedBox.shrink(),
          ),
        ),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(show: false),
      maxY: maxYataMonty == 0 ? 1 : maxYataMonty,
    );
  }

  void _choeMoAnalyticsPar() {
    if (_monthsAnalyticsPar.length <= 1) return;
    showCupertinoModalPopup(
      context: context,
      builder:
          (_) => Container(
            height: 300.h,
            decoration: BoxDecoration(
              color: const Color(0xff101114),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: CupertinoPicker(
                    scrollController: FixedExtentScrollController(
                      initialItem: _monthsAnalyticsPar.indexOf(
                        _selectedMonthAnalyticsPar!,
                      ),
                    ),
                    itemExtent: 40.h,
                    onSelectedItemChanged:
                        (i) => setState(
                          () =>
                              _selectedMonthAnalyticsPar =
                                  _monthsAnalyticsPar[i],
                        ),
                    children:
                        _monthsAnalyticsPar
                            .map(
                              (e) => Center(
                                child: Text(
                                  DateFormat.MMM().format(e),
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ),
                Container(height: 1, color: Colors.white.withOpacity(0.1)),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 12.h,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            height: 44.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14.r),
                              color: const Color(0xff4C545C),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            height: 44.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14.r),
                              color: const Color(0xff10A3F6),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Save',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Analytics',
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xffFFFFFF),
          ),
        ),
      ),
      body:
          _loadMonthAnalytiinMonthAnalyti
              ? const Center(child: CupertinoActivityIndicator())
              : _allAnalyticsPar.isEmpty
              ? Center(
                child: Text(
                  'You have nothing to analyze yet\nAdd a buyer to see statistics',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              )
              : SafeArea(
                child: RefreshIndicator(
                  color: Colors.white,
                  onRefresh: _loadMonthAnalyti,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        Container(
                          padding: EdgeInsets.all(16.sp),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.1),
                            ),
                            color: Colors.white.withOpacity(0.05),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Income for the month: ${DateFormat.MMM().format(_selectedMonthAnalyticsPar!)}',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xffffffff),
                                ),
                              ),
                              SizedBox(
                                height: 220.h,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    right: 6.w,
                                    top: 12.h,
                                  ),
                                  child: BarChart(_chartDataMontyti()),
                                ),
                              ),
                              SizedBox(height: 12.h),
                              Row(
                                children: [
                                  Text(
                                    'Total income: ',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xffffffff),
                                    ),
                                  ),
                                  Text(
                                    '\$${_totalInmeMonthAnalyti().toStringAsFixed(0)}',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xff10A3F6),
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: _choeMoAnalyticsPar,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20.w,
                                        vertical: 10.h,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          20.r,
                                        ),
                                        color: const Color(
                                          0xff4C545C,
                                        ).withOpacity(
                                          _monthsAnalyticsPar.length <= 1
                                              ? 0.4
                                              : 1,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            '${_selectedMonthAnalyticsPar!.year}',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(width: 8.w),
                                          Icon(
                                            LucideIcons.calendar,
                                            color: Colors.white,
                                            size: 20.sp,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),
                        ..._itemsForMontheMonthAnalyti().map((e) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat(
                                  'MMMM dd, yyyy',
                                ).format(e.selectDate),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 14.h,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.1),
                                  ),
                                  color: Colors.white.withOpacity(0.05),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e.selectItems
                                          .map((i) => i.name)
                                          .join(', '),
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Container(
                                      height: 1,
                                      width: double.infinity,
                                      color: const Color(0xff10A3F6),
                                    ),
                                    SizedBox(height: 8.h),
                                    Center(
                                      child: Text(
                                        '\$${e.sellingPrice.toStringAsFixed(0)}',
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xff10A3F6),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 24.h),
                            ],
                          );
                        }).toList(),
                        SizedBox(height: 100.h),
                      ],
                    ),
                  ),
                ),
              ),
    );
  }
}
