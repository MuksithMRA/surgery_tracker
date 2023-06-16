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
  String documentID;
  AppUser({
    this.userId = '',
    this.name = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.password = '',
    this.imageUrl = '',
    this.specialization = '',
    this.documentID = '',
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
      'specialization': specialization,
      'documentId': documentID,
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
      documentID: map['documentId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
