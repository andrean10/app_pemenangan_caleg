class DataUsers2 {
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
  String? nikProfile;
  String? alamatProfile;
  String? jenisKelaminProfile;

  DataUsers2({
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
    this.nikProfile,
    this.alamatProfile,
    this.jenisKelaminProfile,
  });

  @override
  String toString() {
    return 'DataUsers2(id: $id, username: $username, password: $password, isAktif: $isAktif, isRegistps: $isRegistps, namaRoles: $namaRoles, namaProfile: $namaProfile, emailProfile: $emailProfile, nohpProfile: $nohpProfile, gambarProfile: $gambarProfile, nikProfile: $nikProfile, alamatProfile: $alamatProfile, jenisKelaminProfile: $jenisKelaminProfile)';
  }

  factory DataUsers2.fromJson(Map<String, dynamic> json) => DataUsers2(
        id: json['id'] as int?,
        username: json['username'] as String?,
        isAktif: json['is_aktif'] as int?,
        password: json['password'] as String?,
        isRegistps: json['is_registps'] as int?,
        namaRoles: json['nama_roles'] as String?,
        namaProfile: json['nama_profile'] as String?,
        emailProfile: json['email_profile'] as String?,
        nohpProfile: json['nohp_profile'] as String?,
        gambarProfile: json['gambar_profile'] as String?,
        nikProfile: json['nik_profile'] as String?,
        alamatProfile: json['alamat_profile'] as String?,
        jenisKelaminProfile: json['jenis_kelamin_profile'] as String?,
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
        'nik_profile': nikProfile,
        'alamat_profile': alamatProfile,
        'jenis_kelamin_profile': jenisKelaminProfile,
      };

  DataUsers2 copyWith({
    int? id,
    String? username,
    String? password,
    int? isAktif,
    dynamic isRegistps,
    String? namaRoles,
    String? namaProfile,
    String? emailProfile,
    String? nohpProfile,
    String? gambarProfile,
    String? nikProfile,
    String? alamatProfile,
    String? jenisKelaminProfile,
  }) {
    return DataUsers2(
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
      nikProfile: nikProfile ?? this.nikProfile,
      alamatProfile: alamatProfile ?? this.alamatProfile,
      jenisKelaminProfile: jenisKelaminProfile ?? this.jenisKelaminProfile,
    );
  }
}
