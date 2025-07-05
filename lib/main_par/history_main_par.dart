import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parked_offers_sell_anytime_275_t/main_par/logic/models/main_par_model.dart';
import 'package:parked_offers_sell_anytime_275_t/main_par/logic/repositories/main_par_repo.dart';

class HistoryMainPar extends StatefulWidget {
  const HistoryMainPar({super.key});

  @override
  State<HistoryMainPar> createState() => _HistoryMainParState();
}

class _HistoryMainParState extends State<HistoryMainPar> {
  final _searchCtrl = TextEditingController();
  List<MainParModel> _iMainPars = [];
  bool _loMainParg = false;

  @override
  void initState() {
    super.initState();
    _loadHJjdMainPar();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadHJjdMainPar() async {
    setState(() => _loMainParg = true);
    final src = await MainParRepo.getMainPar();
    setState(() {
      _iMainPars = src.reversed.where((e) => e.history == true).toList();

      _loMainParg = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final showSearch = _iMainPars.length >= 3;
    final livIkkdsst =
        _searchCtrl.text.isEmpty
            ? _iMainPars
            : _iMainPars
                .where(
                  (e) => e.name.toLowerCase().contains(
                    _searchCtrl.text.toLowerCase(),
                  ),
                )
                .toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Sales history',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xffffffff),
          ),
        ),
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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              if (showSearch)
                Container(
                  height: 52.h,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: const Color(0xffFFFFFF).withOpacity(0.05),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/serchjddd.png',
                        height: 24.h,
                        width: 24.w,
                        fit: BoxFit.cover,
                        color:
                            _searchCtrl.text.isEmpty
                                ? const Color(0xffAAB3C1)
                                : null,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: TextField(
                          controller: _searchCtrl,
                          cursorColor: const Color(0xff10A3F6),
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xffFFFFFF),
                          ),
                          decoration: InputDecoration(
                            isCollapsed: true,
                            border: InputBorder.none,
                            hintText: 'Search',
                            hintStyle: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff898989),
                            ),
                          ),
                          onChanged: (_) => setState(() {}),
                        ),
                      ),
                      if (_searchCtrl.text.isNotEmpty)
                        GestureDetector(
                          onTap: () {
                            _searchCtrl.clear();
                            SystemChannels.textInput.invokeMethod(
                              'TextInput.hide',
                            );
                            setState(() {});
                          },
                          child: Image.asset(
                            'assets/images/deletefdf.png',
                            height: 32.h,
                            width: 32.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                    ],
                  ),
                ),
              if (showSearch) SizedBox(height: 20.h),
              _loMainParg
                  ? Padding(
                    padding: EdgeInsets.only(top: 250.h),
                    child: const Center(child: CupertinoActivityIndicator()),
                  )
                  : livIkkdsst.isNotEmpty
                  ? RefreshIndicator(
                    color: Colors.white,
                    onRefresh: _loadHJjdMainPar,
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: livIkkdsst.length,
                      separatorBuilder: (_, __) => SizedBox(height: 16.h),
                      itemBuilder: (_, index) {
                        final Uint8List imgBthj = Uint8List.fromList(
                          livIkkdsst[index].image.codeUnits,
                        );
                        return Container(
                          padding: EdgeInsets.all(16.sp),
                          margin: EdgeInsets.only(
                            bottom: index == livIkkdsst.length - 1 ? 100.h : 0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: const Color(0xffFFFFFF).withOpacity(0.2),
                            ),
                            color: const Color(0xffFFFFFF).withOpacity(0.1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(18.r),
                                child: Stack(
                                  children: [
                                    Image.memory(
                                      imgBthj,
                                      width: MediaQuery.of(context).size.width,
                                      height: 209.h,
                                      fit: BoxFit.fill,
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 22.w,
                                          vertical: 10.h,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20.r),
                                            bottomRight: Radius.circular(17.r),
                                          ),
                                          color:
                                              livIkkdsst[index].condition ==
                                                      'Used'
                                                  ? const Color(0xffFFA600)
                                                  : const Color(0xff089C00),
                                        ),
                                        child: Text(
                                          livIkkdsst[index].condition,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xffFFFFFF),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      child: GestureDetector(
                                        onTap: () async {
                                          await shHistoryMainPar(
                                            context,
                                            livIkkdsst[index],
                                          );
                                          _loadHJjdMainPar();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10.w,
                                            vertical: 8.5.h,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(17.r),
                                              bottomRight: Radius.circular(
                                                17.r,
                                              ),
                                            ),
                                            border: Border.all(
                                              color: Color(0xff10A3F6),
                                            ),
                                            color: Colors.white,
                                          ),
                                          child: Text(
                                            'Add item back',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff10A3F6),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                livIkkdsst[index].name,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xffFFFFFF),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                livIkkdsst[index].description,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xffFFFFFF),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                children: [
                                  Text(
                                    'Availability: ',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xffFFFFFF),
                                    ),
                                  ),
                                  Text(
                                    livIkkdsst[index].quantity
                                        .toStringAsFixed(2)
                                        .replaceAll(RegExp(r'(\.0*|0*)$'), ''),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xffFFFFFF),
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    'Price: ',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xffFFFFFF),
                                    ),
                                  ),
                                  Text(
                                    '\$${livIkkdsst[index].price.toStringAsFixed(2).replaceAll(RegExp(r'(\.0*|0*)$'), '')}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xff10A3F6),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                  : Padding(
                    padding: EdgeInsets.only(top: 250.h),
                    child: Center(
                      child: Text(
                        "You haven't sold anything yet",
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
    );
  }
}

class ShHistoryMainPar extends StatefulWidget {
  const ShHistoryMainPar({super.key, required this.model});
  final MainParModel model;
  @override
  State<ShHistoryMainPar> createState() => _ShHistoryMainParState();
}

class _ShHistoryMainParState extends State<ShHistoryMainPar> {
  TextEditingController contrsdd = TextEditingController();
  @override
  void dispose() {
    contrsdd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: IntrinsicHeight(
              child: Container(
                padding: EdgeInsets.all(16.sp),
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  gradient: LinearGradient(
                    colors: [Color(0xff4C545C), Color(0xff17181C)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Adding an item back ',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.close,
                            color: const Color(0xff10A3F6),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14.h),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.r),
                        color: const Color(0xffffffff).withOpacity(0.1),
                      ),
                      child: TextField(
                        controller: contrsdd,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xffffffff),
                        ),
                        cursorColor: const Color(0xffffffff),
                        decoration: InputDecoration(
                          hintText: 'Enter the number of items',
                          hintStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff898989),
                          ),
                          contentPadding: EdgeInsets.all(12.sp),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.r),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.r),
                            borderSide: const BorderSide(
                              color: Color(0xff10A3F6),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    GestureDetector(
                      onTap: () async {
                        await MainParRepo.updateQuantity(
                          widget.model.id,
                          int.tryParse(contrsdd.text) ?? 0,
                        );
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.r),
                          color: const Color(0xff10A3F6),
                        ),
                        child: Center(
                          child: Text(
                            'Add',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> shHistoryMainPar(BuildContext context, MainParModel model) async {
  await showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) {
      return ShHistoryMainPar(model: model);
    },
  );
}
