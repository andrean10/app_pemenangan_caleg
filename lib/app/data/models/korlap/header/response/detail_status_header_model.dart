class DetailStatus {
  int? disetujui;
  int? ditolak;
  int? menunggu;

  DetailStatus({this.disetujui, this.ditolak, this.menunggu});

  @override
  String toString() {
    return 'DetailStatus(disetujui: $disetujui, ditolak: $ditolak, menunggu: $menunggu)';
  }

  factory DetailStatus.fromJson(Map<String, dynamic> json) => DetailStatus(
        disetujui: json['disetujui'] as int?,
        ditolak: json['ditolak'] as int?,
        menunggu: json['menunggu'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'disetujui': disetujui,
        'ditolak': ditolak,
        'menunggu': menunggu,
      };

  DetailStatus copyWith({
    int? disetujui,
    int? ditolak,
    int? menunggu,
  }) {
    return DetailStatus(
      disetujui: disetujui ?? this.disetujui,
      ditolak: ditolak ?? this.ditolak,
      menunggu: menunggu ?? this.menunggu,
    );
  }
}
