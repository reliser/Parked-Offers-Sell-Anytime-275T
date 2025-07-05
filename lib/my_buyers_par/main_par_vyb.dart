import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parked_offers_sell_anytime_275_t/main_par/logic/models/main_par_model.dart';
import 'package:parked_offers_sell_anytime_275_t/main_par/logic/repositories/main_par_repo.dart';

class MainParVyb extends StatefulWidget {
  const MainParVyb({super.key, required this.onChange});
  final ValueChanged<List<MainParModel>> onChange;

  @override
  State<MainParVyb> createState() => _MainParVybState();
}

class _MainParVybState extends State<MainParVyb> {
  final _searchCtrl = TextEditingController();
  final Map<String, MemoryImage> _imgCache = {};
  List<MainParModel> _iMainPars = [];
  final List<MainParModel> _selected = [];
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

  MemoryImage _getImg(String raw) => _imgCache.putIfAbsent(
    raw,
    () => MemoryImage(Uint8List.fromList(raw.codeUnits)),
  );

  Future<void> _loadHJjdMainPar() async {
    setState(() => _loMainParg = true);
    final src = await MainParRepo.getMainPar();
    setState(() {
      _iMainPars = src.reversed.where((e) => e.history == false).toList();
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
          'Select an item',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
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
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
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
                          ),
                        ),
                    ],
                  ),
                ),
              if (showSearch) SizedBox(height: 20.h),
              _loMainParg
                  ? Padding(
                    padding: EdgeInsets.only(top: 250.h),
                    child: const CupertinoActivityIndicator(),
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
                        final item = livIkkdsst[index];
                        final isSelected = _selected.contains(item);

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                _selected.remove(item);
                              } else {
                                _selected.add(item);
                              }
                            });
                          },
                          child: Container(
                            key: ValueKey(item.id),
                            padding: EdgeInsets.all(16.sp),
                            margin: EdgeInsets.only(
                              bottom:
                                  index == livIkkdsst.length - 1 ? 100.h : 0,
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
                                      Image(
                                        image: _getImg(item.image),
                                        width:
                                            MediaQuery.of(context).size.width,
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
                                              bottomRight: Radius.circular(
                                                17.r,
                                              ),
                                            ),
                                            color:
                                                item.condition == 'Used'
                                                    ? const Color(0xffFFA600)
                                                    : const Color(0xff089C00),
                                          ),
                                          child: Text(
                                            item.condition,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 4.h,
                                        right: 4.w,
                                        child: Opacity(
                                          opacity: isSelected ? 1.0 : 0.5,
                                          child: Image.asset(
                                            'assets/images/vaybfdr.png',
                                            width: 40.w,
                                            height: 50.h,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  item.name,
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  item.description,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
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
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      item.quantity
                                          .toStringAsFixed(2)
                                          .replaceAll(
                                            RegExp(r'(\.0*|0*)$'),
                                            '',
                                          ),
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      'Price: ',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      '\$${item.price.toStringAsFixed(2).replaceAll(RegExp(r'(\.0*|0*)$'), '')}',
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
                          ),
                        );
                      },
                    ),
                  )
                  : Padding(
                    padding: EdgeInsets.only(top: 250.h),
                    child: Text(
                      'You have not added any items for selection',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap:
            _selected.isNotEmpty
                ? () {
                  widget.onChange(List<MainParModel>.from(_selected));
                  Navigator.pop(context);
                }
                : null,
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
                'Select',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
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
