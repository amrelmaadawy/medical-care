import 'dart:convert';
import 'package:medical_care/core/helper/type_parser.dart';

class Symptom {
  int? id;
  String? name;
  String? description;
  String? category;

  Symptom({this.id, this.name, this.description, this.category});

  @override
  String toString() {
    return 'Symptom(id: $id, name: $name, description: $description, category: $category)';
  }

  factory Symptom.fromMap(Map<String, dynamic> data) => Symptom(
    id: TypeParser.parseInt(data['id']),
    name: TypeParser.parseString(data['name']),
    description: TypeParser.parseString(data['description']),
    category: TypeParser.parseString(data['category']),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'description': description,
    'category': category,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Symptom].
  factory Symptom.fromJson(String data) {
    return Symptom.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Symptom] to a JSON string.
  String toJson() => json.encode(toMap());

  Symptom copyWith({
    int? id,
    String? name,
    String? description,
    String? category,
  }) {
    return Symptom(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
    );
  }
}
