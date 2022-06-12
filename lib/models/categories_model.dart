class CategoriesModel {
  int code;
  bool status;
  String message;
  List<CategoriesModelData> data;

  CategoriesModel({this.code, this.status, this.message, this.data});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<CategoriesModelData>();
      json['data'].forEach((v) {
        data.add(new CategoriesModelData.fromJson(v));
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

class CategoriesModelData {
  int id;
  String title;
  String description;
  String image;
  String createdAt;
  String updatedAt;

  CategoriesModelData(
      {this.id,
      this.title,
      this.description,
      this.image,
      this.createdAt,
      this.updatedAt});

  CategoriesModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
