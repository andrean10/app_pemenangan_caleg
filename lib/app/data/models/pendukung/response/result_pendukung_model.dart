import 'data_pendukung.dart';

class ResultPendukungModel {
  int? currentPage;
  List<DataPendukung>? data;
  int? lastPage;
  int? perPage;
  int? total;

  ResultPendukungModel({
    this.currentPage,
    this.data,
    this.lastPage,
    this.perPage,
    this.total,
  });

  @override
  String toString() {
    return 'ResultPendukungModel(currentPage: $currentPage, data: $data, lastPage: $lastPage, perPage: $perPage, total: $total)';
  }

  factory ResultPendukungModel.fromJson(Map<String, dynamic> json) =>
      ResultPendukungModel(
        currentPage: json['current_page'] as int?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => DataPendukung.fromJson(e as Map<String, dynamic>))
            .toList(),
        lastPage: json['last_page'] as int?,
        perPage: json['per_page'] as int?,
        total: json['total'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'current_page': currentPage,
        'data': data?.map((e) => e.toJson()).toList(),
        'last_page': lastPage,
        'per_page': perPage,
        'total': total,
      };

  ResultPendukungModel copyWith({
    int? currentPage,
    List<DataPendukung>? data,
    int? lastPage,
    int? perPage,
    int? total,
  }) {
    return ResultPendukungModel(
      currentPage: currentPage ?? this.currentPage,
      data: data ?? this.data,
      lastPage: lastPage ?? this.lastPage,
      perPage: perPage ?? this.perPage,
      total: total ?? this.total,
    );
  }
}
