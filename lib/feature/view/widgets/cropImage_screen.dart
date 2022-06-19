import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salon_provider/feature/values/colors.dart';
import 'package:salon_provider/feature/view/Screen_Salon/home_Screen/addProfile.dart';
import 'package:salon_provider/feature/view/widgets/custom_button.dart';
import 'package:salon_provider/feature/view/widgets/custom_text.dart';

class CropImageScreen extends StatefulWidget {
  static String tag = '/CropImageScreen';

  @override
  CropImageScreenState createState() => CropImageScreenState();
}

class CropImageScreenState extends State<CropImageScreen> {
  AppState state;
  File imageFile;
  String title = "Select image";

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    state = AppState.free;
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        imageFile != null
            ? Center(child: Image.file(imageFile, height: 500, width: 300))
            : Center(
                child: Container(
                  alignment: Alignment.center,
                  color: AppColors.primary20,
                  height: 280,
                  width: Get.width,
                  child: CustomText(
                    text: "Select image to crop",
                    fontSize: 16,
                  ),
                ),
              ),
        Align(
          alignment: Alignment.bottomCenter,
          child: CustomButton(
            // padding: EdgeInsets.only(left: 30, right: 30, top: 16, bottom: 16),
            onPress: () {
              if (state == AppState.free) {
                _pickImage();
                title = "Crop image";
              } else if (state == AppState.picked) {
                _cropImage();
                title = "Clear image";
              } else if (state == AppState.cropped) {
                _clearImage();
                title = "Add image";
              }
            },
            color: AppColors.primary20,
            // child: CustomText(title, fontSize: 14.sp,),
            // shapeBorder: RoundedRectangleBorder(borderRadius: radius(10)),
          ),
        ),
      ],
    ).paddingOnly(bottom: 20, top: 20, left: 16, right: 16);
  }

  Future _pickImage() async {
    imageFile =
        File((await ImagePicker().getImage(source: ImageSource.gallery)).path);
    if (imageFile != null) {
      setState(() {
        state = AppState.picked;
      });
    }
  }

  Future<Null> _cropImage() async {
    var croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9,
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9
            ],
      // androidUiSettings: AndroidUiSettings(
      //   toolbarTitle: 'Image Cropper',
      //   toolbarColor: AppColors.primary,
      //   toolbarWidgetColor: Colors.white,
      //   initAspectRatio: CropAspectRatioPreset.original,
      //   lockAspectRatio: false,
      // ),
    );
    if (croppedFile != null) {
      imageFile = croppedFile as File;
      setState(() {
        state = AppState.cropped;
      });
    }
  }

  void _clearImage() {
    imageFile = null;
    setState(() {
      state = AppState.free;
    });
  }
}
