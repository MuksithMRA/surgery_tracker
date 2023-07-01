import 'dart:convert';

class AppUser {
  String firstName;
  String lastName;
  String specialization;
  String userId;
  String profileImage;
  String email;
  AppUser({
    this.firstName = '',
    this.lastName = '',
    this.specialization = '',
    this.userId = '',
    this.profileImage = '',
    this.email = '',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'specialization': specialization,
      'userId': userId,
      'profileImage': profileImage,
      'email': email,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      specialization: map['specialization'] ?? '',
      userId: map['userId'] ?? '',
      profileImage: map['profileImage'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
