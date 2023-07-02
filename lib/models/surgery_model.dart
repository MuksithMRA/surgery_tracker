import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:surgery_tracker/utils/utils.dart';

class SurgeryModel {
  String userId;
  String consultantName;
  DateTime? date;
  String doneBy;
  String surgeryName;
  String bht;
  String documentID;
  SurgeryModel({
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
      'userId': userId,
      'consultantName': consultantName,
      'date': DateFormat.yMd().format(DateTime.now()),
      'doneBy': doneBy,
      'surgeryName': surgeryName,
      'bht': bht,
    };
  }

  factory SurgeryModel.fromMap(Map<String, dynamic> map) {
    return SurgeryModel(
      userId: map['userId'] as String,
      consultantName: map['consultantName'] as String,
      date: map['date'] != null
          ? Utils.date(map['date'], "MM/dd/yyyy")
          : DateTime.now(),
      doneBy: map['doneBy'] as String,
      surgeryName: map['surgeryName'] as String,
      bht: map['bht'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SurgeryModel.fromJson(String source) =>
      SurgeryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
