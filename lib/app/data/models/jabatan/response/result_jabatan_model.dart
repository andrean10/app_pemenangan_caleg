class ResultJabatanModel {
  int? id;
  String? namaJabatan;
  String? keteranganJabatan;

  ResultJabatanModel({
    this.id,
    this.namaJabatan,
    this.keteranganJabatan,
  });

  @override
  String toString() {
    return '$namaJabatan - $keteranganJabatan';
  }

  factory ResultJabatanModel.fromJson(Map<String, dynamic> json) =>
      ResultJabatanModel(
        id: json['id'] as int?,
        namaJabatan: json['nama_jabatan'] as String?,
        keteranganJabatan: json['keterangan_jabatan'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama_jabatan': namaJabatan,
        'keterangan_jabatan': keteranganJabatan,
      };

  ResultJabatanModel copyWith({
    int? id,
    String? namaJabatan,
    String? keteranganJabatan,
    dynamic membawahiJabatan,
  }) {
    return ResultJabatanModel(
      id: id ?? this.id,
      namaJabatan: namaJabatan ?? this.namaJabatan,
      keteranganJabatan: keteranganJabatan ?? this.keteranganJabatan,
    );
  }
}
