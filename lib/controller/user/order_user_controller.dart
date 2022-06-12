import 'package:get/get.dart';
import 'package:yacht_booking/models/order_details_model.dart';
import 'package:yacht_booking/models/order_offer_model.dart';
import 'package:yacht_booking/models/orders_model.dart';

class OrderUserController extends GetxController {
  Rx<OrdersModel> getOrdersUserData = OrdersModel().obs;
  Rx<OrderOfferModel> orderOffersData = OrderOfferModel().obs;
  Rx<OwnerDetailsModel> getOwnerData = OwnerDetailsModel().obs;
}
