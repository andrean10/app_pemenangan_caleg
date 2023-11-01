import 'data_pendukung_korlap.dart';

class ResultPendukungKorlapModel {
  int? currentPage;
  List<DataPendukungKorlap>? data;
  int? lastPage;
  int? perPage;
  int? total;

  ResultPendukungKorlapModel({
    this.currentPage,
    this.data,
    this.lastPage,
    this.perPage,
    this.total,
  });

  @override
  String toString() {
    return 'ResultPendukungKorlapModel(currentPage: $currentPage, data: $data, lastPage: $lastPage, perPage: $perPage, total: $total)';
  }

  factory ResultPendukungKorlapModel.fromJson(Map<String, dynamic> json) =>
      ResultPendukungKorlapModel(
        currentPage: json['current_page'] as int?,
        data: (json['data'] as List<dynamic>?)
            ?.map(
                (e) => DataPendukungKorlap.fromJson(e as Map<String, dynamic>))
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

  ResultPendukungKorlapModel copyWith({
    int? currentPage,
    List<DataPendukungKorlap>? data,
    int? lastPage,
    int? perPage,
    int? total,
  }) {
    return ResultPendukungKorlapModel(
      currentPage: currentPage ?? this.currentPage,
      data: data ?? this.data,
      lastPage: lastPage ?? this.lastPage,
      perPage: perPage ?? this.perPage,
      total: total ?? this.total,
    );
  }
}
