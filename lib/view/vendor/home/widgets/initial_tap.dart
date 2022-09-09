import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/view/widgets/custom_bottom_sheet.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

class InitialTap extends StatelessWidget {
  const InitialTap({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText(
            'Mmb Tech is now open guests on baharfun.com',
            alignment: AlignmentDirectional.center,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 5.h),
          CustomText(
            'هذا هو المكان الذي يمكنك فيه إدارة كل جانب من جوانب مكانك من المعلومات التي يراها الضيوف يمكنك العثور على المهام الأساسية لإكمال كل مهمة هو شيء نعلم أنه يساعد مالكي العقارات مثلك للحصول على طلبك الأول بشكل أسرع',
            maxLines: 10,
            fontSize: 10,
            textAlign: TextAlign.center,
            fontColor: AppColors.fontSecondaryColor,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 25.h),
          Icon(
            Icons.thumb_up_alt,
            color: AppColors.primaryColor,
            size: 60.r,
          ),
          SizedBox(height: 25.h),
          Container(
            width: 324.w,
            height: 122.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              image: DecorationImage(
                image: AssetImage(
                  Assets.getImage('bg'),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 45.h),
          InkWell(
            onTap: () {
              //Get.to(SubmitRequestScreen());
            },
            borderRadius: BorderRadius.circular(15.r),
            child: Container(
              width: double.infinity,
              padding: EdgeInsetsDirectional.all(15.r),
              decoration: BoxDecoration(
                color: Color(0xffF6F6F7),
                boxShadow: AppColors.boxShadow,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Assets.getIconSvg('order'),
                        fit: BoxFit.contain,
                        width: 30.r,
                        height: 30.r,
                      ),
                      SizedBox(width: 5.w),
                      CustomText(
                        'طلبك حسب ميزانيتك',
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  CustomText(
                    'هنا يكون وصف خاص لخدمه طلبك حسب ميزانيتك',
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    fontSize: 12,
                    fontColor: AppColors.fontSecondaryColor,
                  ),
                  InkWell(
                    onTap: () {
                      customBottomSheet(
                        widget: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomText(
                              'طلبك حسب ميزانيتك',
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: 5.h),
                            CustomText(
                              'مرحباً بك في التطبيق:',
                              alignment: AlignmentDirectional.centerStart,
                              fontColor: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: 5.h),
                            CustomText(
                              'هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص أو شكل توضع الفقرات في الصفحة التي يقرأها. ولذلك يتم استخدام طريقة لوريم إيبسوم لأنها تعطي توزيعاَ طبيعياَ -إلى حد ما- للأحرف عوضاً عن استخدام "هنا يوجد محتوى نصي، هنا يوجد محتوى نصي" فتجعلها تبدو (أي الأحرف) وكأنها نص مقروء.',
                              maxLines: 9,
                              fontSize: 12,
                            ),
                          ],
                        ),
                      );
                    },
                    child: CustomText(
                      'اقراء المزيد',
                      textAlign: TextAlign.center,
                      fontSize: 12,
                      fontColor: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      isUnderline: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
