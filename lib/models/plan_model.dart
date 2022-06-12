class PlanModel {
  int code;
  bool status;
  String message;
  List<PlanModelData> data;
  CurrentPlan currentPlan;

  PlanModel(
      {this.code, this.status, this.message, this.data, this.currentPlan});

  PlanModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PlanModelData>[];
      json['data'].forEach((v) {
        data.add(new PlanModelData.fromJson(v));
      });
    }
    currentPlan = json['current_plan'] != null
        ? new CurrentPlan.fromJson(json['current_plan'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.currentPlan != null) {
      data['current_plan'] = this.currentPlan.toJson();
    }
    return data;
  }
}

class PlanModelData {
  var id;
  var name;
  var details;
  var price;
  var createdAt;
  var updatedAt;

  PlanModelData(
      {this.id,
      this.name,
      this.details,
      this.price,
      this.createdAt,
      this.updatedAt});

  PlanModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    details = json['details'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['details'] = this.details;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class CurrentPlan {
  var id;
  var planId;
  var ownerId;
  var startDate;
  var endDate;
  var createdAt;
  var updatedAt;
  PlanModelData plan;
  Owner owner;

  CurrentPlan(
      {this.id,
      this.planId,
      this.ownerId,
      this.startDate,
      this.endDate,
      this.createdAt,
      this.updatedAt,
      this.plan,
      this.owner});

  CurrentPlan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    planId = json['plan_id'];
    ownerId = json['owner_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    plan = json['plan'] != null ? new PlanModelData.fromJson(json['plan']) : null;
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['plan_id'] = this.planId;
    data['owner_id'] = this.ownerId;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.plan != null) {
      data['plan'] = this.plan.toJson();
    }
    if (this.owner != null) {
      data['owner'] = this.owner.toJson();
    }
    return data;
  }
}

class Owner {
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
  var available;
  var country;
  var fcmToken;
  var createdAt;
  var updatedAt;
  var typeAdmin;

  Owner(
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
      this.available,
      this.country,
      this.fcmToken,
      this.createdAt,
      this.updatedAt,
      this.typeAdmin});

  Owner.fromJson(Map<String, dynamic> json) {
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
    available = json['available'];
    country = json['country'];
    fcmToken = json['fcm_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeAdmin = json['type_admin'];
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
    data['available'] = this.available;
    data['country'] = this.country;
    data['fcm_token'] = this.fcmToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['type_admin'] = this.typeAdmin;
    return data;
  }
}
