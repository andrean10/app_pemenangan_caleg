import 'tps_dashboard_model.dart';

class KoordinatorTpsModel {
  int? id;
  int? tpsId;
  int? usersId;
  TpsDashboardModel? tps;

  KoordinatorTpsModel({this.id, this.tpsId, this.usersId, this.tps});

  @override
  String toString() {
    return 'KoordinatorTpsModel(id: $id, tpsId: $tpsId, usersId: $usersId, tps: $tps)';
  }

  factory KoordinatorTpsModel.fromJson(Map<String, dynamic> json) {
    return KoordinatorTpsModel(
      id: json['id'] as int?,
      tpsId: json['tps_id'] as int?,
      usersId: json['users_id'] as int?,
      tps: json['tps'] == null
          ? null
          : TpsDashboardModel.fromJson(json['tps'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'tps_id': tpsId,
        'users_id': usersId,
        'tps': tps?.toJson(),
      };

  KoordinatorTpsModel copyWith({
    int? id,
    int? tpsId,
    int? usersId,
    TpsDashboardModel? tps,
  }) {
    return KoordinatorTpsModel(
      id: id ?? this.id,
      tpsId: tpsId ?? this.tpsId,
      usersId: usersId ?? this.usersId,
      tps: tps ?? this.tps,
    );
  }
}
