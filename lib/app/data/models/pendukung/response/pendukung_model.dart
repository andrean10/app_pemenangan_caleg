import 'result_pendukung_model.dart';

class PendukungModel {
  int? status;
  String? message;
  ResultPendukungModel? result;

  PendukungModel({this.status, this.message, this.result});

  @override
  String toString() {
    return 'PendukungModel(status: $status, message: $message, result: $result)';
  }

  factory PendukungModel.fromJson(Map<String, dynamic> json) {
    return PendukungModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      result: json['result'] == null
          ? null
          : ResultPendukungModel.fromJson(
              json['result'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result?.toJson(),
      };

  PendukungModel copyWith({
    int? status,
    String? message,
    ResultPendukungModel? result,
  }) {
    return PendukungModel(
      status: status ?? this.status,
      message: message ?? this.message,
      result: result ?? this.result,
    );
  }
}
