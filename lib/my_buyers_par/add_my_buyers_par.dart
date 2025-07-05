import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:parked_offers_sell_anytime_275_t/main_par/logic/models/main_par_model.dart';
import 'package:parked_offers_sell_anytime_275_t/main_par/logic/repositories/main_par_repo.dart';
import 'package:parked_offers_sell_anytime_275_t/my_buyers_par/logic/models/my_buyers_par_model.dart';
import 'package:parked_offers_sell_anytime_275_t/my_buyers_par/logic/repositories/my_buyers_par_repo.dart';
import 'package:parked_offers_sell_anytime_275_t/my_buyers_par/main_par_vyb.dart';
import 'package:parked_offers_sell_anytime_275_t/main_par/add_main_par.dart';

class AddMyBuyersPar extends StatefulWidget {
  const AddMyBuyersPar({super.key, this.model});
  final MyBuyersParModel? model;
  @override
  State<AddMyBuyersPar> createState() => _AddMyBuyersParState();
}

class _AddMyBuyersParState extends State<AddMyBuyersPar> {
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _sellingPrice = TextEditingController();
  List<TextEditingController> _buyersCtr = [TextEditingController()];
  String condition = '';
  bool _isFormValid = false;
  final List<MainParModel> _selectedItems = [];
  DateTime? _salveDadte;
  bool get _isEdit => widget.model != null;

  @override
  void initState() {
    super.initState();
    if (_isEdit) {
      final m = widget.model!;
      _nameCtrl.text = m.name;
      _phoneCtrl.text = m.number.toString();
      _priceCtrl.text = m.price.toString();
      condition = m.status;
      _salveDadte = m.selectDate;
      _buyersCtr =
          m.buyers.isEmpty
              ? [TextEditingController()]
              : m.buyers.map((e) => TextEditingController(text: e)).toList();
      _selectedItems.addAll(m.selectItems);
    }
    _nameCtrl.addListener(_chevsdsdck);
    _phoneCtrl.addListener(_chevsdsdck);
    _priceCtrl.addListener(_chevsdsdck);
    _sellingPrice.addListener(_chevsdsdck);
    _chevsdsdck();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _priceCtrl.dispose();
    _sellingPrice.dispose();
    for (final c in _buyersCtr) {
      c.dispose();
    }
    super.dispose();
  }

  void _chevsdsdck() {
    final ovsddk =
        _nameCtrl.text.trim().isNotEmpty &&
        _phoneCtrl.text.trim().isNotEmpty &&
        _priceCtrl.text.trim().isNotEmpty &&
        condition.isNotEmpty &&
        _selectedItems.isNotEmpty &&
        (condition != 'Completed' ||
            (_sellingPrice.text.trim().isNotEmpty && _salveDadte != null));
    if (ovsddk != _isFormValid) {
      setState(() => _isFormValid = ovsddk);
    }
  }

