import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/apis/home_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/view/user/company_details/company_details_screen.dart';
import 'package:yacht_booking/models/favorite_model.dart';
import 'package:yacht_booking/view/widgets/cash_network_image_share.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';
import 'package:yacht_booking/view/widgets/icon_row.dart';
import 'package:yacht_booking/view/widgets/svg_row.dart';

class FavoriteCardVendor extends StatelessWidget {
  final FavoriteModelData favoriteModelData;

  const FavoriteCardVendor({this.favoriteModelData});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        HomeUserApis.homeUserApis
            .getOwnerDetails(favoriteModelData.vendorId.toString());
        Get.to(() => CompanyDetailsScreen());
      },
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: double.infinity,
        height: 110.h,
        padding: EdgeInsetsDirectional.all(8.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.white,
          border: Border.all(width: 2.w, color: const Color(0xffe9e9ec)),
        ),
        child: Row(
          children: [
            Container(
              width: 85.w,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(15.r),
                // image: DecorationImage(
                //   image: AssetImage(Assets.getImage('bg')),
                //   fit: BoxFit.cover,
                // ),
              ),
              child: favoriteModelData.vendors == null ||
                      favoriteModelData.vendors.photo == null
                  ? SizedBox()
                  : CachedNetworkImageShare(
                      favoriteModelData.vendors.photo, 110.h, 85.w, 15),
            ),
            SizedBox(width: 5.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconRow(
                        Icons.person,
                        '${favoriteModelData.vendors.name ?? ""}',
                      ),
                      IconRow(
                        Icons.star,
                        favoriteModelData.vendors == null
                            ? "0"
                            : '${favoriteModelData.vendors.rate ?? "0"}',
                        iconColor: AppColors.yellow,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  IconRow(
                    Icons.location_on,
                    favoriteModelData.vendors == null
                        ? ""
                        : '${favoriteModelData.vendors.location ?? ""}',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(2.r),
                        child: Icon(
                          Icons.phone,
                          size: 17.r,
                          color: Colors.black,
                        ),
                      ),
                      CustomText(
                        '${favoriteModelData.vendors.mobile}',
                        fontColor: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        textAlign: TextAlign.start,
                        alignment: AlignmentDirectional.centerStart,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(2.r),
                        child: Icon(
                          Icons.email_rounded,
                          size: 17.r,
                          color: Colors.black,
                        ),
                      ),
                      CustomText(
                        '${favoriteModelData.vendors.email}',
                        fontColor: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        textAlign: TextAlign.start,
                        alignment: AlignmentDirectional.centerStart,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
