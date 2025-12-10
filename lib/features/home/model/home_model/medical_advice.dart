import 'dart:convert';

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
    id: data['id'] as int?,
    title: data['title'] as String?,
    desc: data['desc'] as String?,
    status: data['status'] as int?,
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