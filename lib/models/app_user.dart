import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppUser {
  String userId;
  String name;
  String firstName;
  String lastName;
  String email;
  String password;
  String imageUrl;
  String specialization;
  AppUser({
    this.userId = '',
    this.firstName = '',
    this.lastName = '',
    this.name = '',
    this.email = '',
    this.password = '',
    this.imageUrl = '',
    this.specialization = '',
  }) {
    name = '$firstName $lastName';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'name': name,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'imageUrl': imageUrl,
      'specialization': specialization
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      specialization: map['specialization'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
