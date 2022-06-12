class MyOfferModel {
  int code;
  bool status;
  String message;
  List<MyOfferModelData> data;

  MyOfferModel({this.code, this.status, this.message, this.data});

  MyOfferModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MyOfferModelData>[];
      json['data'].forEach((v) {
        data.add(new MyOfferModelData.fromJson(v));
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

class MyOfferModelData {
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
  var dayPrice;
  var bookingWay;
  var deposit;
  var notes;
  var number_of_persones;
  var start_date;
  var end_date;
  var time;
  var createdAt;
  var updatedAt;
  List<ServicesShip> servicesShip;
  List<GallaryOwner> gallaryOwner;

  MyOfferModelData(
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
      this.dayPrice,
      this.bookingWay,
      this.deposit,
      this.notes,
      this.number_of_persones,
      this.start_date,
      this.end_date,
      this.time,
      this.createdAt,
      this.updatedAt,
      this.servicesShip,
      this.gallaryOwner});

  MyOfferModelData.fromJson(Map<String, dynamic> json) {
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
    dayPrice = json['day_price'];
    bookingWay = json['booking_way'];
    deposit = json['deposit'];
    notes = json['notes'];
    number_of_persones = json['number_of_persones'];
    start_date = json['start_date'];
    end_date = json['end_date'];
    time = json['time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['services_ship'] != null) {
      servicesShip = <ServicesShip>[];
      json['services_ship'].forEach((v) {
        servicesShip.add(new ServicesShip.fromJson(v));
      });
    }
    if (json['gallary_owner'] != null) {
      gallaryOwner = <GallaryOwner>[];
      json['gallary_owner'].forEach((v) {
        gallaryOwner.add(new GallaryOwner.fromJson(v));
      });
    }
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
    data['day_price'] = this.dayPrice;
    data['booking_way'] = this.bookingWay;
    data['deposit'] = this.deposit;
    data['notes'] = this.notes;
    data['number_of_persones'] = this.number_of_persones;
    data['start_date'] = this.start_date;
    data['end_date'] = this.end_date;
    data['time'] = this.time;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.servicesShip != null) {
      data['services_ship'] =
          this.servicesShip.map((v) => v.toJson()).toList();
    }
    if (this.gallaryOwner != null) {
      data['gallary_owner'] =
          this.gallaryOwner.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServicesShip {
  var id;
  var serviceId;
  var shipId;
  var subServicesId;
  var createdAt;
  var updatedAt;
  Services services;

  ServicesShip(
      {this.id,
      this.serviceId,
      this.shipId,
      this.subServicesId,
      this.createdAt,
      this.updatedAt,
      this.services});

  ServicesShip.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceId = json['service_id'];
    shipId = json['ship_id'];
    subServicesId = json['sub_services_id'];
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
    data['sub_services_id'] = this.subServicesId;
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
  var parent;
  var createdAt;
  var updatedAt;

  Services(
      {this.id,
      this.title,
      this.icon,
      this.parent,
      this.createdAt,
      this.updatedAt});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    icon = json['icon'];
    parent = json['parent'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['icon'] = this.icon;
    data['parent'] = this.parent;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class GallaryOwner {
  var id;
  var imageUrl;
  var ownerId;
  var shipId;
  var createdAt;
  var updatedAt;

  GallaryOwner(
      {this.id,
      this.imageUrl,
      this.ownerId,
      this.shipId,
      this.createdAt,
      this.updatedAt});

  GallaryOwner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['image_url'];
    ownerId = json['owner_id'];
    shipId = json['ship_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image_url'] = this.imageUrl;
    data['owner_id'] = this.ownerId;
    data['ship_id'] = this.shipId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
