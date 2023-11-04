import '../../../villages/villages_model.dart';

class DataTpsKorcab {
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
  VillagesModel? villages;
  int? totalPendukung;

  DataTpsKorcab({
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
    this.villages,
    this.totalPendukung,
  });

  @override
  String toString() {
    return 'DataTpsKorcab(id: $id, provincesId: $provincesId, regenciesId: $regenciesId, districtsId: $districtsId, villagesId: $villagesId, namaTps: $namaTps, alamatTps: $alamatTps, totallkTps: $totallkTps, totalprTps: $totalprTps, totalsemuaTps: $totalsemuaTps, totalcoTps: $totalcoTps, minimalTps: $minimalTps, kuotaTps: $kuotaTps, pendukungTps: $pendukungTps, villages: $villages)';
  }

  factory DataTpsKorcab.fromJson(Map<String, dynamic> data) => DataTpsKorcab(
        id: data['id'] as int?,
        provincesId: data['provinces_id'] as int?,
        regenciesId: data['regencies_id'] as int?,
        districtsId: data['districts_id'] as int?,
        villagesId: data['villages_id'] as int?,
        namaTps: data['nama_tps'] as String?,
        alamatTps: data['alamat_tps'] as String?,
        totallkTps: data['totallk_tps'] as int?,
        totalprTps: data['totalpr_tps'] as int?,
        totalsemuaTps: data['totalsemua_tps'] as int?,
        totalcoTps: data['totalco_tps'] as int?,
        minimalTps: data['minimal_tps'] as int?,
        kuotaTps: data['kuota_tps'] as int?,
        pendukungTps: data['pendukung_tps'] as int?,
        villages: data['villages'] == null
            ? null
            : VillagesModel.fromJson(data['villages'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'provinces_id': provincesId,
        'regencies_id': regenciesId,
        'districts_id': districtsId,
        'villages_id': villagesId,
        'nama_tps': namaTps,
        'alamat_tps': alamatTps,
        'minimal_tps': minimalTps,
        'kuota_tps': kuotaTps,
        'pendukung_tps': pendukungTps,
      };

  DataTpsKorcab copyWith({
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
    VillagesModel? villages,
    int? totalPendukung,
  }) {
    return DataTpsKorcab(
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
      villages: villages ?? this.villages,
      totalPendukung: totalPendukung ?? this.totalPendukung,
    );
  }
}
