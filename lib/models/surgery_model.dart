// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SurgeryModel {
  int id;
  String userId;
  String consultantName;
  DateTime? date;
  String doneBy;
  String surgeryName;
  String bht;
  String documentID;
  SurgeryModel({
    this.id = 0,
    this.userId = '',
    this.consultantName = '',
    this.date,
    this.doneBy = '',
    this.surgeryName = '',
    this.bht = '',
    this.documentID = '',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'consultantName': consultantName,
      'date': date.toString(),
      'doneBy': doneBy,
      'surgeryName': surgeryName,
      'bht': bht,
    };
  }

  factory SurgeryModel.fromMap(Map<String, dynamic> map) {
    return SurgeryModel(
      id: map['id'] ?? 0,
      userId: map['userId'] as String,
      consultantName: map['consultantName'] as String,
      date: map['date'] != null ? DateTime.parse(map['date']) : DateTime.now(),
      doneBy: map['doneBy'] as String,
      surgeryName: map['surgeryName'] as String,
      bht: map['bht'] as String,
      documentID: map['\$id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SurgeryModel.fromJson(String source) =>
      SurgeryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
