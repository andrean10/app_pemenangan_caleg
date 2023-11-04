import 'koordinator_tps_model.dart';

class ResultDashboardSuaraModel {
  KoordinatorTpsModel? koordinatorTps;
  int? totalDukungan;
  int? totalkoordinator;
  int? targetPemenangan;
  double? presentasePemenangan;
  int? totalDukunganLk;
  int? totalDukunganPr;

  ResultDashboardSuaraModel({
    this.koordinatorTps,
    this.totalDukungan,
    this.totalkoordinator,
    this.targetPemenangan,
    this.presentasePemenangan,
    this.totalDukunganLk,
    this.totalDukunganPr,
  });

  @override
  String toString() {
    return 'ResultDashboardSuaraModel(koordinatorTps: $koordinatorTps, totalDukungan: $totalDukungan, totalkoordinator: $totalkoordinator, targetPemenangan: $targetPemenangan, presentasePemenangan: $presentasePemenangan, totalDukunganLk: $totalDukunganLk, totalDukunganPr: $totalDukunganPr)';
  }

  factory ResultDashboardSuaraModel.fromJson(Map<String, dynamic> json) =>
      ResultDashboardSuaraModel(
        koordinatorTps: json['koordinatorTps'] == null
            ? null
            : KoordinatorTpsModel.fromJson(
                json['koordinatorTps'] as Map<String, dynamic>),
        totalDukungan: json['totalDukungan'] as int?,
        totalkoordinator: json['totalkoordinator'] as int?,
        targetPemenangan: json['targetPemenangan'] as int?,
        presentasePemenangan:
            (json['presentasePemenangan'] as num?)?.toDouble(),
        totalDukunganLk: json['totalDukunganLk'] as int?,
        totalDukunganPr: json['totalDukunganPr'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'koordinatorTps': koordinatorTps?.toJson(),
        'totalDukungan': totalDukungan,
        'totalkoordinator': totalkoordinator,
        'targetPemenangan': targetPemenangan,
        'presentasePemenangan': presentasePemenangan,
        'totalDukunganLk': totalDukunganLk,
        'totalDukunganPr': totalDukunganPr,
      };

  ResultDashboardSuaraModel copyWith({
    KoordinatorTpsModel? koordinatorTps,
    int? totalDukungan,
    int? totalkoordinator,
    int? targetPemenangan,
    double? presentasePemenangan,
    int? totalDukunganLk,
    int? totalDukunganPr,
  }) {
    return ResultDashboardSuaraModel(
      koordinatorTps: koordinatorTps ?? this.koordinatorTps,
      totalDukungan: totalDukungan ?? this.totalDukungan,
      totalkoordinator: totalkoordinator ?? this.totalkoordinator,
      targetPemenangan: targetPemenangan ?? this.targetPemenangan,
      presentasePemenangan: presentasePemenangan ?? this.presentasePemenangan,
      totalDukunganLk: totalDukunganLk ?? this.totalDukunganLk,
      totalDukunganPr: totalDukunganPr ?? this.totalDukunganPr,
    );
  }
}
