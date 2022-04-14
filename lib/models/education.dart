class Education {
  Education({
    required this.id,
    required this.body,
    required this.createdAt,
    required this.updatedAt,
  });

  late final int id;
  late final String body;
  late final DateTime createdAt;
  late final DateTime updatedAt;

  Education.fromMap(Map<String, dynamic> json) {
    id = json["id"];
    body = json["body"];
    createdAt = DateTime.parse(json["createdAt"]);
    updatedAt = DateTime.parse(json["updatedAt"]);
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "body": body,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
