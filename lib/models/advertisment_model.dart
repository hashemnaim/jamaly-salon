class AdvertismentModel {
  int code;
  bool status;
  String message;
  List<AdvertismentModelData> data;

  AdvertismentModel({this.code, this.status, this.message, this.data});

  AdvertismentModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<AdvertismentModelData>();
      json['data'].forEach((v) {
        data.add(new AdvertismentModelData.fromJson(v));
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

class AdvertismentModelData {
  int id;
  String image;
  int views;
  String createdAt;
  String updatedAt;

  AdvertismentModelData({this.id, this.image, this.views, this.createdAt, this.updatedAt});

  AdvertismentModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    views = json['views'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['views'] = this.views;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
