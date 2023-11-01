import 'package:app_pemenangan_caleg/app/data/models/users/users_model.dart';

import '../../tps_model.dart';

class DataTpsPendukung {
  int? id;
  int? tpsId;
  int? usersId;
  int? usersIdKoordinator;
  String? pendukungcoblosTps;
  int? verificationcoblosTps;
  int? tpsStatus;
  String? tpsCoblos;
  TpsModel? tps;
  UsersModel? users;

  DataTpsPendukung({
    this.id,
    this.tpsId,
    this.usersId,
    this.usersIdKoordinator,
    this.pendukungcoblosTps,
    this.verificationcoblosTps,
    this.tpsStatus,
    this.tpsCoblos,
    this.tps,
    this.users,
  });

  @override
  String toString() {
    return 'DataTpsPendukung(id: $id, tpsId: $tpsId, usersId: $usersId, usersIdKoordinator: $usersIdKoordinator, pendukungcoblosTps: $pendukungcoblosTps, verificationcoblosTps: $verificationcoblosTps, tpsStatus: $tpsStatus, tpsCoblos: $tpsCoblos, tps: $tps, users: $users)';
  }

  factory DataTpsPendukung.fromJson(Map<String, dynamic> json) =>
      DataTpsPendukung(
        id: json['id'] as int?,
        tpsId: json['tps_id'] as int?,
        usersId: json['users_id'] as int?,
        usersIdKoordinator: json['users_id_koordinator'] as int?,
        pendukungcoblosTps: json['pendukungcoblos_tps'] as String?,
        verificationcoblosTps: json['verificationcoblos_tps'] as int?,
        tpsStatus: json['tps_status'] as int?,
        tpsCoblos: json['tps_coblos'] as dynamic,
        tps: json['tps'] == null
            ? null
            : TpsModel.fromJson(json['tps'] as Map<String, dynamic>),
        users: json['users'] == null
            ? null
            : UsersModel.fromJson(json['users'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'tps_id': tpsId,
        'users_id': usersId,
        'users_id_koordinator': usersIdKoordinator,
        'pendukungcoblos_tps': pendukungcoblosTps,
        'verificationcoblos_tps': verificationcoblosTps,
        'tps_status': tpsStatus,
        'tps_coblos': tpsCoblos,
        'tps': tps?.toJson(),
        'users': users?.toJson(),
      };

  DataTpsPendukung copyWith({
    int? id,
    int? tpsId,
    int? usersId,
    int? usersIdKoordinator,
    String? pendukungcoblosTps,
    int? verificationcoblosTps,
    int? tpsStatus,
    dynamic tpsCoblos,
    TpsModel? tps,
    UsersModel? users,
  }) {
    return DataTpsPendukung(
      id: id ?? this.id,
      tpsId: tpsId ?? this.tpsId,
      usersId: usersId ?? this.usersId,
      usersIdKoordinator: usersIdKoordinator ?? this.usersIdKoordinator,
      pendukungcoblosTps: pendukungcoblosTps ?? this.pendukungcoblosTps,
      verificationcoblosTps:
          verificationcoblosTps ?? this.verificationcoblosTps,
      tpsStatus: tpsStatus ?? this.tpsStatus,
      tpsCoblos: tpsCoblos ?? this.tpsCoblos,
      tps: tps ?? this.tps,
      users: users ?? this.users,
    );
  }
}
