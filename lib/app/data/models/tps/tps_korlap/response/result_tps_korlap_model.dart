import 'data_tps_korlap.dart';

class ResultTpsKorlapModel {
  int? currentPage;
  List<DataTpsKorlap>? data;
  int? lastPage;
  int? perPage;
  int? total;

  ResultTpsKorlapModel({
    this.currentPage,
    this.data,
    this.lastPage,
    this.perPage,
    this.total,
  });

  @override
  String toString() {
    return 'ResultTpsKorlapModel(currentPage: $currentPage, data: $data, lastPage: $lastPage, perPage: $perPage, total: $total)';
  }

  factory ResultTpsKorlapModel.fromJson(Map<String, dynamic> json) =>
      ResultTpsKorlapModel(
        currentPage: json['current_page'] as int?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => DataTpsKorlap.fromJson(e as Map<String, dynamic>))
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

  ResultTpsKorlapModel copyWith({
    int? currentPage,
    List<DataTpsKorlap>? data,
    int? lastPage,
    int? perPage,
    int? total,
  }) {
    return ResultTpsKorlapModel(
      currentPage: currentPage ?? this.currentPage,
      data: data ?? this.data,
      lastPage: lastPage ?? this.lastPage,
      perPage: perPage ?? this.perPage,
      total: total ?? this.total,
    );
  }
}
