import '../../tps_model.dart';
import '../../../users/users_model.dart';

class DataTpsKorlap {
  int? id;
  int? tpsId;
  int? usersId;
  TpsModel? tps;
  UsersModel? users;

  DataTpsKorlap({this.id, this.tpsId, this.usersId, this.tps, this.users});

  @override
  String toString() {
    return 'DataTpsKorlap(id: $id, tpsId: $tpsId, usersId: $usersId, tps: $tps, users: $users)';
  }

  factory DataTpsKorlap.fromJson(Map<String, dynamic> json) => DataTpsKorlap(
        id: json['id'] as int?,
        tpsId: json['tps_id'] as int?,
        usersId: json['users_id'] as int?,
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
        'tps': tps?.toJson(),
        'users': users?.toJson(),
      };

  DataTpsKorlap copyWith({
    int? id,
    int? tpsId,
    int? usersId,
    TpsModel? tps,
    UsersModel? users,
  }) {
    return DataTpsKorlap(
      id: id ?? this.id,
      tpsId: tpsId ?? this.tpsId,
      usersId: usersId ?? this.usersId,
      tps: tps ?? this.tps,
      users: users ?? this.users,
    );
  }
}
