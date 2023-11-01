import 'result_tps_korlap_model.dart';

class KorlapModel {
  int? status;
  String? message;
  ResultTpsKorlapModel? result;

  KorlapModel({this.status, this.message, this.result});

  @override
  String toString() {
    return 'KorlapModel(status: $status, message: $message, result: $result)';
  }

  factory KorlapModel.fromJson(Map<String, dynamic> json) => KorlapModel(
        status: json['status'] as int?,
        message: json['message'] as String?,
        result: json['result'] == null
            ? null
            : ResultTpsKorlapModel.fromJson(
                json['result'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result?.toJson(),
      };

  KorlapModel copyWith({
    int? status,
    String? message,
    ResultTpsKorlapModel? result,
  }) {
    return KorlapModel(
      status: status ?? this.status,
      message: message ?? this.message,
      result: result ?? this.result,
    );
  }
}
