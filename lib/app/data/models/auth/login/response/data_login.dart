class DataLogin {
  int? id;
  String? username;
  int? isAktif;
  int? isRegistps;
  String? namaRoles;

  DataLogin({
    this.id,
    this.username,
    this.isAktif,
    this.isRegistps,
    this.namaRoles,
  });

  @override
  String toString() {
    return 'DataLogin(id: $id, username: $username,  isAktif: $isAktif, isRegistps: $isRegistps, namaRoles: $namaRoles)';
  }

  factory DataLogin.fromMap(Map<String, dynamic> dataLogin) => DataLogin(
        id: dataLogin['id'] as int?,
        username: dataLogin['username'] as String?,
        isAktif: dataLogin['is_aktif'] as int?,
        isRegistps: dataLogin['is_registps'] as int?,
        namaRoles: dataLogin['nama_roles'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'username': username,
        'is_aktif': isAktif,
        'is_registps': isRegistps,
        'nama_roles': namaRoles,
      };

  DataLogin copyWith({
    int? id,
    String? username,
    int? isAktif,
    int? isRegistps,
    String? namaRoles,
  }) {
    return DataLogin(
      id: id ?? this.id,
      username: username ?? this.username,
      isAktif: isAktif ?? this.isAktif,
      isRegistps: isRegistps ?? this.isRegistps,
      namaRoles: namaRoles ?? this.namaRoles,
    );
  }
}
