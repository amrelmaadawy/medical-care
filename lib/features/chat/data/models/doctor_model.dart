import 'package:medical_care/core/helper/type_parser.dart';

class DoctorModel {
  final int id;
  final String name;
  final String specialization;
  final String? qualification;
  final String? image;
  final String type;

  DoctorModel({
    required this.id,
    required this.name,
    required this.specialization,
    this.qualification,
    this.image,
    required this.type,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: TypeParser.parseInt(json['id']) ?? 0,
      name: TypeParser.parseString(json['name']) ?? 'Unknown',
      specialization: TypeParser.parseString(json['specialization']) ?? '',
      qualification: TypeParser.parseString(json['qualification']),
      image: TypeParser.parseString(json['image']),
      type: TypeParser.parseString(json['type']) ?? '',
    );
  }
}
