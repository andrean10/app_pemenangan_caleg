class ResultSuaraTpsKorcabModel {
  int? provinsi;
  int? kabupaten;
  int? kecamatan;
  int? kelurahan;
  String? totalDukungan;
  String? totalkoordinator;
  int? targetPemenangan;
  double? presentasePemenangan;
  String? totalDukunganLk;
  String? totalDukunganPr;

  ResultSuaraTpsKorcabModel({
    this.provinsi,
    this.kabupaten,
    this.kecamatan,
    this.kelurahan,
    this.totalDukungan,
    this.totalkoordinator,
    this.targetPemenangan,
    this.presentasePemenangan,
    this.totalDukunganLk,
    this.totalDukunganPr,
  });

  @override
  String toString() {
    return 'ResultSuaraTpsKorcabModel(provinsi: $provinsi, kabupaten: $kabupaten, kecamatan: $kecamatan, kelurahan: $kelurahan, totalDukungan: $totalDukungan, totalkoordinator: $totalkoordinator, targetPemenangan: $targetPemenangan, presentasePemenangan: $presentasePemenangan, totalDukunganLk: $totalDukunganLk, totalDukunganPr: $totalDukunganPr)';
  }

  factory ResultSuaraTpsKorcabModel.fromJson(Map<String, dynamic> json) =>
      ResultSuaraTpsKorcabModel(
        provinsi: json['provinsi'] as int?,
        kabupaten: json['kabupaten'] as int?,
        kecamatan: json['kecamatan'] as int?,
        kelurahan: json['kelurahan'] as int?,
        totalDukungan: json['totalDukungan'] as String?,
        totalkoordinator: json['totalkoordinator'] as String?,
        targetPemenangan: json['targetPemenangan'] as int?,
        presentasePemenangan:
            (json['presentasePemenangan'] as num?)?.toDouble(),
        totalDukunganLk: json['totalDukunganLk'] as String?,
        totalDukunganPr: json['totalDukunganPr'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'provinsi': provinsi,
        'kabupaten': kabupaten,
        'kecamatan': kecamatan,
        'kelurahan': kelurahan,
        'totalDukungan': totalDukungan,
        'totalkoordinator': totalkoordinator,
        'targetPemenangan': targetPemenangan,
        'presentasePemenangan': presentasePemenangan,
        'totalDukunganLk': totalDukunganLk,
        'totalDukunganPr': totalDukunganPr,
      };

  ResultSuaraTpsKorcabModel copyWith({
    int? provinsi,
    int? kabupaten,
    int? kecamatan,
    int? kelurahan,
    String? totalDukungan,
    String? totalkoordinator,
    int? targetPemenangan,
    double? presentasePemenangan,
    String? totalDukunganLk,
    String? totalDukunganPr,
  }) {
    return ResultSuaraTpsKorcabModel(
      provinsi: provinsi ?? this.provinsi,
      kabupaten: kabupaten ?? this.kabupaten,
      kecamatan: kecamatan ?? this.kecamatan,
      kelurahan: kelurahan ?? this.kelurahan,
      totalDukungan: totalDukungan ?? this.totalDukungan,
      totalkoordinator: totalkoordinator ?? this.totalkoordinator,
      targetPemenangan: targetPemenangan ?? this.targetPemenangan,
      presentasePemenangan: presentasePemenangan ?? this.presentasePemenangan,
      totalDukunganLk: totalDukunganLk ?? this.totalDukunganLk,
      totalDukunganPr: totalDukunganPr ?? this.totalDukunganPr,
    );
  }
}
