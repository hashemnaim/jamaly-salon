import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:yacht_booking/models/gallary_vendor_model.dart';
import 'package:yacht_booking/models/home_statistic_model.dart';
import 'package:yacht_booking/models/myOffer.dart';
import 'package:yacht_booking/models/my_ship_model.dart';
import 'package:yacht_booking/models/notification_model.dart';
import 'package:yacht_booking/models/order_details_vendor.dart';
import 'package:yacht_booking/models/plan_model.dart';
import 'package:yacht_booking/models/recieved_order.dart';
import 'package:yacht_booking/models/request_details_model.dart';
import 'package:yacht_booking/models/review_vendor_model.dart';
import 'package:yacht_booking/models/service_vendor_model.dart';
import 'package:yacht_booking/models/sub_services_vendor.dart';

class HomeVendorController extends GetxController {
  Rx<RecevedOrder> recevedOrderData = RecevedOrder().obs;
  Rx<HomeStatstic> homeStatsticData = HomeStatstic().obs;
  Rx<ReviewVendor> getReviewData = ReviewVendor().obs;
  Rx<GallaryVendor> getGallaryVendorData = GallaryVendor().obs;
  Rx<MyShipModel> getMyShipData = MyShipModel().obs;
  Rx<MyOfferModel> getMyOfferData = MyOfferModel().obs;
  Rx<OrderDetailsVendor> orderDetailsVendorData = OrderDetailsVendor().obs;
  Rx<ServiceVendorModel> getVendorServicesData = ServiceVendorModel().obs;
  Rx<SubServiceVendorModel> getVendorSubServicesData =
      SubServiceVendorModel().obs;
  Rx<RequestDetailsModel> getRequestDetailsData = RequestDetailsModel().obs;
  Rx<NotificationModel> getNotificationsData = NotificationModel().obs;
  Rx<PlanModel> getPlansData = PlanModel().obs;

  RxInt filterIndex = 4.obs;
  ImagePicker imagePicker = ImagePicker();
  List<XFile> imageList = [];
  List<XFile> imageListOrder = [];

  selectImage() async {
    final XFile selectImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (selectImage.path.isNotEmpty) {
      imageList.add(selectImage);
    }
    update();

    return selectImage;
  }

  removeImage(int index) {
    imageList.removeAt(index);
    update(['images']);
  }

  removeImageOrder(int index) {
    imageListOrder.removeAt(index);
    update(['imagesOrder']);
  }

  clearImage() {
    imageList.clear();
    imageListOrder.clear();
    update(['imagesOrder']);
    update(['images']);
  }
}
