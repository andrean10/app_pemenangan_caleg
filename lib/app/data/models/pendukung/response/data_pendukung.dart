class DataPendukung {
  int? id;
  String? username;
  String? password;
  int? isAktif;
  int? isRegistps;
  String? namaRoles;
  String? namaProfile;
  String? emailProfile;
  String? nohpProfile;
  String? gambarProfile;
  String? jenisKelaminProfile;
  String? alamatProfile;

  DataPendukung({
    this.id,
    this.username,
    this.password,
    this.isAktif,
    this.isRegistps,
    this.namaRoles,
    this.namaProfile,
    this.emailProfile,
    this.nohpProfile,
    this.gambarProfile,
    this.jenisKelaminProfile,
    this.alamatProfile,
  });

  get users => null;

  @override
  String toString() {
    return 'DataPendukung(id: $id, username: $username, password: $password, isAktif: $isAktif, isRegistps: $isRegistps, namaRoles: $namaRoles, namaProfile: $namaProfile, emailProfile: $emailProfile, nohpProfile: $nohpProfile, gambarProfile: $gambarProfile, jenisKelaminProfile: $jenisKelaminProfile, alamatProfile: $alamatProfile)';
  }

  factory DataPendukung.fromJson(Map<String, dynamic> json) => DataPendukung(
        id: json['id'] as int?,
        username: json['username'] as String?,
        password: json['password'] as String?,
        isAktif: json['is_aktif'] as int?,
        isRegistps: json['is_registps'] as int?,
        namaRoles: json['nama_roles'] as String?,
        namaProfile: json['nama_profile'] as String?,
        emailProfile: json['email_profile'] as String?,
        nohpProfile: json['nohp_profile'] as String?,
        gambarProfile: json['gambar_profile'] as String?,
        jenisKelaminProfile: json['jenis_kelamin_profile'] as String?,
        alamatProfile: json['alamat_profile'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'password': password,
        'is_aktif': isAktif,
        'is_registps': isRegistps,
        'nama_roles': namaRoles,
        'nama_profile': namaProfile,
        'email_profile': emailProfile,
        'nohp_profile': nohpProfile,
        'gambar_profile': gambarProfile,
        'jenis_kelamin_profile': jenisKelaminProfile,
        'alamat_profile': alamatProfile,
      };

  DataPendukung copyWith({
    int? id,
    String? username,
    String? password,
    int? isAktif,
    int? isRegistps,
    String? namaRoles,
    String? namaProfile,
    String? emailProfile,
    String? nohpProfile,
    String? gambarProfile,
    String? jenisKelaminProfile,
    String? alamatProfile,
  }) {
    return DataPendukung(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      isAktif: isAktif ?? this.isAktif,
      isRegistps: isRegistps ?? this.isRegistps,
      namaRoles: namaRoles ?? this.namaRoles,
      namaProfile: namaProfile ?? this.namaProfile,
      emailProfile: emailProfile ?? this.emailProfile,
      nohpProfile: nohpProfile ?? this.nohpProfile,
      gambarProfile: gambarProfile ?? this.gambarProfile,
      jenisKelaminProfile: jenisKelaminProfile ?? this.jenisKelaminProfile,
      alamatProfile: alamatProfile ?? this.alamatProfile,
    );
  }
}
