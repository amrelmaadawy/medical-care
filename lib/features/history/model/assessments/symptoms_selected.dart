import 'dart:convert';

class SymptomsSelected {
  int? id;
  String? name;
  String? description;
  String? category;

  SymptomsSelected({this.id, this.name, this.description, this.category});

  @override
  String toString() {
    return 'SymptomsSelected(id: $id, name: $name, description: $description, category: $category)';
  }

  factory SymptomsSelected.fromMap(Map<String, dynamic> data) {
    return SymptomsSelected(
      id: data['id'] as int?,
      name: data['name'] as String?,
      description: data['description'] as String?,
      category: data['category'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'description': description,
    'category': category,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SymptomsSelected].
  factory SymptomsSelected.fromJson(String data) {
    return SymptomsSelected.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SymptomsSelected] to a JSON string.
  String toJson() => json.encode(toMap());

  SymptomsSelected copyWith({
    int? id,
    String? name,
    String? description,
    String? category,
  }) {
    return SymptomsSelected(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
    );
  }
}
