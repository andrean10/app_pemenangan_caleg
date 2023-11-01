import 'data_tps_korcab.dart';

class ResultTpsKorcabModel {
  int? currentPage;
  List<DataTpsKorcab>? data;
  int? from;
  int? lastPage;
  int? perPage;
  int? to;
  int? total;

  ResultTpsKorcabModel({
    this.currentPage,
    this.data,
    this.from,
    this.lastPage,
    this.perPage,
    this.to,
    this.total,
  });

  @override
  String toString() {
    return 'ResultTpsKorcabModel(currentPage: $currentPage, data: $data, from: $from, lastPage: $lastPage, perPage: $perPage, to: $to, total: $total)';
  }

  factory ResultTpsKorcabModel.fromJson(Map<String, dynamic> data) =>
      ResultTpsKorcabModel(
        currentPage: data['current_page'] as int?,
        data: (data['data'] as List<dynamic>?)
            ?.map((e) => DataTpsKorcab.fromJson(e as Map<String, dynamic>))
            .toList(),
        from: data['from'] as int?,
        lastPage: data['last_page'] as int?,
        perPage: data['per_page'] as int?,
        to: data['to'] as int?,
        total: data['total'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'current_page': currentPage,
        'data': data?.map((e) => e.toJson()).toList(),
        'from': from,
        'last_page': lastPage,
        'per_page': perPage,
        'to': to,
        'total': total,
      };

  ResultTpsKorcabModel copyWith({
    int? currentPage,
    List<DataTpsKorcab>? data,
    int? from,
    int? lastPage,
    int? perPage,
    int? to,
    int? total,
  }) {
    return ResultTpsKorcabModel(
      currentPage: currentPage ?? this.currentPage,
      data: data ?? this.data,
      from: from ?? this.from,
      lastPage: lastPage ?? this.lastPage,
      perPage: perPage ?? this.perPage,
      to: to ?? this.to,
      total: total ?? this.total,
    );
  }
}
