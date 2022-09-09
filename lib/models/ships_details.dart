class ShipsDetailsModel {
  var code;
  bool status;
  String message;
  ShipsDetailsModelData data;

  ShipsDetailsModel({this.code, this.status, this.message, this.data});

  ShipsDetailsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? new ShipsDetailsModelData.fromJson(json['data'])
        : null;
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

class ShipsDetailsModelData {
  var id;
  var title;
  var description;
  var image;
  var ownerId;
  var prepaid;
  var offer;
  var rate;
  var price;
  var price_for;
  var country;
  var locationLong;
  var locationLat;
  var createdAt;
  var updatedAt;
  var isFavourite;
  var notes;
  var number_of_persones;
  var start_date;
  var end_date;
  Owner owner;
  List<Galary> gallary;
  List<ServicesShip> servicesShip;

  ShipsDetailsModelData(
      {this.id,
      this.title,
      this.description,
      this.image,
      this.ownerId,
      this.prepaid,
      this.offer,
      this.rate,
      this.price,
      this.price_for,
      this.country,
      this.notes,
      this.locationLong,
      this.locationLat,
      this.createdAt,
      this.updatedAt,
      this.isFavourite,
      this.owner,
      this.gallary,
      this.servicesShip});

  ShipsDetailsModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    ownerId = json['owner_id'];
    prepaid = json['prepaid'];
    notes = json['notes'];
    offer = json['offer'];
    rate = json['rate'];
    number_of_persones = json['number_of_persones'];
    start_date = json['start_date'];
    end_date = json['end_date'];
    price = json['price'];
    price_for = json['price_for'];
    country = json['country'];
    locationLong = json['location_long'];
    locationLat = json['location_lat'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isFavourite = json['is_favourite'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    if (json['gallary'] != null) {
      gallary = new List<Null>();
      json['gallary'].forEach((v) {
        // gallary.add(new Galary.fromJson(v));
      });
    }
    if (json['services_ship'] != null) {
      servicesShip = new List<ServicesShip>();
      json['services_ship'].forEach((v) {
        servicesShip.add(new ServicesShip.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['notes'] = this.notes;
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
    data['is_favourite'] = this.isFavourite;
    if (this.owner != null) {
      data['owner'] = this.owner.toJson();
    }
    // if (this.gallary != null) {
    //   data['gallary'] = this.gallary.map((v) => v.toJson()).toList();
    // }
    if (this.servicesShip != null) {
      data['services_ship'] = this.servicesShip.map((v) => v.toJson()).toList();
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

class ServicesShip {
  var id;
  var serviceId;
  var shipId;
  var createdAt;
  var updatedAt;
  Services services;

  ServicesShip(
      {this.id,
      this.serviceId,
      this.shipId,
      this.createdAt,
      this.updatedAt,
      this.services});

  ServicesShip.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceId = json['service_id'];
    shipId = json['ship_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    services = json['services'] != null
        ? new Services.fromJson(json['services'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_id'] = this.serviceId;
    data['ship_id'] = this.shipId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.services != null) {
      data['services'] = this.services.toJson();
    }
    return data;
  }
}

class Services {
  var id;
  var title;
  var icon;
  var createdAt;
  var updatedAt;

  Services({this.id, this.title, this.icon, this.createdAt, this.updatedAt});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    icon = json['icon'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['icon'] = this.icon;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Galary {}
