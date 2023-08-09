/// MODELO USER

import 'dart:convert';

class User {
  User({
    this.id,
    this.username,
    this.email,
  });

  int? id;
  String? username;
  String? email;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"] ?? "",
        email: json["email"] ?? "",
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
        "email": email,
      };
  bool get isEmpty => id == 0 && username!.isEmpty && email!.isEmpty;

  static List<User> parseUsers(String jsonString) {
    final Map<String, dynamic> parsedJson = json.decode(jsonString);
    final List<dynamic>? userListJson = parsedJson['users'];
    if (userListJson != null) {
      return userListJson.map((user) => User.fromMap(user)).toList();
    } else {
      return [];
    }
  }
}
