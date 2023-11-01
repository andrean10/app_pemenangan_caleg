import 'result_tps_korcab_model.dart';

class TpsKorcabModel {
  int? status;
  String? message;
  ResultTpsKorcabModel? result;

  TpsKorcabModel({this.status, this.message, this.result});

  @override
  String toString() {
    return 'TpsKorcabModel(status: $status, message: $message, result: $result)';
  }

  factory TpsKorcabModel.fromJson(Map<String, dynamic> data) => TpsKorcabModel(
        status: data['status'] as int?,
        message: data['message'] as String?,
        result: data['result'] == null
            ? null
            : ResultTpsKorcabModel.fromJson(
                data['result'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result?.toJson(),
      };

  TpsKorcabModel copyWith({
    int? status,
    String? message,
    ResultTpsKorcabModel? result,
  }) {
    return TpsKorcabModel(
      status: status ?? this.status,
      message: message ?? this.message,
      result: result ?? this.result,
    );
  }
}
