import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:salon_provider/feature/values/colors.dart';

class CustomVerification extends StatefulWidget {
  final Function onDone;

  CustomVerification({
    this.onDone,
  });

  @override
  _CustomVerificationState createState() => _CustomVerificationState();
}

class _CustomVerificationState extends State<CustomVerification>
    with SingleTickerProviderStateMixin {
  TextEditingController controllerPin;
  bool hasError = false;
  bool taped = false;
  FocusNode focusNode = FocusNode();
  String doneText;
  Timer timer;
  int tart = 3 * 60 - 1;

  // void startTimer() {
  //   const oneSec = const Duration(seconds: 1);
  //   _timer = new Timer.periodic(
  //     oneSec,
  //     (Timer timer) => setState(
  //       () {
  //         if (_start < 1) {
  //           timer.cancel();
  //         } else {
  //           _start = _start - 1;
  //         }
  //       },
  //     ),
  //   );
  // }

  @override
  void initState() {
    controllerPin = TextEditingController();
    // startTimer();
    focusNode.addListener(() {
      taped = focusNode.hasFocus;
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    // _timer.cancel();
    controllerPin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: PinCodeTextField(
            autofocus: true,
            controller: controllerPin,

            highlight: true,
            highlightColor: AppColors.primaryColor,
            highlightPinBoxColor: Colors.white,
            defaultBorderColor: Color.fromARGB(255, 0, 0, 0),
            hasTextBorderColor: AppColors.primaryColor,
            maxLength: 6,
            hasError: hasError,
            pinBoxColor: Color.fromARGB(255, 255, 255, 255),

            onTextChanged: (text) {
              setState(() {
                hasError = false;
              });
            },

            onDone: (text) {
              doneText = text;
              widget.onDone(text);
              print("DONE CONTROLLER ${controllerPin.text}");
            },
            pinBoxWidth: 50.75.w,
            pinBoxHeight: 52.h,
            hasUnderline: false,
            wrapAlignment: WrapAlignment.center,
            pinBoxDecoration: ProvidedPinBoxDecoration.defaultPinBoxDecoration,
            pinTextStyle: TextStyle(
              fontSize: 24.sp,
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
              fontFamily: "Manrope",
            ),
            pinTextAnimatedSwitcherTransition:
                ProvidedPinBoxTextAnimation.scalingTransition,
//                    pinBoxColor: Colors.green[100],
            pinTextAnimatedSwitcherDuration: Duration(milliseconds: 150),
//                    highlightAnimation: true,
            keyboardType: TextInputType.number,
            pinBoxRadius: 8.r,
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: [
        //     // CustomText(
        //     //  text:
        //     //   'Resend on  ',
        //     //   fontSize: 14.sp,
        //     //   fontWeight: FontWeight.w400,
        //     //   color: AppColors.primaryColor,
        //     // ),
        //     // CustomText(text:
        //     //   '${_start ~/ 60}:${_start % 60}',
        //     //   fontSize: 14.sp,
        //     //   fontWeight: FontWeight.w600,
        //     //   color: AppColors.primaryColor,
        //     // ),
        //     SizedBox(
        //       width: 15.w,
        //     )
        //   ],
        // ),
      ],
    );
  }
}
