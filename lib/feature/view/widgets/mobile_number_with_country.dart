import 'package:salon_provider/feature/server/getx/app_get_salon.dart';
import 'package:salon_provider/feature/values/colors.dart';
// import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MobileNumberTextField extends StatelessWidget {
  final TextEditingController editingController = TextEditingController();
  final Function fun;
  final String content;
  final String initialText;
  final String labelText;
  MobileNumberTextField(
      {this.fun,
      this.content,
      this.labelText = 'رقم الهاتف',
      this.initialText = ''}) {
    if (content != null) {
      editingController.text = content;
    }
  }
  final AppGet appGet = Get.find();
  final String countryCode = '';
  final String mobileNum = '';
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: SizedBox(
            height: 65.h,
            child: TextFormField(
              controller: editingController,
              initialValue: initialText,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.grayText, width: 2.0.w),
                    borderRadius: BorderRadius.all(new Radius.circular(10.0)),
                  ),
                  labelText: labelText,
                  labelStyle: GoogleFonts.cairo(
                    color: Colors.grey,
                    fontSize: ScreenUtil().setSp(
                      15,
                    ),
                  )),
              onSaved: (value) => fun(value),
              onChanged: (value) => fun(value),
              validator: (val) {
                Pattern pattern = r'(^(?:[+0]9)?[0-9]{10}$)';
                RegExp regex = new RegExp(pattern);
                if (val.isEmpty) {
                  return "يجب ادخال رقم الهاتف";
                } else if (!regex.hasMatch(val)) {
                  return "يوجد خطا برقم الهاتف";
                }
                return null;
              },
            ),
          ),
        ),
        // Directionality(
        //   textDirection: TextDirection.ltr,
        //   child: CountryCodePicker(
        //     countryFilter: [
        //       'SA',
        //     ],
        //     showCountryOnly: false,
        //     showOnlyCountryWhenClosed: false,
        //     alignLeft: false,
        //   ),
        // ),
      ],
    );
  }
}
