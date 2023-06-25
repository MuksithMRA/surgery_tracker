import 'dart:convert';

class AppUser {
  String firstName;
  String lastName;
  String imageUrl;
  String specialization;
  String documentID;
  String userId;
  String profileImage;
  AppUser({
    this.firstName = '',
    this.lastName = '',
    this.imageUrl = '',
    this.specialization = '',
    this.documentID = '',
    this.userId = '',
    this.profileImage = '',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'imageUrl': imageUrl,
      'specialization': specialization,
      'userId': userId,
      'profileImage': profileImage
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      specialization: map['specialization'] ?? '',
      userId: map['userId'] ?? '',
      profileImage: map['profileImage'] ?? '',
      documentID: map['\$id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
