import 'package:app_pemenangan_caleg/app/data/models/users/role/role_model.dart';

import 'profile_model.dart';

class UsersModel {
  int? id;
  String? username;
  String? password;
  int? isAktif;
  int? isRegistps;
  ProfileModel? profile;
  List<RoleModel>? roles;

  UsersModel({
    this.id,
    this.username,
    this.password,
    this.isAktif,
    this.isRegistps,
    this.profile,
    this.roles,
  });

  @override
  String toString() {
    return 'UsersModel(id: $id, username: $username, password: $password, isAktif: $isAktif, isRegistps: $isRegistps, profile: $profile, roles: $roles)';
  }

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        id: json['id'] as int?,
        username: json['username'] as String?,
        password: json['password'] as String?,
        isAktif: json['is_aktif'] as int?,
        isRegistps: json['is_registps'] as int?,
        profile: json['profile'] == null
            ? null
            : ProfileModel.fromJson(json['profile'] as Map<String, dynamic>),
        roles: (json['roles'] as List<dynamic>?)
            ?.map((e) => RoleModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'password': password,
        'is_aktif': isAktif,
        'is_registps': isRegistps,
        'profile': profile?.toJson(),
        'roles': roles?.map((e) => e.toJson()).toList(),
      };

  UsersModel copyWith({
    int? id,
    String? username,
    String? password,
    int? isAktif,
    int? isRegistps,
    ProfileModel? profile,
    List<RoleModel>? roles,
  }) {
    return UsersModel(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      isAktif: isAktif ?? this.isAktif,
      isRegistps: isRegistps ?? this.isRegistps,
      profile: profile ?? this.profile,
      roles: roles ?? this.roles,
    );
  }
}
