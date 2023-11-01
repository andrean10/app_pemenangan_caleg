import 'result_region_model.dart';

class RegionModel {
  int? status;
  String? message;
  ResultRegionModel? result;

  RegionModel({this.status, this.message, this.result});

  @override
  String toString() {
    return 'RegionModel(status: $status, message: $message, result: $result)';
  }

  factory RegionModel.fromJson(Map<String, dynamic> json) => RegionModel(
        status: json['status'] as int?,
        message: json['message'] as String?,
        result: json['result'] == null
            ? null
            : ResultRegionModel.fromJson(
                json['result'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result?.toJson(),
      };
}
