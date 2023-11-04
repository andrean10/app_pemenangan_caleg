import 'package:dio/dio.dart';

class RequestDataUsersModel {
  String? roleId;
  String? username;
  String? oldPassword;
  String? password;
  String? confirmPassword;
  String? emailProfile;
  int? isAktif;
  String? nikProfile;
  int? jabatanId;
  String? namaProfile;
  String? alamatProfile;
  String? nohpProfile;
  String? jenisKelaminProfile;
  MultipartFile? gambarProfile;

  RequestDataUsersModel({
    this.roleId,
    this.username,
    this.oldPassword,
    this.password,
    this.confirmPassword,
    this.emailProfile,
    this.isAktif,
    this.nikProfile,
    this.jabatanId,
    this.namaProfile,
    this.alamatProfile,
    this.nohpProfile,
    this.jenisKelaminProfile,
    this.gambarProfile,
  });

  RequestDataUsersModel copyWith({
    String? id,
    String? roleId,
    String? username,
    String? oldPassword,
    String? password,
    String? confirmPassword,
    String? emailProfile,
    int? isAktif,
    String? nikProfile,
    int? jabatanId,
    String? namaProfile,
    String? alamatProfile,
    String? nohpProfile,
    String? jenisKelaminProfile,
    MultipartFile? gambarProfile,
  }) {
    return RequestDataUsersModel(
      roleId: roleId ?? this.roleId,
      username: username ?? this.username,
      oldPassword: oldPassword ?? this.oldPassword,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      emailProfile: emailProfile ?? this.emailProfile,
      isAktif: isAktif ?? this.isAktif,
      nikProfile: nikProfile ?? this.nikProfile,
      jabatanId: jabatanId ?? this.jabatanId,
      namaProfile: namaProfile ?? this.namaProfile,
      alamatProfile: alamatProfile ?? this.alamatProfile,
      nohpProfile: nohpProfile ?? this.nohpProfile,
      jenisKelaminProfile: jenisKelaminProfile ?? this.jenisKelaminProfile,
      gambarProfile: gambarProfile ?? this.gambarProfile,
    );
  }

  Map<String, dynamic> toJson() => {
        "role_id": roleId,
        "username": username,
        "password_old": oldPassword,
        "password": password,
        "password_confirm": confirmPassword,
        "email_profile": emailProfile,
        "is_aktif": isAktif,
        "nik_profile": nikProfile,
        "jabatan_id": jabatanId,
        "nama_profile": namaProfile,
        "alamat_profile": alamatProfile,
        "nohp_profile": nohpProfile,
        "jenis_kelamin_profile": jenisKelaminProfile,
        "gambar_profile": gambarProfile,
      };

  @override
  String toString() {
    return 'RequestDataUsersModel(roleId: $roleId, username: $username, oldPassword: $oldPassword,  password: $password, confirmPassword: $confirmPassword, emailProfile: $emailProfile, isAktif: $isAktif, nikProfile: $nikProfile, jabatanId: $jabatanId,  namaProfile: $namaProfile, alamatProfile: $alamatProfile, nohpProfile: $nohpProfile, jenisKelaminProfile: $jenisKelaminProfile,  gambarProfile: $gambarProfile)';
  }
}
