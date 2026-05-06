import 'dart:convert';
import 'package:medical_care/core/helper/type_parser.dart';

class MedicalAdvice {
  int? id;
  String? title;
  String? desc;
  int? status;

  MedicalAdvice({this.id, this.title, this.desc, this.status});

  @override
  String toString() {
    return 'MedicalAdvice(id: $id, title: $title, desc: $desc, status: $status)';
  }

  factory MedicalAdvice.fromMap(Map<String, dynamic> data) => MedicalAdvice(
    id: TypeParser.parseInt(data['id']),
    title: TypeParser.parseString(data['title']),
    desc: TypeParser.parseString(data['desc']),
    status: TypeParser.parseInt(data['status']),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'desc': desc,
    'status': status,
  };

  factory MedicalAdvice.fromJson(String data) {
    return MedicalAdvice.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  MedicalAdvice copyWith({int? id, String? title, String? desc, int? status}) {
    return MedicalAdvice(
      id: id ?? this.id,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      status: status ?? this.status,
    );
  }
}
