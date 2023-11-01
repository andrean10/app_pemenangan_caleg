import 'detail_status_header_model.dart';
import 'tps_header_model.dart';

class HeaderPendukungModel {
  TpsHeaderModel? tps;
  int? statusPencapaian;
  DetailStatus? detailStatus;

  HeaderPendukungModel({
    this.tps,
    this.statusPencapaian,
    this.detailStatus,
  });

  @override
  String toString() {
    return 'HeaderPendukungModel(tps: $tps, statusPencapaian: $statusPencapaian, detailStatus: $detailStatus)';
  }

  factory HeaderPendukungModel.fromJson(Map<String, dynamic> json) {
    return HeaderPendukungModel(
      tps: json['tps'] == null
          ? null
          : TpsHeaderModel.fromJson(json['tps'] as Map<String, dynamic>),
      statusPencapaian: json['status_pencapaian'] as int?,
      detailStatus: json['detail_status'] == null
          ? null
          : DetailStatus.fromJson(
              json['detail_status'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'tps': tps?.toJson(),
        'status_pencapaian': statusPencapaian,
        'detail_status': detailStatus?.toJson(),
      };

  HeaderPendukungModel copyWith({
    TpsHeaderModel? tps,
    int? statusPencapaian,
    DetailStatus? detailStatus,
  }) {
    return HeaderPendukungModel(
      tps: tps ?? this.tps,
      statusPencapaian: statusPencapaian ?? this.statusPencapaian,
      detailStatus: detailStatus ?? this.detailStatus,
    );
  }
}
