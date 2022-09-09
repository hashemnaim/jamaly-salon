class SearchShipsModel {
  int code;
  bool status;
  String message;
  List<Data> data;

  SearchShipsModel({this.code, this.status, this.message, this.data});

  SearchShipsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
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

class Data {
  int id;
  String title;
  var description;
  String image;
  int ownerId;
  var prepaid;
  int offer;
  var rate;
  String price;
  int priceFor;
  var country;
  var locationLong;
  var locationLat;
  int dayPrice;
  String bookingWay;
  var deposit;
  var notes;
  String numberOfPersones;
  var startDate;
  var endDate;
  var time;
  String createdAt;
  String updatedAt;
  var fromTime;
  var toTime;
  int serviceId;

  Data(
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
      this.toTime,
      this.serviceId});

  Data.fromJson(Map<String, dynamic> json) {
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
    serviceId = json['service_id'];
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
    data['service_id'] = this.serviceId;
    return data;
  }
}
