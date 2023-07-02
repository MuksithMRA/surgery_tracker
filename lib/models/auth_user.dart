import 'dart:convert';
import 'package:surgery_tracker/models/app_user.dart';

class AuthUser {
  String userId;
  String name;
  String email;
  String password;

  AppUser appUser = AppUser();
  AuthUser({
    this.userId = '',
    this.name = '',
    this.email = '',
    this.password = '',
  });

  get getAppUser => appUser;

  set setAppUser(appUser) => this.appUser = appUser;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'name': name,
      'email': email,
      'password': password,
    };
  }

  Map<String, dynamic> toLoginMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory AuthUser.fromMap(Map<String, dynamic> map) {
    return AuthUser(
      userId: map['userId'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());
  String toLoginJson() => json.encode(toLoginMap());

  factory AuthUser.fromJson(String source) =>
      AuthUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
