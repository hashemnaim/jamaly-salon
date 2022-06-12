class FavoriteModel {
  int code;
  bool status;
  String message;
  List<FavoriteModelData> data;

  FavoriteModel({this.code, this.status, this.message, this.data});

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <FavoriteModelData>[];
      json['data'].forEach((v) {
        data.add(new FavoriteModelData.fromJson(v));
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

class FavoriteModelData {
  var id;
  var userId;
  var vendorId;
  var shipId;
  var type;
  var createdAt;
  var updatedAt;
  Ships ships;
  Vendors vendors;


  FavoriteModelData(
      {this.id,
      this.userId,
      this.vendorId,
      this.shipId,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.ships,
      this.vendors,
      
      });

  FavoriteModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    vendorId = json['vendor_id'];
    shipId = json['ship_id'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    ships = json['ships'] != null ? new Ships.fromJson(json['ships']) : null;
    vendors = json['vendors'] != null ? new Vendors.fromJson(json['vendors']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['vendor_id'] = this.vendorId;
    data['ship_id'] = this.shipId;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.ships != null) {
      data['ships'] = this.ships.toJson();
    }
    if (this.vendors != null) {
      data['vendors'] = this.vendors.toJson();
    }
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
  var priceFor;
  var country;
  var locationLong;
  var locationLat;
  var dayPrice;
  var bookingWay;
  var deposit;
  var notes;
  var numberOfPersones;
  var startDate;
  var endDate;
  var time;
  var createdAt;
  var updatedAt;
  var fromTime;
  var toTime;

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
      this.priceFor,
      this.country,
      this.locationLong,
      this.locationLat,
      this.dayPrice,
      this.bookingWay,
      this.deposit,
      this.notes,
      this.numberOfPersones,
      this.startDate,
      this.endDate,
      this.time,
      this.createdAt,
      this.updatedAt,
      this.fromTime,
      this.toTime});

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
    priceFor = json['price_for'];
    country = json['country'];
    locationLong = json['location_long'];
    locationLat = json['location_lat'];
    dayPrice = json['day_price'];
    bookingWay = json['booking_way'];
    deposit = json['deposit'];
    notes = json['notes'];
    numberOfPersones = json['number_of_persones'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    time = json['time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fromTime = json['from_time'];
    toTime = json['to_time'];
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
    data['price_for'] = this.priceFor;
    data['country'] = this.country;
    data['location_long'] = this.locationLong;
    data['location_lat'] = this.locationLat;
    data['day_price'] = this.dayPrice;
    data['booking_way'] = this.bookingWay;
    data['deposit'] = this.deposit;
    data['notes'] = this.notes;
    data['number_of_persones'] = this.numberOfPersones;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['time'] = this.time;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['from_time'] = this.fromTime;
    data['to_time'] = this.toTime;
    return data;
  }
}
class Vendors {
    Vendors({
        this.id,
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
        this.typeAdmin,
    });

    int id;
    String name;
    String email;
    String mobile;
    String type;
    String location;
    String photo;
    dynamic facebook;
    dynamic rate;
    dynamic categoryId;
    int verifyMobileCode;
    int activeMobile;
    dynamic emailVerifiedAt;
    String locationLong;
    String locationLat;
    int available;
    dynamic country;
    String fcmToken;
    DateTime createdAt;
    DateTime updatedAt;
    int typeAdmin;

    factory Vendors.fromJson(Map<String, dynamic> json) => Vendors(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        type: json["type"],
        location: json["location"],
        photo: json["photo"],
        facebook: json["facebook"],
        rate: json["rate"],
        categoryId: json["category_id"],
        verifyMobileCode: json["verify_mobile_code"],
        activeMobile: json["active_mobile"],
        emailVerifiedAt: json["email_verified_at"],
        locationLong: json["location_long"],
        locationLat: json["location_lat"],
        available: json["available"],
        country: json["country"],
        fcmToken: json["fcm_token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        typeAdmin: json["type_admin"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "mobile": mobile,
        "type": type,
        "location": location,
        "photo": photo,
        "facebook": facebook,
        "rate": rate,
        "category_id": categoryId,
        "verify_mobile_code": verifyMobileCode,
        "active_mobile": activeMobile,
        "email_verified_at": emailVerifiedAt,
        "location_long": locationLong,
        "location_lat": locationLat,
        "available": available,
        "country": country,
        "fcm_token": fcmToken,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "type_admin": typeAdmin,
    };
}
