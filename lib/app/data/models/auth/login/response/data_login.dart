class DataLogin {
  int? id;
  String? username;
  int? isAktif;
  int? isRegistps;
  String? namaRoles;
  int? provincesId;
  int? regenciesId;
  int? districtsId;

  DataLogin({
    this.id,
    this.username,
    this.isAktif,
    this.isRegistps,
    this.namaRoles,
    this.provincesId,
    this.regenciesId,
    this.districtsId,
  });

  @override
  String toString() {
    return 'DataLogin(id: $id, username: $username,  isAktif: $isAktif, isRegistps: $isRegistps, namaRoles: $namaRoles, provincesId: $provincesId, regenciesId: $regenciesId, districtsId: $districtsId)';
  }

  factory DataLogin.fromMap(Map<String, dynamic> dataLogin) => DataLogin(
        id: dataLogin['id'] as int?,
        username: dataLogin['username'] as String?,
        isAktif: dataLogin['is_aktif'] as int?,
        isRegistps: dataLogin['is_registps'] as int?,
        namaRoles: dataLogin['nama_roles'] as String?,
        provincesId: dataLogin['provinces_id'] as int?,
        regenciesId: dataLogin['regencies_id'] as int?,
        districtsId: dataLogin['districts_id'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'username': username,
        'is_aktif': isAktif,
        'is_registps': isRegistps,
        'nama_roles': namaRoles,
        'provinces_id': provincesId,
        'regencies_id': regenciesId,
        'districts_id': districtsId,
      };

  DataLogin copyWith({
    int? id,
    String? username,
    int? isAktif,
    int? isRegistps,
    String? namaRoles,
    int? provincesId,
    int? regenciesId,
    int? districtsId,
  }) {
    return DataLogin(
      id: id ?? this.id,
      username: username ?? this.username,
      isAktif: isAktif ?? this.isAktif,
      isRegistps: isRegistps ?? this.isRegistps,
      namaRoles: namaRoles ?? this.namaRoles,
      provincesId: provincesId ?? this.provincesId,
      regenciesId: regenciesId ?? this.regenciesId,
      districtsId: districtsId ?? this.districtsId,
    );
  }
}
