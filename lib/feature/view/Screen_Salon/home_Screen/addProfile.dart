import 'dart:io';
import 'dart:typed_data';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salon_provider/feature/server/getx/app_get_salon.dart';
import 'package:salon_provider/feature/server/helper/sp_helpar.dart';
import 'package:salon_provider/feature/server/service/server_salon.dart';
import 'package:salon_provider/feature/values/colors.dart';
import 'package:salon_provider/feature/view/widgets/custom_button.dart';
import 'package:salon_provider/feature/view/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salon_provider/feature/view/widgets/custom_text_field.dart';
import '../../Screen_Salon/home_Screen/addService.dart';
import '../../widgets/custom_imagePicker.dart';
import '../../widgets/dashed_line.dart';

enum AppState {
  free,
  picked,
  cropped,
}

class AddProfile extends StatefulWidget {
  final int index;

  const AddProfile({Key key, this.index = 1}) : super(key: key);
  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddProfile> {
  String startTime = "08:00";
  AppState state;
  File imageFile;
  String endTime = "04:00";

  int currnt = 0;
  AppGet appGet = Get.find();
  List<Map> workTime = [];
  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 6; i++) {
      workTime.add({"day": dayLabels[i], "from": startTime, "to": endTime});
    }
  }

  List<String> dayLabels = [
    "Sat",
    "Sun",
    "Mon",
    "Tue",
    "Wed",
    "Thr",
    "Fri",
  ];
  deleteImages(File file) {
    int index = images.indexOf(file);
    images.removeAt(index);
    setState(() {});
  }

  deletelogo(File file) {
    logo = null;
    setState(() {});
  }

  deleteBakground(File file) {
    background = null;
    setState(() {});
  }

  XFile image;

  CroppedFile logo;
  CroppedFile background;
  bool isLoading = false;
  Uint8List decodedBytes;

  List<File> images = [];

  Future pickImage() async {
    try {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image.path.isEmpty) return;
      final imageTemporary = XFile(image.path);
      setState(() {
        images.add(File(imageTemporary.path));
        // this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // shadowColor: Colors.transparent,
        // elevation: 0,
        title: CustomText(
          text: "Working Days".tr,
          color: AppColors.primary,
          fontSize: 18,
        ),
        centerTitle: true,
        toolbarHeight: 40.h,
        actions: [
          if (widget.index == 2)
            Directionality(
              textDirection: TextDirection.ltr,
              child: IconButton(
                  icon: Icon(
                    SPHelper.spHelper.getLanguge() == "ar"
                        ? Icons.arrow_back_ios
                        : Icons.arrow_forward_ios,
                    color: AppColors.primary,
                  ),
                  onPressed: () {
                    Get.back();
                  }),
            )
          else
            InkWell(
              onTap: () {
                Future.delayed(Duration(milliseconds: 200), () async {
                  ServerProvider.instance.getAllVaraibles();
                  Get.to(() => AddService());
                });
              },
              child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                    child: CustomText(
                      text: "Skip",
                      color: AppColors.primary,
                    ),
                  )),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 80,
                child: ListView.builder(
                  itemCount: dayLabels.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        currnt = index;
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: currnt == index
                              ? AppColors.primary
                              : AppColors.primary20,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CustomText(
                                text: dayLabels[index],
                                color: currnt == index
                                    ? Colors.white
                                    : AppColors.primary),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: CustomText(text: "Working hours".tr),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: DateTimePicker(
                        type: DateTimePickerType.time,
                        initialValue: startTime,
                        strutStyle: StrutStyle(),
                        icon: Icon(
                          Icons.event,
                          color: AppColors.primary,
                        ),
                        timeLabelText: "from".tr + " :",
                        style: GoogleFonts.cairo(fontSize: 18),
                        onChanged: (val) {
                          startTime = val;
                          print(startTime);
                        },
                        validator: (val) {
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: DateTimePicker(
                        type: DateTimePickerType.time,
                        initialValue: endTime,
                        icon: Icon(Icons.event),
                        timeLabelText: "to".tr + ":",
                        style: GoogleFonts.cairo(fontSize: 18),
                        onChanged: (val) {
                          endTime = val;
                          int i = workTime
                              .indexWhere((e) => e["day"] == dayLabels[currnt]);
                          workTime.removeAt(i);
                          workTime.add({
                            "day": dayLabels[currnt],
                            "from": startTime,
                            "to": endTime
                          });
                          print(workTime);
                        },
                        validator: (val) {
                          return null;
                        },
                        // onSaved: (val) => print(val),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  text: "Salon Images",
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                width: 400,
                // height: 100,
                child: GetBuilder<AppGet>(
                  init: AppGet(),
                  id: "result",
                  builder: (_) {
                    return Column(children: [
                      GestureDetector(
                        onTap: () async {
                          pickImage();
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
                      images.length == 0
                          ? Container()
                          : Container(
                              height: 140,
                              child: ListView.builder(
                                  padding: EdgeInsets.all(0),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: images.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ImageWidget(
                                          imgFile: images[index],
                                          function: deleteImages),
                                    );
                                  }),
                            )
                    ]);
                  },
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(
                      text: "Salon Logo",
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    width: 400,
                    child: GetBuilder<AppGet>(
                      id: "logo",
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
                              : Container(
                                  height: 100,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ImageWidget(
                                      imgFile: File(logo.path),
                                      function: deletelogo,
                                    ),
                                  ),
                                ),
                        ]);
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  text: "Background Image",
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                width: 400,
                child: GetBuilder<AppGet>(
                  init: AppGet(),
                  id: "result",
                  builder: (_) {
                    return Column(children: [
                      GestureDetector(
                        onTap: () async {
                          final pickImage = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          background = await corpMetod(pickImage.path);
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
                                bottom: 2,
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
                      background == null
                          ? Container()
                          : Container(
                              height: 100,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ImageWidget(
                                  imgFile: File(background.path),
                                  function: deleteBakground,
                                ),
                              ),
                            ),
                    ]);
                  },
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: CustomTextFormField(
                  color: Colors.grey,
                  hintText: "About Salon".tr,
                  textEditingController: appGet.aboutController.value,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 200,
                  child: CustomButton(
                      color: AppColors.primary,
                      text: widget.index == 2 ? "Save".tr : "Next".tr,
                      onPress: () async {
                        await ServerProvider.instance
                            .setEditProduct(
                                about: appGet.aboutController.value.text,
                                workDays: workTime,
                                photo: images,
                                logo: File(logo.path),
                                background: File(background.path))
                            .then((value) {
                          if (value["code"] == 200) {
                            if (widget.index != 2) {
                              Get.to(() => AddService());
                            }
                          }
                        });
                      }),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<CroppedFile> corpMetod(String logo) async {
    if (logo != null) {
      CroppedFile croppedFile2 = await ImageCropper().cropImage(
          sourcePath: logo,
          compressFormat: ImageCompressFormat.jpg,
          compressQuality: 100,
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Cropper',
                toolbarColor: Colors.deepOrange,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
            IOSUiSettings(
              title: 'Cropper',
            ),
          ]);

      return croppedFile2;
    }
  }
}
