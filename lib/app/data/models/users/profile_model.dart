class ProfileModel {
  int? id;
  String? nikProfile;
  int? usersId;
  int? jabatanId;
  String? namaProfile;
  String? emailProfile;
  String? alamatProfile;
  String? nohpProfile;
  String? jenisKelaminProfile;
  String? gambarProfile;

  ProfileModel({
    this.id,
    this.nikProfile,
    this.usersId,
    this.jabatanId,
    this.namaProfile,
    this.emailProfile,
    this.alamatProfile,
    this.nohpProfile,
    this.jenisKelaminProfile,
    this.gambarProfile,
  });

  @override
  String toString() {
    return 'ProfileModel(id: $id, nikProfile: $nikProfile, usersId: $usersId, jabatanId: $jabatanId, namaProfile: $namaProfile, emailProfile: $emailProfile, alamatProfile: $alamatProfile, nohpProfile: $nohpProfile, jenisKelaminProfile: $jenisKelaminProfile, gambarProfile: $gambarProfile)';
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json['id'] as int?,
        nikProfile: json['nik_profile'] as String?,
        usersId: json['users_id'] as int?,
        jabatanId: json['jabatan_id'] as int?,
        namaProfile: json['nama_profile'] as String?,
        emailProfile: json['email_profile'] as String?,
        alamatProfile: json['alamat_profile'] as String?,
        nohpProfile: json['nohp_profile'] as String?,
        jenisKelaminProfile: json['jenis_kelamin_profile'] as String?,
        gambarProfile: json['gambar_profile'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nik_profile': nikProfile,
        'users_id': usersId,
        'jabatan_id': jabatanId,
        'nama_profile': namaProfile,
        'email_profile': emailProfile,
        'alamat_profile': alamatProfile,
        'nohp_profile': nohpProfile,
        'jenis_kelamin_profile': jenisKelaminProfile,
        'gambar_profile': gambarProfile,
      };

  ProfileModel copyWith({
    int? id,
    String? nikProfile,
    int? usersId,
    int? jabatanId,
    String? namaProfile,
    String? emailProfile,
    String? alamatProfile,
    String? nohpProfile,
    String? jenisKelaminProfile,
    String? gambarProfile,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      nikProfile: nikProfile ?? this.nikProfile,
      usersId: usersId ?? this.usersId,
      jabatanId: jabatanId ?? this.jabatanId,
      namaProfile: namaProfile ?? this.namaProfile,
      emailProfile: emailProfile ?? this.emailProfile,
      alamatProfile: alamatProfile ?? this.alamatProfile,
      nohpProfile: nohpProfile ?? this.nohpProfile,
      jenisKelaminProfile: jenisKelaminProfile ?? this.jenisKelaminProfile,
      gambarProfile: gambarProfile ?? this.gambarProfile,
    );
  }
}
