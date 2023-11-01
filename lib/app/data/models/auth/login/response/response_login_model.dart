import 'result_login_model.dart';

class ResponseLoginModel {
  int? status;
  String? message;
  ResultLoginModel? result;

  ResponseLoginModel({this.status, this.message, this.result});

  @override
  String toString() {
    return 'ResponseLoginModel(status: $status, message: $message, result: $result)';
  }

  factory ResponseLoginModel.fromMap(Map<String, dynamic> data) =>
      ResponseLoginModel(
        status: data['status'] as int?,
        message: data['message'] as String?,
        result: data['result'] == null
            ? null
            : ResultLoginModel.fromMap(data['result'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'status': status,
        'message': message,
        'result': result?.toMap(),
      };

  ResponseLoginModel copyWith({
    int? status,
    String? message,
    ResultLoginModel? result,
  }) {
    return ResponseLoginModel(
      status: status ?? this.status,
      message: message ?? this.message,
      result: result ?? this.result,
    );
  }
}
