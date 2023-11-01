import 'data_tps_pendukung.dart';

class ResultTpsPendukungModel {
  int? currentPage;
  List<DataTpsPendukung>? data;
  int? lastPage;
  int? perPage;
  int? total;

  ResultTpsPendukungModel({
    this.currentPage,
    this.data,
    this.lastPage,
    this.perPage,
    this.total,
  });

  @override
  String toString() {
    return 'ResultTpsPendukungModel(currentPage: $currentPage, data: $data, lastPage: $lastPage, perPage: $perPage, total: $total)';
  }

  factory ResultTpsPendukungModel.fromJson(Map<String, dynamic> json) {
    return ResultTpsPendukungModel(
      currentPage: json['current_page'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DataTpsPendukung.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastPage: json['last_page'] as int?,
      perPage: json['per_page'] as int?,
      total: json['total'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'current_page': currentPage,
        'data': data?.map((e) => e.toJson()).toList(),
        'last_page': lastPage,
        'per_page': perPage,
        'total': total,
      };

  ResultTpsPendukungModel copyWith({
    int? currentPage,
    List<DataTpsPendukung>? data,
    int? lastPage,
    int? perPage,
    int? total,
  }) {
    return ResultTpsPendukungModel(
      currentPage: currentPage ?? this.currentPage,
      data: data ?? this.data,
      lastPage: lastPage ?? this.lastPage,
      perPage: perPage ?? this.perPage,
      total: total ?? this.total,
    );
  }
}
