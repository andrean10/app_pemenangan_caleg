import 'package:app_pemenangan_caleg/app/data/models/region/data_region_model.dart';

class ResultRegionModel {
  List<DataRegionModel>? results;
  int? countFiltered;

  ResultRegionModel({this.results, this.countFiltered});

  @override
  String toString() {
    return 'ResultRegionModel(results: $results, countFiltered: $countFiltered)';
  }

  factory ResultRegionModel.fromJson(Map<String, dynamic> json) =>
      ResultRegionModel(
        results: (json['results'] as List<dynamic>?)
            ?.map((e) => DataRegionModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        countFiltered: json['count_filtered'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'results': results?.map((e) => e.toJson()).toList(),
        'count_filtered': countFiltered,
      };

  ResultRegionModel copyWith({
    List<DataRegionModel>? results,
    int? countFiltered,
  }) {
    return ResultRegionModel(
      results: results ?? this.results,
      countFiltered: countFiltered ?? this.countFiltered,
    );
  }
}
