class HomeMealsModel {
  int id;
  String name;
  String price;
  String image;

  HomeMealsModel({this.id, this.name, this.price, this.image});

  HomeMealsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['image'] = this.image;
    return data;
  }
}

List<HomeMealsModel> homeMealsModelFromJson(List<dynamic> data) =>
    List<HomeMealsModel>.from(data.map((x) => HomeMealsModel.fromJson(x)));