  Future<void> _pickvDadte() async {
    final novsdw = DateTime.now();
    DateTime tvsmpd = _salveDadte ?? novsdw;
    final picsddvked = await showDialog<DateTime>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.6),
      builder:
          (ctx) => Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 340.w,
                decoration: BoxDecoration(
                  color: const Color(0xff101114).withOpacity(0.95),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: StatefulBuilder(
                  builder:
                      (ctx, setState) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Theme(
                            data: ThemeData(
                              brightness: Brightness.dark,
                              colorScheme: const ColorScheme.dark(
                                primary: Color(0xff10A3F6),
                                onPrimary: Colors.white,
                                onSurface: Colors.white,
                              ),
                              datePickerTheme: DatePickerThemeData(
                                headerForegroundColor: Colors.white,
                                weekdayStyle: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                dayForegroundColor:
                                    MaterialStateColor.resolveWith(
                                      (states) =>
                                          states.contains(
                                                MaterialState.selected,
                                              )
                                              ? Colors.white
                                              : Colors.white,
                                    ),
                                dayBackgroundColor:
                                    MaterialStateColor.resolveWith(
                                      (states) =>
                                          states.contains(
                                                MaterialState.selected,
                                              )
                                              ? const Color(0xff10A3F6)
                                              : Colors.transparent,
                                    ),
                              ),
                            ),
                            child: CalendarDatePicker(
                              initialDate: tvsmpd,
                              firstDate: DateTime(novsdw.year - 100),
                              lastDate: DateTime(novsdw.year + 100),
                              currentDate: novsdw,
                              onDateChanged: (d) => setState(() => tvsmpd = d),
                            ),
                          ),
                          Container(
                            height: 1,
                            color: Colors.white.withOpacity(0.1),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 12.h,
                            ),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () => setState(() => tvsmpd = novsdw),
                                  child: Text(
                                    'Reset',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xff10A3F6),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () => Navigator.pop(ctx, tvsmpd),
                                  child: Text(
                                    'Done',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xff10A3F6),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                ),
              ),
            ),
          ),
    );
    if (picsddvked != null) {
      setState(() {
        _salveDadte = picsddvked;
        _chevsdsdck();
      });
    }
  }

  List<Widget> _reqvesments() {
    List<Widget> revsdsds = [];
    for (int i = 0; i < _buyersCtr.length; i++) {
      final cvseww = _buyersCtr[i];
      revsdsds.add(
        TextFieldMainPar(
          title: i == 0 ? "Buyer's requirements" : '',
          isOptional: i == 0,
          controller: cvseww,
          hintText: 'Enter the requirements',
          onChanged: (_) {
            final lavsddddst = i == _buyersCtr.length - 1;
            final empvsqqty = cvseww.text.trim().isEmpty;
            if (lavsddddst && !empvsqqty) {
              setState(() => _buyersCtr.add(TextEditingController()));
            } else if (!lavsddddst && empvsqqty) {
              setState(() => _buyersCtr.removeAt(i));
            }
          },
        ),
      );
    }
    return revsdsds;
  }

  void _updatePriceField() {
    final total = _selectedItems.fold<double>(0, (p, e) => p + e.price);
    _priceCtrl.text = total
        .toStringAsFixed(2)
        .replaceAll(RegExp(r'(\.0*|0*)$'), '');
  }

  @override
  Widget build(BuildContext context) {
    final btnColor =
        _isFormValid
            ? const Color(0xff10A3F6)
            : const Color(0xff10A3F6).withOpacity(0.4);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Image.asset(
                  'assets/images/backsjkd.png',
                  height: 35.h,
                  width: 35.w,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
        title: Text(
          'New buyer',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xffffffff),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text(
                'Item',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xffffffff),
                ),
              ),
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => MainParVyb(
                            onChange: (v) {
                              setState(() {
                                _selectedItems
                                  ..clear()
                                  ..addAll(v);
                                _updatePriceField();
                                _chevsdsdck();
                              });
                            },
                          ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(12.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: const Color(0xffffffff).withOpacity(0.1),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _selectedItems.isEmpty
                              ? 'Select an item'
                              : _selectedItems.map((e) => e.name).join(', '),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xffffffff),
                          ),
                        ),
                      ),
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(pi),
                        child: Image.asset(
                          'assets/images/backsjkd.png',
                          height: 28.h,
                          width: 28.w,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              TextFieldMainPar(
                title: 'Buyer name',
                controller: _nameCtrl,
                hintText: 'Name',
              ),
              SizedBox(height: 16.h),
              TextFieldMainPar(
                title: 'Phone number',
                controller: _phoneCtrl,
                hintText: '0-000-000-00-00',
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(height: 16.h),
              ..._reqvesments(),
              SizedBox(height: 16.h),
              TextFieldMainPar(
                title: 'Price',
                controller: _priceCtrl,
                hintText: '\$0',
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
              ),
              SizedBox(height: 16.h),
              Text(
                'Condition of item',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xffffffff),
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          condition = 'Completed';
                          _chevsdsdck();
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color:
                              condition == 'Completed'
                                  ? const Color(0xff089C00)
                                  : const Color(0xff089C00).withOpacity(0.5),
                        ),
                        child: Center(
                          child: Text(
                            'Completed',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          condition = 'Actively';
                          _chevsdsdck();
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color:
                              condition == 'Actively'
                                  ? const Color(0xffFFA600)
                                  : const Color(0xffFFA600).withOpacity(0.5),
                        ),
                        child: Center(
                          child: Text(
                            'Actively',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: condition == 'Completed',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
                    TextFieldMainPar(
                      title: 'Selling price',
                      controller: _sellingPrice,
                      hintText: '\$0',
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}'),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Sale date',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xffffffff),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    GestureDetector(
                      onTap: _pickvDadte,
                      child: Container(
                        padding: EdgeInsets.all(12.sp),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: const Color(0xffffffff).withOpacity(0.1),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                _salveDadte == null
                                    ? 'Select a date'
                                    : DateFormat(
                                      'MMMM dd, yyyy',
                                    ).format(_salveDadte!),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xffffffff),
                                ),
                              ),
                            ),
                            Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationY(pi),
                              child: Image.asset(
                                'assets/images/backsjkd.png',
                                height: 28.h,
                                width: 28.w,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              GestureDetector(
                onTap:
                    _isFormValid
                        ? () async {
                          final m = MyBuyersParModel(
                            id: DateTime.now().millisecondsSinceEpoch,
                            selectDate: _salveDadte ?? DateTime.now(),
                            name: _nameCtrl.text,
                            price: double.tryParse(_priceCtrl.text) ?? 0,
                            selectItems: List<MainParModel>.from(
                              _selectedItems,
                            ),
                            number: int.tryParse(_phoneCtrl.text) ?? 0,
                            buyers:
                                _buyersCtr
                                    .map((e) => e.text.trim())
                                    .where((e) => e.isNotEmpty)
                                    .toList(),
                            status: condition,
                            sellingPrice:
                                double.tryParse(_sellingPrice.text) ?? 0,
                          );
                          await MyBuyersParRepo.setMyBuyersPar(m);
                          for (final it in _selectedItems) {
                            await MainParRepo.updatePriceMin(it.id);
                          }
                          Navigator.pop(context);
                        }
                        : null,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: btnColor,
                  ),
                  child: Center(
                    child: Text(
                      _isEdit ? 'Save changes' : 'Add item',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
