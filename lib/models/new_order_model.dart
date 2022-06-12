class NewOrderModel {
  int code;
  bool status;
  String message;
  List<NewOrders> newOrders;
  List<OldOrders> oldOrders;

  NewOrderModel(
      {this.code, this.status, this.message, this.newOrders, this.oldOrders});

  NewOrderModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    if (json['new_orders'] != null) {
      newOrders = <NewOrders>[];
      json['new_orders'].forEach((v) {
        newOrders.add(new NewOrders.fromJson(v));
      });
    }
    if (json['old_orders'] != null) {
      oldOrders = <Null>[];
      json['old_orders'].forEach((v) {
        oldOrders.add(new OldOrders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.newOrders != null) {
      data['new_orders'] = this.newOrders.map((v) => v.toJson()).toList();
    }
    if (this.oldOrders != null) {
      data['old_orders'] = this.oldOrders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NewOrders {
  var id;
  var userId;
  var ownerId;
  var shipId;
  var mobile;
  var paymentMethod;
 var from;
  var to;
  var date;
  var price;
  var duration;
  var numberOfPersones;
  var status;
  var createdAt;
  var updatedAt;
  Owner owner;

  NewOrders(
      {this.id,
      this.userId,
      this.ownerId,
      this.shipId,
      this.mobile,
      this.paymentMethod,
      this.from,
      this.to,
      this.date,
      this.price,
      this.duration,
      this.numberOfPersones,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.owner});

  NewOrders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    ownerId = json['owner_id'];
    shipId = json['ship_id'];
    mobile = json['mobile'];
    paymentMethod = json['payment_method'];
    from = json['from'];
    to = json['to'];
    date = json['date'];
    price = json['price'];
    duration = json['duration'];
    numberOfPersones = json['number_of_persones'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['owner_id'] = this.ownerId;
    data['ship_id'] = this.shipId;
    data['mobile'] = this.mobile;
    data['payment_method'] = this.paymentMethod;
    data['from'] = this.from;
    data['to'] = this.to;
    data['date'] = this.date;
    data['price'] = this.price;
    data['duration'] = this.duration;
    data['number_of_persones'] = this.numberOfPersones;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.owner != null) {
      data['owner'] = this.owner.toJson();
    }
    return data;
  }
}

class OldOrders {
  var id;
  var userId;
  var ownerId;
  var shipId;
  var mobile;
  var paymentMethod;
 var from;
  var to;
  var date;
  var price;
  var duration;
  var numberOfPersones;
  var status;
  var createdAt;
  var updatedAt;
  Owner owner;

  OldOrders(
      {this.id,
      this.userId,
      this.ownerId,
      this.shipId,
      this.mobile,
      this.paymentMethod,
      this.from,
      this.to,
      this.date,
      this.price,
      this.duration,
      this.numberOfPersones,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.owner});

  OldOrders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    ownerId = json['owner_id'];
    shipId = json['ship_id'];
    mobile = json['mobile'];
    paymentMethod = json['payment_method'];
    from = json['from'];
    to = json['to'];
    date = json['date'];
    price = json['price'];
    duration = json['duration'];
    numberOfPersones = json['number_of_persones'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['owner_id'] = this.ownerId;
    data['ship_id'] = this.shipId;
    data['mobile'] = this.mobile;
    data['payment_method'] = this.paymentMethod;
    data['from'] = this.from;
    data['to'] = this.to;
    data['date'] = this.date;
    data['price'] = this.price;
    data['duration'] = this.duration;
    data['number_of_persones'] = this.numberOfPersones;
    data['status'] = this.status;
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
