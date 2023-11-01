import 'profile_model.dart';

class UsersModel {
  int? id;
  String? username;
  String? password;
  int? isAktif;
  int? isRegistps;
  ProfileModel? profile;

  UsersModel({
    this.id,
    this.username,
    this.password,
    this.isAktif,
    this.isRegistps,
    this.profile,
  });

  @override
  String toString() {
    return 'UsersModel(id: $id, username: $username, password: $password, isAktif: $isAktif, isRegistps: $isRegistps, profile: $profile)';
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
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'password': password,
        'is_aktif': isAktif,
        'is_registps': isRegistps,
        'profile': profile?.toJson(),
      };

  UsersModel copyWith({
    int? id,
    String? username,
    String? password,
    int? isAktif,
    int? isRegistps,
    ProfileModel? profile,
  }) {
    return UsersModel(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      isAktif: isAktif ?? this.isAktif,
      isRegistps: isRegistps ?? this.isRegistps,
      profile: profile ?? this.profile,
    );
  }
}
