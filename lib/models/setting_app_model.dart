class SettingAppModel {
  SettingAppModel({
    this.status,
    this.message,
    this.settingAppData,
    this.code,
  });

  bool status;
  String message;
  List<SettingAppData> settingAppData;
  int code;

  factory SettingAppModel.fromJson(Map<String, dynamic> json) =>
      SettingAppModel(
        status: json["status"],
        message: json["message"],
        settingAppData: List<SettingAppData>.from(
            json["data"].map((x) => SettingAppData.fromJson(x))),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(settingAppData.map((x) => x.toJson())),
        "code": code,
      };
}

class SettingAppData {
  SettingAppData({
    this.id,
    this.logo,
    this.orderText,
    this.logoPosition,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String logo;
  String orderText;
  String logoPosition;
  DateTime createdAt;
  DateTime updatedAt;

  factory SettingAppData.fromJson(Map<String, dynamic> json) => SettingAppData(
        id: json["id"],
        logo: json["logo"].toString(),
        orderText: json["order_text"].toString(),
        logoPosition: json["logo_position"].toString(),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "logo": logo,
        "logo_position": logoPosition,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
