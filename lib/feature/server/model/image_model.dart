class Images {
  String id;
  String imageString;

  Images({
    this.id,
    this.imageString,
  });

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      id: json['id'] as String,
      imageString: json['imageCode'] as String,
    );
  }
}
