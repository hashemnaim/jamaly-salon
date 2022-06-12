class SubServiceVendorModel {
  int code;
  bool status;
  String message;
  List<SubServiceVendorModelData> data;

  SubServiceVendorModel({this.code, this.status, this.message, this.data});

  SubServiceVendorModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SubServiceVendorModelData>[];
      json['data'].forEach((v) {
        data.add(new SubServiceVendorModelData.fromJson(v));
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

class SubServiceVendorModelData {
  var id;
  var title;
  var icon;
  var parent;
  var createdAt;
  var updatedAt;

  SubServiceVendorModelData(
      {this.id,
      this.title,
      this.icon,
      this.parent,
      this.createdAt,
      this.updatedAt});

  SubServiceVendorModelData.fromJson(Map<String, dynamic> json) {
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
