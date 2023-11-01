import 'result_pendukung_korlap_model.dart';

class PendukungKorlapModel {
  int? status;
  String? message;
  ResultPendukungKorlapModel? result;

  PendukungKorlapModel({this.status, this.message, this.result});

  @override
  String toString() {
    return 'PendukungKorlapModel(status: $status, message: $message, result: $result)';
  }

  factory PendukungKorlapModel.fromJson(Map<String, dynamic> json) {
    return PendukungKorlapModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      result: json['result'] == null
          ? null
          : ResultPendukungKorlapModel.fromJson(
              json['result'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result?.toJson(),
      };

  PendukungKorlapModel copyWith({
    int? status,
    String? message,
    ResultPendukungKorlapModel? result,
  }) {
    return PendukungKorlapModel(
      status: status ?? this.status,
      message: message ?? this.message,
      result: result ?? this.result,
    );
  }
}
