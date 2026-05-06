import 'dart:convert';

class Pagination {
  int? total;
  int? perPage;
  int? currentPage;
  int? lastPage;

  Pagination({this.total, this.perPage, this.currentPage, this.lastPage});

  @override
  String toString() {
    return 'Pagination(total: $total, perPage: $perPage, currentPage: $currentPage, lastPage: $lastPage)';
  }

  factory Pagination.fromMap(Map<String, dynamic> data) => Pagination(
    total: data['total'] as int?,
    perPage: data['per_page'] as int?,
    currentPage: data['current_page'] as int?,
    lastPage: data['last_page'] as int?,
  );

  Map<String, dynamic> toMap() => {
    'total': total,
    'per_page': perPage,
    'current_page': currentPage,
    'last_page': lastPage,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Pagination].
  factory Pagination.fromJson(String data) {
    return Pagination.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Pagination] to a JSON string.
  String toJson() => json.encode(toMap());

  Pagination copyWith({
    int? total,
    int? perPage,
    int? currentPage,
    int? lastPage,
  }) {
    return Pagination(
      total: total ?? this.total,
      perPage: perPage ?? this.perPage,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
    );
  }
}
