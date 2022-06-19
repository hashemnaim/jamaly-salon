import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:salon_provider/feature/server/getx/app_get_salon.dart';
import 'package:salon_provider/feature/server/helper/sp_helpar.dart';
import 'package:salon_provider/feature/server/service/server_salon.dart';
import 'package:salon_provider/feature/values/colors.dart';
import 'package:salon_provider/feature/view/Screen_Salon/widgets/addSpechlistSheet.dart';
import 'package:salon_provider/feature/view/widgets/custom_button.dart';
import 'package:salon_provider/feature/view/widgets/custom_dialog_box.dart';
import 'package:salon_provider/feature/view/widgets/custom_image_Network.dart';
import 'package:salon_provider/feature/view/widgets/custom_text.dart';
import 'package:salon_provider/feature/view/widgets/isload.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../main_screen.dart';

class AddSpecialists extends StatefulWidget {
  final int index;

  const AddSpecialists({Key key, this.index = 1}) : super(key: key);

  @override
  _ServesScreenState createState() => _ServesScreenState();
}

class _ServesScreenState extends State<AddSpecialists> {
  AppGet appGet = Get.find();
  int currnt = 0;

  @override
  Widget build(BuildContext context) {
    // print(appGet.salonImage);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // shadowColor: Colors.transparent,
        toolbarHeight: 40.h,
        title: CustomText(
          text: "My Specialists".tr,
          color: AppColors.primary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
        leading: Container(),
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
              onTap: () async {
                await SPHelper.spHelper.setOnBoarding(true);

                Get.off(() => MainScreen());
              },
              child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: CustomText(
                      text: "Skip",
                      color: AppColors.primary,
                    ),
                  )),
            ),
        ],
      ),
      body: Obx(
        () => appGet.mySpecialists.isEmpty
            ? Center(child: IsLoad())
            : RefreshIndicator(
                onRefresh: () {
                  return ServerProvider.instance.getMySpecialists();
                },
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      if (appGet.mySpecialists['data'].length == 0)
                        Expanded(child: Container())
                      else
                        Expanded(
                          child: Container(
                            child: ListView.separated(
                              shrinkWrap: true,
                              primary: false,
                              padding: EdgeInsets.all(0),
                              itemCount: appGet.mySpecialists['data'].length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 2.h),
                                  child: Container(
                                    height: 105.h,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        // boxShadow: sShadow2,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10)),
                                        border: Border.all(
                                          color: Color(0xffEFE0E4),
                                        )),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: appGet.mySpecialists['data']
                                                      [index]['image_url'] ==
                                                  null
                                              ? Image.asset(
                                                  "assets/images/logo.png",
                                                  height: 131.h,
                                                  width: 131.w,
                                                )
                                              : CustomerImageNetwork(
                                                  appGet.mySpecialists['data']
                                                      [index]['image_url'],
                                                  180.h,
                                                  100.w,
                                                  50,
                                                  circle: true,
                                                ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: CustomText(
                                                        text: appGet.mySpecialists[
                                                                        'data']
                                                                    [index]
                                                                ['name'] ??
                                                            "",
                                                        color: AppColors.kBlack,
                                                        fontSize: 22.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    // Transform.translate(
                                                    //   offset: Offset(10, 6),
                                                    //   child: CustomText(
                                                    //     text: appGet.myServices[
                                                    //                 'data'][index]
                                                    //             ['time_needed'] ??
                                                    //         "" + " m",
                                                    //     color: AppColors.primary,
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () => showDialog(
                                            context: context,
                                            builder: (context) =>
                                                CustomDialogBox(
                                              "Do you want to select a Spechlist?"
                                                  .tr,
                                              onPress: () => ServerProvider
                                                  .instance
                                                  .setSpashlistCancel(appGet
                                                          .mySpecialists['data']
                                                      [index]['id']),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  height: 10,
                                );
                              },
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                          ),
                          child: SizedBox(
                            height: 45.h,
                            child: FlatButton(
                              splashColor: Colors.green,
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(100),
                              ),
                              padding: EdgeInsets.all(0),
                              onPressed: () =>
                                  //     ServerProvider.instance.setAddSpecialists(
                                  //   name: "_titleController.text",
                                  // ),
                                  //  photo: appGet.spechlistImage

                                  showMaterialModalBottomSheet(
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                      ),
                                      context: context,
                                      builder: (context) =>
                                          AddSspechlistSheet()),
                              color: AppColors.primary,
                              child: Center(
                                child: CustomText(
                                  text: '+' + "Add More".tr,
                                  fontSize: 22.sp,
                                  color: AppColors.primary20,
                                ),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 20.h,
                      ),
                      widget.index == 2
                          ? Container()
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 20.h,
                              ),
                              child: Container(
                                width: 200.w,
                                child: CustomButton(
                                  onPress: () async {
                                    await SPHelper.spHelper.setOnBoarding(true);

                                    Get.off(() => MainScreen());
                                  },
                                  text: 'Next'.tr,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
