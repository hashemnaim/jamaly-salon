class OrderDetailsVendor {
  int code;
  bool status;
  String message;
  OrderDetailsVendorData data;

  OrderDetailsVendor({this.code, this.status, this.message, this.data});

  OrderDetailsVendor.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new OrderDetailsVendorData.fromJson(json['data']) : null;
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

class OrderDetailsVendorData {
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
  var notes;
  var createdAt;
  var updatedAt;
  User user;
  Owner owner;
  Ship ship;

  OrderDetailsVendorData(
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
      this.notes,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.owner,
      this.ship});

  OrderDetailsVendorData.fromJson(Map<String, dynamic> json) {
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
    notes = json['notes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    ship = json['ship'] != null ? new Ship.fromJson(json['ship']) : null;
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
    data['notes'] = this.notes;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.owner != null) {
      data['owner'] = this.owner.toJson();
    }
    if (this.ship != null) {
      data['ship'] = this.ship.toJson();
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
  var country;
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
      this.country,
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
    country = json['country'];
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
    data['country'] = this.country;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
      this.country,
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
    country = json['country'];
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
    data['country'] = this.country;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Ship {
  var id;
  var title;
  var description;
  var image;
  var ownerId;
  var prepaid;
  var offer;
  var rate;
  var price;
  var country;
  var locationLong;
  var locationLat;
  var createdAt;
  var updatedAt;
  var dayPrice;

  Ship(
      {this.id,
      this.title,
      this.description,
      this.image,
      this.ownerId,
      this.prepaid,
      this.offer,
      this.rate,
      this.price,
      this.country,
      this.locationLong,
      this.locationLat,
      this.createdAt,
      this.updatedAt,
      this.dayPrice});

  Ship.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    ownerId = json['owner_id'];
    prepaid = json['prepaid'];
    offer = json['offer'];
    rate = json['rate'];
    price = json['price'];
    country = json['country'];
    locationLong = json['location_long'];
    locationLat = json['location_lat'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    dayPrice = json['day_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['owner_id'] = this.ownerId;
    data['prepaid'] = this.prepaid;
    data['offer'] = this.offer;
    data['rate'] = this.rate;
    data['price'] = this.price;
    data['country'] = this.country;
    data['location_long'] = this.locationLong;
    data['location_lat'] = this.locationLat;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['day_price'] = this.dayPrice;
    return data;
  }
}
