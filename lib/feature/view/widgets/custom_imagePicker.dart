import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageWidget extends StatelessWidget {
  final File imgFile;
  final Function function;
  const ImageWidget({
    this.imgFile,
    @required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            width: 130.w,
            height: 100.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(color: Colors.transparent)),
          ),
          Positioned(
            right: 0,
            child: Container(
                width: 130.w,
                height: 100.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: Colors.black)),
                child: Image.file(
                  imgFile,
                  fit: BoxFit.cover,
                )),
          ),
          Positioned(
            top: -10,
            left: -3.w,
            child: GestureDetector(
              onTap: () => function(imgFile),
              child: Container(
                height: 35.h,
                width: 35.w,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Container(
                    height: 30.h,
                    width: 30.w,
                    child: CircleAvatar(
                      backgroundColor: Color(0xffF05366),
                      child: Icon(
                        Icons.delete,
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
    );
  }
}
