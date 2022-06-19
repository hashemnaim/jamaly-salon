import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:salon_provider/feature/server/getx/app_get_salon.dart';
import 'package:salon_provider/feature/server/service/server_salon.dart';
import 'package:salon_provider/feature/values/colors.dart';
import 'package:salon_provider/feature/view/widgets/custom_button.dart';
import 'package:salon_provider/feature/view/widgets/custom_dialog_box.dart';
import 'package:salon_provider/feature/view/widgets/custom_image_Network.dart';
import 'package:salon_provider/feature/view/widgets/custom_text.dart';
import 'package:salon_provider/feature/view/widgets/home_category_item.dart';
import 'package:salon_provider/feature/view/widgets/isload.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../server/helper/sp_helpar.dart';
import '../widgets/addServiceSheet.dart';
import 'addSpashlist.dart';

class AddService extends StatefulWidget {
  final int index;

  const AddService({Key key, this.index = 1}) : super(key: key);

  @override
  _ServesScreenState createState() => _ServesScreenState();
}

class _ServesScreenState extends State<AddService> {
  final AppGet appGet = Get.find();
  int currnt = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // shadowColor: Colors.transparent,
        toolbarHeight: 40.h,
        title: CustomText(
          text: "My Services".tr,
          color: AppColors.primary,
          fontSize: 18,
        ),
        centerTitle: true,
        leading: Container(),
        actions: [
          widget.index == 2
              ? Directionality(
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
              : InkWell(
                  onTap: () {
                    Get.off(() => AddSpecialists());
                  },
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: CustomText(
                          text: "Skip",
                          color: AppColors.primary,
                        ),
                      )),
                ),
        ],
      ),
      body: Obx(
        () => appGet.services.isEmpty
            ? Center(child: IsLoad())
            : RefreshIndicator(
                onRefresh: () {
                  appGet.myServices.clear();

                  return ServerProvider.instance.getMyServices(currnt);
                },
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: ((appGet.services["data"].length / 4).ceil() *
                            120.h),
                        child: GridView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: appGet.services["data"].length ?? 0,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4, mainAxisSpacing: 4.h),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                currnt = index;
                                appGet.myServices.clear();
                                ServerProvider.instance.getMyServices(
                                    appGet.services["data"][index]["id"]);

                                setState(() {});
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: currnt == index
                                          ? AppColors.primary
                                          : Colors.grey[12]),
                                  child: HomeCategoryItem(
                                    color: currnt == index
                                        ? Colors.white
                                        : Colors.grey[12],
                                    // index:currnt,
                                    imageName: appGet.services["data"][index]
                                        ["image_url"],

                                    title: appGet.services["data"][index]
                                        ["name"],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                          ),
                          child: SizedBox(
                            height: 40.h,
                            child: FlatButton(
                              splashColor: Colors.green,
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(100),
                              ),
                              padding: EdgeInsets.all(0),
                              onPressed: () => showMaterialModalBottomSheet(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  context: context,
                                  builder: (context) => AddServiceSheet(
                                      title: appGet.services["data"][currnt]
                                          ["name"],
                                      id: appGet.services["data"][currnt]
                                          ["id"])),
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
                        height: 10,
                      ),
                      appGet.myServices.isEmpty
                          ? Expanded(child: IsLoad())
                          : appGet.myServices['data'].length == 0
                              ? Container()
                              : Expanded(
                                  child: Container(
                                    height: 300,
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      primary: false,
                                      padding: EdgeInsets.all(0),
                                      itemCount:
                                          appGet.myServices['data'].length,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index2) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 2.h),
                                          child: Container(
                                            // height: 145,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                // boxShadow: sShadow2,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10)),
                                                border: Border.all(
                                                  color: Color(0xffEFE0E4),
                                                )),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: appGet.myServices[
                                                                      'data']
                                                                  [index2]
                                                              ['image_url'] ==
                                                          null
                                                      ? Image.asset(
                                                          "assets/images/logo.png",
                                                          height: 131.h,
                                                          width: 131.w,
                                                        )
                                                      : CustomerImageNetwork(
                                                          appGet.myServices[
                                                                      'data']
                                                                  [index2]
                                                              ['image_url'],
                                                          100.h,
                                                          100.w,
                                                          10,
                                                          circle: false,
                                                        ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            CustomText(
                                                              text: appGet.myServices[
                                                                              'data']
                                                                          [
                                                                          index2]
                                                                      [
                                                                      'name'] ??
                                                                  "",
                                                              color: AppColors
                                                                  .kBlack,
                                                              fontSize: 22.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        CustomText(
                                                          text: "Price".tr +
                                                                  " :" +
                                                                  " " +
                                                                  appGet
                                                                      .myServices[
                                                                          'data']
                                                                          [
                                                                          index2]
                                                                          [
                                                                          'price']
                                                                      .toString() +
                                                                  " AED" ??
                                                              "",
                                                          color:
                                                              AppColors.kBlack,
                                                        ),
                                                        CustomText(
                                                          text: appGet.myServices[
                                                                          'data']
                                                                      [index2]
                                                                  ['details'] ??
                                                              "",
                                                          color:
                                                              AppColors.kBlack,
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
                                                      "Do You Want to Select a Service?"
                                                          .tr,
                                                      onPress: () => ServerProvider
                                                          .instance
                                                          .setServiceCancel(
                                                              appGet.services[
                                                                      'data'][
                                                                  currnt]['id'],
                                                              appGet.myServices[
                                                                          'data']
                                                                      [index2]
                                                                  ['id']),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
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
                      widget.index == 2
                          ? Container()
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 20.h,
                              ),
                              child: Container(
                                width: 200,
                                child: CustomButton(
                                  onPress: () {
                                    Get.off(() => AddSpecialists());
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
