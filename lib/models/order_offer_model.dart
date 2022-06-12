class OrderOfferModel {
  int code;
  bool status;
  String message;
  List<OrderOfferModelData> data;

  OrderOfferModel({this.code, this.status, this.message, this.data});

  OrderOfferModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <OrderOfferModelData>[];
      json['data'].forEach((v) {
        data.add(new OrderOfferModelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderOfferModelData {
  var id;
  var userId;
  var mobile;
  var serviceId;
 var shipId;
  var ownerId;
  var duration;
  var from;
  var to;
 var numberOfPersones;
  var date;
  var price;
  var notes;
 var status;
  var createdAt;
  var updatedAt;
  var myOffersCount;
  User user;
  List<MyOffers> myOffers;

  OrderOfferModelData(
      {this.id,
      this.userId,
      this.mobile,
      this.serviceId,
      this.shipId,
      this.ownerId,
      this.duration,
      this.from,
      this.to,
      this.numberOfPersones,
      this.date,
      this.price,
      this.notes,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.myOffersCount,
      this.user,
      this.myOffers});

  OrderOfferModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    mobile = json['mobile'];
    serviceId = json['service_id'];
    shipId = json['ship_id'];
    ownerId = json['owner_id'];
    duration = json['duration'];
    from = json['from'];
    to = json['to'];
    numberOfPersones = json['number_of_persones'];
    date = json['date'];
    price = json['price'];
    notes = json['notes'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    myOffersCount = json['my_offers_count'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['my_offers'] != null) {
      myOffers = <MyOffers>[];
      json['my_offers'].forEach((v) {
        myOffers.add(new MyOffers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['mobile'] = this.mobile;
    data['service_id'] = this.serviceId;
    data['ship_id'] = this.shipId;
    data['owner_id'] = this.ownerId;
    data['duration'] = this.duration;
    data['from'] = this.from;
    data['to'] = this.to;
    data['number_of_persones'] = this.numberOfPersones;
    data['date'] = this.date;
    data['price'] = this.price;
    data['notes'] = this.notes;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['my_offers_count'] = this.myOffersCount;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.myOffers != null) {
      data['my_offers'] = this.myOffers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
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
  var createdAt;
  var updatedAt;

  User(
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
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
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
    data['available'] = this.available;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class MyOffers {
  var id;
  var orderRequestId;
  var ownerId;
  var available;
  var message;
  var price;
  var createdAt;
 var updatedAt;
  Owner owner;

  MyOffers(
      {this.id,
      this.orderRequestId,
      this.ownerId,
      this.available,
      this.message,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.owner});

  MyOffers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderRequestId = json['order_request_id'];
    ownerId = json['owner_id'];
    available = json['available'];
    message = json['message'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_request_id'] = this.orderRequestId;
    data['owner_id'] = this.ownerId;
    data['available'] = this.available;
    data['message'] = this.message;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
  var createdAt;
 var updatedAt;

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
      this.createdAt,
      this.updatedAt});

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
    data['available'] = this.available;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
