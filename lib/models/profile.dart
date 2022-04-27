import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    required this.token,
    required this.id,
    required this.email,
    required this.username,
  });

  final String token;
  final int id;
  final String email;
  final String username;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        token: json["token"],
        id: json["id"],
        email: json["email"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "id": id,
        "email": email,
        "username": username,
      };
}
