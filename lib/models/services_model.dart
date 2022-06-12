class ServicesModel {
  int code;
  bool status;
  String message;
  List<ServicesModelData> data;

  ServicesModel({this.code, this.status, this.message, this.data});

  ServicesModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<ServicesModelData>();
      json['data'].forEach((v) {
        data.add(new ServicesModelData.fromJson(v));
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

class ServicesModelData {
  var id;
  var title;
  var icon;
  var createdAt;
  var updatedAt;

  ServicesModelData(
      {this.id, this.title, this.icon, this.createdAt, this.updatedAt});

  ServicesModelData.fromJson(Map<String, dynamic> json) {
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
