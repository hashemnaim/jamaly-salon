class ProfileModel {
  int code;
  bool status;
  String message;
  ProfileModelData data;

  ProfileModel({this.code, this.status, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new ProfileModelData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class ProfileModelData {
  var id;
  var name;
  var email;
  var mobile;
  var type;
  var location;
  var photo;
  var facebook;
  var rate;
  var categoryId;
  var verifyMobileCode;
  var activeMobile;
  var emailVerifiedAt;
  var locationLong;
  var locationLat;
  var createdAt;
  var updatedAt;

  ProfileModelData(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.type,
      this.location,
      this.photo,
      this.facebook,
      this.rate,
      this.categoryId,
      this.verifyMobileCode,
      this.activeMobile,
      this.emailVerifiedAt,
      this.locationLong,
      this.locationLat,
      this.createdAt,
      this.updatedAt});

  ProfileModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    type = json['type'];
    location = json['location'];
    photo = json['photo'];
    facebook = json['facebook'];
    rate = json['rate'];
    categoryId = json['category_id'];
    verifyMobileCode = json['verify_mobile_code'];
    activeMobile = json['active_mobile'];
    emailVerifiedAt = json['email_verified_at'];
    locationLong = json['location_long'];
    locationLat = json['location_lat'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['type'] = this.type;
    data['location'] = this.location;
    data['photo'] = this.photo;
    data['facebook'] = this.facebook;
    data['rate'] = this.rate;
    data['category_id'] = this.categoryId;
    data['verify_mobile_code'] = this.verifyMobileCode;
    data['active_mobile'] = this.activeMobile;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['location_long'] = this.locationLong;
    data['location_lat'] = this.locationLat;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
