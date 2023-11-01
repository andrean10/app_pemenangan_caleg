class TpsModel {
  int? id;
  int? provincesId;
  int? regenciesId;
  int? districtsId;
  int? villagesId;
  String? namaTps;
  String? alamatTps;
  int? totallkTps;
  int? totalprTps;
  int? totalsemuaTps;
  int? totalcoTps;
  int? minimalTps;
  int? kuotaTps;
  int? pendukungTps;

  TpsModel({
    this.id,
    this.provincesId,
    this.regenciesId,
    this.districtsId,
    this.villagesId,
    this.namaTps,
    this.alamatTps,
    this.totallkTps,
    this.totalprTps,
    this.totalsemuaTps,
    this.totalcoTps,
    this.minimalTps,
    this.kuotaTps,
    this.pendukungTps,
  });

  @override
  String toString() {
    return 'Tps(id: $id, provincesId: $provincesId, regenciesId: $regenciesId, districtsId: $districtsId, villagesId: $villagesId, namaTps: $namaTps, alamatTps: $alamatTps, totallkTps: $totallkTps, totalprTps: $totalprTps, totalsemuaTps: $totalsemuaTps, totalcoTps: $totalcoTps, minimalTps: $minimalTps, kuotaTps: $kuotaTps, pendukungTps: $pendukungTps)';
  }

  factory TpsModel.fromJson(Map<String, dynamic> json) => TpsModel(
        id: json['id'] as int?,
        provincesId: json['provinces_id'] as int?,
        regenciesId: json['regencies_id'] as int?,
        districtsId: json['districts_id'] as int?,
        villagesId: json['villages_id'] as int?,
        namaTps: json['nama_tps'] as String?,
        alamatTps: json['alamat_tps'] as String?,
        totallkTps: json['totallk_tps'] as int?,
        totalprTps: json['totalpr_tps'] as int?,
        totalsemuaTps: json['totalsemua_tps'] as int?,
        totalcoTps: json['totalco_tps'] as int?,
        minimalTps: json['minimal_tps'] as int?,
        kuotaTps: json['kuota_tps'] as int?,
        pendukungTps: json['pendukung_tps'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'provinces_id': provincesId,
        'regencies_id': regenciesId,
        'districts_id': districtsId,
        'villages_id': villagesId,
        'nama_tps': namaTps,
        'alamat_tps': alamatTps,
        'totallk_tps': totallkTps,
        'totalpr_tps': totalprTps,
        'totalsemua_tps': totalsemuaTps,
        'totalco_tps': totalcoTps,
        'minimal_tps': minimalTps,
        'kuota_tps': kuotaTps,
        'pendukung_tps': pendukungTps,
      };

  TpsModel copyWith({
    int? id,
    int? provincesId,
    int? regenciesId,
    int? districtsId,
    int? villagesId,
    String? namaTps,
    String? alamatTps,
    int? totallkTps,
    int? totalprTps,
    int? totalsemuaTps,
    int? totalcoTps,
    int? minimalTps,
    int? kuotaTps,
    int? pendukungTps,
  }) {
    return TpsModel(
      id: id ?? this.id,
      provincesId: provincesId ?? this.provincesId,
      regenciesId: regenciesId ?? this.regenciesId,
      districtsId: districtsId ?? this.districtsId,
      villagesId: villagesId ?? this.villagesId,
      namaTps: namaTps ?? this.namaTps,
      alamatTps: alamatTps ?? this.alamatTps,
      totallkTps: totallkTps ?? this.totallkTps,
      totalprTps: totalprTps ?? this.totalprTps,
      totalsemuaTps: totalsemuaTps ?? this.totalsemuaTps,
      totalcoTps: totalcoTps ?? this.totalcoTps,
      minimalTps: minimalTps ?? this.minimalTps,
      kuotaTps: kuotaTps ?? this.kuotaTps,
      pendukungTps: pendukungTps ?? this.pendukungTps,
    );
  }
}
