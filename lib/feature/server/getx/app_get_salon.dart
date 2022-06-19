import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salon_provider/feature/values/constant.dart';
// import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class AppGet extends GetxController {
  SimpleFontelicoProgressDialog dialog = SimpleFontelicoProgressDialog(
      context: Get.context, barrierDimisable: false);
  int indexNav = 1;
  String token;
  String fcmToken = '';
  String name;
  String code;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  var totalPrice = 0.obs;
  var totalAll = 0.obs;
  int type = 1;
  int cityId = 0;
  var filename = "".obs;
  var indexCity = 0.obs;
  // String address;
  var phoneNumber = "".obs;
  var password = "".obs;
  Rx<TextEditingController> aboutController = TextEditingController().obs;
  RxMap salonById = Map().obs;

  RxMap salonByIdGralley = Map().obs;
  RxMap salonByIdReviews = Map().obs;
  RxMap salonByIdService = Map().obs;
  var acceptTerms = false.obs;
  RxMap services = Map().obs;
  RxMap myServices = Map().obs;
  RxString data = "0".obs;

  var products = {}.obs;
  var myBookings = {}.obs;
  var mySpecialists = {}.obs;
  var archiveVisits = {}.obs;
  var slider = {}.obs;
  var bookingDetails = {}.obs;
  var userProfil = {}.obs;
  var search = {}.obs;
  List<int> extraService = [];
  List<int> service = [];
  var myChats = {}.obs;

  var hoursAvailableInDate = {}.obs;

  var enabled = false.obs;
  var address = ''.obs;
  var character;
  var cities = {}.obs;
  var categories = {}.obs;
  var fav = {}.obs;
  var availableInDate = {}.obs;
  File file;
  var dataTime = DateTime.now().obs;
  var regiserImages = <File>[].obs;
  RxMap notifiaction = {}.obs;

  File logoImage;
  File backgroundImage;
  File spechlistImage;
  Rx<TextEditingController> textEditingController = TextEditingController().obs;

  getUser(Map map) {
    this.userProfil.value = map;
  }

  changeAcceptTerms(bool value) {
    this.acceptTerms.value = value;
  }

  setindexNav(indexNav) {
    this.indexNav = indexNav;
    update();
  }

  setData(String data) {
    this.data.value = data;
  }

  setCharacter(character) {
    this.character = character;

    update();
  }

  setAvailableInDate(Map map) {
    this.availableInDate.value = map;
  }

  getMyChats(Map map) {
    this.myChats.value = map;
  }

  getMyNotification(Map map) {
    this.notifiaction.value = map;
  }

  setCode(String code) {
    this.code = code;
    update();
  }

  getBookingDetails(Map map) {
    this.bookingDetails.value = map;
  }

  setHoursAvailableInDate(Map map) {
    this.hoursAvailableInDate.value = map;
  }

  saveAddress(String value) {
    this.address.value = value;
  }

  setService(int index, int id) {
    if (service.contains(id)) {
      print(service);
    } else {
      this.service.add(id);
      print(service);

      update();
    }
  }

  removeService(int index, int id) {
    int idCategories = this.service.indexOf(id);
    this.service.removeAt(idCategories);
    update();
  }

  setExtraService(int index, int id) {
    if (extraService.contains(id)) {
      print(extraService);
    } else {
      this.extraService.add(id);
      print(extraService);

      update();
    }
  }

  removeExtraService(int index, int id) {
    int idCategories = this.extraService.indexOf(id);
    this.extraService.removeAt(idCategories);
    update();
  }

  setTotalePrice(int price) {
    this.totalPrice.value = this.totalPrice.value + price;
  }

  setdeletTotalePrice(int price) {
    this.totalPrice.value = this.totalPrice.value - price;
  }

  setTotaleAll(int priceholl) {
    this.totalAll.value = this.totalPrice.value + priceholl;
  }

  getMyServices(Map map) {
    this.myServices.value = map;
  }

  setServices(Map map) {
    this.services.value = map;
  }

  getProducts(Map map) {
    this.products.value = map;
  }

  getCities(Map map) {
    this.cities.value = map;
  }

  getMyBookings(Map map) {
    this.myBookings.value = map;
  }

  getMySpecialists(Map map) {
    this.mySpecialists.value = map;
  }

  getSearch(Map map) {
    this.search.value = map;
  }

  getArchiveVisits(Map map) {
    this.archiveVisits.value = map;
  }

  getSliders(Map map) {
    this.slider.value = map;
  }

  setToken(String token) {
    this.token = token;
  }

  setCityId(int cityId) {
    this.cityId = cityId;
    update();
  }

  setFile(file) {
    this.file = null;
    update();
  }

  // Future getImage(ImageSource source) async {
  //   final picker = ImagePicker();

  //   final pickedFile = await picker.getImage(source: source, imageQuality: 20);

  //   if (pickedFile != null) {
  //     imageFile = File(pickedFile.path);
  //     regiserImages.add(imageFile);

  //     update();
  //   } else {
  //     imageFile = null;
  //   }
  // }

  // List<Asset> images = <Asset>[];
  // List<Asset> images2 = <Asset>[];
  // List<Asset> salonImage = <Asset>[];
  // List<Asset> serviceImage = <Asset>[];
  // RxList listServicesHome = [].obs;
  // RxList listServices = [].obs;

  // Future<void> loadAssets(int maxImages, List<Asset> resultList) async {
  //   List<Asset> result = await MultiImagePicker.pickImages(
  //     maxImages: maxImages,
  //     enableCamera: true,
  //     selectedAssets: images,
  //     // cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
  //     materialOptions: MaterialOptions(
  //       // actionBarColor: "#abcdef",
  //       actionBarTitle: "App",
  //       allViewTitle: "All Photos",
  //       useDetailsView: false,
  //       selectCircleStrokeColor: "#000000",
  //     ),
  //   );
  //   resultList.addAll(result);

  //   update(["result"]);
  // }

  // Future getProfileImage() async {
  //   final picker = ImagePicker();
  //   final pickedFile =
  //       await picker.getImage(source: ImageSource.gallery, imageQuality: 20);

  //   if (pickedFile != null) {
  //     photoFile = File(pickedFile.path);
  //     ServerAuth.serverAuth.editPhotoProfile(name, photoFile.path);
  //     update();
  //   } else {
  //     logoImage = null;
  //   }
  // }

  Future<File> imagePickerCropImage(int i) async {
    File croppedFile;
    XFile pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    try {
      if (pickedFile != null) {
        croppedFile = await ImageCropper().cropImage(
            sourcePath: pickedFile.path,
            aspectRatio: i == 2
                ? CropAspectRatio(ratioX: 6, ratioY: 10)
                : CropAspectRatio(ratioX: 0.5, ratioY: 0.5),
            cropStyle: i == 3 ? CropStyle.circle : CropStyle.rectangle,
            aspectRatioPresets: Platform.isAndroid
                ? [
                    CropAspectRatioPreset.square,
                    CropAspectRatioPreset.ratio3x2,
                    CropAspectRatioPreset.original,
                    CropAspectRatioPreset.ratio4x3,
                    CropAspectRatioPreset.ratio16x9
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
            ]) as File;
      }
      return croppedFile;
    } catch (e) {
      return null;
    }
  }

  addImageProfile(int i) async {
    try {
      File croppedFile = await imagePickerCropImage(i);
      if (croppedFile != null) {
        switch (i) {
          case 1:
            logoImage = croppedFile;
            setToast(croppedFile.path.toString(), Colors.red);

            break;
          case 2:
            backgroundImage = croppedFile;

            break;
          case 3:
            spechlistImage = croppedFile;

            break;
          default:
        }
        // update(['logo']);
      }
    } catch (e) {}
  }
}
