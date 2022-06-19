import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salon_provider/feature/server/getx/app_get_salon.dart';
import 'package:salon_provider/feature/server/service/server_salon.dart';
import 'package:salon_provider/feature/values/colors.dart';
import 'package:salon_provider/feature/view/widgets/custom_imagePicker.dart';
import 'package:salon_provider/feature/view/widgets/custom_text.dart';
import 'package:salon_provider/feature/view/widgets/custom_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_provider/feature/view/widgets/dashed_line.dart';

import '../../../values/constant.dart';

class AddServiceSheet extends StatefulWidget {
  final int id;
  final String title;

  const AddServiceSheet({Key key, this.title, this.id}) : super(key: key);
  @override
  _AddServiceSheetState createState() => _AddServiceSheetState();
}

class _AddServiceSheetState extends State<AddServiceSheet> {
  final AppGet appGet = Get.find();
  GlobalKey<FormState> regestrationFormKey = GlobalKey();
  TextEditingController _titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discontController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _serviceDetailsController = TextEditingController();
  final serviceImage = [];
  @override
  void initState() {
    _titleController = TextEditingController();
    priceController = TextEditingController();
    priceController = TextEditingController();
    _serviceDetailsController = TextEditingController();
    setState(() {});
    super.initState();
  }

  validateNull(String value) {
    if (value == '') {
      return 'noData'.tr;
    }
  }

  CroppedFile logo;

  deleteImageFromRegistersImages(file) {
    int index = serviceImage.indexOf(file);

    serviceImage.removeAt(index);
    setState(() {});
  }

  saveForm() async {
    if (regestrationFormKey.currentState.validate()) {
      regestrationFormKey.currentState.save();

      await ServerProvider.instance.setAddService(
          serviceId: widget.id,
          name: _titleController.text,
          price: priceController.text,
          discount: discontController.text,
          timeNeeded: _timeController.text,
          details: _serviceDetailsController.text,
          photo: [File(logo.path)]);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600.h,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      // padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 300.h,
          child: Form(
            key: regestrationFormKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomText(
                        text: widget.title,
                        color: AppColors.primary,
                        fontSize: 18,
                      ),
                      Spacer(),
                      InkWell(
                          onTap: () {
                            saveForm();
                          },
                          child: CustomText(
                            text: "Save".tr,
                            color: Colors.green,
                            fontSize: 24,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: CustomTextFormField(
                            hintText: 'Service Name'.tr,
                            textEditingController: _titleController,
                            validator: validateNull,
                          )),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: CustomTextFormField(
                            hintText: 'Service Price',
                            textEditingController: priceController,
                            validator: validateNull,
                            textInputType: TextInputType.number),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                            hintText: 'Descoint Price',
                            textEditingController: discontController,
                            validator: validateNull,
                            textInputType: TextInputType.number),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: CustomTextFormField(
                            hintText: 'Time Needed'.tr,
                            textEditingController: _timeController,
                            validator: validateNull,
                            textInputType: TextInputType.number),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextFormField(
                      hintText: 'Service Details'.tr,
                      textEditingController: _serviceDetailsController,
                      validator: validateNull,
                      textInputType: TextInputType.text),
                  CustomText(
                    text: "Service Images".tr,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  Container(
                    // width: 400,
                    height: 220,
                    child: GetBuilder<AppGet>(
                      init: AppGet(),
                      id: "Result",
                      builder: (_) {
                        return Column(children: [
                          GestureDetector(
                            onTap: () async {
                              final pickImage = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              logo = await corpMetod(pickImage.path);
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
                                        text: "Upload".tr,
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
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ImageWidget(
                                    imgFile: File(
                                      logo.path,
                                    ),
                                    function: deleteImageFromRegistersImages,
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
      ),
    );
  }
}
