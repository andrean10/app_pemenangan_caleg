import '../../../../users/result_users2_model/data_users2.dart';

class ResultListPendukungModel {
  int? currentPage;
  List<DataUsers2>? data;
  int? lastPage;
  int? perPage;
  int? total;

  ResultListPendukungModel({
    this.currentPage,
    this.data,
    this.lastPage,
    this.perPage,
    this.total,
  });

  @override
  String toString() {
    return 'ResultListPendukungModel(currentPage: $currentPage, data: $data, lastPage: $lastPage, perPage: $perPage, total: $total)';
  }

  factory ResultListPendukungModel.fromJson(Map<String, dynamic> json) =>
      ResultListPendukungModel(
        currentPage: json['current_page'] as int?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => DataUsers2.fromJson(e as Map<String, dynamic>))
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

  ResultListPendukungModel copyWith({
    int? currentPage,
    List<DataUsers2>? data,
    int? lastPage,
    int? perPage,
    int? total,
  }) {
    return ResultListPendukungModel(
      currentPage: currentPage ?? this.currentPage,
      data: data ?? this.data,
      lastPage: lastPage ?? this.lastPage,
      perPage: perPage ?? this.perPage,
      total: total ?? this.total,
    );
  }
}
