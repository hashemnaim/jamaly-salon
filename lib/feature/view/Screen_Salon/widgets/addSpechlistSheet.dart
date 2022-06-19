import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salon_provider/feature/server/getx/app_get_salon.dart';
import 'package:salon_provider/feature/values/colors.dart';
import 'package:salon_provider/feature/view/widgets/custom_imagePicker.dart';
import 'package:salon_provider/feature/view/widgets/custom_text.dart';
import 'package:salon_provider/feature/view/widgets/custom_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_provider/feature/view/widgets/dashed_line.dart';

import '../../../server/service/server_salon.dart';
import '../../../values/constant.dart';

class AddSspechlistSheet extends StatefulWidget {
  // final int id;
  // final String title;

  const AddSspechlistSheet({
    Key key,
  }) : super(key: key);
  @override
  _AddServiceSheetState createState() => _AddServiceSheetState();
}

class _AddServiceSheetState extends State<AddSspechlistSheet> {
  final AppGet appGet = Get.find();
  GlobalKey<FormState> regestrationFormKey = GlobalKey();
  TextEditingController titleController = TextEditingController();

  validateNull(String value) {
    if (value == '') {
      return 'noData'.tr;
    }
  }

  deleteSpechlist(file) {
    logo = null;

    setState(() {});
  }

  CroppedFile logo;

  saveForm() async {
    Navigator.pop(context);
    await ServerProvider.instance
        .setAddSpecialists(name: titleController.text, photo: File(logo.path));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600.h,
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Container(
        // height: 300.h,

        child: Form(
          key: regestrationFormKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          saveForm();
                        },
                        child: CustomText(
                          text: "Save".tr,
                          color: Colors.green,
                          fontSize: 20,
                        )),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                CustomTextFormField(
                  hintText: 'Name'.tr,
                  textEditingController: titleController,
                  validator: validateNull,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomText(
                  text: "Spechlist Images".tr,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                Container(
                  // width: 400,
                  // height: 220,
                  child: GetBuilder<AppGet>(
                    init: AppGet(),
                    id: "result",
                    builder: (_) {
                      return Column(children: [
                        GestureDetector(
                          onTap: () async {
                            final pickImage = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            logo = await corpMetod(pickImage.path, crop: 0);
                            setState(() {});
                          },
                          child: Container(
                            height: 50.h,
                            width: 325.w,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                DashedRect(
                                    color: AppColors.primary,
                                    strokeWidth: 2.0,
                                    gap: 3.0),
                                Positioned(
                                    top: 10,
                                    left: 0,
                                    right: 0,
                                    child: Icon(
                                      Icons.cloud_upload,
                                    )),
                                Positioned(
                                  bottom: 4,
                                  left: 0,
                                  right: 0,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: CustomText(
                                      text: "Upload",
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        logo == null
                            ? Container()
                            : CircleAvatar(
                                radius: 80,
                                child: Image.file(
                                  File(logo.path),
                                  // function: deleteSpechlist,
                                ),
                              )
                      ]);
                    },
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
