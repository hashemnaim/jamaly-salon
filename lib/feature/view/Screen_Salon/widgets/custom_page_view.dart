import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'indicatorOnboarding.dart';

class SliderImage extends StatefulWidget {
  final List imageList;

  final double height;
  final double width;

  SliderImage({
    this.imageList,
    this.height,
    this.width,
  });

  @override
  _SliderImageState createState() => _SliderImageState();
}

class _SliderImageState extends State<SliderImage> {
  final PageController _pageController = PageController(initialPage: 0);
  ValueNotifier<double> _pageNotifier;
  int _currentPage = 0;

  @override
  void initState() {
    _pageController.addListener(_pageListener);
    _pageNotifier = ValueNotifier(1.0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
    super.dispose();
  }

  void _pageListener() {
    _pageNotifier.value = _pageController.page;
  }

  //todo:change this list to your model
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            height: 365.h,
            width: Get.width,
            child: Stack(
              children: [
                SizedBox(
                  height: 365.h,
                  width: 375.w,
                  child: PageView.builder(
                    itemCount: widget.imageList.length,
                    controller: PageController(
                      initialPage: 0,
                      viewportFraction: 1,
                    ),
                    onPageChanged: (int index) {
                      _currentPage = index;
                      setState(() {});
                    },
                    itemBuilder: (_, i) {
                      return Container(
                        width: Get.width,
                        alignment: Alignment.center,
                        height: 400.h,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            image: DecorationImage(
                                image: NetworkImage(widget.imageList[i]),
                                fit: BoxFit.fill)),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 16.h,
                  child: Container(
                    width: Get.width,
                    child: ValueListenableBuilder(
                      valueListenable: _pageNotifier,
                      builder: (context, value, child) {
                        final factorChange = (value - _currentPage).abs();
                        print(factorChange);
                        return IndicatorOnboarding(
                          currentPage: _currentPage,
                          numPages: widget.imageList.length,
                          factorChange: factorChange,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _activePhoto(bool active) {
    return Container(
      width: 6.w,
      height: 6.h,
      margin: EdgeInsets.symmetric(vertical: 15.0.h, horizontal: 7.0.w),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? Colors.white : Colors.white.withOpacity(0.43),
        border:
            active ? null : Border.all(width: 0.5.w, color: Color(0xff999999)),
      ),
    );
  }

  List<Widget> buildDots(int index, int count) {
    List<Widget> dots = [];
    for (int i = 0; i < count; ++i) {
      dots.add(_activePhoto(i == index));
    }
    return dots;
  }
}
