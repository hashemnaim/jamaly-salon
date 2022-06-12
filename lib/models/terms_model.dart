 
class TermsModel {
    TermsModel({
        this.code,
        this.status,
        this.message,
        this.data,
    });

    int code;
    bool status;
    String message;
    List<DataTerms> data;

    factory TermsModel.fromJson(Map<String, dynamic> json) => TermsModel(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: List<DataTerms>.from(json["data"].map((x) => DataTerms.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class DataTerms {
    DataTerms({
        this.id,
        this.title,
        this.body,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String title;
    String body;
    DateTime createdAt;
    DateTime updatedAt;

    factory DataTerms.fromJson(Map<String, dynamic> json) => DataTerms(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
