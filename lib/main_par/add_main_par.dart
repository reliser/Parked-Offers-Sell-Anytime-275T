import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parked_offers_sell_anytime_275_t/main_par/logic/models/main_par_model.dart';
import 'package:parked_offers_sell_anytime_275_t/main_par/logic/repositories/main_par_repo.dart';
import 'package:permission_handler/permission_handler.dart';

class AddMainPar extends StatefulWidget {
  const AddMainPar({super.key, this.model});
  final MainParModel? model;

  @override
  State<AddMainPar> createState() => _AddMainParState();
}

class _AddMainParState extends State<AddMainPar> {
  final _nameCtrl = TextEditingController();
  final _quantityCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();

  String condition = '';
  bool _isFormValidMainPar = false;

  File? _imageMainPar;
  Uint8List? _bytesMainPar;
  String? _photoMainPar;

  bool get _isEditMainPar => widget.model != null;

  @override
  void initState() {
    super.initState();
    if (_isEditMainPar) {
      final m = widget.model!;
      _nameCtrl.text = m.name;
      _quantityCtrl.text = m.quantity.toString();
      _priceCtrl.text = m.price.toString();
      _descriptionCtrl.text = m.description;
      condition = m.condition;
      if (m.image.isNotEmpty) {
        _bytesMainPar = Uint8List.fromList(m.image.codeUnits);
        _photoMainPar = m.image;
      }
    }
    _nameCtrl.addListener(_validate);
    _quantityCtrl.addListener(_validate);
    _priceCtrl.addListener(_validate);
    _validate();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _quantityCtrl.dispose();
    _descriptionCtrl.dispose();
    _priceCtrl.dispose();
    super.dispose();
  }

  void _validate() {
    final valid =
        _nameCtrl.text.trim().isNotEmpty &&
        _quantityCtrl.text.trim().isNotEmpty &&
        _priceCtrl.text.trim().isNotEmpty &&
        _photoMainPar != null &&
        condition.isNotEmpty;
    if (valid != _isFormValidMainPar)
      setState(() => _isFormValidMainPar = valid);
  }

  Future<void> _pickImage() async {
    FocusManager.instance.primaryFocus?.unfocus();
    try {
      final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picked == null) return;
      setState(() {
        _imageMainPar = File(picked.path);
        _bytesMainPar = _imageMainPar!.readAsBytesSync();
        _photoMainPar = String.fromCharCodes(_bytesMainPar!);
        _validate();
      });
    } catch (_) {
      final status = await Permission.photos.status;
      if (status.isDenied) showtoMainPar(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttonColor =
        _isFormValidMainPar
            ? const Color(0xff10A3F6)
            : const Color(0xff10A3F6).withOpacity(0.4);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        actions: [
          _isEditMainPar
              ? Padding(
                padding: EdgeInsets.only(right: 14.w),
                child: GestureDetector(
                  onTap: () async {
                    await MainParRepo.deleteMainPar(widget.model!.id);
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: Image.asset(
                      'assets/images/deletdsdf.png',
                      height: 28.h,
                      width: 28.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
              : const SizedBox(),
        ],
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
          'New item',
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
                'Item photo',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xffffffff),
                ),
              ),
              SizedBox(height: 8.h),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _pickImage,
                child:
                    _bytesMainPar != null
                        ? Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.r),
                              child: Image.memory(
                                _bytesMainPar!,
                                height: 222.h,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Positioned(
                              right: 2.w,
                              bottom: 2.h,
                              child: Image.asset(
                                'assets/images/ikkkdsdd.png',
                                height: 60.h,
                                width: 60.w,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        )
                        : Image.asset(
                          'assets/images/imageds.png',
                          height: 222.h,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                        ),
              ),
              SizedBox(height: 16.h),
              TextFieldMainPar(
                title: 'Item name',
                controller: _nameCtrl,
                hintText: 'Name',
              ),
              SizedBox(height: 16.h),
              TextFieldMainPar(
                title: 'Description',
                isOptional: true,
                controller: _descriptionCtrl,
                hintText: 'Enter a description',
              ),
              SizedBox(height: 16.h),
              TextFieldMainPar(
                title: 'Quantity available',
                controller: _quantityCtrl,
                hintText: '0',
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
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
                          condition = 'New';
                          _validate();
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color:
                              condition == 'New'
                                  ? const Color(0xff089C00)
                                  : const Color(0xff089C00).withOpacity(0.5),
                        ),
                        child: Center(
                          child: Text(
                            'New',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color:
                                  condition == 'New'
                                      ? const Color(0xffffffff)
                                      : const Color(
                                        0xffffffff,
                                      ).withOpacity(0.5),
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
                          condition = 'Used';
                          _validate();
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color:
                              condition == 'Used'
                                  ? const Color(0xffFFA600)
                                  : const Color(0xffFFA600).withOpacity(0.5),
                        ),
                        child: Center(
                          child: Text(
                            'Used',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color:
                                  condition == 'Used'
                                      ? const Color(0xffffffff)
                                      : const Color(
                                        0xffffffff,
                                      ).withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              GestureDetector(
                onTap:
                    _isFormValidMainPar
                        ? () async {
                          final mainPar = MainParModel(
                            id: DateTime.now().millisecondsSinceEpoch,
                            image: _photoMainPar!,
                            selectDate: DateTime.now(),
                            name: _nameCtrl.text,
                            quantity: int.tryParse(_quantityCtrl.text) ?? 0,
                            description: _descriptionCtrl.text,
                            price: double.tryParse(_priceCtrl.text) ?? 0,
                            condition: condition,
                            history: false,
                          );
                          await MainParRepo.setMainPar(mainPar);
                          Navigator.pop(context);
                        }
                        : null,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: buttonColor,
                  ),
                  child: Center(
                    child: Text(
                      _isEditMainPar ? 'Save changes' : 'Add item',
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

class TextFieldMainPar extends StatelessWidget {
  const TextFieldMainPar({
    super.key,
    required this.title,
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.inputFormatters,
    this.maxLines = 1,
    this.isOptional = false,
    this.onChanged,
  });

  final String title;
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  final bool isOptional;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xffffffff),
              ),
            ),
            if (isOptional)
              Padding(
                padding: EdgeInsets.only(left: 4.w),
                child: Text(
                  '(optional)',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff898989),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: const Color(0xffffffff).withOpacity(0.1),
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            onChanged: onChanged,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xffffffff),
            ),
            cursorColor: const Color(0xffffffff),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xff898989),
              ),
              contentPadding: EdgeInsets.all(12.sp),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.r),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.r),
                borderSide: const BorderSide(color: Color(0xff10A3F6)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

void showtoMainPar(BuildContext context) {
  showCupertinoDialog<void>(
    context: context,
    barrierDismissible: false,
    builder:
        (_) => CupertinoAlertDialog(
          title: const Text('No access to your photos'),
          content: const Text(
            'Provide access to photos of your items from the garage',
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            CupertinoDialogAction(
              onPressed: () => openAppSettings(),
              isDefaultAction: true,
              child: const Text('Settings'),
            ),
          ],
        ),
  );
}
