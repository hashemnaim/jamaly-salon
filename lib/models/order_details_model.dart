import 'dart:developer';

class OwnerDetailsModel {
  int code;
  bool status;
  String message;
  int starts;
  OwnerDetailsModelData data;

  OwnerDetailsModel(
      {this.code, this.status, this.message, this.starts, this.data});

  OwnerDetailsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    starts = json['starts'];
    data = json['data'] != null
        ? new OwnerDetailsModelData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    data['starts'] = this.starts;

    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class OwnerDetailsModelData {
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
  var isFavourite;
  List<Gallary> gallary;
  List<ServiceOwners> serviceOwners;
  List<Offers> offers;
  List<Reviews> reviews;
  List<Ships> ships;

  OwnerDetailsModelData(
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
      this.updatedAt,
      this.isFavourite,
      this.gallary,
      this.serviceOwners,
      this.offers,
      this.reviews,
      this.ships});

  OwnerDetailsModelData.fromJson(Map<String, dynamic> json) {
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
    isFavourite = json['is_favourite'];

    if (json['gallary'] != null) {
      gallary = new List<Gallary>();
      json['gallary'].forEach((v) {
        gallary.add(new Gallary.fromJson(v));
      });
    }
    if (json['service_owners'] != null) {
      serviceOwners = new List<ServiceOwners>();
      json['service_owners'].forEach((v) {
        serviceOwners.add(new ServiceOwners.fromJson(v));
      });
    }
    if (json['offers'] != null) {
      offers = new List<Offers>();
      json['offers'].forEach((v) {
        offers.add(new Offers.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      reviews = new List<Reviews>();
      json['reviews'].forEach((v) {
        reviews.add(new Reviews.fromJson(v));
      });
    }
    if (json['ships'] != null) {
      ships = new List<Ships>();
      json['ships'].forEach((v) {
        ships.add(new Ships.fromJson(v));
      });
    }
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
    data['is_favourite'] = this.isFavourite;
    if (this.gallary != null) {
      data['gallary'] = this.gallary.map((v) => v.toJson()).toList();
    }
    if (this.serviceOwners != null) {
      data['service_owners'] =
          this.serviceOwners.map((v) => v.toJson()).toList();
    }
    if (this.offers != null) {
      data['offers'] = this.offers.map((v) => v.toJson()).toList();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews.map((v) => v.toJson()).toList();
    }
    if (this.ships != null) {
      data['ships'] = this.ships.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Gallary {
  var id;
  var image;
  var ownerId;
  var ship_id;
  var createdAt;
  var updatedAt;

  Gallary(
      {this.id,
      this.image,
      this.ownerId,
      this.ship_id,
      this.createdAt,
      this.updatedAt});

  Gallary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image_url'];
    ship_id = json['ship_id'];
    ownerId = json['owner_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image_url'] = this.image;
    data['ship_id'] = this.ship_id;
    data['owner_id'] = this.ownerId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ServiceOwners {
  var id;
  var serviceId;
  var ownerId;
  var createdAt;
  var updatedAt;
  Services services;

  ServiceOwners(
      {this.id,
      this.serviceId,
      this.ownerId,
      this.createdAt,
      this.updatedAt,
      this.services});

  ServiceOwners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceId = json['service_id'];
    ownerId = json['owner_id'];
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
    data['owner_id'] = this.ownerId;
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

class Offers {
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

  Offers(
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
      this.updatedAt});

  Offers.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class Reviews {
  var id;
  var name;
  var review;
  var ownerId;
  var rate;
  var createdAt;
  var updatedAt;

  Reviews(
      {this.id,
      this.name,
      this.review,
      this.ownerId,
      this.rate,
      this.createdAt,
      this.updatedAt});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    review = json['review'];
    ownerId = json['owner_id'];
    rate = json['rate'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['review'] = this.review;
    data['owner_id'] = this.ownerId;
    data['rate'] = this.rate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Ships {
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

  Ships(
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
      this.updatedAt});

  Ships.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
